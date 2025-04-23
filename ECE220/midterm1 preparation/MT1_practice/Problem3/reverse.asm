;Reverse Characters
;n characters are provided to you
;in which n is a positive number stored at x4FFF
;characters stored in sequential memory location
;starting at x5000
;Use the subroutine REVERSE to flip the order

.ORIG x3000

;your program starts here








;REVERSE subroutine:
;reverse the order of n characters starting at x5000
;SWAPMEM subroutine must be called here, not in the main user program
REVERSE







;SWAPMEM subroutine:
;address one is in R0, address two in R1
;if mem[R0]=A and mem[R1]=B, then after subroutine call
;   mem[R0]=B and mem[R1]=A
SWAPMEM







NUM_ADDR    .FILL x4FFF
CHAR_ADDR   .FILL x5000

.END
