 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 add *3;
 read main; write 0;
title_str: "BlueHood Computer  ﾒｲﾛ ｾｲｾｲ ﾌﾟﾛｸﾞﾗﾑ";
title_str2: "ﾎﾞﾀﾝｦ ｵｾ! ";
wall_str: "ﾛ";
main:
 read return_1; write *2; read 1024; write *2; read title_str; write *2; read print; write 0; return_1:;
 read return_0; write *2; read 1104; write *2; read title_str2; write *2; read print; write 0; return_0:;
press_wait:
 read *7;
 eq 0;
 branch press_wait;
 read 0;
 write 196;
 init_loop_1:
  read *196;
  gte 23;
  branch init_break_1;
  read 0;
  write 197;
  init_loop_2:
   read *197;
   gte 39;
   branch init_break_2;
   read *196;
   eq 0;
   branch init_wall;
   read *196;
   eq 22;
   branch init_wall;
   read *197;
   eq 0;
   branch init_wall;
   read *197;
   eq 38;
   branch init_wall;
   read *196;
   or *197;
   and 1;
   eq 0;
   branch init_wall;
    read init_blank; write 0;
  init_wall:
   read *196;
   mul 40;
   add *197;
   add 1104;
   write 192;
   read return_2; write *2; read *192; write *2; read wall_str; write *2; read print; write 0; return_2:;
  init_blank:
   read *197;
   add 1;
   write 197;
   read init_loop_2; write 0;
  init_break_2:
  read *196;
  add 1;
  write 196;
  read init_loop_1; write 0;
 init_break_1:
 read 2;
 write 196;
 top_loop:
  read *196;
  gte 37;
  branch top_break;
 top_loop_rerand:
  read *3;
  and 3;
  write 197;
  read return_4; write *2; read *197; write *2; read 2; write *2; read *196; write *2; read makepath; write 0; return_4:;
  read *248;
  branch top_loop_rerand;
  read *196;
  add 2;
  write 196;
  read top_loop; write 0;
 top_break:
 read 4;
 write 196;
 overall_loop:
  read *196;
  gte 21;
  branch overall_break;
  read 2;
  write 197;
  overall_loop_2:
   read *197;
   gte 37;
   branch overall_break_2;
  overall_loop_2_rerand:
   read *3;
   and 3;
   write 192;
   eq 0;
   branch overall_loop_2_rerand;
   read return_5; write *2; read *192; write *2; read *196; write *2; read *197; write *2; read makepath; write 0; return_5:;
   read *248;
   branch overall_loop_2_rerand;
   read *197;
   add 2;
   write 197;
   read overall_loop_2; write 0;
  overall_break_2:
  read *196;
  add 2;
  write 196;
  read overall_loop; write 0;
 overall_break:
halt:
 read *7;
 div 16;
 add 48;
 write 1024;
 read *7;
 and 15;
 add 48;
 write 1025;
 read halt; write 0;
makepath:
 read *2;
 write makepath_rr_0;
makepath_rr_0: add *3;
 write 250;
 read *2;
 write makepath_rr_1;
makepath_rr_1: add *3;
 write 251;
 read *2;
 write makepath_rr_2;
makepath_rr_2: add *3;
 write 252;
 read *251;
 mul 40;
 add *250;
 add 1104;
 write 249;
 read *252;
 neq 0;
 branch makepath_up;
  read *249;
  sub 40;
  write 249;
  read makepath_switch_break; write 0;
 makepath_up:
 read *252;
 neq 1;
 branch makepath_down;
  read *249;
  add 40;
  write 249;
  read makepath_switch_break; write 0;
 makepath_down:
 read *252;
 neq 2;
 branch makepath_left;
  read *249;
  sub 1;
  write 249;
  read makepath_switch_break; write 0;
 makepath_left:
 read *252;
 neq 3;
 branch makepath_right;
  read *249;
  add 1;
  write 249;
  read makepath_switch_break; write 0;
 makepath_right:
makepath_switch_break:
 read *249;
 write makepath_rr_4;
makepath_rr_4: add *3;
 write 248;
  read makepath_return_0; write *2; read *249; write *2; read wall_str; write *2; read print; write 0; makepath_return_0:;
 read *2;
 write makepath_rr_3;
makepath_rr_3: add *3;
 write 0;
sleep:
 read *2;
 write sleep_rr_0;
sleep_rr_0: add *3;
 write 253;
 sleep_loop_0:
  read *253;
  eq 0;
  branch sleep_break_0;
  read *253;
  sub 1;
  write 253;
  read sleep_loop_0; write 0;
 sleep_break_0:
 read *2;
 write sleep_rr_1;
sleep_rr_1: add *3;
 write 0;
print:
 read *2;
 write print_rr_0;
print_rr_0: add *3;
 write 254;
 read *2;
 write print_rr_1;
print_rr_1: add *3;
 write 255;
print_loop:
 read *254;
 write print_rr_2;
print_rr_2: add *3;
        eq 0;
        branch break;
                read *254;
                write print_rr_3;
        print_rr_3: add *3;
                write *255;
                read *254;
                add 1;
                write 254;
                read *255;
                add 1;
                write 255;
 read print_loop; write 0;
break:
 read *2;
 write print_rr_4;
print_rr_4: add *3;
 write 0;
