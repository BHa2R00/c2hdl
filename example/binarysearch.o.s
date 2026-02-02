
example/binarysearch.o:     file format elf32-littleriscv


Disassembly of section .text:

 0x00000000 <binarysearch>:
#else 
#include "stdio.h"
#endif

int binarysearch(int* A, int l, int r, int t)
{
   0:	ff810113          	addi	sp,sp,-8
   4:	00112223          	sw	ra,4(sp)
   8:	00812023          	sw	s0,0(sp)
   c:	00810413          	addi	s0,sp,8
  int L=l, R=r;
  while(L<R) {
  10:	00c5cc63          	blt	a1,a2, 0x28 <binarysearch+0x28>
    int m = L+((R-L)>>1);
    if(A[m]>t) R=m;
    else L=m+1;
  }
  return R-1;
}
  14:	fff60513          	addi	a0,a2,-1
  18:	00412083          	lw	ra,4(sp)
  1c:	00012403          	lw	s0,0(sp)
  20:	00810113          	addi	sp,sp,8
  24:	00008067          	ret
    int m = L+((R-L)>>1);
  28:	40b607b3          	sub	a5,a2,a1
  2c:	4017d793          	srai	a5,a5,0x1
  30:	00b787b3          	add	a5,a5,a1
    if(A[m]>t) R=m;
  34:	00279713          	slli	a4,a5,0x2
  38:	00e50733          	add	a4,a0,a4
  3c:	00072703          	lw	a4,0(a4)
  40:	00e6c663          	blt	a3,a4, 0x4c <binarysearch+0x4c>
    else L=m+1;
  44:	00178593          	addi	a1,a5,1
  48:	fc9ff06f          	j	 0x10 <binarysearch+0x10>
    if(A[m]>t) R=m;
  4c:	00078613          	mv	a2,a5
  50:	fc1ff06f          	j	 0x10 <binarysearch+0x10>
