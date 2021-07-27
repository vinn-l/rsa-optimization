#include <stdio.h>

// very non-optimized code that determines if the following integers are prime numbers or not
// returns 1 if prime number, otherwise returns 0.

// Work still needed. (July 23)

typedef enum {false, true} bool;


bool isPrime (bool y, int x) {

        int i;
        int flag = 0;
		
		// for loop can be optimized		
        for (i = 2; i < x/2; i++){
                if (x % i == 0){
                        flag = 1;
                        break;
                }

        }

        if (flag == 0)
                return true;
        else
                return false;


}

int main () {
    
        bool y;
        int a = 15;
        int b = 17;
        int c = 24;
        int d = 7853;


        printf("%d\n", isPrime(y, a));	// output 0
        printf("%d\n", isPrime(y, b));	// output 1
        printf("%d\n", isPrime(y, c));  // output 0
        printf("%d\n", isPrime(y, d));  // output 1
}