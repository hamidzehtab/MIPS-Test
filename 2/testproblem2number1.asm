.data
msg1: .asciiz "Enter a 32 bit number n : "
msg2: .asciiz "		Enter k  : "
msg3: .asciiz "Enter rotation direction : "

.text

# print initial string  for entering n
la $a0, msg1
addi $v0, $zero, 4
syscall 

# read integer n
addi $v0, $zero, 5
syscall 
addi $s1, $v0, 0

# print initial string for entering k
la $a0, msg2
addi $v0, $zero, 4
syscall 

# read integer k  1<k<31
addi $v0, $zero, 5
syscall 
addi $s2, $v0, 0

# print initial string  for entering rotation direction
la $a0, msg3
addi $v0, $zero, 4
syscall 

# read integer rotate  rotate = 0 or 1   0 -> rotate to left      1 -> rotate to right
addi $v0, $zero, 5
syscall 
addi $s3, $v0, 0

beq $s3, 0, Left
srlv $t1, $s1, $s2	
addi $a0, $0, 32
sub $t0, $a0, $s2	# $t0 = 32 - k 
sllv $t2, $s1, $t0
add $s1, $t1, $t2
j Exit

Left:
sllv $t1, $s1, $s2	
addi $a0, $0, 32
sub $t0, $a0, $s2	# $t0 = 32 - k 
srlv $t2, $s1, $t0
add $s1, $t1, $t2

Exit:
# print output 
addi $a0, $s1, 0
addi $v0, $zero, 1
syscall

# exit
addi $v0, $zero, 10
syscall
