
example/quicksort.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <push_a>:
  volatile int   pr_top;
  volatile int   p, r, q;
} filo_t;

void push_a(filo_t* f)
{
   0:	ff810113          	addi	sp,sp,-8
   4:	00112223          	sw	ra,4(sp)
   8:	00812023          	sw	s0,0(sp)
   c:	00810413          	addi	s0,sp,8
  f->A[f->a_top] = f->a;
  10:	00852703          	lw	a4,8(a0)
  14:	00271713          	slli	a4,a4,0x2
  18:	00052783          	lw	a5,0(a0)
  1c:	00e787b3          	add	a5,a5,a4
  20:	00452703          	lw	a4,4(a0)
  24:	00e7a023          	sw	a4,0(a5)
  f->a_top++;
  28:	00852783          	lw	a5,8(a0)
  2c:	00178793          	addi	a5,a5,1
  30:	00f52423          	sw	a5,8(a0)
}
  34:	00412083          	lw	ra,4(sp)
  38:	00012403          	lw	s0,0(sp)
  3c:	00810113          	addi	sp,sp,8
  40:	00008067          	ret

 0x00000044 <pop_a>:

void pop_a(filo_t* f)
{
  44:	ff810113          	addi	sp,sp,-8
  48:	00112223          	sw	ra,4(sp)
  4c:	00812023          	sw	s0,0(sp)
  50:	00810413          	addi	s0,sp,8
  f->a_top--;
  54:	00852783          	lw	a5,8(a0)
  58:	fff78793          	addi	a5,a5,-1
  5c:	00f52423          	sw	a5,8(a0)
  f->a = f->A[f->a_top];
  60:	00852703          	lw	a4,8(a0)
  64:	00271713          	slli	a4,a4,0x2
  68:	00052783          	lw	a5,0(a0)
  6c:	00e787b3          	add	a5,a5,a4
  70:	0007a783          	lw	a5,0(a5)
  74:	00f52223          	sw	a5,4(a0)
}
  78:	00412083          	lw	ra,4(sp)
  7c:	00012403          	lw	s0,0(sp)
  80:	00810113          	addi	sp,sp,8
  84:	00008067          	ret

 0x00000088 <swap>:

void swap(filo_t* f) 
{
  88:	ff810113          	addi	sp,sp,-8
  8c:	00112223          	sw	ra,4(sp)
  90:	00812023          	sw	s0,0(sp)
  94:	00810413          	addi	s0,sp,8
  if(f->A[f->i] == f->A[f->j]) return;
  98:	00052783          	lw	a5,0(a0)
  9c:	00c52703          	lw	a4,12(a0)
  a0:	00271713          	slli	a4,a4,0x2
  a4:	00e78733          	add	a4,a5,a4
  a8:	00072683          	lw	a3,0(a4)
  ac:	01052703          	lw	a4,16(a0)
  b0:	00271713          	slli	a4,a4,0x2
  b4:	00e78733          	add	a4,a5,a4
  b8:	00072703          	lw	a4,0(a4)
  bc:	06e68e63          	beq	a3,a4, 0x138 <swap+0xb0>
  f->A[f->i] ^= f->A[f->j];
  c0:	01052703          	lw	a4,16(a0)
  c4:	00271713          	slli	a4,a4,0x2
  c8:	00e78733          	add	a4,a5,a4
  cc:	00072603          	lw	a2,0(a4)
  d0:	00c52703          	lw	a4,12(a0)
  d4:	00271713          	slli	a4,a4,0x2
  d8:	00e78733          	add	a4,a5,a4
  dc:	00072683          	lw	a3,0(a4)
  e0:	00c6c6b3          	xor	a3,a3,a2
  e4:	00d72023          	sw	a3,0(a4)
  f->A[f->j] ^= f->A[f->i];
  e8:	00c52703          	lw	a4,12(a0)
  ec:	00271713          	slli	a4,a4,0x2
  f0:	00e78733          	add	a4,a5,a4
  f4:	00072603          	lw	a2,0(a4)
  f8:	01052703          	lw	a4,16(a0)
  fc:	00271713          	slli	a4,a4,0x2
 100:	00e78733          	add	a4,a5,a4
 104:	00072683          	lw	a3,0(a4)
 108:	00c6c6b3          	xor	a3,a3,a2
 10c:	00d72023          	sw	a3,0(a4)
  f->A[f->i] ^= f->A[f->j];
 110:	01052703          	lw	a4,16(a0)
 114:	00271713          	slli	a4,a4,0x2
 118:	00e78733          	add	a4,a5,a4
 11c:	00072683          	lw	a3,0(a4)
 120:	00c52703          	lw	a4,12(a0)
 124:	00271713          	slli	a4,a4,0x2
 128:	00e787b3          	add	a5,a5,a4
 12c:	0007a703          	lw	a4,0(a5)
 130:	00d74733          	xor	a4,a4,a3
 134:	00e7a023          	sw	a4,0(a5)
}
 138:	00412083          	lw	ra,4(sp)
 13c:	00012403          	lw	s0,0(sp)
 140:	00810113          	addi	sp,sp,8
 144:	00008067          	ret

 0x00000148 <push_pr>:

void push_pr(filo_t* f)
{
 148:	ff010113          	addi	sp,sp,-16
 14c:	00112623          	sw	ra,12(sp)
 150:	00812423          	sw	s0,8(sp)
 154:	01010413          	addi	s0,sp,16
  pr_t pr;
  pr.p = f->p;
 158:	02052783          	lw	a5,32(a0)
 15c:	fef42823          	sw	a5,-16(s0)
  pr.r = f->r;
 160:	02452783          	lw	a5,36(a0)
 164:	fef42a23          	sw	a5,-12(s0)
  f->pr_top++;
 168:	01c52783          	lw	a5,28(a0)
 16c:	00178793          	addi	a5,a5,1
 170:	00f52e23          	sw	a5,28(a0)
  f->pr[f->pr_top] = pr;
 174:	01c52703          	lw	a4,28(a0)
 178:	00371713          	slli	a4,a4,0x3
 17c:	01852783          	lw	a5,24(a0)
 180:	00e787b3          	add	a5,a5,a4
 184:	ff042703          	lw	a4,-16(s0)
 188:	00e7a023          	sw	a4,0(a5)
 18c:	ff442703          	lw	a4,-12(s0)
 190:	00e7a223          	sw	a4,4(a5)
}
 194:	00c12083          	lw	ra,12(sp)
 198:	00812403          	lw	s0,8(sp)
 19c:	01010113          	addi	sp,sp,16
 1a0:	00008067          	ret

 0x000001a4 <pop_pr>:

void pop_pr(filo_t* f)
{
 1a4:	ff010113          	addi	sp,sp,-16
 1a8:	00112623          	sw	ra,12(sp)
 1ac:	00812423          	sw	s0,8(sp)
 1b0:	01010413          	addi	s0,sp,16
  pr_t pr;
  pr = f->pr[f->pr_top];
 1b4:	01c52703          	lw	a4,28(a0)
 1b8:	00371713          	slli	a4,a4,0x3
 1bc:	01852783          	lw	a5,24(a0)
 1c0:	00e787b3          	add	a5,a5,a4
 1c4:	0007a703          	lw	a4,0(a5)
 1c8:	fee42823          	sw	a4,-16(s0)
 1cc:	0047a783          	lw	a5,4(a5)
 1d0:	fef42a23          	sw	a5,-12(s0)
  f->p = pr.p;
 1d4:	ff042783          	lw	a5,-16(s0)
 1d8:	02f52023          	sw	a5,32(a0)
  f->r = pr.r;
 1dc:	ff442783          	lw	a5,-12(s0)
 1e0:	02f52223          	sw	a5,36(a0)
  f->pr_top--;
 1e4:	01c52783          	lw	a5,28(a0)
 1e8:	fff78793          	addi	a5,a5,-1
 1ec:	00f52e23          	sw	a5,28(a0)
}
 1f0:	00c12083          	lw	ra,12(sp)
 1f4:	00812403          	lw	s0,8(sp)
 1f8:	01010113          	addi	sp,sp,16
 1fc:	00008067          	ret

 0x00000200 <partition>:

void partition(filo_t* f)
{
 200:	ff010113          	addi	sp,sp,-16
 204:	00112623          	sw	ra,12(sp)
 208:	00812423          	sw	s0,8(sp)
 20c:	00912223          	sw	s1,4(sp)
 210:	01010413          	addi	s0,sp,16
 214:	00050493          	mv	s1,a0
  f->x = f->A[f->r];
 218:	00052703          	lw	a4,0(a0)
 21c:	02452783          	lw	a5,36(a0)
 220:	00279793          	slli	a5,a5,0x2
 224:	00f707b3          	add	a5,a4,a5
 228:	0007a783          	lw	a5,0(a5)
 22c:	00f52a23          	sw	a5,20(a0)
  f->i = f->p;
 230:	02052783          	lw	a5,32(a0)
 234:	00f52623          	sw	a5,12(a0)
  for(f->j=f->p; f->j != f->r; f->j++) {
 238:	02052783          	lw	a5,32(a0)
 23c:	00f52823          	sw	a5,16(a0)
 240:	0104a683          	lw	a3,16(s1)
 244:	0244a783          	lw	a5,36(s1)
 248:	02f69663          	bne	a3,a5, 0x274 <partition+0x74>
    if(f->A[f->j] < f->x) {
      swap(f);
      f->i++;
    }
  }
  swap(f);
 24c:	00048513          	mv	a0,s1
 250:	00000097          	auipc	ra,0x0
 254:	e38080e7          	jalr	-456(ra) #  0x88 <swap>
  f->q = f->i;
 258:	00c4a783          	lw	a5,12(s1)
 25c:	02f4a423          	sw	a5,40(s1)
}
 260:	00c12083          	lw	ra,12(sp)
 264:	00812403          	lw	s0,8(sp)
 268:	00412483          	lw	s1,4(sp)
 26c:	01010113          	addi	sp,sp,16
 270:	00008067          	ret
    if(f->A[f->j] < f->x) {
 274:	0104a783          	lw	a5,16(s1)
 278:	00279793          	slli	a5,a5,0x2
 27c:	00f707b3          	add	a5,a4,a5
 280:	0007a683          	lw	a3,0(a5)
 284:	0144a783          	lw	a5,20(s1)
 288:	02f6d263          	bge	a3,a5, 0x2ac <partition+0xac>
 28c:	fee42823          	sw	a4,-16(s0)
      swap(f);
 290:	00048513          	mv	a0,s1
 294:	00000097          	auipc	ra,0x0
 298:	df4080e7          	jalr	-524(ra) #  0x88 <swap>
      f->i++;
 29c:	00c4a783          	lw	a5,12(s1)
 2a0:	00178793          	addi	a5,a5,1
 2a4:	00f4a623          	sw	a5,12(s1)
 2a8:	ff042703          	lw	a4,-16(s0)
  for(f->j=f->p; f->j != f->r; f->j++) {
 2ac:	0104a783          	lw	a5,16(s1)
 2b0:	00178793          	addi	a5,a5,1
 2b4:	00f4a823          	sw	a5,16(s1)
 2b8:	f89ff06f          	j	 0x240 <partition+0x40>

 0x000002bc <quicksort>:

void quicksort(filo_t* f)
{
 2bc:	fec10113          	addi	sp,sp,-20
 2c0:	00112823          	sw	ra,16(sp)
 2c4:	00812623          	sw	s0,12(sp)
 2c8:	00912423          	sw	s1,8(sp)
 2cc:	01410413          	addi	s0,sp,20
 2d0:	00050493          	mv	s1,a0
  f->pr_top = -1;
 2d4:	fff00793          	li	a5,-1
 2d8:	00f52e23          	sw	a5,28(a0)
  f->p = 0;
 2dc:	02052023          	sw	zero,32(a0)
  f->r = f->a_top -1;
 2e0:	00852783          	lw	a5,8(a0)
 2e4:	fff78793          	addi	a5,a5,-1
 2e8:	02f52223          	sw	a5,36(a0)
      f->p =q +1;
      f->r =r;
      if(f->p < f->r) push_pr(f);
      f->p = p;
      f->r = q-1;
      if(f->p < f->r) push_pr(f);
 2ec:	00000097          	auipc	ra,0x0
 2f0:	e5c080e7          	jalr	-420(ra) #  0x148 <push_pr>
  while(f->pr_top >= 0) {
 2f4:	01c4a783          	lw	a5,28(s1)
 2f8:	0007dc63          	bgez	a5, 0x310 <quicksort+0x54>
    }
  }
}
 2fc:	01012083          	lw	ra,16(sp)
 300:	00c12403          	lw	s0,12(sp)
 304:	00812483          	lw	s1,8(sp)
 308:	01410113          	addi	sp,sp,20
 30c:	00008067          	ret
    pop_pr(f);
 310:	00048513          	mv	a0,s1
 314:	00000097          	auipc	ra,0x0
 318:	e90080e7          	jalr	-368(ra) #  0x1a4 <pop_pr>
    if(f->p < f->r) {
 31c:	0204a703          	lw	a4,32(s1)
 320:	0244a783          	lw	a5,36(s1)
 324:	fcf758e3          	bge	a4,a5, 0x2f4 <quicksort+0x38>
      partition(f);
 328:	00048513          	mv	a0,s1
 32c:	00000097          	auipc	ra,0x0
 330:	ed4080e7          	jalr	-300(ra) #  0x200 <partition>
      int q = f->q;
 334:	0284a783          	lw	a5,40(s1)
      int r = f->r;
 338:	0244a683          	lw	a3,36(s1)
      int p = f->p;
 33c:	0204a703          	lw	a4,32(s1)
      f->p =q +1;
 340:	00178613          	addi	a2,a5,1
 344:	02c4a023          	sw	a2,32(s1)
      f->r =r;
 348:	02d4a223          	sw	a3,36(s1)
      if(f->p < f->r) push_pr(f);
 34c:	0204a603          	lw	a2,32(s1)
 350:	0244a683          	lw	a3,36(s1)
 354:	02d65063          	bge	a2,a3, 0x374 <quicksort+0xb8>
 358:	fee42623          	sw	a4,-20(s0)
 35c:	fef42823          	sw	a5,-16(s0)
 360:	00048513          	mv	a0,s1
 364:	00000097          	auipc	ra,0x0
 368:	de4080e7          	jalr	-540(ra) #  0x148 <push_pr>
 36c:	fec42703          	lw	a4,-20(s0)
 370:	ff042783          	lw	a5,-16(s0)
      f->p = p;
 374:	02e4a023          	sw	a4,32(s1)
      f->r = q-1;
 378:	fff78793          	addi	a5,a5,-1
 37c:	02f4a223          	sw	a5,36(s1)
      if(f->p < f->r) push_pr(f);
 380:	0204a703          	lw	a4,32(s1)
 384:	0244a783          	lw	a5,36(s1)
 388:	f6f756e3          	bge	a4,a5, 0x2f4 <quicksort+0x38>
 38c:	00048513          	mv	a0,s1
 390:	f5dff06f          	j	 0x2ec <quicksort+0x30>
