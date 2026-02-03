#ifdef SIM
#include <stdio.h>
#include <string.h>
#else
#include "stdio.h"
#include "string.h"
#endif

int main()
{
  while(1) {
    char a[50] = "\n\rhelloworld! echo 50 chars\n\r> ";
    fwrite(a, 1, sizeof(a), stdout);
    fread(a, 1, 50, stdin);
    fwrite(a, 1, sizeof(a), stdout);
  }
  return 0;
}
