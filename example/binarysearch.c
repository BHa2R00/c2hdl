#ifdef SIM
#include <stdio.h>
#else 
#include "stdio.h"
#endif

int binarysearch(int* A, int l, int r, int t)
{
  int L=l, R=r;
  while(L<R) {
    int m = L+((R-L)>>1);
    if(A[m]>t) R=m;
    else L=m+1;
  }
  return R-1;
}

#ifdef SIM
int random()
{
  FILE* fp = fopen("/dev/urandom","rb");
  int r;
  fread(&r, sizeof(int), 1, fp);
  return r;
}

int main()
{
  int A[100];
  int k, j=-5000;
  for(k=0;k<100;k++) {
    A[k] = j; 
    printf("%5d: %5d ", k, A[k]);
    if(k%8==7) putchar('\n');
    j += (random() & 0xff);
  }
  j = (j-5000)/2;
  k = binarysearch(A, 0, 100, j);
  printf("\nsearch(%5d)=%5d : %5d \n", j, k, A[k]);
  return 0;
}
#endif
