#ifdef SIM
#include <stdio.h>
#else
#include "sw.h"
#endif

#ifdef SIM
int main()
{
  char a[] = "shit! urmom is so fat\n";
  fwrite(a, 1, sizeof(a), stdout);
  return 0;
}
#endif
