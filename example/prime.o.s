
example/prime.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <__udivsi3_umodsi3>:
        u_b >>= 1;
    }
    return (( 0xa < 0) ^ ( 0xb < 0)) ? -res : res;
}

static unsigned int __udivsi3_umodsi3(unsigned int n, unsigned int d, unsigned int *mod) {
   0:	ff810113          	addi	sp,sp,-8
   4:	00112223          	sw	ra,4(sp)
   8:	00812023          	sw	s0,0(sp)
   c:	00810413          	addi	s0,sp,8
  10:	00050693          	mv	a3,a0
  14:	00058513          	mv	a0,a1
    if (d == 0) return 0;
  18:	04058263          	beqz	a1, 0x5c <__udivsi3_umodsi3+0x5c>
  1c:	02000593          	li	a1,32
    unsigned int q = 0;
  20:	00000713          	li	a4,0
    unsigned int r = 0;
  24:	00000793          	li	a5,0
    for (int i = 0; i < 32; i++) {
        r = (r << 1) | (n >> 31);
  28:	00179793          	slli	a5,a5,0x1
  2c:	01f6d313          	srli	t1,a3,0x1f
  30:	00f367b3          	or	a5,t1,a5
        n <<= 1; 
  34:	00169693          	slli	a3,a3,0x1
        if (r >= d) {
            r -= d;
            q = (q << 1) | 1;
  38:	00171713          	slli	a4,a4,0x1
        if (r >= d) {
  3c:	00a7e663          	bltu	a5,a0, 0x48 <__udivsi3_umodsi3+0x48>
            r -= d;
  40:	40a787b3          	sub	a5,a5,a0
            q = (q << 1) | 1;
  44:	00176713          	ori	a4,a4,1
    for (int i = 0; i < 32; i++) {
  48:	fff58593          	addi	a1,a1,-1
  4c:	fc059ee3          	bnez	a1, 0x28 <__udivsi3_umodsi3+0x28>
        } else {
            q <<= 1;
        }
    }
    if (mod) *mod = r;
  50:	00060463          	beqz	a2, 0x58 <__udivsi3_umodsi3+0x58>
  54:	00f62023          	sw	a5,0(a2)
    unsigned int r = 0;
  58:	00070513          	mv	a0,a4
    return q;
}
  5c:	00412083          	lw	ra,4(sp)
  60:	00012403          	lw	s0,0(sp)
  64:	00810113          	addi	sp,sp,8
  68:	00008067          	ret

 0x0000006c <_fmt_base>:
    return (int)(*(volatile unsigned int *)lfsr); 
}

// printf scanf

static void _fmt_base(void *stream, unsigned int uval, int base, int *count) {
  6c:	fd810113          	addi	sp,sp,-40
  70:	02112223          	sw	ra,36(sp)
  74:	02812023          	sw	s0,32(sp)
  78:	00912e23          	sw	s1,28(sp)
  7c:	02810413          	addi	s0,sp,40
  80:	00050493          	mv	s1,a0
  84:	00058513          	mv	a0,a1
  88:	fec42023          	sw	a2,-32(s0)
    char tmp[12];
    int i = 11;
    tmp[i] = '\0';
  8c:	fe0409a3          	sb	zero,-13(s0)
    int i = 11;
  90:	00b00313          	li	t1,11
  94:	fcd42c23          	sw	a3,-40(s0)
  98:	fc642e23          	sw	t1,-36(s0)
    
    do {
        unsigned int rem;
        // Reuses your Booth-style or hardware divider logic
        uval = __udivsi3_umodsi3(uval, base, &rem);
  9c:	fe440613          	addi	a2,s0,-28
  a0:	fe042583          	lw	a1,-32(s0)
  a4:	00000097          	auipc	ra,0x0
  a8:	f5c080e7          	jalr	-164(ra) #  0x0 <__udivsi3_umodsi3>
        tmp[--i] = (rem < 10) ? (char)(rem + '0') : (char)(rem - 10 + 'a');
  ac:	fe442603          	lw	a2,-28(s0)
  b0:	0ff67793          	zext.b	a5,a2
  b4:	00900593          	li	a1,9
  b8:	fdc42303          	lw	t1,-36(s0)
  bc:	fd842683          	lw	a3,-40(s0)
  c0:	02c5ee63          	bltu	a1,a2, 0xfc <_fmt_base+0x90>
  c4:	03078793          	addi	a5,a5,48
  c8:	0ff7f793          	zext.b	a5,a5
  cc:	fff30313          	addi	t1,t1,-1
  d0:	fe840613          	addi	a2,s0,-24
  d4:	00660633          	add	a2,a2,t1
  d8:	00f60023          	sb	a5,0(a2)
    } while (uval > 0);
  dc:	fa051ce3          	bnez	a0, 0x94 <_fmt_base+0x28>

    char *p = &tmp[i];
    while (*p) { 
  e0:	00064783          	lbu	a5,0(a2)
  e4:	02079063          	bnez	a5, 0x104 <_fmt_base+0x98>
        fputc(*p++, stream); 
        (*count)++; 
    }
}
  e8:	02412083          	lw	ra,36(sp)
  ec:	02012403          	lw	s0,32(sp)
  f0:	01c12483          	lw	s1,28(sp)
  f4:	02810113          	addi	sp,sp,40
  f8:	00008067          	ret
        tmp[--i] = (rem < 10) ? (char)(rem + '0') : (char)(rem - 10 + 'a');
  fc:	05778793          	addi	a5,a5,87
 100:	fc9ff06f          	j	 0xc8 <_fmt_base+0x5c>
        fputc(*p++, stream); 
 104:	00160613          	addi	a2,a2,1
    *(volatile unsigned int *)stream = (unsigned int)c;
 108:	00f4a023          	sw	a5,0(s1)
        (*count)++; 
 10c:	0006a783          	lw	a5,0(a3)
 110:	00178793          	addi	a5,a5,1
 114:	00f6a023          	sw	a5,0(a3)
 118:	fc9ff06f          	j	 0xe0 <_fmt_base+0x74>

 0x0000011c <__mulsi3>:
int __mulsi3(int a, int b) {
 11c:	ff810113          	addi	sp,sp,-8
 120:	00112223          	sw	ra,4(sp)
 124:	00812023          	sw	s0,0(sp)
 128:	00810413          	addi	s0,sp,8
 12c:	00050793          	mv	a5,a0
    unsigned int u_a = ( 0xa < 0) ? -a : a;
 130:	41f55713          	srai	a4,a0,0x1f
 134:	00a746b3          	xor	a3,a4,a0
 138:	40e686b3          	sub	a3,a3,a4
    unsigned int u_b = ( 0xb < 0) ? -b : b;
 13c:	41f5d613          	srai	a2,a1,0x1f
 140:	00b64733          	xor	a4,a2,a1
 144:	40c70733          	sub	a4,a4,a2
    int res = 0;
 148:	00000513          	li	a0,0
    while (u_b > 0) {
 14c:	02071063          	bnez	a4, 0x16c <__mulsi3+0x50>
    return (( 0xa < 0) ^ ( 0xb < 0)) ? -res : res;
 150:	00b7c7b3          	xor	a5,a5,a1
 154:	0007d463          	bgez	a5, 0x15c <__mulsi3+0x40>
 158:	40a00533          	neg	a0,a0
}
 15c:	00412083          	lw	ra,4(sp)
 160:	00012403          	lw	s0,0(sp)
 164:	00810113          	addi	sp,sp,8
 168:	00008067          	ret
        if (u_b & 1) res += u_a;
 16c:	00177613          	andi	a2,a4,1
 170:	00060463          	beqz	a2, 0x178 <__mulsi3+0x5c>
 174:	00d50533          	add	a0,a0,a3
        u_ 0xa <<= 1;
 178:	00169693          	slli	a3,a3,0x1
        u_b >>= 1;
 17c:	00175713          	srli	a4,a4,0x1
 180:	fcdff06f          	j	 0x14c <__mulsi3+0x30>

 0x00000184 <__modsi3>:
int __modsi3(int a, int b) {
 184:	ff010113          	addi	sp,sp,-16
 188:	00112623          	sw	ra,12(sp)
 18c:	00812423          	sw	s0,8(sp)
 190:	00912223          	sw	s1,4(sp)
 194:	01010413          	addi	s0,sp,16
 198:	00050493          	mv	s1,a0
    unsigned int u_d = ( 0xb < 0) ? -b : b;
 19c:	41f5d713          	srai	a4,a1,0x1f
 1a0:	00b745b3          	xor	a1,a4,a1
    unsigned int u_n = ( 0xa < 0) ? -a : a;
 1a4:	41f55793          	srai	a5,a0,0x1f
 1a8:	00a7c533          	xor	a0,a5,a0
    __udivsi3_umodsi3(u_n, u_d, &r);
 1ac:	ff040613          	addi	a2,s0,-16
 1b0:	40e585b3          	sub	a1,a1,a4
 1b4:	40f50533          	sub	a0,a0,a5
 1b8:	00000097          	auipc	ra,0x0
 1bc:	e48080e7          	jalr	-440(ra) #  0x0 <__udivsi3_umodsi3>
    return ( 0xa < 0) ? -(int)r : (int)r;
 1c0:	ff042503          	lw	a0,-16(s0)
 1c4:	0004d463          	bgez	s1, 0x1cc <__modsi3+0x48>
 1c8:	40a00533          	neg	a0,a0
}
 1cc:	00c12083          	lw	ra,12(sp)
 1d0:	00812403          	lw	s0,8(sp)
 1d4:	00412483          	lw	s1,4(sp)
 1d8:	01010113          	addi	sp,sp,16
 1dc:	00008067          	ret

 0x000001e0 <fprintf>:
    }
    *dest = '\0';
    (*count)++;
}

int fprintf(void *stream, const char *fmt, ...) {
 1e0:	fd810113          	addi	sp,sp,-40
 1e4:	00112a23          	sw	ra,20(sp)
 1e8:	00812823          	sw	s0,16(sp)
 1ec:	00912623          	sw	s1,12(sp)
 1f0:	01810413          	addi	s0,sp,24
 1f4:	00058493          	mv	s1,a1
 1f8:	00c42023          	sw	a2,0(s0)
 1fc:	00d42223          	sw	a3,4(s0)
 200:	00e42423          	sw	a4,8(s0)
 204:	00f42623          	sw	a5,12(s0)
    va_list args;
    va_start(args, fmt);
 208:	fe842623          	sw	s0,-20(s0)
    int count = 0;
 20c:	fe042823          	sw	zero,-16(s0)
    for (; *fmt; fmt++) {
 210:	0004c703          	lbu	a4,0(s1)
 214:	00071e63          	bnez	a4, 0x230 <fprintf+0x50>
            count++;
        }
    }
    va_end(args);
    return count;
}
 218:	ff042503          	lw	a0,-16(s0)
 21c:	01412083          	lw	ra,20(sp)
 220:	01012403          	lw	s0,16(sp)
 224:	00c12483          	lw	s1,12(sp)
 228:	02810113          	addi	sp,sp,40
 22c:	00008067          	ret
        if (*fmt == '%' && *(fmt + 1)) {
 230:	02500793          	li	a5,37
 234:	0ef71663          	bne	a4,a5, 0x320 <fprintf+0x140>
 238:	0014c783          	lbu	a5,1(s1)
 23c:	0e078263          	beqz	a5, 0x320 <fprintf+0x140>
            switch (*fmt) {
 240:	07300713          	li	a4,115
 244:	08e78063          	beq	a5,a4, 0x2c4 <fprintf+0xe4>
 248:	07800713          	li	a4,120
 24c:	04e78e63          	beq	a5,a4, 0x2a8 <fprintf+0xc8>
 250:	06400713          	li	a4,100
 254:	0ce79263          	bne	a5,a4, 0x318 <fprintf+0x138>
                case 'd': fprintf_d(stream, va_arg(args, int), &count); break;
 258:	fec42783          	lw	a5,-20(s0)
 25c:	00478713          	addi	a4,a5,4
 260:	fee42623          	sw	a4,-20(s0)
 264:	0007a583          	lw	a1,0(a5)
    if (val < 0) {
 268:	0005de63          	bgez	a1, 0x284 <fprintf+0xa4>
    *(volatile unsigned int *)stream = (unsigned int)c;
 26c:	02d00793          	li	a5,45
 270:	00f52023          	sw	a5,0(a0)
        (*count)++;
 274:	ff042783          	lw	a5,-16(s0)
 278:	00178793          	addi	a5,a5,1
 27c:	fef42823          	sw	a5,-16(s0)
        val = -val;
 280:	40b005b3          	neg	a1,a1
    _fmt_base(stream, (unsigned int)val, 10, count);
 284:	ff040693          	addi	a3,s0,-16
 288:	00a00613          	li	a2,10
 28c:	fea42423          	sw	a0,-24(s0)
 290:	00000097          	auipc	ra,0x0
 294:	ddc080e7          	jalr	-548(ra) #  0x6c <_fmt_base>
 298:	fe842503          	lw	a0,-24(s0)
            fmt++;
 29c:	00148493          	addi	s1,s1,1
    for (; *fmt; fmt++) {
 2a0:	00148493          	addi	s1,s1,1
 2a4:	f6dff06f          	j	 0x210 <fprintf+0x30>
                case 'x': fprintf_x(stream, va_arg(args, unsigned int), &count); break;
 2a8:	fec42783          	lw	a5,-20(s0)
 2ac:	00478713          	addi	a4,a5,4
 2b0:	fee42623          	sw	a4,-20(s0)
    _fmt_base(stream, val, 16, count);
 2b4:	ff040693          	addi	a3,s0,-16
 2b8:	01000613          	li	a2,16
 2bc:	0007a583          	lw	a1,0(a5)
 2c0:	fcdff06f          	j	 0x28c <fprintf+0xac>
                case 's': fprintf_s(stream, va_arg(args, char *), &count); break;
 2c4:	fec42783          	lw	a5,-20(s0)
 2c8:	00478713          	addi	a4,a5,4
 2cc:	fee42623          	sw	a4,-20(s0)
 2d0:	0007a703          	lw	a4,0(a5)
    if (!s) s = "(null)";
 2d4:	00071663          	bnez	a4, 0x2e0 <fprintf+0x100>
 2d8:	00001717          	auipc	a4,0x1
 2dc:	d2870713          	addi	a4,a4,-728 #  0x1000 <main+0x9b0>
 2e0:	ff042683          	lw	a3,-16(s0)
 2e4:	00070793          	mv	a5,a4
 2e8:	00000613          	li	a2,0
    while (*s) { fputc(*s++, stream); (*count)++; }
 2ec:	0007c583          	lbu	a1,0(a5)
 2f0:	00059c63          	bnez	a1, 0x308 <fprintf+0x128>
 2f4:	fa0604e3          	beqz	a2, 0x29c <fprintf+0xbc>
 2f8:	40e68733          	sub	a4,a3,a4
 2fc:	00e787b3          	add	a5,a5,a4
 300:	fef42823          	sw	a5,-16(s0)
 304:	f99ff06f          	j	 0x29c <fprintf+0xbc>
 308:	00178793          	addi	a5,a5,1
    *(volatile unsigned int *)stream = (unsigned int)c;
 30c:	00b52023          	sw	a1,0(a0)
 310:	00100613          	li	a2,1
 314:	fd9ff06f          	j	 0x2ec <fprintf+0x10c>
 318:	00f52023          	sw	a5,0(a0)
    return c; 
 31c:	f81ff06f          	j	 0x29c <fprintf+0xbc>
    *(volatile unsigned int *)stream = (unsigned int)c;
 320:	00e52023          	sw	a4,0(a0)
            count++;
 324:	ff042783          	lw	a5,-16(s0)
 328:	00178793          	addi	a5,a5,1
 32c:	fef42823          	sw	a5,-16(s0)
 330:	f71ff06f          	j	 0x2a0 <fprintf+0xc0>

 0x00000334 <fscanf>:

int fscanf(void *stream, const char *fmt, ...) {
 334:	fcc10113          	addi	sp,sp,-52
 338:	02112023          	sw	ra,32(sp)
 33c:	00812e23          	sw	s0,28(sp)
 340:	00912c23          	sw	s1,24(sp)
 344:	02410413          	addi	s0,sp,36
 348:	00050313          	mv	t1,a0
 34c:	00c42023          	sw	a2,0(s0)
 350:	00d42223          	sw	a3,4(s0)
 354:	00e42423          	sw	a4,8(s0)
 358:	00f42623          	sw	a5,12(s0)
    va_list args;
    va_start(args, fmt);
 35c:	fe842823          	sw	s0,-16(s0)
    int count = 0;
 360:	00000713          	li	a4,0
    for (; *fmt; fmt++) {
        if (*fmt == ' ') skip_ws(stream);
 364:	02000393          	li	t2,32
    for (; *fmt; fmt++) {
 368:	0005c783          	lbu	a5,0(a1)
 36c:	00079e63          	bnez	a5, 0x388 <fscanf+0x54>
            }
        }
    }
    va_end(args);
    return count;
}
 370:	00070513          	mv	a0,a4
 374:	02012083          	lw	ra,32(sp)
 378:	01c12403          	lw	s0,28(sp)
 37c:	01812483          	lw	s1,24(sp)
 380:	03410113          	addi	sp,sp,52
 384:	00008067          	ret
            fmt++;
 388:	00158293          	addi	t0,a1,1
        if (*fmt == ' ') skip_ws(stream);
 38c:	00779a63          	bne	a5,t2, 0x3a0 <fscanf+0x6c>
    return (unsigned char)(*(volatile char *)stream); 
 390:	00034783          	lbu	a5,0(t1)
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 394:	fef3fee3          	bgeu	t2,a5, 0x390 <fscanf+0x5c>
    for (; *fmt; fmt++) {
 398:	00158593          	addi	a1,a1,1
 39c:	fcdff06f          	j	 0x368 <fscanf+0x34>
        else if (*fmt == '%' && *(fmt + 1)) {
 3a0:	02500693          	li	a3,37
 3a4:	fed79ae3          	bne	a5,a3, 0x398 <fscanf+0x64>
 3a8:	0015c783          	lbu	a5,1(a1)
 3ac:	fe0786e3          	beqz	a5, 0x398 <fscanf+0x64>
            switch (*fmt) {
 3b0:	07300693          	li	a3,115
 3b4:	12d78863          	beq	a5,a3, 0x4e4 <fscanf+0x1b0>
 3b8:	07800693          	li	a3,120
 3bc:	0ad78e63          	beq	a5,a3, 0x478 <fscanf+0x144>
 3c0:	06400693          	li	a3,100
 3c4:	00028593          	mv	a1,t0
 3c8:	fcd798e3          	bne	a5,a3, 0x398 <fscanf+0x64>
                case 'd': fscanf_d(stream, va_arg(args, int *), &count); break;
 3cc:	ff042783          	lw	a5,-16(s0)
 3d0:	00478693          	addi	a3,a5,4
 3d4:	fed42823          	sw	a3,-16(s0)
 3d8:	0007a683          	lw	a3,0(a5)
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 3dc:	02000613          	li	a2,32
    return (unsigned char)(*(volatile char *)stream); 
 3e0:	00034783          	lbu	a5,0(t1)
 3e4:	0ff7f493          	zext.b	s1,a5
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 3e8:	fef65ce3          	bge	a2,a5, 0x3e0 <fscanf+0xac>
    int neg = (c == '-') ? (c = fgetc(stream), 1) : 0;
 3ec:	02d00613          	li	a2,45
 3f0:	00000793          	li	a5,0
 3f4:	00c49863          	bne	s1,a2, 0x404 <fscanf+0xd0>
    return (unsigned char)(*(volatile char *)stream); 
 3f8:	00034483          	lbu	s1,0(t1)
 3fc:	0ff4f493          	zext.b	s1,s1
    int neg = (c == '-') ? (c = fgetc(stream), 1) : 0;
 400:	00100793          	li	a5,1
    int val = 0, c = skip_ws(stream);
 404:	00000513          	li	a0,0
    while (c >= '0' &&  0xc <= '9') {
 408:	00900613          	li	a2,9
 40c:	fd048493          	addi	s1,s1,-48
 410:	00967e63          	bgeu	a2,s1, 0x42c <fscanf+0xf8>
    *dest = neg ? -val : val;
 414:	00078463          	beqz	a5, 0x41c <fscanf+0xe8>
 418:	40a00533          	neg	a0,a0
 41c:	00a6a023          	sw	a0,0(a3)
    (*count)++;
 420:	00170713          	addi	a4,a4,1
            fmt++;
 424:	00028593          	mv	a1,t0
 428:	f71ff06f          	j	 0x398 <fscanf+0x64>
 42c:	fc642e23          	sw	t1,-36(s0)
 430:	fee42023          	sw	a4,-32(s0)
 434:	fef42223          	sw	a5,-28(s0)
 438:	fe542423          	sw	t0,-24(s0)
 43c:	fed42623          	sw	a3,-20(s0)
        val = __mulsi3(val, 10) + (c - '0');
 440:	00a00593          	li	a1,10
 444:	00000097          	auipc	ra,0x0
 448:	cd8080e7          	jalr	-808(ra) #  0x11c <__mulsi3>
 44c:	00a48533          	add	a0,s1,a0
    return (unsigned char)(*(volatile char *)stream); 
 450:	fdc42303          	lw	t1,-36(s0)
 454:	00034483          	lbu	s1,0(t1)
 458:	0ff4f493          	zext.b	s1,s1
 45c:	02000393          	li	t2,32
 460:	00900613          	li	a2,9
 464:	fe042703          	lw	a4,-32(s0)
 468:	fe442783          	lw	a5,-28(s0)
 46c:	fe842283          	lw	t0,-24(s0)
 470:	fec42683          	lw	a3,-20(s0)
 474:	f99ff06f          	j	 0x40c <fscanf+0xd8>
                case 'x': fscanf_x(stream, va_arg(args, unsigned int *), &count); break;
 478:	ff042783          	lw	a5,-16(s0)
 47c:	00478693          	addi	a3,a5,4
 480:	fed42823          	sw	a3,-16(s0)
 484:	0007a503          	lw	a0,0(a5)
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 488:	02000613          	li	a2,32
    return (unsigned char)(*(volatile char *)stream); 
 48c:	00034683          	lbu	a3,0(t1)
 490:	0ff6f793          	zext.b	a5,a3
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 494:	fed65ce3          	bge	a2,a3, 0x48c <fscanf+0x158>
    unsigned int val = 0;
 498:	00000613          	li	a2,0
        if (c >= '0' &&  0xc <= '9')      digit = c - '0';
 49c:	00900493          	li	s1,9
        else if (c >= 'a' &&  0xc <= 'f') digit = c - 'a' + 10;
 4a0:	00500593          	li	a1,5
        if (c >= '0' &&  0xc <= '9')      digit = c - '0';
 4a4:	fd078693          	addi	a3,a5,-48
 4a8:	00d4f863          	bgeu	s1,a3, 0x4b8 <fscanf+0x184>
        else if (c >= 'a' &&  0xc <= 'f') digit = c - 'a' + 10;
 4ac:	f9f78693          	addi	a3,a5,-97
 4b0:	00d5ee63          	bltu	a1,a3, 0x4cc <fscanf+0x198>
 4b4:	fa978693          	addi	a3,a5,-87
        val = (val << 4) | digit;
 4b8:	00461613          	slli	a2,a2,0x4
 4bc:	00c6e633          	or	a2,a3,a2
    return (unsigned char)(*(volatile char *)stream); 
 4c0:	00034783          	lbu	a5,0(t1)
 4c4:	0ff7f793          	zext.b	a5,a5
    while (1) {
 4c8:	fddff06f          	j	 0x4a4 <fscanf+0x170>
        else if (c >= 'A' &&  0xc <= 'F') digit = c - 'A' + 10;
 4cc:	fbf78693          	addi	a3,a5,-65
 4d0:	00d5e663          	bltu	a1,a3, 0x4dc <fscanf+0x1a8>
 4d4:	fc978693          	addi	a3,a5,-55
 4d8:	fe1ff06f          	j	 0x4b8 <fscanf+0x184>
    *dest = val;
 4dc:	00c52023          	sw	a2,0(a0)
    (*count)++;
 4e0:	f41ff06f          	j	 0x420 <fscanf+0xec>
                case 's': fscanf_s(stream, va_arg(args, char *), &count); break;
 4e4:	ff042783          	lw	a5,-16(s0)
 4e8:	00478693          	addi	a3,a5,4
 4ec:	fed42823          	sw	a3,-16(s0)
 4f0:	0007a603          	lw	a2,0(a5)
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 4f4:	02000593          	li	a1,32
    return (unsigned char)(*(volatile char *)stream); 
 4f8:	00034783          	lbu	a5,0(t1)
 4fc:	0ff7f693          	zext.b	a3,a5
    while ((c = fgetc(stream)) <= ' ' && c != EOF); 
 500:	fef5dce3          	bge	a1,a5, 0x4f8 <fscanf+0x1c4>
 504:	01700513          	li	a0,23
 508:	008005b7          	lui	a1,0x800
 50c:	01358593          	addi	a1,a1,19 #  0x800013 <lfsr+0x7fd00b>
    while (c != -1 && c != ' ' && c != '\t' && c != '\n' && c != '\r') {
 510:	ff768793          	addi	a5,a3,-9
 514:	00f56c63          	bltu	a0,a5, 0x52c <fscanf+0x1f8>
 518:	00f5d7b3          	srl	a5,a1,a5
 51c:	0017f793          	andi	a5,a5,1
 520:	00078663          	beqz	a5, 0x52c <fscanf+0x1f8>
    *dest = '\0';
 524:	00060023          	sb	zero,0(a2)
 528:	ef9ff06f          	j	 0x420 <fscanf+0xec>
        *dest++ = (char)c;
 52c:	00160613          	addi	a2,a2,1
 530:	fed60fa3          	sb	a3,-1(a2)
    return (unsigned char)(*(volatile char *)stream); 
 534:	00034683          	lbu	a3,0(t1)
 538:	0ff6f693          	zext.b	a3,a3
 53c:	fd5ff06f          	j	 0x510 <fscanf+0x1dc>

 0x00000540 <isqrt>:
#else
#include "stdio.h"
#endif


unsigned int isqrt(unsigned int value) {
 540:	ff810113          	addi	sp,sp,-8
 544:	00112223          	sw	ra,4(sp)
 548:	00812023          	sw	s0,0(sp)
 54c:	00810413          	addi	s0,sp,8
 550:	00050713          	mv	a4,a0
    unsigned int res = 0;
    unsigned int bit = 1U << 30; 
 554:	400007b7          	lui	a5,0x40000
    while (bit > value) {
 558:	00f76e63          	bltu	a4,a5, 0x574 <isqrt+0x34>
    unsigned int res = 0;
 55c:	00000513          	li	a0,0
        bit >>= 2;
    }
    while (bit != 0) {
 560:	00079e63          	bnez	a5, 0x57c <isqrt+0x3c>
            res >>= 1;
        }
        bit >>= 2;
    }
    return res;
}
 564:	00412083          	lw	ra,4(sp)
 568:	00012403          	lw	s0,0(sp)
 56c:	00810113          	addi	sp,sp,8
 570:	00008067          	ret
        bit >>= 2;
 574:	0027d793          	srli	a5,a5,0x2
 578:	fe1ff06f          	j	 0x558 <isqrt+0x18>
        if (value >= res + bit) {
 57c:	00f506b3          	add	a3,a0,a5
            res = (res >> 1) + bit;
 580:	00155513          	srli	a0,a0,0x1
        if (value >= res + bit) {
 584:	00d76663          	bltu	a4,a3, 0x590 <isqrt+0x50>
            value -= res + bit;
 588:	40d70733          	sub	a4,a4,a3
            res = (res >> 1) + bit;
 58c:	00f50533          	add	a0,a0,a5
        bit >>= 2;
 590:	0027d793          	srli	a5,a5,0x2
 594:	fcdff06f          	j	 0x560 <isqrt+0x20>

 0x00000598 <prime>:

int prime(int n, int d)
{
 598:	ff010113          	addi	sp,sp,-16
 59c:	00112623          	sw	ra,12(sp)
 5a0:	00812423          	sw	s0,8(sp)
 5a4:	00912223          	sw	s1,4(sp)
 5a8:	01010413          	addi	s0,sp,16
 5ac:	fea42823          	sw	a0,-16(s0)
 5b0:	00058493          	mv	s1,a1
  if(d > isqrt(n)) return 1;
 5b4:	ff042503          	lw	a0,-16(s0)
 5b8:	00000097          	auipc	ra,0x0
 5bc:	f88080e7          	jalr	-120(ra) #  0x540 <isqrt>
 5c0:	02956063          	bltu	a0,s1, 0x5e0 <prime+0x48>
  if(n % d == 0) return 0;
 5c4:	00048593          	mv	a1,s1
 5c8:	ff042503          	lw	a0,-16(s0)
 5cc:	00000097          	auipc	ra,0x0
 5d0:	bb8080e7          	jalr	-1096(ra) #  0x184 <__modsi3>
 5d4:	00050863          	beqz	a0, 0x5e4 <prime+0x4c>
  return prime(n, d+2);
 5d8:	00248493          	addi	s1,s1,2
 5dc:	fd9ff06f          	j	 0x5b4 <prime+0x1c>
  if(d > isqrt(n)) return 1;
 5e0:	00100513          	li	a0,1
}
 5e4:	00c12083          	lw	ra,12(sp)
 5e8:	00812403          	lw	s0,8(sp)
 5ec:	00412483          	lw	s1,4(sp)
 5f0:	01010113          	addi	sp,sp,16
 5f4:	00008067          	ret

 0x000005f8 <primep>:

int primep(int n)
{
 5f8:	ff810113          	addi	sp,sp,-8
 5fc:	00112223          	sw	ra,4(sp)
 600:	00812023          	sw	s0,0(sp)
 604:	00810413          	addi	s0,sp,8
  if(n <= 1) return 0;
 608:	00100793          	li	a5,1
 60c:	02a7d663          	bge	a5,a0, 0x638 <primep+0x40>
  if(n == 2) return 1;
 610:	00200693          	li	a3,2
 614:	02d50463          	beq	a0,a3, 0x63c <primep+0x44>
  if(n % 2 == 0) return 0;
 618:	00f577b3          	and	a5,a0,a5
 61c:	02078063          	beqz	a5, 0x63c <primep+0x44>
  return prime(n ,3);
 620:	00300593          	li	a1,3
}
 624:	00412083          	lw	ra,4(sp)
 628:	00012403          	lw	s0,0(sp)
 62c:	00810113          	addi	sp,sp,8
  return prime(n ,3);
 630:	00000317          	auipc	t1,0x0
 634:	f6830067          	jr	-152(t1) #  0x598 <prime>
  if(n <= 1) return 0;
 638:	00000793          	li	a5,0
}
 63c:	00078513          	mv	a0,a5
 640:	00412083          	lw	ra,4(sp)
 644:	00012403          	lw	s0,0(sp)
 648:	00810113          	addi	sp,sp,8
 64c:	00008067          	ret

 0x00000650 <main>:

int main()
{
 650:	fec10113          	addi	sp,sp,-20
 654:	00112823          	sw	ra,16(sp)
 658:	00812623          	sw	s0,12(sp)
 65c:	00912423          	sw	s1,8(sp)
 660:	01410413          	addi	s0,sp,20
  int n, m;
  while(1) {
    printf("find all prime number from\n\r> ");
 664:	00001597          	auipc	a1,0x1
 668:	9a458593          	addi	a1,a1,-1628 #  0x1008 <main+0x9b8>
 66c:	00001517          	auipc	a0,0x1
 670:	9e052503          	lw	a0,-1568(a0) #  0x104c <_GLOBAL_OFFSET_TABLE_+0x4>
 674:	00000097          	auipc	ra,0x0
 678:	b6c080e7          	jalr	-1172(ra) #  0x1e0 <fprintf>
    scanf("%d", &n);
 67c:	fec40613          	addi	a2,s0,-20
 680:	00001597          	auipc	a1,0x1
 684:	9a858593          	addi	a1,a1,-1624 #  0x1028 <main+0x9d8>
 688:	00001517          	auipc	a0,0x1
 68c:	9c852503          	lw	a0,-1592(a0) #  0x1050 <_GLOBAL_OFFSET_TABLE_+0x8>
 690:	00000097          	auipc	ra,0x0
 694:	ca4080e7          	jalr	-860(ra) #  0x334 <fscanf>
    printf("%d\n\rto\n\r> ", n);
 698:	fec42603          	lw	a2,-20(s0)
 69c:	00001597          	auipc	a1,0x1
 6a0:	99058593          	addi	a1,a1,-1648 #  0x102c <main+0x9dc>
 6a4:	00001517          	auipc	a0,0x1
 6a8:	9a852503          	lw	a0,-1624(a0) #  0x104c <_GLOBAL_OFFSET_TABLE_+0x4>
 6ac:	00000097          	auipc	ra,0x0
 6b0:	b34080e7          	jalr	-1228(ra) #  0x1e0 <fprintf>
    scanf("%d", &m);
 6b4:	ff040613          	addi	a2,s0,-16
 6b8:	00001597          	auipc	a1,0x1
 6bc:	97058593          	addi	a1,a1,-1680 #  0x1028 <main+0x9d8>
 6c0:	00001517          	auipc	a0,0x1
 6c4:	99052503          	lw	a0,-1648(a0) #  0x1050 <_GLOBAL_OFFSET_TABLE_+0x8>
 6c8:	00000097          	auipc	ra,0x0
 6cc:	c6c080e7          	jalr	-916(ra) #  0x334 <fscanf>
    printf("%d\n\r: ", m);
 6d0:	ff042603          	lw	a2,-16(s0)
 6d4:	00001597          	auipc	a1,0x1
 6d8:	96458593          	addi	a1,a1,-1692 #  0x1038 <main+0x9e8>
 6dc:	00001517          	auipc	a0,0x1
 6e0:	97052503          	lw	a0,-1680(a0) #  0x104c <_GLOBAL_OFFSET_TABLE_+0x4>
 6e4:	00000097          	auipc	ra,0x0
 6e8:	afc080e7          	jalr	-1284(ra) #  0x1e0 <fprintf>
    for(int i = n; i<=m; i++){
 6ec:	fec42483          	lw	s1,-20(s0)
 6f0:	ff042783          	lw	a5,-16(s0)
 6f4:	0297d063          	bge	a5,s1, 0x714 <main+0xc4>
      if(primep(i)) printf("%d ", i);
    }
    printf("\n\r");
 6f8:	00001597          	auipc	a1,0x1
 6fc:	94c58593          	addi	a1,a1,-1716 #  0x1044 <main+0x9f4>
 700:	00001517          	auipc	a0,0x1
 704:	94c52503          	lw	a0,-1716(a0) #  0x104c <_GLOBAL_OFFSET_TABLE_+0x4>
 708:	00000097          	auipc	ra,0x0
 70c:	ad8080e7          	jalr	-1320(ra) #  0x1e0 <fprintf>
    printf("find all prime number from\n\r> ");
 710:	f55ff06f          	j	 0x664 <main+0x14>
      if(primep(i)) printf("%d ", i);
 714:	00048513          	mv	a0,s1
 718:	00000097          	auipc	ra,0x0
 71c:	ee0080e7          	jalr	-288(ra) #  0x5f8 <primep>
 720:	02050063          	beqz	a0, 0x740 <main+0xf0>
 724:	00048613          	mv	a2,s1
 728:	00001597          	auipc	a1,0x1
 72c:	91858593          	addi	a1,a1,-1768 #  0x1040 <main+0x9f0>
 730:	00001517          	auipc	a0,0x1
 734:	91c52503          	lw	a0,-1764(a0) #  0x104c <_GLOBAL_OFFSET_TABLE_+0x4>
 738:	00000097          	auipc	ra,0x0
 73c:	aa8080e7          	jalr	-1368(ra) #  0x1e0 <fprintf>
    for(int i = n; i<=m; i++){
 740:	00148493          	addi	s1,s1,1
 744:	fadff06f          	j	 0x6f0 <main+0xa0>
