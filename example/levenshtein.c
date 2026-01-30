#ifdef SIM
#include <stdio.h>
#endif
#include <string.h>

int min3(int a, int b, int c)
{
  int m = a;
  if(b < m) m = b;
  if(c < m) m = c;
  return m;
}

int levenshtein(char* a, int a_len, char* b, int b_len)
{
  if(a_len ==0) return b_len;
  if(b_len ==0) return a_len;
  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1;
  int m = min3(
    levenshtein(a, a_len-1, b, b_len) +1, 
    levenshtein(a, a_len, b, b_len-1) +1, 
    levenshtein(a, a_len-1, b, b_len-1) +cost
  );
  return m;
}

#ifdef SIM
int main()
{
  char a[] = "shit";
  char b[] = "urmom";
  char c[] = "Shit!";
  printf("d(%s,%s)=%d\n", a, b, levenshtein(a,strlen(a),b,strlen(b)));
  printf("d(%s,%s)=%d\n", a, c, levenshtein(a,strlen(a),c,strlen(c)));
  return 0;
}
#endif
