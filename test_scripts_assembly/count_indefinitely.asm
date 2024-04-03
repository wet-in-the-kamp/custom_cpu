LDI 0x0001           # Load 1 into register A
ADD 0x1000	     # Load address 0x1000 into B (which has 0x0001) and add to A
OUT		     # Output result 
JPN 0x0000	     # If we wrap around then start over, else NOP
JMP 0x0001	     # If we make it to this expression then continue adding (address 1)

ADDR
0x1000 0x0001
