#ifdef SIM
#include <stdio.h>
#include <string.h>
#else
#include "stdio.h"
#include "string.h"
#endif

int main()
{
  fprintf(stdout, "\r\nhello world\n\r> ");
  while(1) {
    int a=1, b=1, c=0, l;
    fprintf(stdout, "input a limit of fibonacci\n\r> ");
    fscanf(stdin, "%d", &l);
    fprintf(stdout, "%d\n", l);
    if(l < 0) {
      a=-1; b=-1;
      while(a > l) {
        c = a+b;
        a = b;
        b = c;
        fprintf(stdout, "%d ", a);
      }
    }
    else {
      while(a < l) {
        c = a+b;
        a = b;
        b = c;
        fprintf(stdout, "%d ", a);
      }
    }
    fprintf(stdout,"\n\r");
  }
  return 0;
}
