library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BH_com is
    Port ( A : out  STD_LOGIC_VECTOR (15 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0);
           C : out  STD_LOGIC_VECTOR (15 downto 0);
                          clk : in STD_LOGIC);
end BH_com;

architecture Behavioral of BH_com is

	signal clkcnt: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	
	-- CPU
	signal cpu_pc: integer := 0;
	signal cpu_stat: integer := 0; 

	signal cpu_inst_addr: integer;
	signal cpu_wdata: integer;

	type prom is array (0 to 127) of integer;
	constant boot: prom := (
		1550, 90, -- Z
		1551, 105, -- i
		1552, 115, -- s
		1553, 97, -- a
		1554, 107, -- k
		1555, 117, -- u
		1556, 32, -- 
		1557, 32, -- 

		1558 + 24, 67, -- C
		1559 + 24, 80, -- P
		1560 + 24, 85, -- U
		1561 + 24, 38, -- &
		1562 + 24, 80, -- P
		1563 + 24, 80, --P
		1564 + 24, 85, -- U
		1565 + 24, 32, 

		1566 + 48, 111, -- o
		1567 + 48, 110, -- n
		1568 + 48, 32,  --
		1569 + 48, 70, -- F
		1570 + 48, 80, -- P
		1571 + 48, 71, -- G
		1572 + 48, 65, -- A
		1573 + 48, 32, 

		1574 + 72, 105, -- i
		1575 + 72, 110, -- n
		1576 + 72, 32, --
		1577 + 72, 86, -- V
		1578 + 72, 72, -- H
		1579 + 72, 68, -- D
		1580 + 72, 76, -- L
		1581 + 72, 32, 

		1582 + 96, 32, 
		1583 + 96, 32, 
		1584 + 96, 32, 
		1585 + 96, 32, 
		1586 + 96, 32, 
		1587 + 96, 32, 
		1588 + 96, 32, 
		1589 + 96, 32, 

		1590 + 120, 84, -- T
		1591 + 120, 119, -- w
		1592 + 120, 105, -- i
		1593 + 120, 116, -- t
		1594 + 120, 116, -- t
		1595 + 120, 101, -- e
		1596 + 120, 114, -- r
		1597 + 120, 64, -- @

		1598 + 144, 98, -- b
		1599 + 144, 108, -- l
		1600 + 144, 117, -- u
		1601 + 144, 101, -- e
		1602 + 144, 104, -- h
		1603 + 144, 111, -- o
		1604 + 144, 111, -- o
		1605 + 144, 100, -- d

		1606 + 168, 95, -- _
		1607 + 168, 97, -- a
		1608 + 168, 100, -- d
		1609 + 168, 109, -- m
		1610 + 168, 105, -- i
		1611 + 168, 110, -- n
		1612 + 168, 32, --
		1613 + 168, 32 --
	);
	
	-- VRAM
	COMPONENT vram
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 clkb : IN STD_LOGIC;
		 web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal vram_1_clka : STD_LOGIC;
	signal vram_1_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
	signal vram_1_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
	signal vram_1_dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal vram_1_douta : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal vram_1_clkb : STD_LOGIC;
	signal vram_1_web : STD_LOGIC_VECTOR(0 DOWNTO 0);
	signal vram_1_addrb : STD_LOGIC_VECTOR(9 DOWNTO 0);
	signal vram_1_dinb : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal vram_1_doutb : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	-- CROM
	component crom is
    Port (
		chr: in std_logic_vector(6 downto 0);
		row: in std_logic_vector(2 downto 0);
		col: in std_logic_vector(2 downto 0);
		dot: out std_logic
	 );
	end component;
	signal crom_1_chr: std_logic_vector(6 downto 0);
	signal crom_1_row: std_logic_vector(2 downto 0);
	signal crom_1_col: std_logic_vector(2 downto 0);
	signal crom_1_dot: std_logic;
	
	-- PPU
	signal ppu_clkcnt: integer := 0;
	signal ppu_linecnt: integer := 0;

	signal stat_vsync: std_logic;
	signal stat_hsync: std_logic;

	signal lum: std_logic;
begin 

	process(clk) begin
		if (rising_edge(clk)) then
			clkcnt <= clkcnt + 1;
		end if;
	end process;

	-- CPU
	process(clkcnt(20)) begin
		if (rising_edge(clkcnt(20))) then
			case cpu_stat is
				when 0 =>	-- Read instruction
					cpu_inst_addr <= boot(cpu_pc mod 128);
					cpu_pc <= cpu_pc + 1;
					cpu_stat <= 1;
				when 1 =>	-- Read Memory
					cpu_stat <= 2;
				when 2 =>	-- Operation
					cpu_wdata <= boot(cpu_pc mod 128);
					cpu_pc <= cpu_pc + 1;

					cpu_stat <= 3;
				when 3 =>	-- Write memory
					if (cpu_inst_addr>=1024 and cpu_inst_addr<=2047) then
						vram_1_addrb <= CONV_std_logic_vector(((cpu_inst_addr-1024)/32 mod 32)*32 + ((cpu_inst_addr-1024)mod 32), 10);
						vram_1_dinb <= CONV_std_logic_vector(cpu_wdata, 8);
						--vram_1((cpu_inst_addr-1024)/32 mod 32)((cpu_inst_addr-1024)mod 32) <= CONV_std_logic_vector(cpu_wdata, 8);
					end if;
					cpu_stat <= 0;
				when others =>
			end case;
		end if;
	end process;
	
	-- PPU
	process(clk) begin
		if (rising_edge(clk)) then
			case ppu_clkcnt is
				when 2032 =>
					ppu_clkcnt <= 0;
					
					case ppu_linecnt is
						when 262 =>
							ppu_linecnt <= 0;
						when others =>
							ppu_linecnt <= ppu_linecnt + 1;
					end case;
					
				when others =>
					ppu_clkcnt <= ppu_clkcnt + 1;
			end case;
		end if;
	end process;
	
	stat_vsync <= '1' when ppu_linecnt<3 else '0';
	stat_hsync <= '1' when ppu_clkcnt<150 else '0';
	
	lum <= crom_1_dot;

	A(0) <= '0' when (stat_vsync='0' and stat_hsync='1') or (stat_vsync='1' and ppu_clkcnt>=150) else '1';
	A(1) <= lum when stat_vsync='0' and stat_hsync='0' else '0';
	A(15 downto 2) <= "00000000000000";
	B <= "0000000000000000";
	C <= "0000000000000000";
	
	-- VRAM
	vram_1 : vram
	  PORT MAP (
		 clka => vram_1_clka,
		 wea => vram_1_wea,
		 addra => vram_1_addra,
		 dina => vram_1_dina,
		 douta => vram_1_douta,
		 clkb => vram_1_clkb,
		 web => vram_1_web,
		 addrb => vram_1_addrb,
		 dinb => vram_1_dinb,
		 doutb => vram_1_doutb
	  );
	  vram_1_clka <= clk;
	  vram_1_wea <= "0";
	  vram_1_addra <= CONV_std_logic_vector((ppu_linecnt/8 mod 32)*32 + ((ppu_clkcnt + 1)/4/8 mod 32), 10);
	  vram_1_clkb <= clk;
	  vram_1_web <= "1";
	  
	  -- CROM
	crom_1: crom port map (
		chr => crom_1_chr,
		row => crom_1_row,
		col => crom_1_col,
		dot => crom_1_dot
	 );
	 crom_1_chr <= vram_1_douta(6 downto 0);
	 crom_1_row <= conv_std_logic_vector(ppu_linecnt, 3);
	 crom_1_col <= conv_std_logic_vector(ppu_clkcnt/4, 3);

end Behavioral;
