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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *UNISIM_P_0947159679;
char *IEEE_P_1242562249;
char *IEEE_P_2592010699;
char *STD_TEXTIO;
char *STD_STANDARD;
char *IEEE_P_3499444699;
char *IEEE_P_2717149903;
char *IEEE_P_3620187407;
char *UNISIM_P_3222816464;
char *IEEE_P_1367372525;
char *WORK_P_2056487417;
char *IEEE_P_3564397177;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    ieee_p_1242562249_init();
    work_p_2056487417_init();
    unisim_p_0947159679_init();
    std_textio_init();
    ieee_p_2717149903_init();
    ieee_p_1367372525_init();
    unisim_p_3222816464_init();
    ieee_p_3564397177_init();
    xilinxcorelib_a_1711907355_2959432447_init();
    xilinxcorelib_a_2817327874_1709443946_init();
    xilinxcorelib_a_1655808614_0543512595_init();
    xilinxcorelib_a_1457159126_3212880686_init();
    work_a_0151958993_1278436910_init();
    work_a_2205949838_3212880686_init();
    xilinxcorelib_a_3073806374_2959432447_init();
    xilinxcorelib_a_3541679604_1709443946_init();
    xilinxcorelib_a_2658629619_0543512595_init();
    xilinxcorelib_a_3433311452_3212880686_init();
    work_a_3772128646_1178700139_init();
    work_a_0576198598_1516540902_init();
    unisim_a_2562466605_1496654361_init();
    unisim_a_1717296735_4086321779_init();
    unisim_a_2892212195_1521797606_init();
    unisim_a_0350208134_1521797606_init();
    unisim_a_1347630660_3996864970_init();
    unisim_a_3213974906_3996864970_init();
    unisim_a_3055263662_1392679692_init();
    unisim_a_0587692967_3731405331_init();
    unisim_a_0774281858_3731405331_init();
    unisim_a_3600803327_3731405331_init();
    unisim_a_1232727138_3676810390_init();
    unisim_a_1446710196_3752513572_init();
    unisim_a_4104775526_3752513572_init();
    unisim_a_2121384304_3723259517_init();
    unisim_a_1646226234_1266530935_init();
    unisim_a_3484885994_2523279426_init();
    unisim_a_3702704980_1602505438_init();
    work_a_3926497698_0632001823_init();
    work_a_0183838134_3212880686_init();
    work_a_1985558087_2372691052_init();


    xsi_register_tops("work_a_1985558087_2372691052");

    UNISIM_P_0947159679 = xsi_get_engine_memory("unisim_p_0947159679");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_2717149903 = xsi_get_engine_memory("ieee_p_2717149903");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    UNISIM_P_3222816464 = xsi_get_engine_memory("unisim_p_3222816464");
    IEEE_P_1367372525 = xsi_get_engine_memory("ieee_p_1367372525");
    WORK_P_2056487417 = xsi_get_engine_memory("work_p_2056487417");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");

    return xsi_run_simulation(argc, argv);

}
