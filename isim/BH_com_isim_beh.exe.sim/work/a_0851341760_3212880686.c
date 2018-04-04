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
static const char *ng0 = "Function conv_integer ended without a return statement";
static const char *ng1 = "/home/hato/mycom/BH_com.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;
extern char *IEEE_P_3499444699;

char *ieee_p_2592010699_sub_1697423399_503743352(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_1735675855_503743352(char *, char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
char *ieee_p_2592010699_sub_795620321_503743352(char *, char *, char *, char *, char *, char *);
char *ieee_p_3499444699_sub_2213602152_3536714472(char *, char *, int , int );
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );
int ieee_p_3620187407_sub_514432868_3965413181(char *, char *, char *);


int work_a_0851341760_3212880686_sub_307966218_3057020925(char *t1, unsigned char t2)
{
    char t4[8];
    int t0;
    char *t5;

LAB0:    t5 = (t4 + 4U);
    *((unsigned char *)t5) = t2;
    if (t2 != 0)
        goto LAB2;

LAB4:    t0 = 0;

LAB1:    return t0;
LAB2:    t0 = 1;
    goto LAB1;

LAB3:    xsi_error(ng0);
    t0 = 0;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:    goto LAB3;

}

int work_a_0851341760_3212880686_sub_401119202_3057020925(char *t1, int t2)
{
    char t4[8];
    int t0;
    char *t5;
    int t6;

LAB0:    t5 = (t4 + 4U);
    *((int *)t5) = t2;
    t6 = (t2 * 16777216);
    t0 = t6;

LAB1:    return t0;
LAB2:;
}

int work_a_0851341760_3212880686_sub_769852499_3057020925(char *t1, int t2, int t3)
{
    char t5[16];
    int t0;
    char *t6;
    char *t7;
    int t8;
    int t9;

LAB0:    t6 = (t5 + 4U);
    *((int *)t6) = t2;
    t7 = (t5 + 8U);
    *((int *)t7) = t3;
    t8 = (t2 * 16777216);
    t9 = (t8 + t3);
    t0 = t9;

LAB1:    return t0;
LAB2:;
}

static void work_a_0851341760_3212880686_p_0(char *t0)
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

LAB0:    xsi_set_current_line(168, ng1);
    t1 = (t0 + 844U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 8788);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(169, ng1);
    t4 = (t0 + 960U);
    t5 = *((char **)t4);
    t4 = (t0 + 14648U);
    t6 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t3, t5, t4, 1);
    t7 = (t3 + 12U);
    t8 = *((unsigned int *)t7);
    t9 = (1U * t8);
    t10 = (32U != t9);
    if (t10 == 1)
        goto LAB5;

LAB6:    t11 = (t0 + 8952);
    t12 = (t11 + 32U);
    t13 = *((char **)t12);
    t14 = (t13 + 32U);
    t15 = *((char **)t14);
    memcpy(t15, t6, 32U);
    xsi_driver_first_trans_fast(t11);
    goto LAB3;

LAB5:    xsi_size_not_matching(32U, t9, 0);
    goto LAB6;

}

static void work_a_0851341760_3212880686_p_1(char *t0)
{
    char t43[16];
    char t44[16];
    char t45[16];
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    int t7;
    int t8;
    char *t9;
    char *t10;
    int t11;
    int t12;
    char *t13;
    int t14;
    char *t15;
    int t16;
    char *t17;
    int t18;
    char *t19;
    int t20;
    char *t21;
    int t22;
    char *t23;
    int t24;
    char *t25;
    int t26;
    char *t27;
    int t28;
    char *t29;
    int t30;
    char *t31;
    int t32;
    char *t33;
    int t34;
    char *t35;
    int t36;
    char *t37;
    int t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    unsigned char t46;
    unsigned char t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned char t51;

LAB0:    xsi_set_current_line(178, ng1);
    t1 = (t0 + 844U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 8796);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(179, ng1);
    t3 = (t0 + 1144U);
    t4 = *((char **)t3);
    t5 = *((int *)t4);
    if (t5 == 0)
        goto LAB6;

LAB11:    if (t5 == 1)
        goto LAB7;

LAB12:    if (t5 == 2)
        goto LAB8;

LAB13:    if (t5 == 3)
        goto LAB9;

LAB14:
LAB10:
LAB5:    goto LAB3;

LAB6:    xsi_set_current_line(181, ng1);
    t3 = (t0 + 1604U);
    t6 = *((char **)t3);
    t7 = *((int *)t6);
    t8 = (t7 / 16777216);
    t3 = (t0 + 5276U);
    t9 = *((char **)t3);
    t3 = (t9 + 0);
    *((int *)t3) = t8;
    xsi_set_current_line(182, ng1);
    t1 = (t0 + 1604U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t7 = xsi_vhdl_mod(t5, 16777216);
    t1 = (t0 + 5344U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t7;
    xsi_set_current_line(184, ng1);
    t1 = (t0 + 5276U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 8988);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t9 = (t6 + 32U);
    t10 = *((char **)t9);
    *((int *)t10) = t5;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(185, ng1);
    t1 = (t0 + 1052U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t7 = (t5 + 1);
    t1 = (t0 + 9024);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t9 = (t6 + 32U);
    t10 = *((char **)t9);
    *((int *)t10) = t7;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(187, ng1);
    t1 = (t0 + 5276U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 4188U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    if (t5 == t7)
        goto LAB17;

LAB20:    t1 = (t0 + 4256U);
    t6 = *((char **)t1);
    t8 = *((int *)t6);
    if (t5 == t8)
        goto LAB17;

LAB21:    t1 = (t0 + 4324U);
    t9 = *((char **)t1);
    t11 = *((int *)t9);
    if (t5 == t11)
        goto LAB17;

LAB22:    t1 = (t0 + 4392U);
    t10 = *((char **)t1);
    t12 = *((int *)t10);
    if (t5 == t12)
        goto LAB17;

LAB23:    t1 = (t0 + 4460U);
    t13 = *((char **)t1);
    t14 = *((int *)t13);
    if (t5 == t14)
        goto LAB17;

LAB24:    t1 = (t0 + 4528U);
    t15 = *((char **)t1);
    t16 = *((int *)t15);
    if (t5 == t16)
        goto LAB17;

LAB25:    t1 = (t0 + 4596U);
    t17 = *((char **)t1);
    t18 = *((int *)t17);
    if (t5 == t18)
        goto LAB17;

LAB26:    t1 = (t0 + 4664U);
    t19 = *((char **)t1);
    t20 = *((int *)t19);
    if (t5 == t20)
        goto LAB17;

LAB27:    t1 = (t0 + 4800U);
    t21 = *((char **)t1);
    t22 = *((int *)t21);
    if (t5 == t22)
        goto LAB17;

LAB28:    t1 = (t0 + 4868U);
    t23 = *((char **)t1);
    t24 = *((int *)t23);
    if (t5 == t24)
        goto LAB17;

LAB29:    t1 = (t0 + 4936U);
    t25 = *((char **)t1);
    t26 = *((int *)t25);
    if (t5 == t26)
        goto LAB17;

LAB30:    t1 = (t0 + 5004U);
    t27 = *((char **)t1);
    t28 = *((int *)t27);
    if (t5 == t28)
        goto LAB17;

LAB31:    t1 = (t0 + 5072U);
    t29 = *((char **)t1);
    t30 = *((int *)t29);
    if (t5 == t30)
        goto LAB17;

LAB32:    t1 = (t0 + 5140U);
    t31 = *((char **)t1);
    t32 = *((int *)t31);
    if (t5 == t32)
        goto LAB17;

LAB33:    t1 = (t0 + 4120U);
    t33 = *((char **)t1);
    t34 = *((int *)t33);
    if (t5 == t34)
        goto LAB18;

LAB34:    t1 = (t0 + 4732U);
    t35 = *((char **)t1);
    t36 = *((int *)t35);
    if (t5 == t36)
        goto LAB18;

LAB35:
LAB19:
LAB16:    xsi_set_current_line(195, ng1);
    t1 = (t0 + 9096);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB5;

LAB7:    xsi_set_current_line(197, ng1);
    t1 = (t0 + 1604U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 9132);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t9 = (t6 + 32U);
    t10 = *((char **)t9);
    *((int *)t10) = t5;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(198, ng1);
    t1 = (t0 + 9096);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 2;
    xsi_driver_first_trans_fast(t1);
    goto LAB5;

LAB8:    xsi_set_current_line(200, ng1);
    t1 = (t0 + 1788U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t7 = xsi_vhdl_mod(t5, 16777216);
    t1 = (t0 + 5344U);
    t4 = *((char **)t1);
    t1 = (t4 + 0);
    *((int *)t1) = t7;
    xsi_set_current_line(202, ng1);
    t1 = (t0 + 1236U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 4188U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    if (t5 == t7)
        goto LAB38;

LAB55:    t1 = (t0 + 4120U);
    t6 = *((char **)t1);
    t8 = *((int *)t6);
    if (t5 == t8)
        goto LAB39;

LAB56:    t1 = (t0 + 4256U);
    t9 = *((char **)t1);
    t11 = *((int *)t9);
    if (t5 == t11)
        goto LAB40;

LAB57:    t1 = (t0 + 4324U);
    t10 = *((char **)t1);
    t12 = *((int *)t10);
    if (t5 == t12)
        goto LAB41;

LAB58:    t1 = (t0 + 4392U);
    t13 = *((char **)t1);
    t14 = *((int *)t13);
    if (t5 == t14)
        goto LAB42;

LAB59:    t1 = (t0 + 4460U);
    t15 = *((char **)t1);
    t16 = *((int *)t15);
    if (t5 == t16)
        goto LAB43;

LAB60:    t1 = (t0 + 4528U);
    t17 = *((char **)t1);
    t18 = *((int *)t17);
    if (t5 == t18)
        goto LAB44;

LAB61:    t1 = (t0 + 4596U);
    t19 = *((char **)t1);
    t20 = *((int *)t19);
    if (t5 == t20)
        goto LAB45;

LAB62:    t1 = (t0 + 4664U);
    t21 = *((char **)t1);
    t22 = *((int *)t21);
    if (t5 == t22)
        goto LAB46;

LAB63:    t1 = (t0 + 4732U);
    t23 = *((char **)t1);
    t24 = *((int *)t23);
    if (t5 == t24)
        goto LAB47;

LAB64:    t1 = (t0 + 4800U);
    t25 = *((char **)t1);
    t26 = *((int *)t25);
    if (t5 == t26)
        goto LAB48;

LAB65:    t1 = (t0 + 4868U);
    t27 = *((char **)t1);
    t28 = *((int *)t27);
    if (t5 == t28)
        goto LAB49;

LAB66:    t1 = (t0 + 4936U);
    t29 = *((char **)t1);
    t30 = *((int *)t29);
    if (t5 == t30)
        goto LAB50;

LAB67:    t1 = (t0 + 5004U);
    t31 = *((char **)t1);
    t32 = *((int *)t31);
    if (t5 == t32)
        goto LAB51;

LAB68:    t1 = (t0 + 5072U);
    t33 = *((char **)t1);
    t34 = *((int *)t33);
    if (t5 == t34)
        goto LAB52;

LAB69:    t1 = (t0 + 5140U);
    t35 = *((char **)t1);
    t36 = *((int *)t35);
    if (t5 == t36)
        goto LAB53;

LAB70:
LAB54:
LAB37:    xsi_set_current_line(260, ng1);
    t1 = (t0 + 9096);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 3;
    xsi_driver_first_trans_fast(t1);
    goto LAB5;

LAB9:    xsi_set_current_line(264, ng1);
    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t2 = (t5 == 0);
    if (t2 != 0)
        goto LAB75;

LAB77:    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t2 = (t5 == 1);
    if (t2 != 0)
        goto LAB78;

LAB79:    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t46 = (t5 >= 128);
    if (t46 == 1)
        goto LAB82;

LAB83:    t2 = (unsigned char)0;

LAB84:    if (t2 != 0)
        goto LAB80;

LAB81:    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t46 = (t5 >= 256);
    if (t46 == 1)
        goto LAB87;

LAB88:    t2 = (unsigned char)0;

LAB89:    if (t2 != 0)
        goto LAB85;

LAB86:    t1 = (t0 + 1512U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t46 = (t5 >= 1024);
    if (t46 == 1)
        goto LAB92;

LAB93:    t2 = (unsigned char)0;

LAB94:    if (t2 != 0)
        goto LAB90;

LAB91:
LAB76:    xsi_set_current_line(279, ng1);
    t1 = (t0 + 9096);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB5;

LAB15:;
LAB17:    xsi_set_current_line(189, ng1);
    t1 = (t0 + 5344U);
    t37 = *((char **)t1);
    t38 = *((int *)t37);
    t1 = (t0 + 9060);
    t39 = (t1 + 32U);
    t40 = *((char **)t39);
    t41 = (t40 + 32U);
    t42 = *((char **)t41);
    *((int *)t42) = t38;
    xsi_driver_first_trans_fast(t1);
    goto LAB16;

LAB18:    xsi_set_current_line(191, ng1);
    t1 = (t0 + 1052U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 9060);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t9 = (t6 + 32U);
    t10 = *((char **)t9);
    *((int *)t10) = t5;
    xsi_driver_first_trans_fast(t1);
    goto LAB16;

LAB36:;
LAB38:    xsi_set_current_line(204, ng1);
    t1 = (t0 + 1788U);
    t37 = *((char **)t1);
    t38 = *((int *)t37);
    t1 = (t0 + 9168);
    t39 = (t1 + 32U);
    t40 = *((char **)t39);
    t41 = (t40 + 32U);
    t42 = *((char **)t41);
    *((int *)t42) = t38;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(205, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB39:    xsi_set_current_line(207, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 9168);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t9 = (t6 + 32U);
    t10 = *((char **)t9);
    *((int *)t10) = t5;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(208, ng1);
    t1 = (t0 + 5344U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 9204);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t9 = (t6 + 32U);
    t10 = *((char **)t9);
    *((int *)t10) = t5;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB40:    xsi_set_current_line(211, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 1788U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t8 = (t5 + t7);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(212, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB41:    xsi_set_current_line(214, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 1788U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t8 = (t5 - t7);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(215, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB42:    xsi_set_current_line(217, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 1788U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t8 = (t5 * t7);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(218, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB43:    xsi_set_current_line(221, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB44:    xsi_set_current_line(223, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t44, t5, 32);
    t4 = (t0 + 1788U);
    t6 = *((char **)t4);
    t7 = *((int *)t6);
    t4 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t45, t7, 32);
    t9 = ieee_p_2592010699_sub_795620321_503743352(IEEE_P_2592010699, t43, t1, t44, t4, t45);
    t8 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t9, t43);
    t10 = (t0 + 9168);
    t13 = (t10 + 32U);
    t15 = *((char **)t13);
    t17 = (t15 + 32U);
    t19 = *((char **)t17);
    *((int *)t19) = t8;
    xsi_driver_first_trans_fast(t10);
    xsi_set_current_line(224, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB45:    xsi_set_current_line(226, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t44, t5, 32);
    t4 = (t0 + 1788U);
    t6 = *((char **)t4);
    t7 = *((int *)t6);
    t4 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t45, t7, 32);
    t9 = ieee_p_2592010699_sub_1735675855_503743352(IEEE_P_2592010699, t43, t1, t44, t4, t45);
    t8 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t9, t43);
    t10 = (t0 + 9168);
    t13 = (t10 + 32U);
    t15 = *((char **)t13);
    t17 = (t15 + 32U);
    t19 = *((char **)t17);
    *((int *)t19) = t8;
    xsi_driver_first_trans_fast(t10);
    xsi_set_current_line(227, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB46:    xsi_set_current_line(229, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t44, t5, 32);
    t4 = (t0 + 1788U);
    t6 = *((char **)t4);
    t7 = *((int *)t6);
    t4 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t45, t7, 32);
    t9 = ieee_p_2592010699_sub_1697423399_503743352(IEEE_P_2592010699, t43, t1, t44, t4, t45);
    t8 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t9, t43);
    t10 = (t0 + 9168);
    t13 = (t10 + 32U);
    t15 = *((char **)t13);
    t17 = (t15 + 32U);
    t19 = *((char **)t17);
    *((int *)t19) = t8;
    xsi_driver_first_trans_fast(t10);
    xsi_set_current_line(230, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB47:    xsi_set_current_line(233, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t2 = (t5 != 0);
    if (t2 != 0)
        goto LAB72;

LAB74:    xsi_set_current_line(236, ng1);
    t1 = (t0 + 1052U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 9168);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t9 = (t6 + 32U);
    t10 = *((char **)t9);
    *((int *)t10) = t5;
    xsi_driver_first_trans_fast(t1);

LAB73:    xsi_set_current_line(238, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB48:    xsi_set_current_line(240, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 1788U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t2 = (t5 == t7);
    t8 = work_a_0851341760_3212880686_sub_307966218_3057020925(t0, t2);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(241, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB49:    xsi_set_current_line(243, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 1788U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t2 = (t5 != t7);
    t8 = work_a_0851341760_3212880686_sub_307966218_3057020925(t0, t2);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(244, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB50:    xsi_set_current_line(246, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 1788U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t2 = (t5 < t7);
    t8 = work_a_0851341760_3212880686_sub_307966218_3057020925(t0, t2);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(247, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB51:    xsi_set_current_line(249, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 1788U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t2 = (t5 <= t7);
    t8 = work_a_0851341760_3212880686_sub_307966218_3057020925(t0, t2);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(250, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB52:    xsi_set_current_line(252, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 1788U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t2 = (t5 > t7);
    t8 = work_a_0851341760_3212880686_sub_307966218_3057020925(t0, t2);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(253, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB53:    xsi_set_current_line(255, ng1);
    t1 = (t0 + 1880U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = (t0 + 1788U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t2 = (t5 >= t7);
    t8 = work_a_0851341760_3212880686_sub_307966218_3057020925(t0, t2);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t8;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(256, ng1);
    t1 = (t0 + 9204);
    t3 = (t1 + 32U);
    t4 = *((char **)t3);
    t6 = (t4 + 32U);
    t9 = *((char **)t6);
    *((int *)t9) = 1;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB71:;
LAB72:    xsi_set_current_line(234, ng1);
    t1 = (t0 + 5344U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t1 = (t0 + 9168);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t7;
    xsi_driver_first_trans_fast(t1);
    goto LAB73;

LAB75:    xsi_set_current_line(265, ng1);
    t1 = (t0 + 1696U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t1 = (t0 + 9024);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t7;
    xsi_driver_first_trans_fast(t1);
    goto LAB76;

LAB78:    xsi_set_current_line(267, ng1);
    t1 = (t0 + 1696U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t1 = (t0 + 9240);
    t6 = (t1 + 32U);
    t9 = *((char **)t6);
    t10 = (t9 + 32U);
    t13 = *((char **)t10);
    *((int *)t13) = t7;
    xsi_driver_first_trans_fast(t1);
    goto LAB76;

LAB80:    xsi_set_current_line(269, ng1);
    t1 = (t0 + 1696U);
    t6 = *((char **)t1);
    t8 = *((int *)t6);
    t1 = (t0 + 1512U);
    t9 = *((char **)t1);
    t11 = *((int *)t9);
    t12 = (t11 - 128);
    t14 = xsi_vhdl_mod(t12, 128);
    t16 = (t14 - 0);
    t48 = (t16 * 1);
    t49 = (1 * t48);
    t50 = (0U + t49);
    t1 = (t0 + 9276);
    t10 = (t1 + 32U);
    t13 = *((char **)t10);
    t15 = (t13 + 32U);
    t17 = *((char **)t15);
    *((int *)t17) = t8;
    xsi_driver_first_trans_delta(t1, t50, 1, 0LL);
    goto LAB76;

LAB82:    t1 = (t0 + 1512U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t47 = (t7 <= 255);
    t2 = t47;
    goto LAB84;

LAB85:    xsi_set_current_line(271, ng1);
    t1 = (t0 + 1696U);
    t6 = *((char **)t1);
    t8 = *((int *)t6);
    t1 = (t0 + 1512U);
    t9 = *((char **)t1);
    t11 = *((int *)t9);
    t12 = (t11 - 256);
    t14 = xsi_vhdl_mod(t12, 256);
    t16 = (t14 - 0);
    t48 = (t16 * 1);
    t49 = (1 * t48);
    t50 = (0U + t49);
    t1 = (t0 + 9312);
    t10 = (t1 + 32U);
    t13 = *((char **)t10);
    t15 = (t13 + 32U);
    t17 = *((char **)t15);
    *((int *)t17) = t8;
    xsi_driver_first_trans_delta(t1, t50, 1, 0LL);
    goto LAB76;

LAB87:    t1 = (t0 + 1512U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t47 = (t7 <= 511);
    t2 = t47;
    goto LAB89;

LAB90:    xsi_set_current_line(273, ng1);
    t1 = (t0 + 1512U);
    t6 = *((char **)t1);
    t8 = *((int *)t6);
    t11 = (t8 - 1024);
    t12 = (t11 / 32);
    t14 = xsi_vhdl_mod(t12, 32);
    t16 = (t14 * 32);
    t1 = (t0 + 1512U);
    t9 = *((char **)t1);
    t18 = *((int *)t9);
    t20 = (t18 - 1024);
    t22 = xsi_vhdl_mod(t20, 32);
    t24 = (t16 + t22);
    t1 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t43, t24, 10);
    t10 = (t43 + 12U);
    t48 = *((unsigned int *)t10);
    t48 = (t48 * 1U);
    t51 = (10U != t48);
    if (t51 == 1)
        goto LAB95;

LAB96:    t13 = (t0 + 9348);
    t15 = (t13 + 32U);
    t17 = *((char **)t15);
    t19 = (t17 + 32U);
    t21 = *((char **)t19);
    memcpy(t21, t1, 10U);
    xsi_driver_first_trans_fast(t13);
    xsi_set_current_line(274, ng1);
    t1 = (t0 + 1696U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t1 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t43, t5, 8);
    t4 = (t43 + 12U);
    t48 = *((unsigned int *)t4);
    t48 = (t48 * 1U);
    t2 = (8U != t48);
    if (t2 == 1)
        goto LAB97;

LAB98:    t6 = (t0 + 9384);
    t9 = (t6 + 32U);
    t10 = *((char **)t9);
    t13 = (t10 + 32U);
    t15 = *((char **)t13);
    memcpy(t15, t1, 8U);
    xsi_driver_first_trans_fast(t6);
    goto LAB76;

LAB92:    t1 = (t0 + 1512U);
    t4 = *((char **)t1);
    t7 = *((int *)t4);
    t47 = (t7 <= 2047);
    t2 = t47;
    goto LAB94;

LAB95:    xsi_size_not_matching(10U, t48, 0);
    goto LAB96;

LAB97:    xsi_size_not_matching(8U, t48, 0);
    goto LAB98;

}

static void work_a_0851341760_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned char t4;
    char *t5;
    int t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    int t13;
    unsigned char t14;
    char *t15;
    int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;

LAB0:    xsi_set_current_line(285, ng1);
    t1 = (t0 + 1144U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t4 = (t3 == 0);
    if (t4 != 0)
        goto LAB3;

LAB4:    t11 = (t0 + 1144U);
    t12 = *((char **)t11);
    t13 = *((int *)t12);
    t14 = (t13 == 1);
    if (t14 != 0)
        goto LAB5;

LAB6:
LAB2:    t21 = (t0 + 8804);
    *((int *)t21) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 1052U);
    t5 = *((char **)t1);
    t6 = *((int *)t5);
    t1 = (t0 + 9420);
    t7 = (t1 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    *((int *)t10) = t6;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t11 = (t0 + 1420U);
    t15 = *((char **)t11);
    t16 = *((int *)t15);
    t11 = (t0 + 9420);
    t17 = (t11 + 32U);
    t18 = *((char **)t17);
    t19 = (t18 + 32U);
    t20 = *((char **)t19);
    *((int *)t20) = t16;
    xsi_driver_first_trans_fast(t11);
    goto LAB2;

}

static void work_a_0851341760_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned char t4;
    char *t5;
    int t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    int t13;
    unsigned char t14;
    char *t15;
    int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned char t21;
    char *t22;
    char *t23;
    int t24;
    unsigned char t25;
    char *t26;
    int t27;
    unsigned char t28;
    char *t29;
    char *t30;
    int t31;
    int t32;
    int t33;
    int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    int t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    unsigned char t44;
    char *t45;
    char *t46;
    int t47;
    char *t48;
    int t49;
    unsigned char t50;
    char *t51;
    int t52;
    char *t53;
    int t54;
    char *t55;
    int t56;
    int t57;
    unsigned char t58;
    char *t59;
    char *t60;
    int t61;
    char *t62;
    int t63;
    int t64;
    char *t65;
    int t66;
    int t67;
    int t68;
    unsigned int t69;
    unsigned int t70;
    unsigned int t71;
    int t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;
    char *t77;
    char *t78;

LAB0:    xsi_set_current_line(288, ng1);
    t1 = (t0 + 1328U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t4 = (t3 == 0);
    if (t4 != 0)
        goto LAB3;

LAB4:    t11 = (t0 + 1328U);
    t12 = *((char **)t11);
    t13 = *((int *)t12);
    t14 = (t13 == 1);
    if (t14 != 0)
        goto LAB5;

LAB6:    t22 = (t0 + 1328U);
    t23 = *((char **)t22);
    t24 = *((int *)t23);
    t25 = (t24 >= 128);
    if (t25 == 1)
        goto LAB9;

LAB10:    t21 = (unsigned char)0;

LAB11:    if (t21 != 0)
        goto LAB7;

LAB8:    t45 = (t0 + 1328U);
    t46 = *((char **)t45);
    t47 = *((int *)t46);
    t45 = (t0 + 3984U);
    t48 = *((char **)t45);
    t49 = *((int *)t48);
    t50 = (t47 >= t49);
    if (t50 == 1)
        goto LAB14;

LAB15:    t44 = (unsigned char)0;

LAB16:    if (t44 != 0)
        goto LAB12;

LAB13:
LAB2:    t78 = (t0 + 8812);
    *((int *)t78) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 1052U);
    t5 = *((char **)t1);
    t6 = *((int *)t5);
    t1 = (t0 + 9456);
    t7 = (t1 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    *((int *)t10) = t6;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB5:    t11 = (t0 + 1880U);
    t15 = *((char **)t11);
    t16 = *((int *)t15);
    t11 = (t0 + 9456);
    t17 = (t11 + 32U);
    t18 = *((char **)t17);
    t19 = (t18 + 32U);
    t20 = *((char **)t19);
    *((int *)t20) = t16;
    xsi_driver_first_trans_fast(t11);
    goto LAB2;

LAB7:    t22 = (t0 + 1972U);
    t29 = *((char **)t22);
    t22 = (t0 + 1328U);
    t30 = *((char **)t22);
    t31 = *((int *)t30);
    t32 = (t31 - 128);
    t33 = xsi_vhdl_mod(t32, 128);
    t34 = (t33 - 0);
    t35 = (t34 * 1);
    xsi_vhdl_check_range_of_index(0, 127, 1, t33);
    t36 = (4U * t35);
    t37 = (0 + t36);
    t22 = (t29 + t37);
    t38 = *((int *)t22);
    t39 = (t0 + 9456);
    t40 = (t39 + 32U);
    t41 = *((char **)t40);
    t42 = (t41 + 32U);
    t43 = *((char **)t42);
    *((int *)t43) = t38;
    xsi_driver_first_trans_fast(t39);
    goto LAB2;

LAB9:    t22 = (t0 + 1328U);
    t26 = *((char **)t22);
    t27 = *((int *)t26);
    t28 = (t27 <= 255);
    t21 = t28;
    goto LAB11;

LAB12:    t45 = (t0 + 2064U);
    t59 = *((char **)t45);
    t45 = (t0 + 1328U);
    t60 = *((char **)t45);
    t61 = *((int *)t60);
    t45 = (t0 + 3984U);
    t62 = *((char **)t45);
    t63 = *((int *)t62);
    t64 = (t61 - t63);
    t45 = (t0 + 4052U);
    t65 = *((char **)t45);
    t66 = *((int *)t65);
    t67 = xsi_vhdl_mod(t64, t66);
    t68 = (t67 - 0);
    t69 = (t68 * 1);
    xsi_vhdl_check_range_of_index(0, 255, 1, t67);
    t70 = (4U * t69);
    t71 = (0 + t70);
    t45 = (t59 + t71);
    t72 = *((int *)t45);
    t73 = (t0 + 9456);
    t74 = (t73 + 32U);
    t75 = *((char **)t74);
    t76 = (t75 + 32U);
    t77 = *((char **)t76);
    *((int *)t77) = t72;
    xsi_driver_first_trans_fast(t73);
    goto LAB2;

LAB14:    t45 = (t0 + 1328U);
    t51 = *((char **)t45);
    t52 = *((int *)t51);
    t45 = (t0 + 3984U);
    t53 = *((char **)t45);
    t54 = *((int *)t53);
    t45 = (t0 + 4052U);
    t55 = *((char **)t45);
    t56 = *((int *)t55);
    t57 = (t54 + t56);
    t58 = (t52 < t57);
    t44 = t58;
    goto LAB16;

}

static void work_a_0851341760_3212880686_p_4(char *t0)
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

LAB0:    xsi_set_current_line(295, ng1);
    t1 = (t0 + 844U);
    t2 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 8820);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(296, ng1);
    t3 = (t0 + 3444U);
    t4 = *((char **)t3);
    t5 = *((int *)t4);
    if (t5 == 2032)
        goto LAB6;

LAB8:
LAB7:    xsi_set_current_line(308, ng1);
    t1 = (t0 + 3444U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t10 = (t5 + 1);
    t1 = (t0 + 9492);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((int *)t8) = t10;
    xsi_driver_first_trans_fast(t1);

LAB5:    goto LAB3;

LAB6:    xsi_set_current_line(298, ng1);
    t3 = (t0 + 9492);
    t6 = (t3 + 32U);
    t7 = *((char **)t6);
    t8 = (t7 + 32U);
    t9 = *((char **)t8);
    *((int *)t9) = 0;
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(300, ng1);
    t1 = (t0 + 3536U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    if (t5 == 262)
        goto LAB11;

LAB13:
LAB12:    xsi_set_current_line(304, ng1);
    t1 = (t0 + 3536U);
    t3 = *((char **)t1);
    t5 = *((int *)t3);
    t10 = (t5 + 1);
    t1 = (t0 + 9528);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((int *)t8) = t10;
    xsi_driver_first_trans_fast(t1);

LAB10:    goto LAB5;

LAB9:;
LAB11:    xsi_set_current_line(302, ng1);
    t1 = (t0 + 9528);
    t4 = (t1 + 32U);
    t6 = *((char **)t4);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((int *)t8) = 0;
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB14:;
}

static void work_a_0851341760_3212880686_p_5(char *t0)
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

LAB0:    xsi_set_current_line(313, ng1);
    t1 = (t0 + 3536U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t4 = (t3 < 3);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t9 = (t0 + 9564);
    t10 = (t9 + 32U);
    t11 = *((char **)t10);
    t12 = (t11 + 32U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)2;
    xsi_driver_first_trans_fast(t9);

LAB2:    t14 = (t0 + 8828);
    *((int *)t14) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 9564);
    t5 = (t1 + 32U);
    t6 = *((char **)t5);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_6(char *t0)
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

LAB0:    xsi_set_current_line(314, ng1);
    t1 = (t0 + 3444U);
    t2 = *((char **)t1);
    t3 = *((int *)t2);
    t4 = (t3 < 150);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t9 = (t0 + 9600);
    t10 = (t9 + 32U);
    t11 = *((char **)t10);
    t12 = (t11 + 32U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)2;
    xsi_driver_first_trans_fast(t9);

LAB2:    t14 = (t0 + 8836);
    *((int *)t14) = 1;

LAB1:    return;
LAB3:    t1 = (t0 + 9600);
    t5 = (t1 + 32U);
    t6 = *((char **)t5);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_7(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(316, ng1);

LAB3:    t1 = (t0 + 3352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 9636);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast(t1);

LAB2:    t8 = (t0 + 8844);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_8(char *t0)
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

LAB0:    xsi_set_current_line(318, ng1);
    t3 = (t0 + 3628U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t6 = (t5 == (unsigned char)2);
    if (t6 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t3 = (t0 + 3628U);
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
LAB14:    t21 = (t0 + 9672);
    t22 = (t21 + 32U);
    t23 = *((char **)t22);
    t24 = (t23 + 32U);
    t25 = *((char **)t24);
    *((unsigned char *)t25) = (unsigned char)3;
    xsi_driver_first_trans_delta(t21, 15U, 1, 0LL);

LAB2:    t26 = (t0 + 8852);
    *((int *)t26) = 1;

LAB1:    return;
LAB3:    t3 = (t0 + 9672);
    t17 = (t3 + 32U);
    t18 = *((char **)t17);
    t19 = (t18 + 32U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = (unsigned char)2;
    xsi_driver_first_trans_delta(t3, 15U, 1, 0LL);
    goto LAB2;

LAB5:    t1 = (unsigned char)1;
    goto LAB7;

LAB8:    t3 = (t0 + 3720U);
    t7 = *((char **)t3);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)3);
    t2 = t9;
    goto LAB10;

LAB11:    t3 = (t0 + 3444U);
    t14 = *((char **)t3);
    t15 = *((int *)t14);
    t16 = (t15 >= 150);
    t10 = t16;
    goto LAB13;

LAB15:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_9(char *t0)
{
    unsigned char t1;
    unsigned char t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    int t12;
    unsigned char t13;
    char *t14;
    int t15;
    unsigned char t16;
    char *t17;
    unsigned char t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;

LAB0:    xsi_set_current_line(319, ng1);
    t4 = (t0 + 3628U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)2);
    if (t7 == 1)
        goto LAB11;

LAB12:    t3 = (unsigned char)0;

LAB13:    if (t3 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB14:    t23 = (t0 + 9708);
    t24 = (t23 + 32U);
    t25 = *((char **)t24);
    t26 = (t25 + 32U);
    t27 = *((char **)t26);
    *((unsigned char *)t27) = (unsigned char)2;
    xsi_driver_first_trans_delta(t23, 14U, 1, 0LL);

LAB2:    t28 = (t0 + 8860);
    *((int *)t28) = 1;

LAB1:    return;
LAB3:    t4 = (t0 + 3812U);
    t17 = *((char **)t4);
    t18 = *((unsigned char *)t17);
    t4 = (t0 + 9708);
    t19 = (t4 + 32U);
    t20 = *((char **)t19);
    t21 = (t20 + 32U);
    t22 = *((char **)t21);
    *((unsigned char *)t22) = t18;
    xsi_driver_first_trans_delta(t4, 14U, 1, 0LL);
    goto LAB2;

LAB5:    t4 = (t0 + 3444U);
    t14 = *((char **)t4);
    t15 = *((int *)t14);
    t16 = (t15 < 1536);
    t1 = t16;
    goto LAB7;

LAB8:    t4 = (t0 + 3444U);
    t11 = *((char **)t4);
    t12 = *((int *)t11);
    t13 = (t12 > 511);
    t2 = t13;
    goto LAB10;

LAB11:    t4 = (t0 + 3720U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)2);
    t3 = t10;
    goto LAB13;

LAB15:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_10(char *t0)
{
    char *t1;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(320, ng1);

LAB3:    t1 = (t0 + 16660);
    t3 = (14U != 14U);
    if (t3 == 1)
        goto LAB5;

LAB6:    t4 = (t0 + 9744);
    t5 = (t4 + 32U);
    t6 = *((char **)t5);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    memcpy(t8, t1, 14U);
    xsi_driver_first_trans_delta(t4, 0U, 14U, 0LL);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(14U, 14U, 0);
    goto LAB6;

}

static void work_a_0851341760_3212880686_p_11(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(321, ng1);

LAB3:    t1 = (t0 + 16674);
    t3 = (t0 + 9780);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 16U);
    xsi_driver_first_trans_fast_port(t3);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_12(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(322, ng1);

LAB3:    t1 = (t0 + 16690);
    t3 = (t0 + 9816);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 16U);
    xsi_driver_first_trans_fast_port(t3);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_13(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(338, ng1);

LAB3:    t1 = (t0 + 868U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 9852);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast(t1);

LAB2:    t8 = (t0 + 8868);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_14(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(339, ng1);

LAB3:    t1 = (t0 + 16706);
    t3 = (t0 + 9888);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 1U);
    xsi_driver_first_trans_fast(t3);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_15(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    int t4;
    int t5;
    int t6;
    int t7;
    char *t8;
    int t9;
    int t10;
    int t11;
    int t12;
    int t13;
    int t14;
    int t15;
    char *t16;
    unsigned int t17;
    unsigned char t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    xsi_set_current_line(340, ng1);

LAB3:    t2 = (t0 + 3536U);
    t3 = *((char **)t2);
    t4 = *((int *)t3);
    t5 = (t4 / 8);
    t6 = xsi_vhdl_mod(t5, 32);
    t7 = (t6 * 32);
    t2 = (t0 + 3444U);
    t8 = *((char **)t2);
    t9 = *((int *)t8);
    t10 = (t9 - 512);
    t11 = (t10 + 1);
    t12 = (t11 / 4);
    t13 = (t12 / 8);
    t14 = xsi_vhdl_mod(t13, 32);
    t15 = (t7 + t14);
    t2 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t1, t15, 10);
    t16 = (t1 + 12U);
    t17 = *((unsigned int *)t16);
    t17 = (t17 * 1U);
    t18 = (10U != t17);
    if (t18 == 1)
        goto LAB5;

LAB6:    t19 = (t0 + 9924);
    t20 = (t19 + 32U);
    t21 = *((char **)t20);
    t22 = (t21 + 32U);
    t23 = *((char **)t22);
    memcpy(t23, t2, 10U);
    xsi_driver_first_trans_fast(t19);

LAB2:    t24 = (t0 + 8876);
    *((int *)t24) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(10U, t17, 0);
    goto LAB6;

}

static void work_a_0851341760_3212880686_p_16(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(341, ng1);

LAB3:    t1 = (t0 + 868U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 9960);
    t4 = (t1 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast(t1);

LAB2:    t8 = (t0 + 8884);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_17(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(342, ng1);

LAB3:    t1 = (t0 + 16707);
    t3 = (t0 + 9996);
    t4 = (t3 + 32U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 1U);
    xsi_driver_first_trans_fast(t3);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_18(char *t0)
{
    char *t1;
    char *t2;
    unsigned int t3;
    unsigned int t4;
    unsigned int t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;

LAB0:    xsi_set_current_line(351, ng1);

LAB3:    t1 = (t0 + 2524U);
    t2 = *((char **)t1);
    t3 = (7 - 6);
    t4 = (t3 * 1U);
    t5 = (0 + t4);
    t1 = (t2 + t5);
    t6 = (t0 + 10032);
    t7 = (t6 + 32U);
    t8 = *((char **)t7);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 7U);
    xsi_driver_first_trans_fast(t6);

LAB2:    t11 = (t0 + 8892);
    *((int *)t11) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0851341760_3212880686_p_19(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    int t4;
    char *t5;
    unsigned int t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(352, ng1);

LAB3:    t2 = (t0 + 3536U);
    t3 = *((char **)t2);
    t4 = *((int *)t3);
    t2 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t1, t4, 3);
    t5 = (t1 + 12U);
    t6 = *((unsigned int *)t5);
    t6 = (t6 * 1U);
    t7 = (3U != t6);
    if (t7 == 1)
        goto LAB5;

LAB6:    t8 = (t0 + 10068);
    t9 = (t8 + 32U);
    t10 = *((char **)t9);
    t11 = (t10 + 32U);
    t12 = *((char **)t11);
    memcpy(t12, t2, 3U);
    xsi_driver_first_trans_fast(t8);

LAB2:    t13 = (t0 + 8900);
    *((int *)t13) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(3U, t6, 0);
    goto LAB6;

}

static void work_a_0851341760_3212880686_p_20(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    int t4;
    int t5;
    char *t6;
    unsigned int t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    xsi_set_current_line(353, ng1);

LAB3:    t2 = (t0 + 3444U);
    t3 = *((char **)t2);
    t4 = *((int *)t3);
    t5 = (t4 / 4);
    t2 = ieee_p_3499444699_sub_2213602152_3536714472(IEEE_P_3499444699, t1, t5, 3);
    t6 = (t1 + 12U);
    t7 = *((unsigned int *)t6);
    t7 = (t7 * 1U);
    t8 = (3U != t7);
    if (t8 == 1)
        goto LAB5;

LAB6:    t9 = (t0 + 10104);
    t10 = (t9 + 32U);
    t11 = *((char **)t10);
    t12 = (t11 + 32U);
    t13 = *((char **)t12);
    memcpy(t13, t2, 3U);
    xsi_driver_first_trans_fast(t9);

LAB2:    t14 = (t0 + 8908);
    *((int *)t14) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(3U, t7, 0);
    goto LAB6;

}


extern void work_a_0851341760_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0851341760_3212880686_p_0,(void *)work_a_0851341760_3212880686_p_1,(void *)work_a_0851341760_3212880686_p_2,(void *)work_a_0851341760_3212880686_p_3,(void *)work_a_0851341760_3212880686_p_4,(void *)work_a_0851341760_3212880686_p_5,(void *)work_a_0851341760_3212880686_p_6,(void *)work_a_0851341760_3212880686_p_7,(void *)work_a_0851341760_3212880686_p_8,(void *)work_a_0851341760_3212880686_p_9,(void *)work_a_0851341760_3212880686_p_10,(void *)work_a_0851341760_3212880686_p_11,(void *)work_a_0851341760_3212880686_p_12,(void *)work_a_0851341760_3212880686_p_13,(void *)work_a_0851341760_3212880686_p_14,(void *)work_a_0851341760_3212880686_p_15,(void *)work_a_0851341760_3212880686_p_16,(void *)work_a_0851341760_3212880686_p_17,(void *)work_a_0851341760_3212880686_p_18,(void *)work_a_0851341760_3212880686_p_19,(void *)work_a_0851341760_3212880686_p_20};
	static char *se[] = {(void *)work_a_0851341760_3212880686_sub_307966218_3057020925,(void *)work_a_0851341760_3212880686_sub_401119202_3057020925,(void *)work_a_0851341760_3212880686_sub_769852499_3057020925};
	xsi_register_didat("work_a_0851341760_3212880686", "isim/BH_com_isim_beh.exe.sim/work/a_0851341760_3212880686.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
