
example/helloworld.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <__mulsi3>:
#define stdout ((void*)&stdout)
#define stdin ((void*)&stdin)
#define EOF (-1)
#define NULL ((void *)0)

int __mulsi3(int a, int b) {
   0:	ff810113          	addi	sp,sp,-8
   4:	00112223          	sw	ra,4(sp)
   8:	00812023          	sw	s0,0(sp)
   c:	00810413          	addi	s0,sp,8
  10:	00050793          	mv	a5,a0
    int res = 0;
    unsigned int u_a = ( 0xa < 0) ? -a : a;
  14:	41f55713          	srai	a4,a0,0x1f
  18:	00a746b3          	xor	a3,a4,a0
  1c:	40e686b3          	sub	a3,a3,a4
    unsigned int u_b = ( 0xb < 0) ? -b : b;
  20:	41f5d613          	srai	a2,a1,0x1f
  24:	00b64733          	xor	a4,a2,a1
  28:	40c70733          	sub	a4,a4,a2
    int res = 0;
  2c:	00000513          	li	a0,0
    while (u_b > 0) {
  30:	02071063          	bnez	a4, 0x50 <__mulsi3+0x50>
        if (u_b & 1) res += u_a;
        u_ 0xa <<= 1;
        u_b >>= 1;
    }
    return (( 0xa < 0) ^ ( 0xb < 0)) ? -res : res;
  34:	00b7c7b3          	xor	a5,a5,a1
  38:	0007d463          	bgez	a5, 0x40 <__mulsi3+0x40>
  3c:	40a00533          	neg	a0,a0
}
  40:	00412083          	lw	ra,4(sp)
  44:	00012403          	lw	s0,0(sp)
  48:	00810113          	addi	sp,sp,8
  4c:	00008067          	ret
        if (u_b & 1) res += u_a;
  50:	00177613          	andi	a2,a4,1
  54:	00060463          	beqz	a2, 0x5c <__mulsi3+0x5c>
  58:	00d50533          	add	a0,a0,a3
        u_ 0xa <<= 1;
  5c:	00169693          	slli	a3,a3,0x1
        u_b >>= 1;
  60:	00175713          	srli	a4,a4,0x1
  64:	fcdff06f          	j	 0x30 <__mulsi3+0x30>

 0x00000068 <itoa>:
    unsigned int r;
    _u_div_mod(a, b, &r);
    return r;
}

char* itoa(int val, char* s) {
  68:	fe410113          	addi	sp,sp,-28
  6c:	00112c23          	sw	ra,24(sp)
  70:	00812a23          	sw	s0,20(sp)
  74:	00912823          	sw	s1,16(sp)
  78:	01c10413          	addi	s0,sp,28
  7c:	00050713          	mv	a4,a0
  80:	00058513          	mv	a0,a1
    char* ptr = s;
  84:	00058693          	mv	a3,a1
    unsigned int uval;
    
    if (val < 0) {
  88:	00075a63          	bgez	a4, 0x9c <itoa+0x34>
        *ptr++ = '-';
  8c:	00158693          	addi	a3,a1,1
  90:	02d00793          	li	a5,45
  94:	00f58023          	sb	a5,0(a1)
        uval = (unsigned int)(-val);
  98:	40e00733          	neg	a4,a4
    } else {
        uval = (unsigned int)val;
    }

    char buf[11];
    int i = 0;
  9c:	fe840293          	addi	t0,s0,-24
  a0:	00000593          	li	a1,0
  a4:	fe542223          	sw	t0,-28(s0)
            q |= (1U << i);
  a8:	00100393          	li	t2,1
    unsigned int q = 0, r = 0;
  ac:	00000313          	li	t1,0
    for (int i = 31; i >= 0; i--) {
  b0:	01f00613          	li	a2,31
    unsigned int q = 0, r = 0;
  b4:	00000793          	li	a5,0
        r = (r << 1) | ((n >> i) & 1);
  b8:	00179493          	slli	s1,a5,0x1
  bc:	00c757b3          	srl	a5,a4,a2
  c0:	0017f793          	andi	a5,a5,1
  c4:	0097e7b3          	or	a5,a5,s1
        if (r >= d) {
  c8:	00900493          	li	s1,9
  cc:	00f4f863          	bgeu	s1,a5, 0xdc <itoa+0x74>
            r -= d;
  d0:	ff678793          	addi	a5,a5,-10
            q |= (1U << i);
  d4:	00c394b3          	sll	s1,t2,a2
  d8:	00936333          	or	t1,t1,s1
    for (int i = 31; i >= 0; i--) {
  dc:	fff60613          	addi	a2,a2,-1
  e0:	fff00493          	li	s1,-1
  e4:	fc961ae3          	bne	a2,s1, 0xb8 <itoa+0x50>
    // Use the absolute magnitude for division to prevent signed logic errors
    do {
        unsigned int rem;
        uval = _u_div_mod(uval, 10, &rem);
        buf[i++] = (char)(rem + '0');
  e8:	00158593          	addi	a1,a1,1
  ec:	03078793          	addi	a5,a5,48
  f0:	00f28023          	sb	a5,0(t0)
    } while (uval > 0);
  f4:	00128293          	addi	t0,t0,1
  f8:	04031263          	bnez	t1, 0x13c <itoa+0xd4>
  fc:	00058793          	mv	a5,a1
 100:	00068713          	mv	a4,a3

    // Reverse buffer into the destination string
    while (i > 0) {
        *ptr++ = buf[--i];
 104:	fff78793          	addi	a5,a5,-1
 108:	00170713          	addi	a4,a4,1
 10c:	fe442603          	lw	a2,-28(s0)
 110:	00f60633          	add	a2,a2,a5
 114:	00064603          	lbu	a2,0(a2)
 118:	fec70fa3          	sb	a2,-1(a4)
    while (i > 0) {
 11c:	fe0794e3          	bnez	a5, 0x104 <itoa+0x9c>
 120:	00b686b3          	add	a3,a3,a1
    }
    *ptr = '\0';
 124:	00068023          	sb	zero,0(a3)
    return s;
}
 128:	01812083          	lw	ra,24(sp)
 12c:	01412403          	lw	s0,20(sp)
 130:	01012483          	lw	s1,16(sp)
 134:	01c10113          	addi	sp,sp,28
 138:	00008067          	ret
        uval = _u_div_mod(uval, 10, &rem);
 13c:	00030713          	mv	a4,t1
 140:	f6dff06f          	j	 0xac <itoa+0x44>

 0x00000144 <fprintf>:
    return nmemb;
}

// printf scanf

int fprintf(void *stream, const char *fmt, ...) {
 144:	fc810113          	addi	sp,sp,-56
 148:	02112223          	sw	ra,36(sp)
 14c:	02812023          	sw	s0,32(sp)
 150:	00912e23          	sw	s1,28(sp)
 154:	02810413          	addi	s0,sp,40
 158:	00050313          	mv	t1,a0
 15c:	00058493          	mv	s1,a1
 160:	00c42023          	sw	a2,0(s0)
 164:	00d42223          	sw	a3,4(s0)
 168:	00e42423          	sw	a4,8(s0)
 16c:	00f42623          	sw	a5,12(s0)
    va_list args;
    va_start(args, fmt);
 170:	fe842223          	sw	s0,-28(s0)
    int count = 0;
 174:	00000793          	li	a5,0
    char tmp[12]; // Stack buffer for itoa

    for (; *fmt; fmt++) {
 178:	0004c703          	lbu	a4,0(s1)
 17c:	00071e63          	bnez	a4, 0x198 <fprintf+0x54>
            count++;
        }
    }
    va_end(args);
    return count;
}
 180:	00078513          	mv	a0,a5
 184:	02412083          	lw	ra,36(sp)
 188:	02012403          	lw	s0,32(sp)
 18c:	01c12483          	lw	s1,28(sp)
 190:	03810113          	addi	sp,sp,56
 194:	00008067          	ret
        if (*fmt == '%' && *(fmt + 1) == 'd') {
 198:	02500693          	li	a3,37
 19c:	06d71463          	bne	a4,a3, 0x204 <fprintf+0xc0>
 1a0:	0014c603          	lbu	a2,1(s1)
 1a4:	06400693          	li	a3,100
 1a8:	04d61e63          	bne	a2,a3, 0x204 <fprintf+0xc0>
 1ac:	fc642c23          	sw	t1,-40(s0)
 1b0:	fcf42e23          	sw	a5,-36(s0)
            itoa(va_arg(args, int), tmp);
 1b4:	fe442703          	lw	a4,-28(s0)
 1b8:	00470693          	addi	a3,a4,4
 1bc:	fed42223          	sw	a3,-28(s0)
 1c0:	fe840593          	addi	a1,s0,-24
 1c4:	feb42023          	sw	a1,-32(s0)
 1c8:	00072503          	lw	a0,0(a4)
 1cc:	00000097          	auipc	ra,0x0
 1d0:	e9c080e7          	jalr	-356(ra) #  0x68 <itoa>
            char *p = tmp;
 1d4:	fe042583          	lw	a1,-32(s0)
            while (*p) { fputc(*p++, stream); count++; }
 1d8:	fdc42783          	lw	a5,-36(s0)
 1dc:	fd842303          	lw	t1,-40(s0)
 1e0:	0005c703          	lbu	a4,0(a1)
 1e4:	00071863          	bnez	a4, 0x1f4 <fprintf+0xb0>
            fmt++;
 1e8:	00148493          	addi	s1,s1,1
    for (; *fmt; fmt++) {
 1ec:	00148493          	addi	s1,s1,1
 1f0:	f89ff06f          	j	 0x178 <fprintf+0x34>
            while (*p) { fputc(*p++, stream); count++; }
 1f4:	00158593          	addi	a1,a1,1
    *(volatile unsigned int *)stream = (unsigned int)c;
 1f8:	00e32023          	sw	a4,0(t1)
            while (*p) { fputc(*p++, stream); count++; }
 1fc:	00178793          	addi	a5,a5,1
 200:	fe1ff06f          	j	 0x1e0 <fprintf+0x9c>
    *(volatile unsigned int *)stream = (unsigned int)c;
 204:	00e32023          	sw	a4,0(t1)
            count++;
 208:	00178793          	addi	a5,a5,1
 20c:	fe1ff06f          	j	 0x1ec <fprintf+0xa8>

 0x00000210 <fscanf>:

int fscanf(void *stream, const char *fmt, ...) {
 210:	fcc10113          	addi	sp,sp,-52
 214:	02112023          	sw	ra,32(sp)
 218:	00812e23          	sw	s0,28(sp)
 21c:	00912c23          	sw	s1,24(sp)
 220:	02410413          	addi	s0,sp,36
 224:	00050313          	mv	t1,a0
 228:	00c42023          	sw	a2,0(s0)
 22c:	00d42223          	sw	a3,4(s0)
 230:	00e42423          	sw	a4,8(s0)
 234:	00f42623          	sw	a5,12(s0)
    va_list args;
    va_start(args, fmt);
 238:	fe842823          	sw	s0,-16(s0)
    int count = 0;
 23c:	00000793          	li	a5,0
    for (; *fmt; fmt++) {
        if (*fmt == ' ') { skip_ws(stream); }
 240:	02000713          	li	a4,32
    for (; *fmt; fmt++) {
 244:	0005c603          	lbu	a2,0(a1)
 248:	00061e63          	bnez	a2, 0x264 <fscanf+0x54>
            count++;
        }
    }
    va_end(args);
    return count;
}
 24c:	00078513          	mv	a0,a5
 250:	02012083          	lw	ra,32(sp)
 254:	01c12403          	lw	s0,28(sp)
 258:	01812483          	lw	s1,24(sp)
 25c:	03410113          	addi	sp,sp,52
 260:	00008067          	ret
        else if (*fmt == '%' && *(++fmt) == 'd') {
 264:	00158693          	addi	a3,a1,1
        if (*fmt == ' ') { skip_ws(stream); }
 268:	00e61a63          	bne	a2,a4, 0x27c <fscanf+0x6c>
    return (unsigned char)(*(volatile char *)stream); 
 26c:	00034683          	lbu	a3,0(t1)
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 270:	fed77ee3          	bgeu	a4,a3, 0x26c <fscanf+0x5c>
    for (; *fmt; fmt++) {
 274:	00158593          	addi	a1,a1,1
 278:	fcdff06f          	j	 0x244 <fscanf+0x34>
        else if (*fmt == '%' && *(++fmt) == 'd') {
 27c:	02500513          	li	a0,37
 280:	fea61ae3          	bne	a2,a0, 0x274 <fscanf+0x64>
 284:	0015c603          	lbu	a2,1(a1)
 288:	00068593          	mv	a1,a3
 28c:	06400513          	li	a0,100
 290:	fea612e3          	bne	a2,a0, 0x274 <fscanf+0x64>
            int *dest = va_arg(args, int *);
 294:	ff042603          	lw	a2,-16(s0)
 298:	00460593          	addi	a1,a2,4
 29c:	feb42823          	sw	a1,-16(s0)
 2a0:	00062283          	lw	t0,0(a2)
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 2a4:	02000593          	li	a1,32
    return (unsigned char)(*(volatile char *)stream); 
 2a8:	00034603          	lbu	a2,0(t1)
 2ac:	0ff67493          	zext.b	s1,a2
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 2b0:	fec5dce3          	bge	a1,a2, 0x2a8 <fscanf+0x98>
            int neg = (c == '-') ? (c = fgetc(stream), 1) : 0;
 2b4:	02d00593          	li	a1,45
 2b8:	00000613          	li	a2,0
 2bc:	00b49863          	bne	s1,a1, 0x2cc <fscanf+0xbc>
    return (unsigned char)(*(volatile char *)stream); 
 2c0:	00034483          	lbu	s1,0(t1)
 2c4:	0ff4f493          	zext.b	s1,s1
            int neg = (c == '-') ? (c = fgetc(stream), 1) : 0;
 2c8:	00100613          	li	a2,1
            int val = 0, c = skip_ws(stream);
 2cc:	00000513          	li	a0,0
            while (c >= '0' &&  0xc <= '9') {
 2d0:	00900393          	li	t2,9
 2d4:	fd048493          	addi	s1,s1,-48
 2d8:	0093fe63          	bgeu	t2,s1, 0x2f4 <fscanf+0xe4>
            *dest = neg ? -val : val;
 2dc:	00060463          	beqz	a2, 0x2e4 <fscanf+0xd4>
 2e0:	40a00533          	neg	a0,a0
 2e4:	00a2a023          	sw	a0,0(t0)
            count++;
 2e8:	00178793          	addi	a5,a5,1
        else if (*fmt == '%' && *(++fmt) == 'd') {
 2ec:	00068593          	mv	a1,a3
 2f0:	f85ff06f          	j	 0x274 <fscanf+0x64>
 2f4:	fc642e23          	sw	t1,-36(s0)
 2f8:	fef42023          	sw	a5,-32(s0)
 2fc:	fed42223          	sw	a3,-28(s0)
 300:	fe542423          	sw	t0,-24(s0)
 304:	fec42623          	sw	a2,-20(s0)
                val = __mulsi3(val, 10) + (c - '0');
 308:	00a00593          	li	a1,10
 30c:	00000097          	auipc	ra,0x0
 310:	cf4080e7          	jalr	-780(ra) #  0x0 <__mulsi3>
 314:	00a48533          	add	a0,s1,a0
    return (unsigned char)(*(volatile char *)stream); 
 318:	fdc42303          	lw	t1,-36(s0)
 31c:	00034483          	lbu	s1,0(t1)
 320:	0ff4f493          	zext.b	s1,s1
 324:	02000713          	li	a4,32
 328:	00900393          	li	t2,9
 32c:	fe042783          	lw	a5,-32(s0)
 330:	fe442683          	lw	a3,-28(s0)
 334:	fe842283          	lw	t0,-24(s0)
 338:	fec42603          	lw	a2,-20(s0)
 33c:	f99ff06f          	j	 0x2d4 <fscanf+0xc4>

 0x00000340 <main>:
#include "stdio.h"
#include "string.h"
#endif

int main()
{
 340:	fec10113          	addi	sp,sp,-20
 344:	00112823          	sw	ra,16(sp)
 348:	00812623          	sw	s0,12(sp)
 34c:	00912423          	sw	s1,8(sp)
 350:	01410413          	addi	s0,sp,20
  fprintf(stdout, "\r\nhello world\n\r> ");
 354:	00001597          	auipc	a1,0x1
 358:	cac58593          	addi	a1,a1,-852 #  0x1000 <main+0xcc0>
 35c:	00001517          	auipc	a0,0x1
 360:	cec52503          	lw	a0,-788(a0) #  0x1048 <_GLOBAL_OFFSET_TABLE_+0x4>
 364:	00000097          	auipc	ra,0x0
 368:	de0080e7          	jalr	-544(ra) #  0x144 <fprintf>
  while(1) {
    int a=1, b=1, c=0, l;
    fprintf(stdout, "input a limit of fibonacci\n\r> ");
 36c:	00001597          	auipc	a1,0x1
 370:	ca858593          	addi	a1,a1,-856 #  0x1014 <main+0xcd4>
 374:	00001517          	auipc	a0,0x1
 378:	cd452503          	lw	a0,-812(a0) #  0x1048 <_GLOBAL_OFFSET_TABLE_+0x4>
 37c:	00000097          	auipc	ra,0x0
 380:	dc8080e7          	jalr	-568(ra) #  0x144 <fprintf>
    fscanf(stdin, "%d", &l);
 384:	ff040613          	addi	a2,s0,-16
 388:	00001597          	auipc	a1,0x1
 38c:	cac58593          	addi	a1,a1,-852 #  0x1034 <main+0xcf4>
 390:	00001517          	auipc	a0,0x1
 394:	cbc52503          	lw	a0,-836(a0) #  0x104c <_GLOBAL_OFFSET_TABLE_+0x8>
 398:	00000097          	auipc	ra,0x0
 39c:	e78080e7          	jalr	-392(ra) #  0x210 <fscanf>
    fprintf(stdout, "%d\n", l);
 3a0:	ff042603          	lw	a2,-16(s0)
 3a4:	00001597          	auipc	a1,0x1
 3a8:	c9458593          	addi	a1,a1,-876 #  0x1038 <main+0xcf8>
 3ac:	00001517          	auipc	a0,0x1
 3b0:	c9c52503          	lw	a0,-868(a0) #  0x1048 <_GLOBAL_OFFSET_TABLE_+0x4>
 3b4:	00000097          	auipc	ra,0x0
 3b8:	d90080e7          	jalr	-624(ra) #  0x144 <fprintf>
    if(l < 0) {
 3bc:	ff042783          	lw	a5,-16(s0)
 3c0:	0807c663          	bltz	a5, 0x44c <main+0x10c>
    int a=1, b=1, c=0, l;
 3c4:	00100493          	li	s1,1
 3c8:	00048793          	mv	a5,s1
        b = c;
        fprintf(stdout, "%d ", a);
      }
    }
    else {
      while( 0xa < l) {
 3cc:	ff042703          	lw	a4,-16(s0)
 3d0:	06e7d863          	bge	a5,a4, 0x440 <main+0x100>
        c = a+b;
 3d4:	00978733          	add	a4,a5,s1
 3d8:	fee42623          	sw	a4,-20(s0)
        a = b;
        b = c;
        fprintf(stdout, "%d ", a);
 3dc:	00048613          	mv	a2,s1
 3e0:	00001597          	auipc	a1,0x1
 3e4:	c5c58593          	addi	a1,a1,-932 #  0x103c <main+0xcfc>
 3e8:	00001517          	auipc	a0,0x1
 3ec:	c6052503          	lw	a0,-928(a0) #  0x1048 <_GLOBAL_OFFSET_TABLE_+0x4>
 3f0:	00000097          	auipc	ra,0x0
 3f4:	d54080e7          	jalr	-684(ra) #  0x144 <fprintf>
        a = b;
 3f8:	00048793          	mv	a5,s1
        b = c;
 3fc:	fec42703          	lw	a4,-20(s0)
 400:	00070493          	mv	s1,a4
 404:	fc9ff06f          	j	 0x3cc <main+0x8c>
        c = a+b;
 408:	00978733          	add	a4,a5,s1
 40c:	fee42623          	sw	a4,-20(s0)
        fprintf(stdout, "%d ", a);
 410:	00048613          	mv	a2,s1
 414:	00001597          	auipc	a1,0x1
 418:	c2858593          	addi	a1,a1,-984 #  0x103c <main+0xcfc>
 41c:	00001517          	auipc	a0,0x1
 420:	c2c52503          	lw	a0,-980(a0) #  0x1048 <_GLOBAL_OFFSET_TABLE_+0x4>
 424:	00000097          	auipc	ra,0x0
 428:	d20080e7          	jalr	-736(ra) #  0x144 <fprintf>
        a = b;
 42c:	00048793          	mv	a5,s1
        b = c;
 430:	fec42703          	lw	a4,-20(s0)
 434:	00070493          	mv	s1,a4
      while(a > l) {
 438:	ff042703          	lw	a4,-16(s0)
 43c:	fcf746e3          	blt	a4,a5, 0x408 <main+0xc8>
      }
    }
    fprintf(stdout,"\n\r");
 440:	00001597          	auipc	a1,0x1
 444:	c0058593          	addi	a1,a1,-1024 #  0x1040 <main+0xd00>
 448:	f15ff06f          	j	 0x35c <main+0x1c>
      a=-1; b=-1;
 44c:	fff00493          	li	s1,-1
 450:	00048793          	mv	a5,s1
 454:	fe5ff06f          	j	 0x438 <main+0xf8>
