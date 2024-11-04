#=================================================================
# Copyright 2024 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================

# HW1-3
# Student Name: Shaan Patel
# Date: 9/4/2024
#
# This program computes the Intersection over Union of two rectangles
# as an integer representing a percent:
#                 Area(Intersection of R1 and R2) * 100
#  IoU =    -----------------------------------------------------
#           Area(R1) + Area(R2) - Area(Intersection of R1 and R2)
#
# Assumptions for this homework:	
#  1. R1 and R2 do overlap (Area of intersection of R1 and R2 != 0)
#  2. only R1's bottom left corner is inside R2, and only R2's top
#     right corner is inside R1.	
#
# Input: two bounding boxes, each specified as (Tx, Ty, Bx, By), where
#	 (Tx, Ty) is the upper left corner point and
#	 (Bx, By) is the lower right corner point.
# Output: IoU (an integer, 1 <= IoU <= 99).
#
# IoU should be specified as an integer (only the whole part of the division),
# i.e., round down to the nearest whole number between 1 and 99 inclusive.
#
# Also, for HW1 (only), do not write values to registers $0, $29, $30, or $31
# and do NOT use helper functions or function calls (JAL).
#
# FOR FULL CREDIT (on all assignments in this class), BE SURE TO TRY
# MULTIPLE TEST CASES and DOCUMENT YOUR CODE.

.data
# DO NOT change the following three labels (you may change the initial values):
#               Tx, Ty,  Bx, By	
R1:	.word	64, 51, 205, 210
R2:	.word	19, 65, 190, 326
IoU:	.alloc  1
	
.text

	# Loading R1 and R2 into registers $9 and $10
	addi $9, $0, R1
	addi $10, $0, R2
	# Load R1 values into registers
    lw $2, 0($9)   # Load R1[Tx] into $2
    lw $3, 4($9)   # Load R1[Ty] into $3
    lw $4, 8($9)   # Load R1[Bx] into $4
    lw $5, 12($9)  # Load R1[By] into $5

    # Load R2 values into registers
    lw $6, 0($10)   # Load R2[Tx] into $6
    lw $7, 4($10)   # Load R2[Ty] into $7
    lw $8, 8($10)   # Load R2[Bx] into $8
    lw $9, 12($10)  # Load R2[By] into $9

	#Finding the area of RX (general rectangle):
  	#We have the top left corner and the bottom right corner, so we can just subtract the y-coordinate from the bottom right 
    #from the y-coordinate from the top left to get the height of the rectangle. This is seen as RX[Ty] - RX[By]. We can then
    #apply a similar logic to subtract the x-coordinate from the top left from the a-coordinate of the bottom right to get
  	#the width of the rectangle. This is seen as RX[Bx] - RX[Tx]. We can then multiply these together as the formula for the area
  	#of a rectangle is height * width, so the area of the general rectangle X is: (RX[Ty] - RX[By]) * (RX[Bx] - RX[Tx]).
	
	#R1 area calculation
	sub $10, $3, $5 #R1 height, R1[Ty] - R1[By]
	sub $11, $4, $2 #R1 width, R1[Bx] - R1[Tx]
	mult $10, $11 #Multiply the width and height of R1
	mflo $12 #Store the area of R1 into $12

	#R2 area calculation
	sub $13, $7, $9 #R2 height, R2[Ty] - R2[By]
	sub $14, $8, $6 #R2 width, R2[Bx] - R2[Tx]
	mult $13, $14 #Multiply the width and height of R2
	mflo $15 #Store the area of R2 into $15

	#Finding the height and width of the area of the intersection of R1 and R2:
  	#According to the homework, the rectangles will always overlap in such a way that R1 is in the top right corner
  	#and R2 is in the bottom right corner. Because of this, the height of the area of intersection is simply the
  	#y-coordinate of the top corner of R2 minus the y-coordinate of the bottom corner of R1. This can be written as
  	#R2[Ty] - R1[By]. The width of the area of intersection is then going to be the x-coordinate of the bottom corner 
  	#of R2 minus the x-coordinate of the top corner of R1. This can be written as R2[Bx] - R1[Tx].

	#Intersection area calculation
	sub $16, $7, $5 #Intersection area height, R2[Ty] - R1[By]
	sub $17, $8, $2 #Intersection area width, R2[Bx] - R1[Tx]
	mult $16, $17 #Multiply the width and height of the intersection area
	mflo $18 #Store the intersection area into $18
	addiu $19, $18, 0 #Make a copy of the intersection area in $19

	#We now have all the variables found in the formula for the IoU, so we can now just use that formula to calculate.
	lw $20, 100
	mult $19, $20 #Numerator in the formula for the IoU, multiply the intersection area by 100.
	mflo $21 #Store the numerator in $21
	add $22, $12, $15 #Store the sum of the R1 and R2 areas in $22
	sub $23, $22, $18 #Subtract the area of intersection from the total area and store in $23 (full denominator now).
	div $21, $23 #Divide the numerator stored in $21 by the denominator for the IoU stored in $23
	mflo $31 #Store the IoU in the assigned register slot of $31.

End:	jr $31	     			# return to OS

