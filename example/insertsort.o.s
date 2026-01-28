
example/insertsort.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <push_a>:
  volatile int   i, j;
  volatile int   p, r;
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
  if(f->A[f->i] > f->A[f->j]) {
  98:	00052783          	lw	a5,0(a0)
  9c:	00c52703          	lw	a4,12(a0)
  a0:	00271713          	slli	a4,a4,0x2
  a4:	00e78733          	add	a4,a5,a4
  a8:	00072683          	lw	a3,0(a4)
  ac:	01052703          	lw	a4,16(a0)
  b0:	00271713          	slli	a4,a4,0x2
  b4:	00e78733          	add	a4,a5,a4
  b8:	00072703          	lw	a4,0(a4)
  bc:	0ad75063          	bge	a4,a3, 0x15c <swap+0xd4>
    if(f->A[f->i] == f->A[f->j]) return;
  c0:	00c52703          	lw	a4,12(a0)
  c4:	00271713          	slli	a4,a4,0x2
  c8:	00e78733          	add	a4,a5,a4
  cc:	00072683          	lw	a3,0(a4)
  d0:	01052703          	lw	a4,16(a0)
  d4:	00271713          	slli	a4,a4,0x2
  d8:	00e78733          	add	a4,a5,a4
  dc:	00072703          	lw	a4,0(a4)
  e0:	06e68e63          	beq	a3,a4, 0x15c <swap+0xd4>
    f->A[f->i] ^= f->A[f->j];
  e4:	01052703          	lw	a4,16(a0)
  e8:	00271713          	slli	a4,a4,0x2
  ec:	00e78733          	add	a4,a5,a4
  f0:	00072603          	lw	a2,0(a4)
  f4:	00c52703          	lw	a4,12(a0)
  f8:	00271713          	slli	a4,a4,0x2
  fc:	00e78733          	add	a4,a5,a4
 100:	00072683          	lw	a3,0(a4)
 104:	00c6c6b3          	xor	a3,a3,a2
 108:	00d72023          	sw	a3,0(a4)
    f->A[f->j] ^= f->A[f->i];
 10c:	00c52703          	lw	a4,12(a0)
 110:	00271713          	slli	a4,a4,0x2
 114:	00e78733          	add	a4,a5,a4
 118:	00072603          	lw	a2,0(a4)
 11c:	01052703          	lw	a4,16(a0)
 120:	00271713          	slli	a4,a4,0x2
 124:	00e78733          	add	a4,a5,a4
 128:	00072683          	lw	a3,0(a4)
 12c:	00c6c6b3          	xor	a3,a3,a2
 130:	00d72023          	sw	a3,0(a4)
    f->A[f->i] ^= f->A[f->j];
 134:	01052703          	lw	a4,16(a0)
 138:	00271713          	slli	a4,a4,0x2
 13c:	00e78733          	add	a4,a5,a4
 140:	00072683          	lw	a3,0(a4)
 144:	00c52703          	lw	a4,12(a0)
 148:	00271713          	slli	a4,a4,0x2
 14c:	00e787b3          	add	a5,a5,a4
 150:	0007a703          	lw	a4,0(a5)
 154:	00d74733          	xor	a4,a4,a3
 158:	00e7a023          	sw	a4,0(a5)
  }
}
 15c:	00412083          	lw	ra,4(sp)
 160:	00012403          	lw	s0,0(sp)
 164:	00810113          	addi	sp,sp,8
 168:	00008067          	ret

 0x0000016c <insertsort>:

void insertsort (filo_t* f)
{
 16c:	ff410113          	addi	sp,sp,-12
 170:	00112423          	sw	ra,8(sp)
 174:	00812223          	sw	s0,4(sp)
 178:	00912023          	sw	s1,0(sp)
 17c:	00c10413          	addi	s0,sp,12
 180:	00050493          	mv	s1,a0
  for(f->p=1; f->p < f->a_top; f->p++) {
 184:	00100793          	li	a5,1
 188:	00f52a23          	sw	a5,20(a0)
 18c:	0144a703          	lw	a4,20(s1)
 190:	0084a783          	lw	a5,8(s1)
 194:	00f74c63          	blt	a4,a5, 0x1ac <insertsort+0x40>
      f->i = f->r;
      f->j = f->r+1;
      swap(f);
    }
  }
}
 198:	00812083          	lw	ra,8(sp)
 19c:	00412403          	lw	s0,4(sp)
 1a0:	00012483          	lw	s1,0(sp)
 1a4:	00c10113          	addi	sp,sp,12
 1a8:	00008067          	ret
    for(f->r = f->p-1; f->r >= 0; f->r--) {
 1ac:	0144a783          	lw	a5,20(s1)
 1b0:	fff78793          	addi	a5,a5,-1
 1b4:	00f4ac23          	sw	a5,24(s1)
 1b8:	0184a783          	lw	a5,24(s1)
 1bc:	0007da63          	bgez	a5, 0x1d0 <insertsort+0x64>
  for(f->p=1; f->p < f->a_top; f->p++) {
 1c0:	0144a783          	lw	a5,20(s1)
 1c4:	00178793          	addi	a5,a5,1
 1c8:	00f4aa23          	sw	a5,20(s1)
 1cc:	fc1ff06f          	j	 0x18c <insertsort+0x20>
      f->i = f->r;
 1d0:	0184a783          	lw	a5,24(s1)
 1d4:	00f4a623          	sw	a5,12(s1)
      f->j = f->r+1;
 1d8:	0184a783          	lw	a5,24(s1)
 1dc:	00178793          	addi	a5,a5,1
 1e0:	00f4a823          	sw	a5,16(s1)
      swap(f);
 1e4:	00048513          	mv	a0,s1
 1e8:	00000097          	auipc	ra,0x0
 1ec:	ea0080e7          	jalr	-352(ra) #  0x88 <swap>
    for(f->r = f->p-1; f->r >= 0; f->r--) {
 1f0:	0184a783          	lw	a5,24(s1)
 1f4:	fbdff06f          	j	 0x1b0 <insertsort+0x44>
