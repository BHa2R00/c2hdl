#ifdef SIM
#include <stdio.h>
#endif

typedef struct 
{
  volatile int*  A;
  volatile int   a;
  volatile int   a_top;
  volatile int   i, j;
  volatile int   p, r;
} filo_t;

void push_a(filo_t* f)
{
  f->A[f->a_top] = f->a;
  f->a_top++;
}

void pop_a(filo_t* f)
{
  f->a_top--;
  f->a = f->A[f->a_top];
}

void swap(filo_t* f) 
{
  if(f->A[f->i] > f->A[f->j]) {
    if(f->A[f->i] == f->A[f->j]) return;
    f->A[f->i] ^= f->A[f->j];
    f->A[f->j] ^= f->A[f->i];
    f->A[f->i] ^= f->A[f->j];
  }
}

void insertsort (filo_t* f)
{
  for(f->p=1; f->p < f->a_top; f->p++) {
    for(f->r = f->p-1; f->r >= 0; f->r--) {
      f->i = f->r;
      f->j = f->r+1;
      swap(f);
    }
  }
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
  filo_t f;
  int A[75];
  f.a_top = 0;
  f.A = A;
  printf("push\n");
  for(int k=0;k<75;k++) {
    f.a = random();
    printf("%8d  %8d\n", k, f.a);
    push_a(&f);
  }
  printf("sort\n");
  insertsort(&f);
  printf("pop\n");
  for(int k=0;k<75;k++) {
    pop_a(&f);
    printf("%8d  %8d\n", k, f.a);
  }
  return 0;
}
#endif
