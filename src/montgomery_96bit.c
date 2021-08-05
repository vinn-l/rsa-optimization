#include <stdio.h>
#include <math.h>
#include <stdint.h>

// uint32x3_t
typedef struct uint32x3_t {
    uint32_t x, y, z;
} uint32x3_t;

// uint32x3_t operations
uint32x3_t add(uint32x3_t, uint32x3_t);
uint32x3_t sub(uint32x3_t, uint32x3_t);
uint32x3_t compare(uint32x3_t, uint32x3_t);
// uint32x3_t mul(uint32x3_t, uint32x3_t);
// uint32x3_t div(uint32x3_t, uint32x3_t);
// uint32x3_t and(uint32x3_t, uint32x3_t);
// uint32x3_t or(uint32x3_t, uint32x3_t);
// uint32x3_t xor(uint32x3_t, uint32x3_t);
uint32x3_t lshift(uint32x3_t, int);
uint32x3_t rshift(uint32x3_t, int);


// https://en.wikipedia.org/wiki/Modular_exponentiation
// Modular Exponentiation based on slides and also pseudocode on Wikipedia.
int modular_exponentiation(int b, int e, int m)
{
    int result = 1;

    if (1 & e) // if e is odd
        result = b;
    while (e > 0)
    { // while e > 0
        e >>= 1;                       // e = e/2
        b = (b * b) % m;               // b = b^2 % m
        if (e & 1)                     // if e is odd
            result = (result * b) % m; // result = result * b % m
    }
    return result;
}

// Code written based of MMM pseudocode from slides

// Observation: RSA does not use negative X, Y and M, thus unsigned
// should be used to maximize number of representable positive integers
// changing to unsigned long long int should be done to allow 95 bit
// integers
int modular_multiplication(int X, int Y, int M)
{
    // Observation: Common variables that are frequently used should be
    // stored in registers
    int T = 0;

    // Find m, number of bits in M
    int m = 0;
    int temp = M;
    while (temp)
    {
        m++;
        temp >>= 1;
    }
    // Observation: Loop unrolling can be performed, especially since
    // only 2 operations in the loop, and the second operation is dependent
    // on first.
    for (int i = 0; i < m; i++)
    {
        // Observation: Repeated calculation of X(i), can store result
        // in a register.

        // Observation: Multiplication is expensive, but since
        // multiplication is not going to be with a direct power of 2,
        // difficult to identify how to optimize with bit operations.

        // Observation: There are operations in T that is not dependent
        // on n, such as (T + (((x >> i) & 1) * y)), ensure that
        // compiler allows this to be run concurrently.
        int n = (T & 1) ^ (((X >> i) & 1) & (Y & 1));
        printf("X>>i & 1 = %i\n", (X >> i) & 1);
        printf("n = %i\n", n);
        printf("n * M = %i\n", (n * M));
        T = (T + ((X >> i) & 1) * Y + (n * M)) >> 1;
    }
    if (T >= M)
        T = T - M;
    return T;
}

int main(int argc, char *argv[])
{
    // Basic Modular Multiplication Test from Slides
    int X = 17;
    int Y = 22;
    int M = 23;

    int Z = modular_multiplication(X, Y, M);
    printf("%d\n", Z); // Answer should be 16

    // Basic Modular Exponentiation Test from Slides
    int base = 4;
    int exp = 13;
    int mod = 497;

    int modulo = modular_exponentiation(base, exp, mod);
    printf("%d\n", modulo); // Answer should be 445
    return 0;

    // Simple E
    // P = 221695237201051
    // Q = 162886253482817
    // N = 36111106602663634391602840667
    // E = 17
    // D = 59477116757327705569596493553 
    // x = 28

    // 95 bit E
    P = 221695237201051 // 48 bit
    Q = 162886253482817 // 48 bit
    N = 36111106602663634391602840667 // P*Q, 48 bit * 48 bit = 95 bit
    E = 19414542554036919968371256159 // prime, therefore is relatively prime with (P-1)(Q-1)
    D = 36700924073403172721919985439 // 95 bit
    x = 19731648216590892426383796091

    // 95 bit keys
    const uint32_t N[3] = {0x74AE6843, 0x79222DF5, 0xCAA0445B}
    const uint32_t E[3] = {0x3EBB554C, 0xBEB56109, 0x2B0B2B5F}
    const uint32_t D[3] = {0x76964AF8, 0xA1660D33, 0x7A2F071F}

    // encrypt plaintext 55
    // cipher text expected result 5740687887086918635830255485
    // decrypt expected result 55

    // encrypt plaintext 17297563458314651238923946123
    // cipher text expected result 29193194689960104856100570005
    // decrypt expected result 36111106602663634391602840667

    // Unsure as to how to generate 96 bit keys, therefore just use random 96 bits for now.
    char N[] = "0x74AE684379222DF5CAA0445B" // 95 bits - 0b11101001010111001101000010000110111100100100010001011011111010111001010101000000100010001011011
    char E[] = "000000000000000000010001"
    char D[] = "0x"
}