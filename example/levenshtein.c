#ifdef SIM
#include <stdio.h>
#endif
#include <string.h>

int levenshtein(char* a, int a_len, char* b, int b_len)
{
  if(a_len ==0) return b_len;
  if(b_len ==0) return a_len;
  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1;
  int d = levenshtein(a, a_len-1, b, b_len) +1;
  int i = levenshtein(a, a_len, b, b_len-1) +1;
  int s = levenshtein(a, a_len-1, b, b_len-1) +cost;
  if(i < d) d = i;
  if(s < d) d = s;
  return d;
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
