#include <stdio.h>
#include <math.h>

int count_bits(int i){
    int m = 0;
    while (i)
    {
        m++;
        i >>= 1;
    }

    return m;
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
    int m = count_bits(M);
    
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

// Modular Exponentiation used with Montgomery Multiplication
int modular_exponentiation_mont(int b, int e, int m, int numBits)
{
    int r2_mod = (1 << (2 * numBits)) % m;
    int result = modular_multiplication(1, r2_mod, m);
    int p = modular_multiplication(b, r2_mod, m);

    // if (1 & e) // if e is odd
    //     result = b;
    while (e > 0)
    { // while e > 0
        if (e & 1)                     // if e is odd
            // result = (result * b) % m; // result = result * b % m
            result = modular_multiplication(result, p, m);

        e >>= 1;                       // e = e/2
        // b = (b * b) % m;               // b = b^2 % m
        p = modular_multiplication(p, p, m);
    }
    result = modular_multiplication(1, result, m);

    return result;
}

int main()
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

    // Basic Modular Exponentiation Test with Montgomery from Slides
    int base_m = 4;
    int exp_m = 13;
    int mod_m = 497;

    int modulo_m = modular_exponentiation_mont(base_m, exp_m, mod_m, count_bits(mod_m));
    printf("%d\n", modulo_m); // Answer should be 445
    return 0;
}