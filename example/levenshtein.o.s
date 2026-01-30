
example/levenshtein.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <levenshtein>:
#inclu 0xde <stdio.h>
#endif
#inclu 0xde <string.h>

int levenshtein(char* a, int a_len, char* b, int b_len)
{
   0:	fd810113          	addi	sp,sp,-40
   4:	02112223          	sw	ra,36(sp)
   8:	02812023          	sw	s0,32(sp)
   c:	00912e23          	sw	s1,28(sp)
  10:	02810413          	addi	s0,sp,40
  14:	fea42823          	sw	a0,-16(s0)
  18:	fec42623          	sw	a2,-20(s0)
  1c:	00068493          	mv	s1,a3
  if(a_len ==0) return b_len;
  20:	0a058863          	beqz	a1, 0xd0 <levenshtein+0xd0>
  24:	00058713          	mv	a4,a1
  if(b_len ==0) return a_len;
  28:	0a068263          	beqz	a3, 0xcc <levenshtein+0xcc>
  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1;
  int d = levenshtein(a, a_len-1, b, b_len) +1;
  2c:	fff58793          	addi	a5,a1,-1
  30:	feb42223          	sw	a1,-28(s0)
  34:	fef42423          	sw	a5,-24(s0)
  38:	00078593          	mv	a1,a5
  3c:	00000097          	auipc	ra,0x0
  40:	fc4080e7          	jalr	-60(ra) #  0x0 <levenshtein>
  44:	fca42c23          	sw	a0,-40(s0)
  int i = levenshtein(a, a_len, b, b_len-1) +1;
  48:	fff48693          	addi	a3,s1,-1
  4c:	fcd42e23          	sw	a3,-36(s0)
  50:	fec42603          	lw	a2,-20(s0)
  54:	fe442703          	lw	a4,-28(s0)
  58:	00070593          	mv	a1,a4
  5c:	fee42023          	sw	a4,-32(s0)
  60:	ff042503          	lw	a0,-16(s0)
  64:	00000097          	auipc	ra,0x0
  68:	f9c080e7          	jalr	-100(ra) #  0x0 <levenshtein>
  6c:	fea42223          	sw	a0,-28(s0)
  int s = levenshtein(a, a_len-1, b, b_len-1) +cost;
  70:	fdc42683          	lw	a3,-36(s0)
  74:	fec42603          	lw	a2,-20(s0)
  78:	fe842583          	lw	a1,-24(s0)
  7c:	ff042503          	lw	a0,-16(s0)
  80:	00000097          	auipc	ra,0x0
  84:	f80080e7          	jalr	-128(ra) #  0x0 <levenshtein>
  int cost = (a[a_len-1] == b[b_len-1]) ? 0 : 1;
  88:	ff042783          	lw	a5,-16(s0)
  8c:	fe042703          	lw	a4,-32(s0)
  90:	00e78733          	add	a4,a5,a4
  94:	fec42783          	lw	a5,-20(s0)
  98:	009787b3          	add	a5,a5,s1
  9c:	fff74703          	lbu	a4,-1(a4)
  a0:	fff7c783          	lbu	a5,-1(a5)
  a4:	40f70733          	sub	a4,a4,a5
  a8:	00e03733          	snez	a4,a4
  int s = levenshtein(a, a_len-1, b, b_len-1) +cost;
  ac:	00a70733          	add	a4,a4,a0
  int i = levenshtein(a, a_len, b, b_len-1) +1;
  b0:	fe442283          	lw	t0,-28(s0)
  b4:	00128793          	addi	a5,t0,1
  if(i < d) d = i;
  b8:	fd842303          	lw	t1,-40(s0)
  bc:	0062c463          	blt	t0,t1, 0xc4 <levenshtein+0xc4>
  int d = levenshtein(a, a_len-1, b, b_len) +1;
  c0:	00130793          	addi	a5,t1,1
  if(s < d) d = s;
  c4:	00078493          	mv	s1,a5
  c8:	00f75463          	bge	a4,a5, 0xd0 <levenshtein+0xd0>
  if(b_len ==0) return a_len;
  cc:	00070493          	mv	s1,a4
  return d;
}
  d0:	00048513          	mv	a0,s1
  d4:	02412083          	lw	ra,36(sp)
  d8:	02012403          	lw	s0,32(sp)
  dc:	01c12483          	lw	s1,28(sp)
  e0:	02810113          	addi	sp,sp,40
  e4:	00008067          	ret
