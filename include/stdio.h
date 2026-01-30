typedef unsigned int size_t;
extern char stdout;
extern char stdin; 
#define stdout ((void*)&stdout)
#define stdin ((void*)&stdin)

void *memcpy(void *dest, const void *src, size_t n) {
    char *d = (char *)dest;
    const char *s = (const char *)src;
    while (n--) *d++ = *s++;
    return dest;
}

int __mulsi3(short a, short b) 
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

void swdiv(int a, int b, int *q_out, int *r_out) {
    int q = 0, r = 0;
    unsigned int aa = (a < 0) ? (unsigned int)(-a) : (unsigned int)a;
    unsigned int bb = (b < 0) ? (unsigned int)(-b) : (unsigned int)b;
    if (bb != 0) {
        for (int i = 0; i < 32; i++) {
            r = (r << 1) | ((aa >> 31) & 1);
            aa <<= 1;
            if ((unsigned int)r >= bb) {
                r -= bb;
                q = (q << 1) | 1;
            } else {
                q <<= 1;
            }
        }
    }
    if ((a < 0) != (b < 0)) q = -q;
    if (a < 0) r = -r;
    if (q_out) *q_out = q;
    if (r_out) *r_out = r;
}

int __divsi3(int a, int b) {
    int q;
    swdiv(a, b, &q, 0);
    return q;
}

int __modsi3(int a, int b) {
    int r;
    swdiv(a, b, 0, &r);
    return r;
}

size_t fwrite(const void *ptr, size_t size, size_t nmemb, void *stream) {
    const char *data = (const char *)ptr;
    volatile char *port = (volatile char *)stream;
    size_t total = size * nmemb;
    for (size_t i = 0; i < total; i++) {
        *port = data[i]; 
    }
    return nmemb;
}

size_t fread(void *ptr, size_t size, size_t nmemb, void *stream) {
    char *data = (char *)ptr;
    volatile char *port = (volatile char *)stream;
    size_t total = size * nmemb;
    for (size_t i = 0; i < total; i++) {
        data[i] = *port; 
    }
    return nmemb;
}
