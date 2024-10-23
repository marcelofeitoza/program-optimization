LOCAL_PATH := /Users/$(USER)/.local/share/solana/install/active_release/bin/sdk/sbf/c/

.PHONY: all clean asm

SRC_DIR ?= ./src
OUT_DIR ?= ./out

all: $(OUT_DIR)/program.so $(OUT_DIR)/program.s
	
clean:
	rm -rf $(OUT_DIR)

LLVM_DIR = $(LOCAL_PATH)../dependencies/platform-tools/llvm
LLVM_SYSTEM_INC_DIRS := $(LLVM_DIR)/lib/clang/15.0.4/include
STD_INC_DIRS := $(LLVM_DIR)/include
STD_LIB_DIRS := $(LLVM_DIR)/lib

# Verify the correct paths for clang and ld.lld
CC := $(LLVM_DIR)/bin/clang
LLD := $(LLVM_DIR)/bin/ld.lld

SYSTEM_INC_DIRS := \
	$(LOCAL_PATH)inc \
	$(LLVM_SYSTEM_INC_DIRS) \

C_FLAGS := \
	-Werror \
	-O2 \
	-fno-builtin \
	-std=c17 \
	$(addprefix -isystem,$(SYSTEM_INC_DIRS)) \
	$(addprefix -I,$(STD_INC_DIRS)) \
	-target sbf \
	-fPIC

SBF_LLD_FLAGS := \
	-z notext \
	-shared \
	--Bdynamic \
	$(LOCAL_PATH)sbf.ld \
	--entry entrypoint \
	-L $(STD_LIB_DIRS) \
	-lc \

$(OUT_DIR)/program.o: $(SRC_DIR)/entrypoint.c
	mkdir -p $(OUT_DIR)
	$(CC) $(C_FLAGS) -o $(OUT_DIR)/program.o -c $(SRC_DIR)/entrypoint.c

$(OUT_DIR)/program.so: $(OUT_DIR)/program.o
	$(LLD) $(SBF_LLD_FLAGS) -o $(OUT_DIR)/program.so $(OUT_DIR)/program.o

$(OUT_DIR)/program.s: $(SRC_DIR)/entrypoint.c
	mkdir -p $(OUT_DIR)
	$(CC) $(C_FLAGS) -S -o $(OUT_DIR)/program.s $(SRC_DIR)/entrypoint.c