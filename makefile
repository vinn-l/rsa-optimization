TARGET = montgomery prime
TARGET_ASM = montgomery_asm prime_asm
LIBS = -lm
CC = gcc
CFLAGS = -g -Wall -Wextra -O -Wfloat-equal -Wundef
ASMFLAGS = -fverbose-asm
.PHONY: default all clean

SRC_DIR := src

default: $(TARGET)
asm: $(TARGET_ASM)
all: default asm

montgomery: $(SRC_DIR)/montgomery.c
	$(CC) $(CFLAGS) $< -o $@

prime: $(SRC_DIR)/prime.c
	$(CC) $(CFLAGS) $< -o $@

montgomery_asm: $(SRC_DIR)/montgomery.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S

prime_asm: $(SRC_DIR)/prime.c
	$(CC) $(CFLAGS) $(ASMFLAGS) $< -S

clean:
	-rm -f *.o *.s
	-rm -f $(TARGET)