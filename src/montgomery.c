#include <stdio.h>
#include <math.h>

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
}