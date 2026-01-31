#ifdef SIM
#include <stdio.h>
#else
#include "stdio.h"
#endif

int main()
{
  char a[50] = "helloworld! echo 50 chars\n> ";
  fwrite(a, 1, sizeof(a), stdout);
  fread(a, 1, 50, stdin);
  fwrite(a, 1, sizeof(a), stdout);
  return 0;
}
