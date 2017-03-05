	.data 
arr:    .word 89, 19, 91, 23, 31, 46, 3, 67, 17, 11, 43, 73 #4 bytes for each of 12 integers.

	.text
	li $t0, 0 #initialize loop counter i~=$t0 to 0.
	li $t1, 0x0000002c #initialize loop max value $t1 to 2c=hex(11*4);
	li $t2, 0x00000000 #initialize max value to 0.
	li $t3, 0x00000000 #initialize return index to 0.
	la $t7, arr #Array start stored in $t7.
loop:   add $t6 $t7 $t0 #Memory= 4*index + array start, and we increment the index by 4.
	lw $t4 ($t6) #load current array value into t4
	sub $t5 $t4 $t2 #subtract array value from known max: temp becomes current arrval minus max value
	bltz $t5 postsw #if temp is positive, swap, else jump to postswap.
swap:   addi $t2 $t4 0 #$t2<-$t4 Arrval becomes the new known max. ERROR HERE.
	addi $t3 $t0 0 #$t3<-$t0 Current index becomes the new return index.
postsw: addi $t0 $t0 4  #increment loop counter by 4 bytes.
	bne $t0 $t1 loop #Loops back if we're not done yet (i equals maxindex)
	sra $t3 $t3 2 #divide the index by 4 by bitshifting twice.  Result is zero-indexed.
	li  $v0, 1           # service 1 is print integer
	addi $a0, $t3, 0  #load result into t3.
	syscall #print value of $t3
	li $v0, 10 #load exit value
	syscall #exit call.
exit:
