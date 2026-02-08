#include "stdarg.h"

typedef unsigned int size_t;
extern char stdout;
extern char stdin;
#define stdout ((void*)&stdout)
#define stdin ((void*)&stdin)
#define EOF (-1)
#define NULL ((void *)0)

int __mulsi3(int a, int b) {
    int res = 0;
    unsigned int u_a = (a < 0) ? -a : a;
    unsigned int u_b = (b < 0) ? -b : b;
    while (u_b > 0) {
        if (u_b & 1) res += u_a;
        u_a <<= 1;
        u_b >>= 1;
    }
    return ((a < 0) ^ (b < 0)) ? -res : res;
}

static unsigned int _u_div_mod(unsigned int n, unsigned int d, unsigned int *mod) {
    unsigned int q = 0, r = 0;
    if (d == 0) return 0;
    for (int i = 31; i >= 0; i--) {
        r = (r << 1) | ((n >> i) & 1);
        if (r >= d) {
            r -= d;
            q |= (1U << i);
        }
    }
    if (mod) *mod = r;
    return q;
}

int __divsi3(int a, int b) {
    unsigned int u_n = (a < 0) ? -a : a;
    unsigned int u_d = (b < 0) ? -b : b;
    unsigned int q = _u_div_mod(u_n, u_d, 0);
    return ((a < 0) ^ (b < 0)) ? -(int)q : (int)q;
}

int __modsi3(int a, int b) {
    unsigned int u_n = (a < 0) ? -a : a;
    unsigned int u_d = (b < 0) ? -b : b;
    unsigned int r;
    _u_div_mod(u_n, u_d, &r);
    return (a < 0) ? -(int)r : (int)r;
}

unsigned int __udivsi3(unsigned int a, unsigned int b) {
    return _u_div_mod(a, b, 0);
}

unsigned int __umodsi3(unsigned int a, unsigned int b) {
    unsigned int r;
    _u_div_mod(a, b, &r);
    return r;
}

char* itoa(int val, char* s) {
    char* ptr = s;
    unsigned int uval;
    
    if (val < 0) {
        *ptr++ = '-';
        uval = (unsigned int)(-val);
    } else {
        uval = (unsigned int)val;
    }

    char buf[11];
    int i = 0;
    // Use the absolute magnitude for division to prevent signed logic errors
    do {
        unsigned int rem;
        uval = _u_div_mod(uval, 10, &rem);
        buf[i++] = (char)(rem + '0');
    } while (uval > 0);

    // Reverse buffer into the destination string
    while (i > 0) {
        *ptr++ = buf[--i];
    }
    *ptr = '\0';
    return s;
}

// --- I/O CORE ---

int fputc(int c, void *stream) { 
    *(volatile unsigned int *)stream = (unsigned int)c;
    return c; 
}

int fgetc(void *stream) { 
    return (unsigned char)(*(volatile char *)stream); 
}

static int skip_ws(void *stream) {
    int c;
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
    return c;
}

size_t fwrite(const void *ptr, size_t size, size_t nmemb, void *stream) {
    const unsigned char *data = (const unsigned char *)ptr;
    size_t total_bytes = size * nmemb;
    
    for (size_t i = 0; i < total_bytes; i++) {
        if (fputc(data[i], stream) == EOF) {
            return i / size; // Return number of full members completed
        }
    }
    return nmemb;
}

size_t fread(void *ptr, size_t size, size_t nmemb, void *stream) {
    unsigned char *data = (unsigned char *)ptr;
    size_t total_bytes = size * nmemb;
    
    for (size_t i = 0; i < total_bytes; i++) {
        int c = fgetc(stream);
        if (c == EOF) {
            return i / size;
        }
        data[i] = (unsigned char)c;
    }
    return nmemb;
}

// printf scanf

int fprintf(void *stream, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    int count = 0;
    char tmp[12]; // Stack buffer for itoa

    for (; *fmt; fmt++) {
        if (*fmt == '%' && *(fmt + 1) == 'd') {
            fmt++;
            itoa(va_arg(args, int), tmp);
            char *p = tmp;
            while (*p) { fputc(*p++, stream); count++; }
        } else {
            fputc(*fmt, stream);
            count++;
        }
    }
    va_end(args);
    return count;
}

int fscanf(void *stream, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    int count = 0;
    for (; *fmt; fmt++) {
        if (*fmt == ' ') { skip_ws(stream); }
        else if (*fmt == '%' && *(++fmt) == 'd') {
            int *dest = va_arg(args, int *);
            int val = 0, c = skip_ws(stream);
            int neg = (c == '-') ? (c = fgetc(stream), 1) : 0;
            while (c >= '0' && c <= '9') {
                val = __mulsi3(val, 10) + (c - '0');
                c = fgetc(stream);
            }
            *dest = neg ? -val : val;
            count++;
        }
    }
    va_end(args);
    return count;
}

