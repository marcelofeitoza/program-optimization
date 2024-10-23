	.text
	.file	"program.c"
	.globl	entrypoint                      # -- Begin function entrypoint
	.p2align	3
	.type	entrypoint,@function
entrypoint:                             # @entrypoint
# %bb.0:
	stxdw [r10 - 16], r1
	mov64 r1, r10
	add64 r1, -112
	stxdw [r10 - 120], r1
	mov64 r2, 0
	mov64 r3, 40
	call memset
	ldxdw r2, [r10 - 120]
	mov64 r1, r10
	add64 r1, -72
	stxdw [r10 - 112], r1
	ldxdw r1, [r10 - 16]
	mov64 r3, 1
	call sol_deserialize
	jne r0, 0, LBB0_2
	ja LBB0_1
LBB0_1:
	lddw r1, .L.str
	stxdw [r10 - 128], r1
	call sol_strlen
	ldxdw r1, [r10 - 128]
	mov64 r2, r0
	call sol_log_
	lddw r1, 8589934592
	stxdw [r10 - 8], r1
	ja LBB0_9
LBB0_2:
	ldxdw r1, [r10 - 88]
	jne r1, 0, LBB0_4
	ja LBB0_3
LBB0_3:
	lddw r1, .L.str.1
	stxdw [r10 - 136], r1
	call sol_strlen
	ldxdw r1, [r10 - 136]
	mov64 r2, r0
	call sol_log_
	lddw r1, 8589934592
	stxdw [r10 - 8], r1
	ja LBB0_9
LBB0_4:
	ldxdw r1, [r10 - 96]
	ldxb r1, [r1 + 0]
	stxdw [r10 - 144], r1
	jeq r1, 0, LBB0_5
	ja LBB0_10
LBB0_10:
	ldxdw r1, [r10 - 144]
	lsh64 r1, 32
	rsh64 r1, 32
	jeq r1, 1, LBB0_6
	ja LBB0_11
LBB0_11:
	ldxdw r1, [r10 - 144]
	lsh64 r1, 32
	rsh64 r1, 32
	jeq r1, 2, LBB0_7
	ja LBB0_8
LBB0_5:
	lddw r1, .L.str.2
	stxdw [r10 - 152], r1
	call sol_strlen
	ldxdw r1, [r10 - 152]
	mov64 r2, r0
	call sol_log_
	mov64 r1, r10
	add64 r1, -112
	call initialize_counter
	stxdw [r10 - 8], r0
	ja LBB0_9
LBB0_6:
	lddw r1, .L.str.3
	stxdw [r10 - 160], r1
	call sol_strlen
	ldxdw r1, [r10 - 160]
	mov64 r2, r0
	call sol_log_
	mov64 r1, r10
	add64 r1, -112
	call increment_counter
	stxdw [r10 - 8], r0
	ja LBB0_9
LBB0_7:
	lddw r1, .L.str.4
	stxdw [r10 - 168], r1
	call sol_strlen
	ldxdw r1, [r10 - 168]
	mov64 r2, r0
	call sol_log_
	mov64 r1, r10
	add64 r1, -112
	call decrement_counter
	stxdw [r10 - 8], r0
	ja LBB0_9
LBB0_8:
	lddw r1, .L.str.5
	stxdw [r10 - 176], r1
	call sol_strlen
	ldxdw r1, [r10 - 176]
	mov64 r2, r0
	call sol_log_
	lddw r1, 12884901888
	stxdw [r10 - 8], r1
	ja LBB0_9
LBB0_9:
	ldxdw r0, [r10 - 8]
	exit
.Lfunc_end0:
	.size	entrypoint, .Lfunc_end0-entrypoint
                                        # -- End function
	.p2align	3                               # -- Begin function sol_deserialize
	.type	sol_deserialize,@function
sol_deserialize:                        # @sol_deserialize
# %bb.0:
	stxdw [r10 - 16], r1
	stxdw [r10 - 24], r2
	stxdw [r10 - 32], r3
	ldxdw r1, [r10 - 16]
	jeq r1, 0, LBB1_2
	ja LBB1_1
LBB1_1:
	ldxdw r1, [r10 - 24]
	jne r1, 0, LBB1_3
	ja LBB1_2
LBB1_2:
	mov64 r1, 0
	stxb [r10 - 1], r1
	ja LBB1_16
LBB1_3:
	ldxdw r1, [r10 - 16]
	ldxdw r1, [r1 + 0]
	ldxdw r2, [r10 - 24]
	stxdw [r2 + 8], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 8
	stxdw [r10 - 16], r1
	mov64 r1, 0
	stxw [r10 - 36], r1
	ja LBB1_4
LBB1_4:                                 # =>This Inner Loop Header: Depth=1
	ldxw r1, [r10 - 36]
	lsh64 r1, 32
	arsh64 r1, 32
	ldxdw r2, [r10 - 24]
	ldxdw r2, [r2 + 8]
	jge r1, r2, LBB1_15
	ja LBB1_5
LBB1_5:                                 #   in Loop: Header=BB1_4 Depth=1
	ldxdw r1, [r10 - 16]
	ldxb r1, [r1 + 0]
	stxb [r10 - 37], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 1
	stxdw [r10 - 16], r1
	ldxw r2, [r10 - 36]
	lsh64 r2, 32
	arsh64 r2, 32
	ldxdw r1, [r10 - 32]
	jgt r1, r2, LBB1_10
	ja LBB1_6
LBB1_6:                                 #   in Loop: Header=BB1_4 Depth=1
	ldxb r1, [r10 - 37]
	jne r1, 255, LBB1_8
	ja LBB1_7
LBB1_7:                                 #   in Loop: Header=BB1_4 Depth=1
	ldxdw r1, [r10 - 16]
	add64 r1, 1
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 1
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 1
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 4
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 32
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 32
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 8
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r1, [r1 + 0]
	stxdw [r10 - 48], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 8
	stxdw [r10 - 16], r1
	ldxdw r2, [r10 - 48]
	ldxdw r1, [r10 - 16]
	add64 r1, r2
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 10240
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 7
	and64 r1, -8
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 8
	stxdw [r10 - 16], r1
	ja LBB1_9
LBB1_8:                                 #   in Loop: Header=BB1_4 Depth=1
	ldxdw r1, [r10 - 16]
	add64 r1, 7
	stxdw [r10 - 16], r1
	ja LBB1_9
LBB1_9:                                 #   in Loop: Header=BB1_4 Depth=1
	ja LBB1_14
LBB1_10:                                #   in Loop: Header=BB1_4 Depth=1
	ldxb r1, [r10 - 37]
	jne r1, 255, LBB1_12
	ja LBB1_11
LBB1_11:                                #   in Loop: Header=BB1_4 Depth=1
	ldxdw r1, [r10 - 16]
	ldxb r1, [r1 + 0]
	mov64 r2, 0
	stxdw [r10 - 72], r2
	mov64 r2, 1
	stxdw [r10 - 64], r2
	stxdw [r10 - 56], r2
	jne r1, 0, LBB1_18
# %bb.17:                               #   in Loop: Header=BB1_4 Depth=1
	ldxdw r1, [r10 - 72]
	stxdw [r10 - 56], r1
LBB1_18:                                #   in Loop: Header=BB1_4 Depth=1
	ldxdw r2, [r10 - 64]
	ldxdw r1, [r10 - 56]
	ldxdw r3, [r10 - 24]
	ldxdw r3, [r3 + 0]
	ldxw r4, [r10 - 36]
	lsh64 r4, 32
	arsh64 r4, 32
	mul64 r4, 56
	add64 r3, r4
	stxb [r3 + 48], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 1
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxb r1, [r1 + 0]
	stxdw [r10 - 80], r2
	jne r1, 0, LBB1_20
# %bb.19:                               #   in Loop: Header=BB1_4 Depth=1
	ldxdw r1, [r10 - 72]
	stxdw [r10 - 80], r1
LBB1_20:                                #   in Loop: Header=BB1_4 Depth=1
	ldxdw r2, [r10 - 64]
	ldxdw r1, [r10 - 80]
	ldxdw r3, [r10 - 24]
	ldxdw r3, [r3 + 0]
	ldxw r4, [r10 - 36]
	lsh64 r4, 32
	arsh64 r4, 32
	mul64 r4, 56
	add64 r3, r4
	stxb [r3 + 49], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 1
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxb r1, [r1 + 0]
	stxdw [r10 - 88], r2
	jne r1, 0, LBB1_22
# %bb.21:                               #   in Loop: Header=BB1_4 Depth=1
	ldxdw r1, [r10 - 72]
	stxdw [r10 - 88], r1
LBB1_22:                                #   in Loop: Header=BB1_4 Depth=1
	ldxdw r1, [r10 - 88]
	ldxdw r2, [r10 - 24]
	ldxdw r2, [r2 + 0]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxb [r2 + 50], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 1
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 4
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r2, [r10 - 24]
	ldxdw r2, [r2 + 0]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 0], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 32
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r2, [r10 - 24]
	ldxdw r2, [r2 + 0]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 32], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 32
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r2, [r10 - 24]
	ldxdw r2, [r2 + 0]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 8], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 8
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r1, [r1 + 0]
	ldxdw r2, [r10 - 24]
	ldxdw r2, [r2 + 0]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 8
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r2, [r10 - 24]
	ldxdw r2, [r2 + 0]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 24], r1
	ldxdw r1, [r10 - 24]
	ldxdw r1, [r1 + 0]
	ldxw r2, [r10 - 36]
	lsh64 r2, 32
	arsh64 r2, 32
	mul64 r2, 56
	add64 r1, r2
	ldxdw r2, [r1 + 16]
	ldxdw r1, [r10 - 16]
	add64 r1, r2
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 10240
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 7
	and64 r1, -8
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r1, [r1 + 0]
	ldxdw r2, [r10 - 24]
	ldxdw r2, [r2 + 0]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 40], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 8
	stxdw [r10 - 16], r1
	ja LBB1_13
LBB1_12:                                #   in Loop: Header=BB1_4 Depth=1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 0]
	ldxb r3, [r10 - 37]
	mul64 r3, 56
	mov64 r1, r2
	add64 r1, r3
	ldxb r1, [r1 + 48]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	and64 r1, 1
	stxb [r2 + 48], r1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 0]
	ldxb r3, [r10 - 37]
	mul64 r3, 56
	mov64 r1, r2
	add64 r1, r3
	ldxb r1, [r1 + 49]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	and64 r1, 1
	stxb [r2 + 49], r1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 0]
	ldxb r3, [r10 - 37]
	mul64 r3, 56
	mov64 r1, r2
	add64 r1, r3
	ldxb r1, [r1 + 50]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	and64 r1, 1
	stxb [r2 + 50], r1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 0]
	ldxb r3, [r10 - 37]
	mul64 r3, 56
	mov64 r1, r2
	add64 r1, r3
	ldxdw r1, [r1 + 0]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 0], r1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 0]
	ldxb r3, [r10 - 37]
	mul64 r3, 56
	mov64 r1, r2
	add64 r1, r3
	ldxdw r1, [r1 + 32]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 32], r1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 0]
	ldxb r3, [r10 - 37]
	mul64 r3, 56
	mov64 r1, r2
	add64 r1, r3
	ldxdw r1, [r1 + 8]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 8], r1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 0]
	ldxb r3, [r10 - 37]
	mul64 r3, 56
	mov64 r1, r2
	add64 r1, r3
	ldxdw r1, [r1 + 16]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 16], r1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 0]
	ldxb r3, [r10 - 37]
	mul64 r3, 56
	mov64 r1, r2
	add64 r1, r3
	ldxdw r1, [r1 + 24]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 24], r1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 0]
	ldxb r3, [r10 - 37]
	mul64 r3, 56
	mov64 r1, r2
	add64 r1, r3
	ldxdw r1, [r1 + 40]
	ldxw r3, [r10 - 36]
	lsh64 r3, 32
	arsh64 r3, 32
	mul64 r3, 56
	add64 r2, r3
	stxdw [r2 + 40], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 7
	stxdw [r10 - 16], r1
	ja LBB1_13
LBB1_13:                                #   in Loop: Header=BB1_4 Depth=1
	ja LBB1_14
LBB1_14:                                #   in Loop: Header=BB1_4 Depth=1
	ldxw r1, [r10 - 36]
	add64 r1, 1
	stxw [r10 - 36], r1
	ja LBB1_4
LBB1_15:
	ldxdw r1, [r10 - 16]
	ldxdw r1, [r1 + 0]
	ldxdw r2, [r10 - 24]
	stxdw [r2 + 24], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 8
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r2, [r10 - 24]
	stxdw [r2 + 16], r1
	ldxdw r1, [r10 - 24]
	ldxdw r2, [r1 + 24]
	ldxdw r1, [r10 - 16]
	add64 r1, r2
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r2, [r10 - 24]
	stxdw [r2 + 32], r1
	ldxdw r1, [r10 - 16]
	add64 r1, 32
	stxdw [r10 - 16], r1
	mov64 r1, 1
	stxb [r10 - 1], r1
	ja LBB1_16
LBB1_16:
	ldxb r0, [r10 - 1]
	exit
.Lfunc_end1:
	.size	sol_deserialize, .Lfunc_end1-sol_deserialize
                                        # -- End function
	.p2align	3                               # -- Begin function sol_strlen
	.type	sol_strlen,@function
sol_strlen:                             # @sol_strlen
# %bb.0:
	stxdw [r10 - 8], r1
	mov64 r1, 0
	stxdw [r10 - 16], r1
	ja LBB2_1
LBB2_1:                                 # =>This Inner Loop Header: Depth=1
	ldxdw r1, [r10 - 8]
	ldxb r1, [r1 + 0]
	jeq r1, 0, LBB2_3
	ja LBB2_2
LBB2_2:                                 #   in Loop: Header=BB2_1 Depth=1
	ldxdw r1, [r10 - 16]
	add64 r1, 1
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 8]
	add64 r1, 1
	stxdw [r10 - 8], r1
	ja LBB2_1
LBB2_3:
	ldxdw r0, [r10 - 16]
	exit
.Lfunc_end2:
	.size	sol_strlen, .Lfunc_end2-sol_strlen
                                        # -- End function
	.globl	initialize_counter              # -- Begin function initialize_counter
	.p2align	3
	.type	initialize_counter,@function
initialize_counter:                     # @initialize_counter
# %bb.0:
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r1, [r1 + 0]
	stxdw [r10 - 24], r1
	ldxdw r1, [r10 - 24]
	ldxb r1, [r1 + 49]
	and64 r1, 1
	jne r1, 0, LBB3_2
	ja LBB3_1
LBB3_1:
	lddw r1, .L.str.6
	stxdw [r10 - 40], r1
	call sol_strlen
	ldxdw r1, [r10 - 40]
	mov64 r2, r0
	call sol_log_
	lddw r1, 17179869184
	stxdw [r10 - 8], r1
	ja LBB3_3
LBB3_2:
	ldxdw r1, [r10 - 24]
	ldxdw r1, [r1 + 24]
	stxdw [r10 - 32], r1
	ldxdw r2, [r10 - 32]
	mov64 r1, 0
	stxdw [r10 - 48], r1
	stxdw [r2 + 0], r1
	lddw r1, .L.str.7
	stxdw [r10 - 56], r1
	call sol_strlen
	ldxdw r1, [r10 - 56]
	mov64 r2, r0
	call sol_log_
	ldxdw r1, [r10 - 48]
	stxdw [r10 - 8], r1
	ja LBB3_3
LBB3_3:
	ldxdw r0, [r10 - 8]
	exit
.Lfunc_end3:
	.size	initialize_counter, .Lfunc_end3-initialize_counter
                                        # -- End function
	.globl	increment_counter               # -- Begin function increment_counter
	.p2align	3
	.type	increment_counter,@function
increment_counter:                      # @increment_counter
# %bb.0:
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r1, [r1 + 0]
	stxdw [r10 - 24], r1
	ldxdw r1, [r10 - 24]
	ldxb r1, [r1 + 49]
	and64 r1, 1
	jne r1, 0, LBB4_2
	ja LBB4_1
LBB4_1:
	lddw r1, .L.str.6
	stxdw [r10 - 40], r1
	call sol_strlen
	ldxdw r1, [r10 - 40]
	mov64 r2, r0
	call sol_log_
	lddw r1, 17179869184
	stxdw [r10 - 8], r1
	ja LBB4_3
LBB4_2:
	ldxdw r1, [r10 - 24]
	ldxdw r1, [r1 + 24]
	stxdw [r10 - 32], r1
	ldxdw r2, [r10 - 32]
	ldxdw r1, [r2 + 0]
	add64 r1, 1
	stxdw [r2 + 0], r1
	lddw r1, .L.str.8
	stxdw [r10 - 48], r1
	call sol_strlen
	ldxdw r1, [r10 - 48]
	mov64 r2, r0
	call sol_log_
	mov64 r1, 0
	stxdw [r10 - 8], r1
	ja LBB4_3
LBB4_3:
	ldxdw r0, [r10 - 8]
	exit
.Lfunc_end4:
	.size	increment_counter, .Lfunc_end4-increment_counter
                                        # -- End function
	.globl	decrement_counter               # -- Begin function decrement_counter
	.p2align	3
	.type	decrement_counter,@function
decrement_counter:                      # @decrement_counter
# %bb.0:
	stxdw [r10 - 16], r1
	ldxdw r1, [r10 - 16]
	ldxdw r1, [r1 + 0]
	stxdw [r10 - 24], r1
	ldxdw r1, [r10 - 24]
	ldxb r1, [r1 + 49]
	and64 r1, 1
	jne r1, 0, LBB5_2
	ja LBB5_1
LBB5_1:
	lddw r1, .L.str.6
	stxdw [r10 - 40], r1
	call sol_strlen
	ldxdw r1, [r10 - 40]
	mov64 r2, r0
	call sol_log_
	lddw r1, 17179869184
	stxdw [r10 - 8], r1
	ja LBB5_5
LBB5_2:
	ldxdw r1, [r10 - 24]
	ldxdw r1, [r1 + 24]
	stxdw [r10 - 32], r1
	ldxdw r1, [r10 - 32]
	ldxdw r1, [r1 + 0]
	jne r1, 0, LBB5_4
	ja LBB5_3
LBB5_3:
	lddw r1, .L.str.9
	stxdw [r10 - 48], r1
	call sol_strlen
	ldxdw r1, [r10 - 48]
	mov64 r2, r0
	call sol_log_
	lddw r1, 8589934592
	stxdw [r10 - 8], r1
	ja LBB5_5
LBB5_4:
	ldxdw r2, [r10 - 32]
	ldxdw r1, [r2 + 0]
	add64 r1, -1
	stxdw [r2 + 0], r1
	lddw r1, .L.str.10
	stxdw [r10 - 56], r1
	call sol_strlen
	ldxdw r1, [r10 - 56]
	mov64 r2, r0
	call sol_log_
	mov64 r1, 0
	stxdw [r10 - 8], r1
	ja LBB5_5
LBB5_5:
	ldxdw r0, [r10 - 8]
	exit
.Lfunc_end5:
	.size	decrement_counter, .Lfunc_end5-decrement_counter
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Failed to deserialize input"
	.size	.L.str, 28

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"Invalid data length"
	.size	.L.str.1, 20

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"InitializeCounter"
	.size	.L.str.2, 18

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"IncrementCounter"
	.size	.L.str.3, 17

	.type	.L.str.4,@object                # @.str.4
.L.str.4:
	.asciz	"DecrementCounter"
	.size	.L.str.4, 17

	.type	.L.str.5,@object                # @.str.5
.L.str.5:
	.asciz	"Invalid instruction data"
	.size	.L.str.5, 25

	.type	.L.str.6,@object                # @.str.6
.L.str.6:
	.asciz	"Account is not writable"
	.size	.L.str.6, 24

	.type	.L.str.7,@object                # @.str.7
.L.str.7:
	.asciz	"Counter initialized to 0"
	.size	.L.str.7, 25

	.type	.L.str.8,@object                # @.str.8
.L.str.8:
	.asciz	"Counter incremented"
	.size	.L.str.8, 20

	.type	.L.str.9,@object                # @.str.9
.L.str.9:
	.asciz	"Counter is already 0, cannot decrement"
	.size	.L.str.9, 39

	.type	.L.str.10,@object               # @.str.10
.L.str.10:
	.asciz	"Counter decremented"
	.size	.L.str.10, 20

	.addrsig
	.addrsig_sym sol_deserialize
	.addrsig_sym sol_log_
	.addrsig_sym sol_strlen
	.addrsig_sym initialize_counter
	.addrsig_sym increment_counter
	.addrsig_sym decrement_counter
