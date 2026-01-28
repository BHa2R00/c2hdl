
example/fibonacci.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <fibonacci_step>:
#endif

typedef struct { volatile int a,b,c, k; } counter_t;

void fibonacci_step (counter_t* t) 
{
   0:	ff810113          	addi	sp,sp,-8
   4:	00112223          	sw	ra,4(sp)
   8:	00812023          	sw	s0,0(sp)
   c:	00810413          	addi	s0,sp,8
  t->c = t->a + t->b;
  10:	00052783          	lw	a5,0(a0)
  14:	00452703          	lw	a4,4(a0)
  18:	00e787b3          	add	a5,a5,a4
  1c:	00f52423          	sw	a5,8(a0)
  t->a = t->b;
  20:	00452783          	lw	a5,4(a0)
  24:	00f52023          	sw	a5,0(a0)
  t->b = t->c;
  28:	00852783          	lw	a5,8(a0)
  2c:	00f52223          	sw	a5,4(a0)
  #ifdef SIM
  printf("a=%d, b=%d, c=%d, k=%d\n", t->a, t->b, t->c, t->k);
  #endif
}
  30:	00412083          	lw	ra,4(sp)
  34:	00012403          	lw	s0,0(sp)
  38:	00810113          	addi	sp,sp,8
  3c:	00008067          	ret

 0x00000040 <fibonacci>:

void fibonacci (counter_t* t)
{
  40:	ff410113          	addi	sp,sp,-12
  44:	00112423          	sw	ra,8(sp)
  48:	00812223          	sw	s0,4(sp)
  4c:	00912023          	sw	s1,0(sp)
  50:	00c10413          	addi	s0,sp,12
  54:	00050493          	mv	s1,a0
  while(--t->k >= 0) fibonacci_step(t);
  58:	00c4a783          	lw	a5,12(s1)
  5c:	fff78793          	addi	a5,a5,-1
  60:	00f4a623          	sw	a5,12(s1)
  64:	0007dc63          	bgez	a5, 0x7c <fibonacci+0x3c>
}
  68:	00812083          	lw	ra,8(sp)
  6c:	00412403          	lw	s0,4(sp)
  70:	00012483          	lw	s1,0(sp)
  74:	00c10113          	addi	sp,sp,12
  78:	00008067          	ret
  while(--t->k >= 0) fibonacci_step(t);
  7c:	00048513          	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	f80080e7          	jalr	-128(ra) #  0x0 <fibonacci_step>
  88:	fd1ff06f          	j	 0x58 <fibonacci+0x18>
