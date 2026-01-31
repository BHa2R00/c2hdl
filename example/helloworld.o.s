
example/helloworld.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <memcpy>:
extern char stdout;
extern char stdin;
#define stdout ((void*)&stdout)
#define stdin ((void*)&stdin)

void *memcpy(void *dest, const void *src, size_t n) {
   0:	ff810113          	addi	sp,sp,-8
   4:	00112223          	sw	ra,4(sp)
   8:	00812023          	sw	s0,0(sp)
   c:	00810413          	addi	s0,sp,8
    char *d = (char *)dest;
    const char *s = (const char *)src;
    while (n--) *d++ = *s++;
  10:	00000793          	li	a5,0
  14:	00f61a63          	bne	a2,a5, 0x28 <memcpy+0x28>
    return dest;
}
  18:	00412083          	lw	ra,4(sp)
  1c:	00012403          	lw	s0,0(sp)
  20:	00810113          	addi	sp,sp,8
  24:	00008067          	ret
    while (n--) *d++ = *s++;
  28:	00f58733          	add	a4,a1,a5
  2c:	00074683          	lbu	a3,0(a4)
  30:	00f50733          	add	a4,a0,a5
  34:	00d70023          	sb	a3,0(a4)
  38:	00178793          	addi	a5,a5,1
  3c:	fd9ff06f          	j	 0x14 <memcpy+0x14>

 0x00000040 <memset>:

void *memset(void *s, int c, size_t n) {
  40:	ff810113          	addi	sp,sp,-8
  44:	00112223          	sw	ra,4(sp)
  48:	00812023          	sw	s0,0(sp)
  4c:	00810413          	addi	s0,sp,8
    unsigned char *p = (unsigned char *)s;
    while (n--) {
  50:	00c50633          	add	a2,a0,a2
    unsigned char *p = (unsigned char *)s;
  54:	00050793          	mv	a5,a0
    while (n--) {
  58:	00c79a63          	bne	a5,a2, 0x6c <memset+0x2c>
        *p++ = (unsigned char)c;
    }
    return s;
}
  5c:	00412083          	lw	ra,4(sp)
  60:	00012403          	lw	s0,0(sp)
  64:	00810113          	addi	sp,sp,8
  68:	00008067          	ret
        *p++ = (unsigned char)c;
  6c:	00178793          	addi	a5,a5,1
  70:	feb78fa3          	sb	a1,-1(a5)
  74:	fe5ff06f          	j	 0x58 <memset+0x18>

 0x00000078 <__mulsi3>:

int __mulsi3(short a, short b) 
{
  78:	ff810113          	addi	sp,sp,-8
  7c:	00112223          	sw	ra,4(sp)
  80:	00812023          	sw	s0,0(sp)
  84:	00810413          	addi	s0,sp,8
  88:	00050693          	mv	a3,a0
  int m = 0;
  unsigned short aa = (unsigned short)(short)a;
  unsigned short bb = (unsigned short)(short)b;
  if(aa & (1<<15)) aa = -aa;
  8c:	40f55793          	srai	a5,a0,0xf
  90:	00f54733          	xor	a4,a0,a5
  94:	40f70733          	sub	a4,a4,a5
  98:	01071713          	slli	a4,a4,0x10
  9c:	01075713          	srli	a4,a4,0x10
  if(bb & (1<<15)) bb = -bb;
  a0:	40f5d613          	srai	a2,a1,0xf
  a4:	00c5c7b3          	xor	a5,a1,a2
  a8:	40c787b3          	sub	a5,a5,a2
  ac:	01079793          	slli	a5,a5,0x10
  b0:	0107d793          	srli	a5,a5,0x10
  b4:	00000513          	li	a0,0
  while(aa) {
  b8:	02071063          	bnez	a4, 0xd8 <__mulsi3+0x60>
    if(aa & 1) m += bb;
     0xbb <<=1;
    aa >>=1;
  }
  if((a<0)!=(b<0)) m = -m;
  bc:	00b6c6b3          	xor	a3,a3,a1
  c0:	0006d463          	bgez	a3, 0xc8 <__mulsi3+0x50>
  c4:	40a00533          	neg	a0,a0
  return m;
}
  c8:	00412083          	lw	ra,4(sp)
  cc:	00012403          	lw	s0,0(sp)
  d0:	00810113          	addi	sp,sp,8
  d4:	00008067          	ret
    if(aa & 1) m += bb;
  d8:	00177613          	andi	a2,a4,1
  dc:	00060463          	beqz	a2, 0xe4 <__mulsi3+0x6c>
  e0:	00f50533          	add	a0,a0,a5
     0xbb <<=1;
  e4:	00179793          	slli	a5,a5,0x1
  e8:	01079793          	slli	a5,a5,0x10
  ec:	0107d793          	srli	a5,a5,0x10
    aa >>=1;
  f0:	00175713          	srli	a4,a4,0x1
  f4:	fc5ff06f          	j	 0xb8 <__mulsi3+0x40>

 0x000000f8 <fwrite>:
    int r;
    swdiv(a, b, 0, &r);
    return r;
}

size_t fwrite(const void *ptr, size_t size, size_t nmemb, void *stream) {
  f8:	fec10113          	addi	sp,sp,-20
  fc:	00112823          	sw	ra,16(sp)
 100:	00812623          	sw	s0,12(sp)
 104:	00912423          	sw	s1,8(sp)
 108:	01410413          	addi	s0,sp,20
 10c:	00050493          	mv	s1,a0
 110:	00058513          	mv	a0,a1
 114:	00060593          	mv	a1,a2
 118:	fed42623          	sw	a3,-20(s0)
    const char *data = (const char *)ptr;
    volatile char *port = (volatile char *)stream;
    size_t total = size * nmemb;
 11c:	fec42823          	sw	a2,-16(s0)
 120:	00000097          	auipc	ra,0x0
 124:	f58080e7          	jalr	-168(ra) #  0x78 <__mulsi3>
    for (size_t i = 0; i < total; i++) {
 128:	00000793          	li	a5,0
 12c:	ff042583          	lw	a1,-16(s0)
 130:	fec42683          	lw	a3,-20(s0)
 134:	00a79e63          	bne	a5,a0, 0x150 <fwrite+0x58>
        *port = data[i]; 
    }
    return nmemb;
}
 138:	00058513          	mv	a0,a1
 13c:	01012083          	lw	ra,16(sp)
 140:	00c12403          	lw	s0,12(sp)
 144:	00812483          	lw	s1,8(sp)
 148:	01410113          	addi	sp,sp,20
 14c:	00008067          	ret
        *port = data[i]; 
 150:	00f48633          	add	a2,s1,a5
 154:	00064603          	lbu	a2,0(a2)
 158:	00c68023          	sb	a2,0(a3)
    for (size_t i = 0; i < total; i++) {
 15c:	00178793          	addi	a5,a5,1
 160:	fd5ff06f          	j	 0x134 <fwrite+0x3c>

 0x00000164 <fread>:

size_t fread(void *ptr, size_t size, size_t nmemb, void *stream) {
 164:	fec10113          	addi	sp,sp,-20
 168:	00112823          	sw	ra,16(sp)
 16c:	00812623          	sw	s0,12(sp)
 170:	00912423          	sw	s1,8(sp)
 174:	01410413          	addi	s0,sp,20
 178:	00050493          	mv	s1,a0
 17c:	00058513          	mv	a0,a1
 180:	fec42823          	sw	a2,-16(s0)
 184:	fed42623          	sw	a3,-20(s0)
    char *data = (char *)ptr;
    volatile char *port = (volatile char *)stream;
    size_t total = size * nmemb;
 188:	00060593          	mv	a1,a2
 18c:	00000097          	auipc	ra,0x0
 190:	eec080e7          	jalr	-276(ra) #  0x78 <__mulsi3>
    for (size_t i = 0; i < total; i++) {
 194:	00000793          	li	a5,0
 198:	fec42683          	lw	a3,-20(s0)
 19c:	00a79e63          	bne	a5,a0, 0x1b8 <fread+0x54>
        data[i] = *port; 
    }
    return nmemb;
}
 1a0:	ff042503          	lw	a0,-16(s0)
 1a4:	01012083          	lw	ra,16(sp)
 1a8:	00c12403          	lw	s0,12(sp)
 1ac:	00812483          	lw	s1,8(sp)
 1b0:	01410113          	addi	sp,sp,20
 1b4:	00008067          	ret
        data[i] = *port; 
 1b8:	0006c583          	lbu	a1,0(a3)
 1bc:	00f48633          	add	a2,s1,a5
 1c0:	00b60023          	sb	a1,0(a2)
    for (size_t i = 0; i < total; i++) {
 1c4:	00178793          	addi	a5,a5,1
 1c8:	fd5ff06f          	j	 0x19c <fread+0x38>

 0x000001cc <main>:
#else
#include "stdio.h"
#endif

int main()
{
 1cc:	fc010113          	addi	sp,sp,-64
 1d0:	02112e23          	sw	ra,60(sp)
 1d4:	02812c23          	sw	s0,56(sp)
 1d8:	02912a23          	sw	s1,52(sp)
 1dc:	04010413          	addi	s0,sp,64
  char a[50] = "helloworld! echo 50 chars\n> ";
 1e0:	01d00613          	li	a2,29
 1e4:	00001597          	auipc	a1,0x1
 1e8:	e1c58593          	addi	a1,a1,-484 #  0x1000 <main+0xe34>
 1ec:	fc040493          	addi	s1,s0,-64
 1f0:	00048513          	mv	a0,s1
 1f4:	00000097          	auipc	ra,0x0
 1f8:	e0c080e7          	jalr	-500(ra) #  0x0 <memcpy>
 1fc:	01500613          	li	a2,21
 200:	00000593          	li	a1,0
 204:	fdd40513          	addi	a0,s0,-35
 208:	00000097          	auipc	ra,0x0
 20c:	e38080e7          	jalr	-456(ra) #  0x40 <memset>
  fwrite(a, 1, sizeof(a), stdout);
 210:	00001697          	auipc	a3,0x1
 214:	e286a683          	lw	a3,-472(a3) #  0x1038 <_GLOBAL_OFFSET_TABLE_+0x4>
 218:	03200613          	li	a2,50
 21c:	00100593          	li	a1,1
 220:	00048513          	mv	a0,s1
 224:	00000097          	auipc	ra,0x0
 228:	ed4080e7          	jalr	-300(ra) #  0xf8 <fwrite>
  fread(a, 1, 50, stdin);
 22c:	00001697          	auipc	a3,0x1
 230:	e106a683          	lw	a3,-496(a3) #  0x103c <_GLOBAL_OFFSET_TABLE_+0x8>
 234:	03200613          	li	a2,50
 238:	00100593          	li	a1,1
 23c:	00048513          	mv	a0,s1
 240:	00000097          	auipc	ra,0x0
 244:	f24080e7          	jalr	-220(ra) #  0x164 <fread>
  fwrite(a, 1, sizeof(a), stdout);
 248:	00001697          	auipc	a3,0x1
 24c:	df06a683          	lw	a3,-528(a3) #  0x1038 <_GLOBAL_OFFSET_TABLE_+0x4>
 250:	03200613          	li	a2,50
 254:	00100593          	li	a1,1
 258:	00048513          	mv	a0,s1
 25c:	00000097          	auipc	ra,0x0
 260:	e9c080e7          	jalr	-356(ra) #  0xf8 <fwrite>
  return 0;
}
 264:	00000513          	li	a0,0
 268:	03c12083          	lw	ra,60(sp)
 26c:	03812403          	lw	s0,56(sp)
 270:	03412483          	lw	s1,52(sp)
 274:	04010113          	addi	sp,sp,64
 278:	00008067          	ret
