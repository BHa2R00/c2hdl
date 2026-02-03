
example/helloworld.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <__mulsi3>:
extern char stdin;
#define stdout ((void*)&stdout)
#define stdin ((void*)&stdin)

int __mulsi3(short a, short b) 
{
   0:	ff810113          	addi	sp,sp,-8
   4:	00112223          	sw	ra,4(sp)
   8:	00812023          	sw	s0,0(sp)
   c:	00810413          	addi	s0,sp,8
  10:	00050693          	mv	a3,a0
  int m = 0;
  unsigned short aa = (unsigned short)(short)a;
  unsigned short bb = (unsigned short)(short)b;
  if(aa & (1<<15)) aa = -aa;
  14:	40f55793          	srai	a5,a0,0xf
  18:	00f54733          	xor	a4,a0,a5
  1c:	40f70733          	sub	a4,a4,a5
  20:	01071713          	slli	a4,a4,0x10
  24:	01075713          	srli	a4,a4,0x10
  if(bb & (1<<15)) bb = -bb;
  28:	40f5d613          	srai	a2,a1,0xf
  2c:	00c5c7b3          	xor	a5,a1,a2
  30:	40c787b3          	sub	a5,a5,a2
  34:	01079793          	slli	a5,a5,0x10
  38:	0107d793          	srli	a5,a5,0x10
  3c:	00000513          	li	a0,0
  while(aa) {
  40:	02071063          	bnez	a4, 0x60 <__mulsi3+0x60>
    if(aa & 1) m += bb;
     0xbb <<=1;
    aa >>=1;
  }
  if((a<0)!=(b<0)) m = -m;
  44:	00b6c6b3          	xor	a3,a3,a1
  48:	0006d463          	bgez	a3, 0x50 <__mulsi3+0x50>
  4c:	40a00533          	neg	a0,a0
  return m;
}
  50:	00412083          	lw	ra,4(sp)
  54:	00012403          	lw	s0,0(sp)
  58:	00810113          	addi	sp,sp,8
  5c:	00008067          	ret
    if(aa & 1) m += bb;
  60:	00177613          	andi	a2,a4,1
  64:	00060463          	beqz	a2, 0x6c <__mulsi3+0x6c>
  68:	00f50533          	add	a0,a0,a5
     0xbb <<=1;
  6c:	00179793          	slli	a5,a5,0x1
  70:	01079793          	slli	a5,a5,0x10
  74:	0107d793          	srli	a5,a5,0x10
    aa >>=1;
  78:	00175713          	srli	a4,a4,0x1
  7c:	fc5ff06f          	j	 0x40 <__mulsi3+0x40>

 0x00000080 <fwrite>:
    int r;
    swdiv(a, b, 0, &r);
    return r;
}

size_t fwrite(const void *ptr, size_t size, size_t nmemb, void *stream) {
  80:	fec10113          	addi	sp,sp,-20
  84:	00112823          	sw	ra,16(sp)
  88:	00812623          	sw	s0,12(sp)
  8c:	00912423          	sw	s1,8(sp)
  90:	01410413          	addi	s0,sp,20
  94:	00050493          	mv	s1,a0
  98:	00058513          	mv	a0,a1
  9c:	00060593          	mv	a1,a2
  a0:	fed42623          	sw	a3,-20(s0)
    const char *data = (const char *)ptr;
    volatile char *port = (volatile char *)stream;
    size_t total = size * nmemb;
  a4:	fec42823          	sw	a2,-16(s0)
  a8:	00000097          	auipc	ra,0x0
  ac:	f58080e7          	jalr	-168(ra) #  0x0 <__mulsi3>
    for (size_t i = 0; i < total; i++) {
  b0:	00000793          	li	a5,0
  b4:	ff042583          	lw	a1,-16(s0)
  b8:	fec42683          	lw	a3,-20(s0)
  bc:	00a79e63          	bne	a5,a0, 0xd8 <fwrite+0x58>
        *port = data[i]; 
    }
    return nmemb;
}
  c0:	00058513          	mv	a0,a1
  c4:	01012083          	lw	ra,16(sp)
  c8:	00c12403          	lw	s0,12(sp)
  cc:	00812483          	lw	s1,8(sp)
  d0:	01410113          	addi	sp,sp,20
  d4:	00008067          	ret
        *port = data[i]; 
  d8:	00f48633          	add	a2,s1,a5
  dc:	00064603          	lbu	a2,0(a2)
  e0:	00c68023          	sb	a2,0(a3)
    for (size_t i = 0; i < total; i++) {
  e4:	00178793          	addi	a5,a5,1
  e8:	fd5ff06f          	j	 0xbc <fwrite+0x3c>

 0x000000ec <fread>:

size_t fread(void *ptr, size_t size, size_t nmemb, void *stream) {
  ec:	fec10113          	addi	sp,sp,-20
  f0:	00112823          	sw	ra,16(sp)
  f4:	00812623          	sw	s0,12(sp)
  f8:	00912423          	sw	s1,8(sp)
  fc:	01410413          	addi	s0,sp,20
 100:	00050493          	mv	s1,a0
 104:	00058513          	mv	a0,a1
 108:	fec42823          	sw	a2,-16(s0)
 10c:	fed42623          	sw	a3,-20(s0)
    char *data = (char *)ptr;
    volatile char *port = (volatile char *)stream;
    size_t total = size * nmemb;
 110:	00060593          	mv	a1,a2
 114:	00000097          	auipc	ra,0x0
 118:	eec080e7          	jalr	-276(ra) #  0x0 <__mulsi3>
    for (size_t i = 0; i < total; i++) {
 11c:	00000793          	li	a5,0
 120:	fec42683          	lw	a3,-20(s0)
 124:	00a79e63          	bne	a5,a0, 0x140 <fread+0x54>
        data[i] = *port; 
    }
    return nmemb;
}
 128:	ff042503          	lw	a0,-16(s0)
 12c:	01012083          	lw	ra,16(sp)
 130:	00c12403          	lw	s0,12(sp)
 134:	00812483          	lw	s1,8(sp)
 138:	01410113          	addi	sp,sp,20
 13c:	00008067          	ret
        data[i] = *port; 
 140:	0006c583          	lbu	a1,0(a3)
 144:	00f48633          	add	a2,s1,a5
 148:	00b60023          	sb	a1,0(a2)
    for (size_t i = 0; i < total; i++) {
 14c:	00178793          	addi	a5,a5,1
 150:	fd5ff06f          	j	 0x124 <fread+0x38>

 0x00000154 <memcpy>:

void *memcpy(void *dest, const void *src, size_t n) {
 154:	ff810113          	addi	sp,sp,-8
 158:	00112223          	sw	ra,4(sp)
 15c:	00812023          	sw	s0,0(sp)
 160:	00810413          	addi	s0,sp,8
    char *d = (char *)dest;
    const char *s = (const char *)src;
    while (n--) *d++ = *s++;
 164:	00000793          	li	a5,0
 168:	00f61a63          	bne	a2,a5, 0x17c <memcpy+0x28>
    return dest;
}
 16c:	00412083          	lw	ra,4(sp)
 170:	00012403          	lw	s0,0(sp)
 174:	00810113          	addi	sp,sp,8
 178:	00008067          	ret
    while (n--) *d++ = *s++;
 17c:	00f58733          	add	a4,a1,a5
 180:	00074683          	lbu	a3,0(a4)
 184:	00f50733          	add	a4,a0,a5
 188:	00d70023          	sb	a3,0(a4)
 18c:	00178793          	addi	a5,a5,1
 190:	fd9ff06f          	j	 0x168 <memcpy+0x14>

 0x00000194 <main>:
#include "stdio.h"
#include "string.h"
#endif

int main()
{
 194:	fc010113          	addi	sp,sp,-64
 198:	02112e23          	sw	ra,60(sp)
 19c:	02812c23          	sw	s0,56(sp)
 1a0:	02912a23          	sw	s1,52(sp)
 1a4:	04010413          	addi	s0,sp,64
  while(1) {
    char a[50] = "\n\rhelloworld! echo 50 chars\n\r> ";
 1a8:	02000613          	li	a2,32
 1ac:	00001597          	auipc	a1,0x1
 1b0:	e5458593          	addi	a1,a1,-428 #  0x1000 <main+0xe6c>
 1b4:	fc040493          	addi	s1,s0,-64
 1b8:	00048513          	mv	a0,s1
 1bc:	00000097          	auipc	ra,0x0
 1c0:	f98080e7          	jalr	-104(ra) #  0x154 <memcpy>
 1c4:	fe042023          	sw	zero,-32(s0)
 1c8:	fe042223          	sw	zero,-28(s0)
 1cc:	fe042423          	sw	zero,-24(s0)
 1d0:	fe042623          	sw	zero,-20(s0)
 1d4:	fe041823          	sh	zero,-16(s0)
    fwrite(a, 1, sizeof(a), stdout);
 1d8:	00001697          	auipc	a3,0x1
 1dc:	e606a683          	lw	a3,-416(a3) #  0x1038 <_GLOBAL_OFFSET_TABLE_+0x4>
 1e0:	03200613          	li	a2,50
 1e4:	00100593          	li	a1,1
 1e8:	00048513          	mv	a0,s1
 1ec:	00000097          	auipc	ra,0x0
 1f0:	e94080e7          	jalr	-364(ra) #  0x80 <fwrite>
    fread(a, 1, 50, stdin);
 1f4:	00001697          	auipc	a3,0x1
 1f8:	e486a683          	lw	a3,-440(a3) #  0x103c <_GLOBAL_OFFSET_TABLE_+0x8>
 1fc:	03200613          	li	a2,50
 200:	00100593          	li	a1,1
 204:	00048513          	mv	a0,s1
 208:	00000097          	auipc	ra,0x0
 20c:	ee4080e7          	jalr	-284(ra) #  0xec <fread>
    fwrite(a, 1, sizeof(a), stdout);
 210:	00001697          	auipc	a3,0x1
 214:	e286a683          	lw	a3,-472(a3) #  0x1038 <_GLOBAL_OFFSET_TABLE_+0x4>
 218:	03200613          	li	a2,50
 21c:	00100593          	li	a1,1
 220:	00048513          	mv	a0,s1
 224:	00000097          	auipc	ra,0x0
 228:	e5c080e7          	jalr	-420(ra) #  0x80 <fwrite>
  while(1) {
 22c:	f7dff06f          	j	 0x1a8 <main+0x14>
