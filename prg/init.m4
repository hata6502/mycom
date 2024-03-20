define(`pc', `0')
define(`wreg', `1')
define(`sp', `2')

dnl define(`rand', `3')
dnl define(`i2c_addr', `8')
dnl define(`i2c_rdata', `9')
dnl define(`i2c_wdata', `10')
dnl define(`i2c_stat', `11')

define(`nop', `add 0')
define(`goto', `read $1; write pc')
define(`push', `read $1; write *sp')

dnl 電源投入時にCPUが安定するまで待つ
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
nop;
goto(main);
