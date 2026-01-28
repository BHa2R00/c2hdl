#ifdef SIM
#include <stdio.h>
#endif

typedef struct { volatile int a,b,c, k; } counter_t;

void fibonacci_step (counter_t* t) 
{
  t->c = t->a + t->b;
  t->a = t->b;
  t->b = t->c;
  #ifdef SIM
  printf("a=%d, b=%d, c=%d, k=%d\n", t->a, t->b, t->c, t->k);
  #endif
}

void fibonacci (counter_t* t)
{
  while(--t->k >= 0) fibonacci_step(t);
}

#ifdef SIM
int main ()
{
  counter_t c;
  c.a =0;
  c.b =1;
  c.k =16;
  fibonacci(&c);
  return 0;
}
#endif
