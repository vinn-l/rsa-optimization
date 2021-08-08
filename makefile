TARGET = montgomery montgomery_96bit montgomery_96bit_optimized
TARGET_ASM = montgomery_asm montgomery_96bit_asm montgomery_96bit_optimized_asm

LIBS = -lm
CC = gcc
# CFLAGS = -g -Wall -Wextra -O -Wfloat-equal -Wundef
CFLAGS = -Wall -Wextra -O -Wfloat-equal -Wundef -Wno-missing-braces
ASMFLAGS = -fverbose-asm
.PHONY: default all clean

SRC_DIR := src

default: $(TARGET)
asm: $(TARGET_ASM)
all: default asm

montgomery: $(SRC_DIR)/montgomery.c
	$(CC) $(CFLAGS) $< -o $@

montgomery_asm: $(SRC_DIR)/montgomery.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S

montgomery_96bit: $(SRC_DIR)/montgomery_96bit.c
	$(CC) $(CFLAGS) $< -o $@ 

montgomery_96bit_asm: $(SRC_DIR)/montgomery_96bit.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S

montgomery_96bit_optimized: $(SRC_DIR)/montgomery_96bit_optimized.c
	$(CC) $(CFLAGS) $< -o $@

montgomery_96bit_optimized_asm: $(SRC_DIR)/montgomery_96bit_optimized.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S

clean:
	-rm -f *.o *.s
	-rm -f $(TARGET)