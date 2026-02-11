#ifdef SIM
#include <stdio.h>
#else
#include "stdio.h"
#endif


unsigned int isqrt(unsigned int value) {
    unsigned int res = 0;
    unsigned int bit = 1U << 30; 
    while (bit > value) {
        bit >>= 2;
    }
    while (bit != 0) {
        if (value >= res + bit) {
            value -= res + bit;
            res = (res >> 1) + bit;
        } else {
            res >>= 1;
        }
        bit >>= 2;
    }
    return res;
}

int prime(int n, int d)
{
  if(d > isqrt(n)) return 1;
  if(n % d == 0) return 0;
  return prime(n, d+2);
}

int primep(int n)
{
  if(n <= 1) return 0;
  if(n == 2) return 1;
  if(n % 2 == 0) return 0;
  return prime(n ,3);
}

int main()
{
  int n, m;
  while(1) {
    printf("find all prime number from\n\r> ");
    scanf("%d", &n);
    printf("%d\n\rto\n\r> ", n);
    scanf("%d", &m);
    printf("%d\n\r: ", m);
    for(int i = n; i<=m; i++){
      if(primep(i)) printf("%d ", i);
    }
    printf("\n\r");
  }
  return 0;
}

