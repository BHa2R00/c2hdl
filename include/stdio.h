#include "stdarg.h"

typedef unsigned int size_t;
extern char stdout;
extern char stdin;
extern unsigned int lfsr;
#define stdout ((void*)&stdout)
#define stdin ((void*)&stdin)
#define lfsr ((void*)&lfsr)
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

static unsigned int __udivsi3_umodsi3(unsigned int n, unsigned int d, unsigned int *mod) {
    if (d == 0) return 0;
    unsigned int q = 0;
    unsigned int r = 0;
    for (int i = 0; i < 32; i++) {
        r = (r << 1) | (n >> 31);
        n <<= 1; 
        if (r >= d) {
            r -= d;
            q = (q << 1) | 1;
        } else {
            q <<= 1;
        }
    }
    if (mod) *mod = r;
    return q;
}

int __divsi3(int a, int b) {
    unsigned int u_n = (a < 0) ? -a : a;
    unsigned int u_d = (b < 0) ? -b : b;
    unsigned int q = __udivsi3_umodsi3(u_n, u_d, 0);
    return ((a < 0) ^ (b < 0)) ? -(int)q : (int)q;
}

int __modsi3(int a, int b) {
    unsigned int u_n = (a < 0) ? -a : a;
    unsigned int u_d = (b < 0) ? -b : b;
    unsigned int r;
    __udivsi3_umodsi3(u_n, u_d, &r);
    return (a < 0) ? -(int)r : (int)r;
}

unsigned int __udivsi3(unsigned int a, unsigned int b) {
    return __udivsi3_umodsi3(a, b, 0);
}

unsigned int __umodsi3(unsigned int a, unsigned int b) {
    unsigned int r;
    __udivsi3_umodsi3(a, b, &r);
    return r;
}

unsigned long long __lshrdi3(unsigned long long u, int b) {
    if (b == 0) return u;
    unsigned int *p = (unsigned int *)&u;
    unsigned int low  = p[0];
    unsigned int high = p[1];
    unsigned int res_low, res_high;
    if (b >= 32) {
        res_high = 0;
        res_low  = high >> (b - 32);
    } else {
        res_high = high >> b;
        res_low  = (low >> b) | (high << (32 - b));
    }
    unsigned long long result;
    unsigned int *res_p = (unsigned int *)&result;
    res_p[0] = res_low;
    res_p[1] = res_high;
    return result;
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

int rand() { 
    return (int)(*(volatile unsigned int *)lfsr); 
}

// printf scanf

static void _fmt_base(void *stream, unsigned int uval, int base, int *count) {
    char tmp[12];
    int i = 11;
    tmp[i] = '\0';
    
    do {
        unsigned int rem;
        // Reuses your Booth-style or hardware divider logic
        uval = __udivsi3_umodsi3(uval, base, &rem);
        tmp[--i] = (rem < 10) ? (char)(rem + '0') : (char)(rem - 10 + 'a');
    } while (uval > 0);

    char *p = &tmp[i];
    while (*p) { 
        fputc(*p++, stream); 
        (*count)++; 
    }
}

static void fprintf_d(void *stream, int val, int *count) {
    if (val < 0) {
        fputc('-', stream);
        (*count)++;
        val = -val;
    }
    _fmt_base(stream, (unsigned int)val, 10, count);
}

static void fprintf_x(void *stream, unsigned int val, int *count) {
    _fmt_base(stream, val, 16, count);
}

static void fprintf_s(void *stream, char *s, int *count) {
    if (!s) s = "(null)";
    while (*s) { fputc(*s++, stream); (*count)++; }
}

static void fscanf_d(void *stream, int *dest, int *count) {
    int val = 0, c = skip_ws(stream);
    int neg = (c == '-') ? (c = fgetc(stream), 1) : 0;
    while (c >= '0' && c <= '9') {
        val = __mulsi3(val, 10) + (c - '0');
        c = fgetc(stream);
    }
    *dest = neg ? -val : val;
    (*count)++;
}

static void fscanf_x(void *stream, unsigned int *dest, int *count) {
    unsigned int val = 0;
    int c = skip_ws(stream);
    while (1) {
        int digit;
        if (c >= '0' && c <= '9')      digit = c - '0';
        else if (c >= 'a' && c <= 'f') digit = c - 'a' + 10;
        else if (c >= 'A' && c <= 'F') digit = c - 'A' + 10;
        else break;
        val = (val << 4) | digit;
        c = fgetc(stream);
    }
    *dest = val;
    (*count)++;
}

static void fscanf_s(void *stream, char *dest, int *count) {
    int c = skip_ws(stream);
    if (c == -1) return;
    while (c != -1 && c != ' ' && c != '\t' && c != '\n' && c != '\r') {
        *dest++ = (char)c;
        c = fgetc(stream);
    }
    *dest = '\0';
    (*count)++;
}

int fprintf(void *stream, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    int count = 0;
    for (; *fmt; fmt++) {
        if (*fmt == '%' && *(fmt + 1)) {
            fmt++;
            switch (*fmt) {
                case 'd': fprintf_d(stream, va_arg(args, int), &count); break;
                case 'x': fprintf_x(stream, va_arg(args, unsigned int), &count); break;
                case 's': fprintf_s(stream, va_arg(args, char *), &count); break;
                default:  fputc(*fmt, stream);
            }
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
        if (*fmt == ' ') skip_ws(stream);
        else if (*fmt == '%' && *(fmt + 1)) {
            fmt++;
            switch (*fmt) {
                case 'd': fscanf_d(stream, va_arg(args, int *), &count); break;
                case 'x': fscanf_x(stream, va_arg(args, unsigned int *), &count); break;
                case 's': fscanf_s(stream, va_arg(args, char *), &count); break;
            }
        }
    }
    va_end(args);
    return count;
}

#define printf(...)  fprintf(stdout, __VA_ARGS__)
#define scanf(...)   fscanf(stdin, __VA_ARGS__)

