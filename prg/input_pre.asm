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
 read return___LINE__; write *2; read 0; write *2; read sleep; write 0; return___LINE__:;
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
 read 1024;
 write 128;
i2c_read_loop:
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
 read *9;
 write *128;
 read *128;
 add 1;
 write 128;
 read i2c_read_loop; write 0;
