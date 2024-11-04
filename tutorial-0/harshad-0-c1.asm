Joy2:  addiu $1, $0, 42            # set $1 to 42 (input to program)
       addiu $11, $1, 0            # save a copy of x in $11
       addi  $2, $0, 0             # initialize loop counter to 0
       addiu $3, $0, 32            # set upper limit to 32
Loop:  addi  $2, $2, 1             # increment loop counter
       bne   $2, $3, Loop          # if counter is not equal to 32, loop back
Exit:  jr    $31		   # return to caller
