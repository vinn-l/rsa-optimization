TARGET = montgomery_96bit montgomery_96bit_optimized_v1 montgomery_96bit_optimized_v2 montgomery_96bit_optimized_v3 montgomery_96bit_optimized_v4 montgomery_96bit_optimized_v2neon mmm_95bit_before_loop_unroll_test mmm_95bit_after_loop_unroll_test
TARGET_ASM = montgomery_96bit_asm montgomery_96bit_optimized_v1_asm montgomery_96bit_optimized_v2_asm montgomery_96bit_optimized_v3_asm montgomery_96bit_optimized_v4_asm montgomery_96bit_optimized_v2neon_asm mmm_95bit_before_loop_unroll_test_asm mmm_95bit_after_loop_unroll_test_asm

LIBS = -lm
CC = gcc
# CFLAGS = -g -Wall -Wextra -Wfloat-equal -Wundef
CFLAGS = -O1 -Wall -Wextra -Wfloat-equal -Wundef -Wno-missing-braces -Wno-maybe-uninitialized # Current setting is -O1
# ASMFLAGS = -fverbose-asm
ASMFLAGS = 
.PHONY: default all clean

SRC_DIR := src
ASM_DIR := asm

default: $(TARGET)
asm: $(TARGET_ASM)
all: default asm

montgomery_96bit: $(SRC_DIR)/montgomery_96bit.c
	$(CC) $(CFLAGS) $< -o $@

montgomery_96bit_asm: $(SRC_DIR)/montgomery_96bit.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S -o $(ASM_DIR)/$@.s

montgomery_96bit_optimized_v1: $(SRC_DIR)/montgomery_96bit_optimized_v1.c
	$(CC) $(CFLAGS) $< -o $@

montgomery_96bit_optimized_v1_asm: $(SRC_DIR)/montgomery_96bit_optimized_v1.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S -o $(ASM_DIR)/$@.s

montgomery_96bit_optimized_v2: $(SRC_DIR)/montgomery_96bit_optimized_v2.c
	$(CC) $(CFLAGS) $< -o $@

montgomery_96bit_optimized_v2_asm: $(SRC_DIR)/montgomery_96bit_optimized_v2.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S -o $(ASM_DIR)/$@.s

montgomery_96bit_optimized_v3: $(SRC_DIR)/montgomery_96bit_optimized_v3.c
	$(CC) $(CFLAGS) $< -o $@

montgomery_96bit_optimized_v3_asm: $(SRC_DIR)/montgomery_96bit_optimized_v3.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S -o $(ASM_DIR)/$@.s

montgomery_96bit_optimized_v4: $(SRC_DIR)/montgomery_96bit_optimized_v4.c
	$(CC) $(CFLAGS) $< -o $@

montgomery_96bit_optimized_v4_asm: $(SRC_DIR)/montgomery_96bit_optimized_v4.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S -o $(ASM_DIR)/$@.s

mmm_95bit_before_loop_unroll_test: $(SRC_DIR)/mmm_95bit_before_loop_unroll_test.c
	$(CC) $(CFLAGS) $< -o $@

mmm_95bit_before_loop_unroll_test_asm: $(SRC_DIR)/mmm_95bit_before_loop_unroll_test.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S -o $(ASM_DIR)/$@.s

mmm_95bit_after_loop_unroll_test: $(SRC_DIR)/mmm_95bit_after_loop_unroll_test.c
	$(CC) $(CFLAGS) $< -o $@

mmm_95bit_after_loop_unroll_test_asm: $(SRC_DIR)/mmm_95bit_after_loop_unroll_test.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S -o $(ASM_DIR)/$@.s

montgomery_96bit_optimized_v2neon: $(SRC_DIR)/montgomery_96bit_optimized_v2neon.c
	$(CC) $(CFLAGS) -mfpu=neon $< -o $@

montgomery_96bit_optimized_v2neon_asm: $(SRC_DIR)/montgomery_96bit_optimized_v2neon.c
	$(CC) $(CFLAGS) -mfpu=neon $(ASMFLAGS) $< -S -o $(ASM_DIR)/$@.s

clean:
	-rm -f *.o *.s
	-rm -f $(ASM_DIR)/*
	-rm -f $(TARGET)