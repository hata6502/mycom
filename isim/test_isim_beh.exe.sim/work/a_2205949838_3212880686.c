/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/hato/mycom/crom.vhd";
extern char *IEEE_P_3620187407;

int ieee_p_3620187407_sub_514432868_3965413181(char *, char *, char *);


static void work_a_2205949838_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    char *t8;
    char *t9;
    int t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    char *t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    unsigned char t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;

LAB0:    xsi_set_current_line(2365, ng0);

LAB3:    t1 = (t0 + 1040U);
    t2 = *((char **)t1);
    t1 = (t0 + 776U);
    t3 = *((char **)t1);
    t1 = (t0 + 3256U);
    t4 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t3, t1);
    t5 = (t4 - 0);
    t6 = (t5 * 1);
    xsi_vhdl_check_range_of_index(0, 7, 1, t4);
    t7 = (1U * t6);
    t8 = (t0 + 684U);
    t9 = *((char **)t8);
    t8 = (t0 + 3240U);
    t10 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t9, t8);
    t11 = (t10 - 0);
    t12 = (t11 * 1);
    xsi_vhdl_check_range_of_index(0, 7, 1, t10);
    t13 = (8U * t12);
    t14 = (t0 + 592U);
    t15 = *((char **)t14);
    t14 = (t0 + 3224U);
    t16 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t15, t14);
    t17 = (t16 - 0);
    t18 = (t17 * 1);
    xsi_vhdl_check_range_of_index(0, 255, 1, t16);
    t19 = (64U * t18);
    t20 = (0 + t19);
    t21 = (t20 + t13);
    t22 = (t21 + t7);
    t23 = (t2 + t22);
    t24 = *((unsigned char *)t23);
    t25 = (t0 + 1808);
    t26 = (t25 + 32U);
    t27 = *((char **)t26);
    t28 = (t27 + 32U);
    t29 = *((char **)t28);
    *((unsigned char *)t29) = t24;
    xsi_driver_first_trans_fast_port(t25);

LAB2:    t30 = (t0 + 1764);
    *((int *)t30) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


void ieee_p_2592010699_sub_3130575329_503743352();

extern void work_a_2205949838_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2205949838_3212880686_p_0};
	xsi_register_didat("work_a_2205949838_3212880686", "isim/test_isim_beh.exe.sim/work/a_2205949838_3212880686.didat");
	xsi_register_executes(pe);
	xsi_register_resolution_function(1, 2, (void *)ieee_p_2592010699_sub_3130575329_503743352, 4);
}
