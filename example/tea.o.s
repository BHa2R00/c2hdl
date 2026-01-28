
example/tea.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <swmul>:
#ifdef SIM
#inclu 0xde <stdio.h>
#endif

int swmul(short a, short b) 
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
  40:	02071063          	bnez	a4, 0x60 <swmul+0x60>
    if(aa & 1) m += bb;
     0xbb <<=1;
    aa >>=1;
  }
  if((a<0)!=(b<0)) m = -m;
  44:	00b6c6b3          	xor	a3,a3,a1
  48:	0006d463          	bgez	a3, 0x50 <swmul+0x50>
  4c:	40a00533          	neg	a0,a0
  return m;
}
  50:	00412083          	lw	ra,4(sp)
  54:	00012403          	lw	s0,0(sp)
  58:	00810113          	addi	sp,sp,8
  5c:	00008067          	ret
    if(aa & 1) m += bb;
  60:	00177613          	andi	a2,a4,1
  64:	00060463          	beqz	a2, 0x6c <swmul+0x6c>
  68:	00f50533          	add	a0,a0,a5
     0xbb <<=1;
  6c:	00179793          	slli	a5,a5,0x1
  70:	01079793          	slli	a5,a5,0x10
  74:	0107d793          	srli	a5,a5,0x10
    aa >>=1;
  78:	00175713          	srli	a4,a4,0x1
  7c:	fc5ff06f          	j	 0x40 <swmul+0x40>

 0x00000080 <tinyenc>:
  volatile unsigned short* dat;
  volatile unsigned short* key;
} tea_t;

void tinyenc(tea_t* t)
{
  80:	ff010113          	addi	sp,sp,-16
  84:	00112623          	sw	ra,12(sp)
  88:	00812423          	sw	s0,8(sp)
  8c:	00912223          	sw	s1,4(sp)
  90:	01010413          	addi	s0,sp,16
  unsigned short x = t->dat[0];
  94:	00452583          	lw	a1,4(a0)
  98:	0005d683          	lhu	a3,0(a1)
  9c:	01069693          	slli	a3,a3,0x10
  a0:	0106d693          	srli	a3,a3,0x10
  unsigned short y = t->dat[1];
  a4:	0025d703          	lhu	a4,2(a1)
  a8:	01071713          	slli	a4,a4,0x10
  ac:	01075713          	srli	a4,a4,0x10
  unsigned short sum = 0;
  int i;
  for(i=0;i<t->round;i++){
  b0:	00000293          	li	t0,0
  unsigned short sum = 0;
  b4:	00000613          	li	a2,0
    sum += DELTA;
  b8:	ffffa7b7          	lui	a5,0xffffa
  bc:	e3778793          	addi	a5,a5,-457 #  0xffff9e37 <tinydec+0xffff9cd3>
  c0:	fef42823          	sw	a5,-16(s0)
  for(i=0;i<t->round;i++){
  c4:	00052783          	lw	a5,0(a0)
  c8:	02f2c063          	blt	t0,a5, 0xe8 <tinyenc+0x68>
    y += ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3]);
    #ifdef SIM
    printf("sum = %x\n", sum);
    #endif
  }
  t->dat[0] = x;
  cc:	00d59023          	sh	a3,0(a1)
  t->dat[1] = y;
  d0:	00e59123          	sh	a4,2(a1)
}
  d4:	00c12083          	lw	ra,12(sp)
  d8:	00812403          	lw	s0,8(sp)
  dc:	00412483          	lw	s1,4(sp)
  e0:	01010113          	addi	sp,sp,16
  e4:	00008067          	ret
    sum += DELTA;
  e8:	ff042783          	lw	a5,-16(s0)
  ec:	00f60633          	add	a2,a2,a5
  f0:	01061613          	slli	a2,a2,0x10
  f4:	01065613          	srli	a2,a2,0x10
    x += ((y << SHL) + t->key[0]) ^ (y + sum) ^ ((y >> SHR) + t->key[1]);
  f8:	00852303          	lw	t1,8(a0)
  fc:	00035783          	lhu	a5,0(t1)
 100:	00235383          	lhu	t2,2(t1)
 104:	00471493          	slli	s1,a4,0x4
 108:	00f487b3          	add	a5,s1,a5
 10c:	00575493          	srli	s1,a4,0x5
 110:	007484b3          	add	s1,s1,t2
 114:	0097c7b3          	xor	a5,a5,s1
 118:	00c703b3          	add	t2,a4,a2
 11c:	0077c7b3          	xor	a5,a5,t2
 120:	00f687b3          	add	a5,a3,a5
 124:	01079693          	slli	a3,a5,0x10
 128:	0106d693          	srli	a3,a3,0x10
    y += ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3]);
 12c:	00435483          	lhu	s1,4(t1)
 130:	00635383          	lhu	t2,6(t1)
 134:	00469793          	slli	a5,a3,0x4
 138:	009787b3          	add	a5,a5,s1
 13c:	0056d313          	srli	t1,a3,0x5
 140:	00730333          	add	t1,t1,t2
 144:	0067c7b3          	xor	a5,a5,t1
 148:	00d60333          	add	t1,a2,a3
 14c:	0067c7b3          	xor	a5,a5,t1
 150:	00f707b3          	add	a5,a4,a5
 154:	01079713          	slli	a4,a5,0x10
 158:	01075713          	srli	a4,a4,0x10
  for(i=0;i<t->round;i++){
 15c:	00128293          	addi	t0,t0,1
 160:	f65ff06f          	j	 0xc4 <tinyenc+0x44>

 0x00000164 <tinydec>:

void tinydec (tea_t* t) {
 164:	fe410113          	addi	sp,sp,-28
 168:	00112c23          	sw	ra,24(sp)
 16c:	00812a23          	sw	s0,20(sp)
 170:	00912823          	sw	s1,16(sp)
 174:	01c10413          	addi	s0,sp,28
  unsigned short x = t->dat[0];
 178:	00452303          	lw	t1,4(a0)
 17c:	00035703          	lhu	a4,0(t1)
 180:	01071713          	slli	a4,a4,0x10
 184:	01075713          	srli	a4,a4,0x10
 188:	fee42223          	sw	a4,-28(s0)
  unsigned short y = t->dat[1];
 18c:	00235483          	lhu	s1,2(t1)
 190:	fe642423          	sw	t1,-24(s0)
 194:	01049493          	slli	s1,s1,0x10
 198:	0104d493          	srli	s1,s1,0x10
  unsigned short sum = swmul(DELTA, t->round);
 19c:	00052583          	lw	a1,0(a0)
 1a0:	fea42623          	sw	a0,-20(s0)
 1a4:	01059593          	slli	a1,a1,0x10
 1a8:	4105d593          	srai	a1,a1,0x10
 1ac:	ffffa537          	lui	a0,0xffffa
 1b0:	e3750513          	addi	a0,a0,-457 #  0xffff9e37 <tinydec+0xffff9cd3>
 1b4:	00000097          	auipc	ra,0x0
 1b8:	e4c080e7          	jalr	-436(ra) #  0x0 <swmul>
 1bc:	01051693          	slli	a3,a0,0x10
 1c0:	0106d693          	srli	a3,a3,0x10
  int i;
  for(i=0;i<t->round;i++){
 1c4:	00000513          	li	a0,0
    y -= ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3]);
    x -= ((y << SHL) + t->key[0]) ^ (y + sum) ^ ((y >> SHR) + t->key[1]);
    sum -= DELTA;
 1c8:	000067b7          	lui	a5,0x6
 1cc:	1c978793          	addi	a5,a5,457 #  0x61c9 <tinydec+0x6065>
 1d0:	fef42823          	sw	a5,-16(s0)
  for(i=0;i<t->round;i++){
 1d4:	fec42603          	lw	a2,-20(s0)
 1d8:	fe842303          	lw	t1,-24(s0)
 1dc:	fe442703          	lw	a4,-28(s0)
 1e0:	00062783          	lw	a5,0(a2)
 1e4:	02f54063          	blt	a0,a5, 0x204 <tinydec+0xa0>
    #ifdef SIM
    printf("sum = %x\n", sum);
    #endif
  }
  t->dat[0] = x;
 1e8:	00e31023          	sh	a4,0(t1)
  t->dat[1] = y;
 1ec:	00931123          	sh	s1,2(t1)
}
 1f0:	01812083          	lw	ra,24(sp)
 1f4:	01412403          	lw	s0,20(sp)
 1f8:	01012483          	lw	s1,16(sp)
 1fc:	01c10113          	addi	sp,sp,28
 200:	00008067          	ret
    y -= ((x << SHL) + t->key[2]) ^ (x + sum) ^ ((x >> SHR) + t->key[3]);
 204:	00862583          	lw	a1,8(a2)
 208:	0045d783          	lhu	a5,4(a1)
 20c:	0065d283          	lhu	t0,6(a1)
 210:	00471393          	slli	t2,a4,0x4
 214:	00f387b3          	add	a5,t2,a5
 218:	00575393          	srli	t2,a4,0x5
 21c:	005383b3          	add	t2,t2,t0
 220:	0077c7b3          	xor	a5,a5,t2
 224:	00d702b3          	add	t0,a4,a3
 228:	0057c7b3          	xor	a5,a5,t0
 22c:	40f487b3          	sub	a5,s1,a5
 230:	01079493          	slli	s1,a5,0x10
 234:	0104d493          	srli	s1,s1,0x10
    x -= ((y << SHL) + t->key[0]) ^ (y + sum) ^ ((y >> SHR) + t->key[1]);
 238:	0005d383          	lhu	t2,0(a1)
 23c:	0025d283          	lhu	t0,2(a1)
 240:	00449793          	slli	a5,s1,0x4
 244:	007787b3          	add	a5,a5,t2
 248:	0054d593          	srli	a1,s1,0x5
 24c:	005585b3          	add	a1,a1,t0
 250:	00b7c7b3          	xor	a5,a5,a1
 254:	009685b3          	add	a1,a3,s1
 258:	00b7c7b3          	xor	a5,a5,a1
 25c:	40f707b3          	sub	a5,a4,a5
 260:	01079713          	slli	a4,a5,0x10
 264:	01075713          	srli	a4,a4,0x10
    sum -= DELTA;
 268:	ff042783          	lw	a5,-16(s0)
 26c:	00f686b3          	add	a3,a3,a5
 270:	01069693          	slli	a3,a3,0x10
 274:	0106d693          	srli	a3,a3,0x10
  for(i=0;i<t->round;i++){
 278:	00150513          	addi	a0,a0,1
 27c:	f65ff06f          	j	 0x1e0 <tinydec+0x7c>
