
example/levenshtein.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <min3>:
#inclu 0xde <stdio.h>
#endif
#inclu 0xde <string.h>

int min3(int a, int b, int c)
{
   0:	ff810113          	addi	sp,sp,-8
   4:	00112223          	sw	ra,4(sp)
   8:	00812023          	sw	s0,0(sp)
   c:	00810413          	addi	s0,sp,8
  10:	00050793          	mv	a5,a0
  int m = a;
  if( 0xb < m) m = b;
  if( 0xc < m) m = c;
  14:	00060513          	mv	a0,a2
  18:	00b64463          	blt	a2,a1, 0x20 <min3+0x20>
  1c:	00058513          	mv	a0,a1
  20:	00a7d463          	bge	a5,a0, 0x28 <min3+0x28>
  24:	00078513          	mv	a0,a5
  return m;
}
  28:	00412083          	lw	ra,4(sp)
  2c:	00012403          	lw	s0,0(sp)
  30:	00810113          	addi	sp,sp,8
  34:	00008067          	ret

 0x00000038 <levenshtein>:

int levenshtein(char* a, int a_len, char* b, int b_len)
{
  38:	fd810113          	addi	sp,sp,-40
  3c:	02112223          	sw	ra,36(sp)
  40:	02812023          	sw	s0,32(sp)
  44:	00912e23          	sw	s1,28(sp)
  48:	02810413          	addi	s0,sp,40
  4c:	fea42823          	sw	a0,-16(s0)
  50:	fec42623          	sw	a2,-20(s0)
  54:	00068493          	mv	s1,a3
  if(a_len ==0) return b_len;
  58:	0a058863          	beqz	a1, 0x108 <levenshtein+0xd0>
  if(b_len ==0) return a_len;
  5c:	0c068263          	beqz	a3, 0x120 <levenshtein+0xe8>
  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1;
  int m = min3(
    levenshtein(a, a_len-1, b, b_len) +1, 
  60:	fff58793          	addi	a5,a1,-1
  64:	feb42223          	sw	a1,-28(s0)
  68:	fef42423          	sw	a5,-24(s0)
  6c:	00078593          	mv	a1,a5
  70:	00000097          	auipc	ra,0x0
  74:	fc8080e7          	jalr	-56(ra) #  0x38 <levenshtein>
  78:	fca42c23          	sw	a0,-40(s0)
    levenshtein(a, a_len, b, b_len-1) +1, 
  7c:	fff48693          	addi	a3,s1,-1
  80:	fcd42e23          	sw	a3,-36(s0)
  84:	fec42603          	lw	a2,-20(s0)
  88:	fe442703          	lw	a4,-28(s0)
  8c:	00070593          	mv	a1,a4
  90:	fee42023          	sw	a4,-32(s0)
  94:	ff042503          	lw	a0,-16(s0)
  98:	00000097          	auipc	ra,0x0
  9c:	fa0080e7          	jalr	-96(ra) #  0x38 <levenshtein>
  a0:	fea42223          	sw	a0,-28(s0)
    levenshtein(a, a_len-1, b, b_len-1) +cost
  a4:	fdc42683          	lw	a3,-36(s0)
  a8:	fec42603          	lw	a2,-20(s0)
  ac:	fe842583          	lw	a1,-24(s0)
  b0:	ff042503          	lw	a0,-16(s0)
  b4:	00000097          	auipc	ra,0x0
  b8:	f84080e7          	jalr	-124(ra) #  0x38 <levenshtein>
  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1;
  bc:	ff042783          	lw	a5,-16(s0)
  c0:	fe042703          	lw	a4,-32(s0)
  c4:	00e786b3          	add	a3,a5,a4
  c8:	fec42783          	lw	a5,-20(s0)
  cc:	00978733          	add	a4,a5,s1
  d0:	fff6c783          	lbu	a5,-1(a3)
  d4:	fff74703          	lbu	a4,-1(a4)
  d8:	40e787b3          	sub	a5,a5,a4
  dc:	00f037b3          	snez	a5,a5
  int m = min3(
  e0:	00a787b3          	add	a5,a5,a0
  e4:	fe442283          	lw	t0,-28(s0)
  e8:	00128293          	addi	t0,t0,1
  if( 0xb < m) m = b;
  ec:	fd842303          	lw	t1,-40(s0)
  f0:	00130313          	addi	t1,t1,1
  f4:	0062d463          	bge	t0,t1, 0xfc <levenshtein+0xc4>
  f8:	00028313          	mv	t1,t0
  if( 0xc < m) m = c;
  fc:	00078493          	mv	s1,a5
 100:	00f35463          	bge	t1,a5, 0x108 <levenshtein+0xd0>
 104:	00030493          	mv	s1,t1
  );
  return m;
}
 108:	00048513          	mv	a0,s1
 10c:	02412083          	lw	ra,36(sp)
 110:	02012403          	lw	s0,32(sp)
 114:	01c12483          	lw	s1,28(sp)
 118:	02810113          	addi	sp,sp,40
 11c:	00008067          	ret
  if(b_len ==0) return a_len;
 120:	00058493          	mv	s1,a1
 124:	fe5ff06f          	j	 0x108 <levenshtein+0xd0>
