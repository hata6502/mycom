 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 add 0;
 read main; write 0;
main:
 read 80;
 write 8;
i2c_wait_0:
 read *11;
 and 4;
 branch i2c_wait_0;
i2c_wait_1:
 read 0;
 write 10;
 read 1;
 write 11;
i2c_wait_a:
 read *11;
 and 4;
 eq 0;
 branch i2c_wait_a;
i2c_wait_5:
 read *11;
 and 4;
 branch i2c_wait_5;
i2c_wait_2:
 read 0;
 write 10;
 read 1;
 write 11;
i2c_wait_b:
 read *11;
 and 4;
 eq 0;
 branch i2c_wait_b;
 read 0;
 write 11;
i2c_wait_6:
 read *11;
 and 4;
 branch i2c_wait_6;
 read 0;
 write 254;
 read 2048;
 write 255;
i2c_read_loop:
 read *255;
 eq 3072;
 branch i2c_read_loop_break;
i2c_wait_4:
 read 3;
 write 11;
i2c_wait_c:
 read *11;
 and 4;
 eq 0;
 branch i2c_wait_c;
i2c_wait_3:
 read *11;
 and 4;
 branch i2c_wait_3;
 read *254;
 neq 0;
 branch cnt_l_0;
  read *9;
  write 253;
  read 1;
  write 254;
  read cnt_l_switch; write 0;
cnt_l_0:
 read *254;
 neq 1;
 branch cnt_l_1;
  read *9;
  mul 256;
  add *253;
  write 253;
  read 2;
  write 254;
  read cnt_l_switch; write 0;
cnt_l_1:
 read *254;
 neq 2;
 branch cnt_l_2;
  read *9;
  mul 65536;
  add *253;
  write 253;
  read *253;
  write *255;
  read *255;
  add 1;
  write 255;
  read 0;
  write 254;
  read cnt_l_switch; write 0;
cnt_l_2:
cnt_l_switch:
 read i2c_read_loop; write 0;
i2c_read_loop_break:
 read 2048; write 0;
