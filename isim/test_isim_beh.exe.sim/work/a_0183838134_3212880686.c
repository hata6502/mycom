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

/* This file is designed for use with ISim build 0x8ef4fb42 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/hato/BH_com/BH_com.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );


static void work_a_0183838134_3212880686_p_0(char *t0)
{
    char t3[16];
    char *t1;
    unsigned char t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    xsi_set_current_line(71, ng0);
    t1 = (t0 + 844U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4220);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(72, ng0);
    t4 = (t0 + 960U);
    t5 = *((char **)t4);
    t4 = (t0 + 7616U);
    t6 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t3, t5, t4, 1);
    t7 = (t3 + 12U);
    t8 = *((unsigned int *)t7);
    t9 = (1U * t8);
    t10 = (32U != t9);
    if (t10 == 1)
        goto LAB5;

LAB6:    t11 = (t0 + 4320);
    t12 = (t11 + 32U);
    t13 = *((char **)t12);
    t14 = (t13 + 40U);
    t15 = *((char **)t14);
    memcpy(t15, t6, 32U);
    xsi_driver_first_trans_fast(t11);
    goto LAB3;

LAB5:    xsi_size_not_matching(32U, t9, 0);
    goto LAB6;

}

static void work_a_0183838134_3212880686_p_1(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    char *t7;
    int t8;
    int t9;
    int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    int t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    unsigned char t20;
    unsigned char t21;
    unsigned char t22;
    int t23;
    int t24;
    int t25;
    int t26;
    int t27;
    int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;

LAB0:    xsi_set_current_line(78, ng0);
    t1 = (t0 + 844U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4228);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(79, ng0);
    t3 = (t0 + 1144U);
    t4 = *((char **)t3);
    t5 = *((int *)t4);
    if (t5 == 0)
        goto LAB6;

LAB10:    if (t5 == 1)
        goto LAB7;

LAB11:    if (t5 == 2)
        goto LAB8;

LAB12:
LAB9:
LAB5:    goto LAB3;

LAB6:    xsi_set_current_line(81, ng0);
    t3 = (t0 + 1960U);
    t6 = *((char **)t3);
    t3 = (t0 + 1052U);
    t7 = *((char **)t3);
    t8 = *((int *)t7);
    t9 = xsi_vhdl_mod(t8, 16);
    t10 = (t9 - 0);
    t11 = (t10 * 1);
    xsi_vhdl_check_range_of_index(0, 15, 1, t9);
    t12 = (4U * t11);
    t13 = (0 + t12);
    t3 = (t6 + t13);
    t14 = *((int *)t3);
    t15 = (t0 + 4356);
    t16 = (t15 + 32U);
    t17 = *((char **)t16);
    t18 = (t17 + 40U);
    t19 = *((char **)t18);
    *((int *)t19) = t14;
    xsi_driver_first_trans_fast(t15);
    xsi_set_current_line(82, ng0);
    t1 = (t0 + 1052U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t8 = (t5 + 1);
    t1 = (t0 + 4392);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 40U);
    t15 = *((char **)t7);
    *((int *)t15) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(83, ng0);
    t1 = (t0 + 4428);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 40U);
    t7 = *((char **)t6);
    *((int *)t7) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB5;

LAB7:    xsi_set_current_line(85, ng0);
    t1 = (t0 + 4428);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 40U);
    t7 = *((char **)t6);
    *((int *)t7) = 2;
    xsi_driver_first_trans_fast(t1);
    goto LAB5;

LAB8:    xsi_set_current_line(87, ng0);
    t1 = (t0 + 1236U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t20 = (t5 >= 1024);
    if (t20 == 1)
        goto LAB17;

LAB18:    t2 = (unsigned char)0;

LAB19:    if (t2 != 0)
        goto LAB14;

LAB16:
LAB15:    xsi_set_current_line(90, ng0);
    t1 = (t0 + 4428);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 40U);
    t7 = *((char **)t6);
    *((int *)t7) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB5;

LAB13:;
LAB14:    xsi_set_current_line(88, ng0);
    t1 = (t0 + 16115);
    t22 = (8U != 8U);
    if (t22 == 1)
        goto LAB20;

LAB21:    t7 = (t0 + 1236U);
    t15 = *((char **)t7);
    t9 = *((int *)t15);
    t10 = (t9 - 1024);
    t14 = (t10 / 32);
    t23 = xsi_vhdl_mod(t14, 32);
    t24 = (t23 - 0);
    t11 = (t24 * 1);
    t12 = (256U * t11);
    t13 = (0U + t12);
    t7 = (t0 + 1236U);
    t16 = *((char **)t7);
    t25 = *((int *)t16);
    t26 = (t25 - 1024);
    t27 = xsi_vhdl_mod(t26, 32);
    t28 = (t27 - 0);
    t29 = (t28 * 1);
    t30 = (8U * t29);
    t31 = (t13 + t30);
    t7 = (t0 + 4464);
    t17 = (t7 + 32U);
    t18 = *((char **)t17);
    t19 = (t18 + 40U);
    t32 = *((char **)t19);
    memcpy(t32, t1, 8U);
    xsi_driver_first_trans_delta(t7, t31, 8U, 0LL);
    goto LAB15;

LAB17:    t1 = (t0 + 1236U);
    t4 = *((char **)t1);
    t8 = *((int *)t4);
    t21 = (t8 <= 2047);
    t2 = t21;
    goto LAB19;

LAB20:    xsi_size_not_matching(8U, 8U, 0);
    goto LAB21;

}

static void work_a_0183838134_3212880686_p_2(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    int t10;

LAB0:    xsi_set_current_line(98, ng0);
    t1 = (t0 + 844U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4236);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(99, ng0);
    t3 = (t0 + 1420U);
    t4 = *((char **)t3);
    t5 = *((int *)t4);
    if (t5 == 2032)
        goto LAB6;

LAB8:
LAB7:    xsi_set_current_line(111, ng0);
    t1 = (t0 + 1420U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t10 = (t5 + 1);
    t1 = (t0 + 4500);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 40U);
    t8 = *((char **)t7);
    *((int *)t8) = t10;
    xsi_driver_first_trans_fast(t1);

LAB5:    goto LAB3;

LAB6:    xsi_set_current_line(101, ng0);
    t3 = (t0 + 4500);
    t6 = (t3 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 40U);
    t9 = *((char **)t8);
    *((int *)t9) = 0;
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(103, ng0);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    if (t5 == 262)
        goto LAB11;

LAB13:
LAB12:    xsi_set_current_line(107, ng0);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t10 = (t5 + 1);
    t1 = (t0 + 4536);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 40U);
    t8 = *((char **)t7);
    *((int *)t8) = t10;
    xsi_driver_first_trans_fast(t1);

LAB10:    goto LAB5;

LAB9:;
LAB11:    xsi_set_current_line(105, ng0);
    t1 = (t0 + 4536);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 40U);
    t8 = *((char **)t7);
    *((int *)t8) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB14:;
}

static void work_a_0183838134_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    xsi_set_current_line(116, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t4 = (t3 < 3);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t9 = (t0 + 4572);
    t10 = (t9 + 32U);
    t11 = *((char **)t10);
    t12 = (t11 + 40U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)2;
    xsi_driver_first_trans_fast(t9);

LAB2:    t14 = (t0 + 4244);
    *((int *)t14) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 4572);
    t5 = (t1 + 32U);
    t6 = *((char **)t5);
    t7 = (t6 + 40U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0183838134_3212880686_p_4(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    xsi_set_current_line(117, ng0);
    t1 = (t0 + 1420U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t4 = (t3 < 150);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t9 = (t0 + 4608);
    t10 = (t9 + 32U);
    t11 = *((char **)t10);
    t12 = (t11 + 40U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)2;
    xsi_driver_first_trans_fast(t9);

LAB2:    t14 = (t0 + 4252);
    *((int *)t14) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 4608);
    t5 = (t1 + 32U);
    t6 = *((char **)t5);
    t7 = (t6 + 40U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0183838134_3212880686_p_5(char *t0)
{
    char t20[16];
    char t26[16];
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    int t6;
    int t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    int t12;
    int t13;
    int t14;
    int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t21;
    char *t22;
    int t23;
    unsigned int t24;
    char *t27;
    char *t28;
    int t29;
    unsigned char t30;
    char *t31;
    char *t32;
    int t33;
    int t34;
    int t35;
    int t36;
    unsigned int t37;
    char *t38;
    int t39;
    int t40;
    int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned char t46;
    char *t47;
    char *t48;
    char *t49;
    char *t50;
    char *t51;
    char *t52;

LAB0:    xsi_set_current_line(119, ng0);
    t1 = (t0 + 1328U);
    t2 = *((char **)t1);
    t1 = (t0 + 1420U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 / 4);
    t6 = (t5 / 8);
    t7 = xsi_vhdl_mod(t6, 32);
    t8 = (t7 - 0);
    t9 = (t8 * 1);
    xsi_vhdl_check_range_of_index(0, 31, 1, t7);
    t10 = (8U * t9);
    t1 = (t0 + 1512U);
    t11 = *((char **)t1);
    t12 = *((int *)t11);
    t13 = (t12 / 8);
    t14 = xsi_vhdl_mod(t13, 32);
    t15 = (t14 - 0);
    t16 = (t15 * 1);
    xsi_vhdl_check_range_of_index(0, 31, 1, t14);
    t17 = (256U * t16);
    t18 = (0 + t17);
    t19 = (t18 + t10);
    t1 = (t2 + t19);
    t21 = (t20 + 0U);
    t22 = (t21 + 0U);
    *((int *)t22) = 7;
    t22 = (t21 + 4U);
    *((int *)t22) = 0;
    t22 = (t21 + 8U);
    *((int *)t22) = -1;
    t23 = (0 - 7);
    t24 = (t23 * -1);
    t24 = (t24 + 1);
    t22 = (t21 + 12U);
    *((unsigned int *)t22) = t24;
    t22 = (t0 + 16123);
    t27 = (t26 + 0U);
    t28 = (t27 + 0U);
    *((int *)t28) = 0;
    t28 = (t27 + 4U);
    *((int *)t28) = 7;
    t28 = (t27 + 8U);
    *((int *)t28) = 1;
    t29 = (7 - 0);
    t24 = (t29 * 1);
    t24 = (t24 + 1);
    t28 = (t27 + 12U);
    *((unsigned int *)t28) = t24;
    t30 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t1, t20, t22, t26);
    if (t30 != 0)
        goto LAB3;

LAB4:
LAB2:    t52 = (t0 + 4260);
    *((int *)t52) = 1;

LAB1:    return;
LAB3:    t28 = (t0 + 2028U);
    t31 = *((char **)t28);
    t28 = (t0 + 1420U);
    t32 = *((char **)t28);
    t33 = *((int *)t32);
    t34 = (t33 / 4);
    t35 = xsi_vhdl_mod(t34, 8);
    t36 = (t35 - 7);
    t24 = (t36 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t35);
    t37 = (1U * t24);
    t28 = (t0 + 1512U);
    t38 = *((char **)t28);
    t39 = *((int *)t38);
    t40 = xsi_vhdl_mod(t39, 8);
    t41 = (t40 - 0);
    t42 = (t41 * 1);
    xsi_vhdl_check_range_of_index(0, 7, 1, t40);
    t43 = (8U * t42);
    t44 = (0 + t43);
    t45 = (t44 + t37);
    t28 = (t31 + t45);
    t46 = *((unsigned char *)t28);
    t47 = (t0 + 4644);
    t48 = (t47 + 32U);
    t49 = *((char **)t48);
    t50 = (t49 + 40U);
    t51 = *((char **)t50);
    *((unsigned char *)t51) = t46;
    xsi_driver_first_trans_fast(t47);
    goto LAB2;

}

static void work_a_0183838134_3212880686_p_6(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    int t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    xsi_set_current_line(121, ng0);
    t3 = (t0 + 1604U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)2);
    if (t6 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t3 = (t0 + 1604U);
    t11 = *((char **)t3);
    t12 = *((unsigned char *)t11);
    t13 = (t12 == (unsigned char)3);
    if (t13 == 1)
        goto LAB11;

LAB12:    t10 = (unsigned char)0;

LAB13:    t1 = t10;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB14:    t21 = (t0 + 4680);
    t22 = (t21 + 32U);
    t23 = *((char **)t22);
    t24 = (t23 + 40U);
    t25 = *((char **)t24);
    *((unsigned char *)t25) = (unsigned char)3;
    xsi_driver_first_trans_delta(t21, 15U, 1, 0LL);

LAB2:    t26 = (t0 + 4268);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t3 = (t0 + 4680);
    t17 = (t3 + 32U);
    t18 = *((char **)t17);
    t19 = (t18 + 40U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = (unsigned char)2;
    xsi_driver_first_trans_delta(t3, 15U, 1, 0LL);
    goto LAB2;

LAB5:    t1 = (unsigned char)1;
    goto LAB7;

LAB8:    t3 = (t0 + 1696U);
    t7 = *((char **)t3);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)3);
    t2 = t9;
    goto LAB10;

LAB11:    t3 = (t0 + 1420U);
    t14 = *((char **)t3);
    t15 = *((int *)t14);
    t16 = (t15 >= 150);
    t10 = t16;
    goto LAB13;

LAB15:    goto LAB2;

}

static void work_a_0183838134_3212880686_p_7(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;

LAB0:    xsi_set_current_line(122, ng0);
    t2 = (t0 + 1604U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB8:    t15 = (t0 + 4716);
    t16 = (t15 + 32U);
    t17 = *((char **)t16);
    t18 = (t17 + 40U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)2;
    xsi_driver_first_trans_delta(t15, 14U, 1, 0LL);

LAB2:    t20 = (t0 + 4276);
    *((int *)t20) = 1;

LAB1:    return;
LAB3:    t2 = (t0 + 1788U);
    t9 = *((char **)t2);
    t10 = *((unsigned char *)t9);
    t2 = (t0 + 4716);
    t11 = (t2 + 32U);
    t12 = *((char **)t11);
    t13 = (t12 + 40U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = t10;
    xsi_driver_first_trans_delta(t2, 14U, 1, 0LL);
    goto LAB2;

LAB5:    t2 = (t0 + 1696U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)2);
    t1 = t8;
    goto LAB7;

LAB9:    goto LAB2;

}

static void work_a_0183838134_3212880686_p_8(char *t0)
{
    char *t1;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(123, ng0);

LAB3:    t1 = (t0 + 16131);
    t3 = (14U != 14U);
    if (t3 == 1)
        goto LAB5;

LAB6:    t4 = (t0 + 4752);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    t7 = (t6 + 40U);
    t8 = *((char **)t7);
    memcpy(t8, t1, 14U);
    xsi_driver_first_trans_delta(t4, 0U, 14U, 0LL);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(14U, 14U, 0);
    goto LAB6;

}

static void work_a_0183838134_3212880686_p_9(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(124, ng0);

LAB3:    t1 = (t0 + 16145);
    t3 = (t0 + 4788);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 16U);
    xsi_driver_first_trans_fast_port(t3);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0183838134_3212880686_p_10(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(125, ng0);

LAB3:    t1 = (t0 + 16161);
    t3 = (t0 + 4824);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 40U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 16U);
    xsi_driver_first_trans_fast_port(t3);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}


void ieee_p_2592010699_sub_3130575329_503743352();

void ieee_p_2592010699_sub_3130575329_503743352();

extern void work_a_0183838134_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0183838134_3212880686_p_0,(void *)work_a_0183838134_3212880686_p_1,(void *)work_a_0183838134_3212880686_p_2,(void *)work_a_0183838134_3212880686_p_3,(void *)work_a_0183838134_3212880686_p_4,(void *)work_a_0183838134_3212880686_p_5,(void *)work_a_0183838134_3212880686_p_6,(void *)work_a_0183838134_3212880686_p_7,(void *)work_a_0183838134_3212880686_p_8,(void *)work_a_0183838134_3212880686_p_9,(void *)work_a_0183838134_3212880686_p_10};
	xsi_register_didat("work_a_0183838134_3212880686", "isim/test_isim_beh.exe.sim/work/a_0183838134_3212880686.didat");
	xsi_register_executes(pe);
	xsi_register_resolution_function(3, 2, (void *)ieee_p_2592010699_sub_3130575329_503743352, 8);
	xsi_register_resolution_function(6, 2, (void *)ieee_p_2592010699_sub_3130575329_503743352, 8);
}
