#ifdef SIM
#include <stdio.h>
#endif

typedef struct { volatile int p, r; } pr_t;
typedef struct 
{
  volatile int*  A;
  volatile int   a;
  volatile int   a_top;
  volatile int   i, j;
  volatile int   x;
  volatile pr_t* pr;
  volatile int   pr_top;
  volatile int   p, r, q;
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
  if(f->A[f->i] == f->A[f->j]) return;
  f->A[f->i] ^= f->A[f->j];
  f->A[f->j] ^= f->A[f->i];
  f->A[f->i] ^= f->A[f->j];
}

void push_pr(filo_t* f)
{
  pr_t pr;
  pr.p = f->p;
  pr.r = f->r;
  f->pr_top++;
  f->pr[f->pr_top] = pr;
}

void pop_pr(filo_t* f)
{
  pr_t pr;
  pr = f->pr[f->pr_top];
  f->p = pr.p;
  f->r = pr.r;
  f->pr_top--;
}

void partition(filo_t* f)
{
  f->x = f->A[f->r];
  f->i = f->p;
  for(f->j=f->p; f->j != f->r; f->j++) {
    if(f->A[f->j] < f->x) {
      swap(f);
      f->i++;
    }
  }
  swap(f);
  f->q = f->i;
}

void quicksort(filo_t* f)
{
  f->pr_top = -1;
  f->p = 0;
  f->r = f->a_top -1;
  push_pr(f);
  while(f->pr_top >= 0) {
    pop_pr(f);
    if(f->p < f->r) {
      partition(f);
      int q = f->q;
      int r = f->r;
      int p = f->p;
      f->p =q +1;
      f->r =r;
      if(f->p < f->r) push_pr(f);
      f->p = p;
      f->r = q-1;
      if(f->p < f->r) push_pr(f);
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
  pr_t pr[16];
  int A[75];
  f.a_top = 0;
  f.A = A;
  f.pr = pr;
  printf("push\n");
  for(int k=0;k<75;k++) {
    f.a = random();
    printf("%8d  %8d\n", k, f.a);
    push_a(&f);
  }
  printf("sort\n");
  quicksort(&f);
  printf("pop\n");
  for(int k=0;k<75;k++) {
    pop_a(&f);
    printf("%8d  %8d\n", k, f.a);
  }
  return 0;
}
#endif
