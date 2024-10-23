LOCAL_PATH := /Users/$(USER)/.local/share/solana/install/active_release/bin/sdk/sbf/c/

.PHONY: all clean

SRC_DIR ?= ./src
OUT_DIR ?= ./out

all: $(OUT_DIR)/program.so $(OUT_DIR)/program.s

clean:
	rm -rf $(OUT_DIR)

LLVM_DIR = $(LOCAL_PATH)../dependencies/platform-tools/llvm
LLVM_SYSTEM_INC_DIRS := $(LLVM_DIR)/lib/clang/15.0.4/include
STD_INC_DIRS := $(LLVM_DIR)/include
STD_LIB_DIRS := $(LLVM_DIR)/lib

CC := $(LLVM_DIR)/bin/clang
LLD := $(LLVM_DIR)/bin/ld.lld

SYSTEM_INC_DIRS := \
	$(LOCAL_PATH)inc \
	$(LLVM_SYSTEM_INC_DIRS)

# Compiler flags for C files
C_FLAGS := \
	-Werror \
	-O0 \
	-fno-builtin \
	-std=c17 \
	$(addprefix -isystem,$(SYSTEM_INC_DIRS)) \
	$(addprefix -I,$(STD_INC_DIRS)) \
	-target sbf \
	-fPIC

# Compiler flags for assembly files
AS_FLAGS := \
	-target sbf \
	-fPIC

# Linker flags
SBF_LLD_FLAGS := \
	-z notext \
	-shared \
	--Bdynamic \
	$(LOCAL_PATH)sbf.ld \
	--entry entrypoint \
	-L $(STD_LIB_DIRS) \
	-lc

# Rule for compiling the assembly file to object file
$(OUT_DIR)/program.o: $(SRC_DIR)/program.s
	mkdir -p $(OUT_DIR)
	$(CC) $(AS_FLAGS) -o $(OUT_DIR)/program.o -c $(SRC_DIR)/program.s

# Rule for linking the object file to create the final shared object
$(OUT_DIR)/program.so: $(OUT_DIR)/program.o
	$(LLD) $(SBF_LLD_FLAGS) -o $(OUT_DIR)/program.so $(OUT_DIR)/program.o

# Rule for compiling the C file to assembly for analysis or further optimization
$(OUT_DIR)/program.s: $(SRC_DIR)/program.c
	mkdir -p $(OUT_DIR)
	$(CC) $(C_FLAGS) -S -o $(OUT_DIR)/program.s $(SRC_DIR)/program.c

# Add the C object file to your dependencies
$(OUT_DIR)/sol_deserialize_wrapper.o: $(SRC_DIR)/sol_deserialize_wrapper.c
	mkdir -p $(OUT_DIR)
	$(CC) $(C_FLAGS) -o $(OUT_DIR)/sol_deserialize_wrapper.o -c $(SRC_DIR)/sol_deserialize_wrapper.c

# Update the linking rule to include the C object file
$(OUT_DIR)/program.so: $(OUT_DIR)/program.o $(OUT_DIR)/sol_deserialize_wrapper.o
	$(LLD) $(SBF_LLD_FLAGS) -o $(OUT_DIR)/program.so $(OUT_DIR)/program.o $(OUT_DIR)/sol_deserialize_wrapper.o
