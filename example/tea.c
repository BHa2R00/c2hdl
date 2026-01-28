#ifdef SIM
#include <stdio.h>
#endif

int swmul(short a, short b) 
{
  int m = 0;
  unsigned short aa = (unsigned short)(short)a;
  unsigned short bb = (unsigned short)(short)b;
  if(aa & (1<<15)) aa = -aa;
  if(bb & (1<<15)) bb = -bb;
  while(aa) {
    if(aa & 1) m += bb;
    bb <<=1;
    aa >>=1;
  }
  if((a<0)!=(b<0)) m = -m;
  return m;
}

#define DELTA 0x9E37
#define SHL 4
#define SHR 5
typedef struct 
{
  volatile int round;
  volatile unsigned short* dat;
  volatile unsigned short* key;
} tea_t;

void tinyenc(tea_t* t)
{
  unsigned short x = t->dat[0];
  unsigned short y = t->dat[1];
  unsigned short sum = 0;
  int i;
  for(i=0;i<t->round;i++){
    sum += DELTA;
    x += ((y << SHL) + t->key[0]) ^ (y + sum) ^ ((y >> SHR) + t->key[1]);
    y += ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3]);
    #ifdef SIM
    printf("sum = %x\n", sum);
    #endif
  }
  t->dat[0] = x;
  t->dat[1] = y;
}

void tinydec (tea_t* t) {
  unsigned short x = t->dat[0];
  unsigned short y = t->dat[1];
  unsigned short sum = swmul(DELTA, t->round);
  int i;
  for(i=0;i<t->round;i++){
    y -= ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3]);
    x -= ((y << SHL) + t->key[0]) ^ (y + sum) ^ ((y >> SHR) + t->key[1]);
    sum -= DELTA;
    #ifdef SIM
    printf("sum = %x\n", sum);
    #endif
  }
  t->dat[0] = x;
  t->dat[1] = y;
}

#ifdef SIM
int main ()
{
  tea_t e;
  unsigned short dat[3] = {0x4443,0x4241,0x0};
  unsigned short key[4] = {0x1234,0x5678,0x9ABC,0xDEF1};
  e.round =10;
  e.dat = dat;
  e.key = key;
  printf("plain = %s\n", (char*)dat);
  tinyenc(&e);
  printf("ciper = %lx , %s\n", *(long unsigned int*)dat, (char*)dat);
  tinydec(&e);
  printf("plain = %s\n", (char*)dat);
  return 0;
}
#endif
