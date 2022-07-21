# Hamid Reza Zehtab - 9912762541

.data 
# intializing the memory
n: .word 3
a: .word 6, 3, 3
b: .word 8, 3, 4
c: .word 10, 3, 5
area: .word -3, -3, -3
perimeter: .word  -3, -3, -3

.text
# loading memory addresses 
la $s0, n 
lw $s0, 0($s0)    # loading n in $s0
la $s1, a
la $s2, b
la $s3, c
la $s4, perimeter
la $s5, area

LOOP:
	beq $s0,$zero,EXIT    	# if n==0 -> exit
	lw $t1, 0($s1)        	# $t1 = a[0]
	lw $t2, 0($s2)		# $t2 = b[0]
	lw $t3, 0($s3)		# $t3 = c[0]
	
	add $a0, $t1, $t2	# $a0 = a[0] + b[0]
	add $a1, $t1, $t3	# $a1 = a[0] + c[0]
	add $a2, $t2, $t3	# $a2 = b[0] + c[0]
	
	slt $v0, $t1, $a2	# check a[0] < b[0] + c[0]
	slt $v1, $t2, $a1	# check b[0] < a[0] + c[0]
	slt $a3, $t3, $a0	# check c[0] < a[0] + b[0]
	
	add $v1, $v0, $v1	
	add $a3, $v1, $a3
	
	bne $a3, 3, NEXT	# if all three conditions are met then continue
	
	
	add $t4, $t1, $t2	# $t4 = a[i] + b[i]
	add $t4, $t4, $t3	# $t4 = a[i] + b[i] + c[i]
	
	sw $t4, 0($s4)		# perimeter[i] =  a[i] + b[i] + c[i]
	
	# moving all  memory addresses one word forward except area and reducing number of remaining items by one
	addi $s1, $s1, 4
	addi $s2, $s2, 4
	addi $s3, $s3, 4
	addi $s4, $s4, 4
	sub $s0, $s0, 1
	
	addi $a0, $t1 , 0	# $a0 = a[i]
	addi $a1, $t2 , 0	# $a1 = b[i]
	addi $a2, $t3 , 0	# $a2 = c[i]
	
	# multiplyin each of values  a^2  ,  b^2  , c^2
	mult $a0, $a0
	mflo $a0
	mult $a1, $a1
	mflo $a1
	mult $a2, $a2
	mflo $a2
	
	add $a0, $a0, $a1	# $a0 = a^2 + b^2
	beq $a2, $a0, Area	# cheking if c^2 = a^2 + b^2 ( taking it for granted that c>=a and c>=b ) then jump to area calculator
	
	add $s7, $0, $0
	addi $s7, $s7, -2	# if not set area[i] to -2 and store it in the memory
	sw $s7, 0($s5)
	
	addi $s5, $s5, 4	# moving area memory one step forward
	
	
	j LOOP		# jump to start because there might be more items
	
	Area:
	mult $t2, $t1	# $a0 = a * b
	mflo $a0
	addi $a1, $zero, 2
	div $a0, $a1  # $a0 = (a*b)/2
	mflo $a0
	sw $a0, 0($s5)		# storing area[i] in memory
	addi $s5, $s5, 4	# moving area memory one step forward
	j LOOP		# jump to start because there might be more items
	
	NEXT:	# if not a triangle set area and perimeter to -1 and move all one step forward
	add $t4, $0, $0
	addi $t4, $t4, -1
	sw $t4, 0($s4)
	sw $t4, 0($s5)
	addi $s1, $s1, 4
	addi $s2, $s2, 4
	addi $s3, $s3, 4
	addi $s4, $s4, 4
	addi $s5, $s5, 4
	sub $s0, $s0, 1
	j LOOP		# jump to start because there might be more items

EXIT:
