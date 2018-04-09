








nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
nop
read #0
write #128
*while_0
read #16
write 2
read 128
neq 2
eq #0
branch #wbreak_0
read #1
write 2
read 128
add 2
write #128
read #while_0
write 0
*wbreak_0
*while_1
read #1
eq #0
branch #wbreak_1
read #while_1
write 0
*wbreak_1

