//=================================================================
// Copyright 2024 Georgia Tech.  All rights reserved.
// The materials provided by the instructor in this course are for
// the use of the students currently enrolled in the course.
// Copyrighted course materials may not be further disseminated.
// This file must not be made publicly available anywhere.
//=================================================================

#include <stdio.h>
#include <stdlib.h>

/* 
 Student Name: Shaan Patel
 Date: 9/4/2024

ECE 2035 Homework 1-2

This is the only file that should be modified for the C implementation
of Homework 1.

Do not include any additional libraries.

This program computes the Intersection over Union of two rectangles
as an integer representing a percent:
                 Area(Intersection of R1 and R2) * 100
  IoU =    -----------------------------------------------------
           Area(R1) + Area(R2) - Area(Intersection of R1 and R2)

Assumptions for this homework:	
  1. R1 and R2 do overlap (Area of intersection of R1 and R2 != 0)
  2. only R1's bottom left corner is inside R2, and only R2's top
     right corner is inside R1.	

Input: two bounding boxes, each specified as {Tx, Ty, Bx, By), where
	 (Tx, Ty) is the upper left corner point and
	 (Bx, By) is the lower right corner point.
       These are given in two global arrays R1 and R2.
Output: IoU (an integer, 1 <= IoU <= 99).

IoU should be specified as an integer (only the whole part of the division),
i.e., round down to the nearest whole number between 1 and 100 inclusive.

FOR FULL CREDIT (on all assignments in this class), BE SURE TO TRY
MULTIPLE TEST CASES and DOCUMENT YOUR CODE.
*/

//DO NOT change the following declaration (you may change the initial value).
// Bounding box: {Tx, Ty, Bx, By}
int R1[] = {64, 51, 205, 210};
int R2[] = {19, 65, 190, 326};
int IoU;

/*
For the grading scripts to run correctly, the above declarations
must be the first lines of code in this file (for this homework
assignment only).  Under penalty of grade point loss, do not change
these lines, except to replace the initial values while you are testing
your code.  

Also, do not include any additional libraries.
 */

int main() {

  /*
  Finding the area of RX (general rectangle):
  We have the top left corner and the bottom right corner, so we can just subtract the y-coordinate from the bottom right 
  from the y-coordinate from the top left to get the height of the rectangle. This is seen as RX[1] - RX[3]. We can then
  apply a similar logic to subtract the x-coordinate from the top left from the a-coordinate of the bottom right to get
  the width of the rectangle. This is seen as RX[2] - RX[0]. We can then multiply these together as the formula for the area
  of a rectangle is height * width, so the area of the general rectangle X is: (RX[1] - RX[3]) * (RX[2] - RX[0]).
  */
  int areaR1 = (R1[1] - R1[3]) * (R1[2] - R1[0]);
  int areaR2 = (R2[1] - R2[3]) * (R2[2] - R2[0]);

  /*
  Finding the height and width of the area of the intersection of R1 and R2:
  According to the homework, the rectangles will always overlap in such a way that R1 is in the top right corner
  and R2 is in the bottom right corner. Because of this, the height of the area of intersection is simply the
  y-coordinate of the top corner of R2 minus the y-coordinate of the bottom corner of R1. This can be written as
  R2[1] - R1[3]. The width of the area of intersection is then going to be the x-coordinate of the bottom corner 
  of R2 minus the x-coordinate of the top corner of R1. This can be written as R2[2] - R1[0].
  */
  int intersectionHeight = R2[1] - R1[3];
  int intersectionWidth = R2[2] - R1[0];

  /*
  Now that we have the width and height, just multiply them together to find the area of the intersection
  between R1 and R2:
  */
  int intersectionArea = intersectionWidth * intersectionHeight;

  //We now have all the variables found in the formula for the IoU, so we can now just use that formula to calculate.
  IoU = (intersectionArea * 100) / (areaR1 + areaR2 - intersectionArea);

  printf("Intersection over Union: %d%%\n", IoU);
  return 0;
}



