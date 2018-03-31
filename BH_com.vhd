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
	function bool_to_integer(L: BOOLEAN) return integer is 
		begin 
         if L then 
             return(1); 
         else 
             return(0); 
         end if; 
	end function; 
	
	function is_word(inst: integer) return integer is 
		begin 
		return (inst*16777216);
	end function;
	function is_word(inst: integer; operand: integer) return integer is 
		begin 
		return (inst*16777216 + operand);
	end function; 

	signal clkcnt: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	
	-- CPU
	signal cpu_pc: integer := 256;
	signal cpu_stat: integer := 0;
	signal cpu_inst: integer;

	signal cpu_addr: integer;
	signal cpu_raddr: integer;
	signal cpu_waddr: integer;
	
	signal cpu_rdata: integer;
	signal cpu_wdata: integer;
	signal cpu_opdata: integer;

	signal cpu_work: integer;
	type greg is array (0 to 127) of integer;
	signal cpu_greg: greg;
	
	-- Memory map
	constant ADDR_BOOT: integer := 256;
	constant SIZE_BOOT: integer := 256;

	-- Instruction
	constant IS_ADD: integer := 0;
	constant IS_SUB: integer := 1;
	constant IS_MUL: integer := 2;
	constant IS_DIV: integer := 3;
	constant IS_AND: integer := 4;
	constant IS_OR: integer := 5;
	constant IS_XOR: integer := 6;

	constant IS_READ: integer := 7;
	constant IS_WRITE: integer := 8;

	constant IS_BRANCH: integer := 9;
	constant IS_EQ: integer := 10;	-- ==
	constant IS_NEQ: integer := 11;	-- !=
	constant IS_LT: integer := 12;	-- <
	constant IS_LTE: integer := 13;	-- <=
	constant IS_GT: integer := 14;	-- >
	constant IS_GTE: integer := 15;	--	>=

	-- Virtual instruction
	constant IS_NOP: integer := IS_ADD;

	-- BOOT
	constant ORG_BOOT: integer := ADDR_BOOT+16;
	type prom is array (0 to 255) of integer;
	constant boot: prom := (
		is_word(IS_NOP), -- Wait for the power steady
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
	
		-- Program
			is_word(IS_READ, ORG_BOOT+26),	-- 0
			is_word(IS_WRITE, 128),	-- 1
			is_word(IS_READ, ORG_BOOT+24), 	-- 2
			is_word(IS_WRITE, 129), 	-- 3
			is_word(IS_READ, ORG_BOOT+25),	-- 4
			is_word(IS_WRITE, 131),	-- 5

		-- *label_0
				is_word(IS_NOP),	-- 6
				is_word(IS_NOP),	-- 7
				is_word(IS_NOP),	-- 8
				is_word(IS_READ, ORG_BOOT+33),	-- 9
				is_word(IS_WRITE, 130),	-- 10
				is_word(IS_READ, ORG_BOOT+28),	-- 11
				is_word(IS_WRITE, 0),	-- 12
			-- *label_1
				is_word(IS_READ, 132),	-- 13
				is_word(IS_ADD, ORG_BOOT+29),	-- 14
				is_word(IS_WRITE, 132),	-- 15
				is_word(IS_READ, 129),	-- 16
				is_word(IS_ADD, ORG_BOOT+30),	-- 17
				is_word(IS_WRITE, 129),	-- 18
			is_word(IS_AND, 16777216),	-- 19
			is_word(IS_NEQ, ORG_BOOT+31),	-- 20
			is_word(IS_BRANCH, ORG_BOOT+6),	-- 21
			
		-- *label_2
			is_word(IS_READ, ORG_BOOT+32),	-- 22
			is_word(IS_WRITE, 0),	-- 23
			
		-- Data
			is_word(IS_WRITE, 1024),	-- 24
			is_word(IS_WRITE, 0), -- 25
			is_word(IS_READ, 132),	-- 26
			is_word(IS_READ, 0),	--27
			128,	-- 28
			1,	-- 29
			1,	-- 30
			2048,	-- 31
			ORG_BOOT + 22, -- 32
			is_word(IS_READ, ORG_BOOT+34), -- 33	
			ORG_BOOT+13,	-- 34

		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		256,
		35
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
	process(clk)
	variable inst: integer;
	variable operand: integer;
	begin
		if (rising_edge(clk)) then
			case cpu_stat is
				when 0 =>	-- Read instruction
					inst := cpu_rdata/16777216;
					operand := cpu_rdata mod 16777216;
					
					cpu_inst <= inst;
					cpu_pc <= cpu_pc + 1;
					
					case inst is
						when IS_READ|IS_ADD|IS_SUB|IS_MUL|IS_DIV|IS_AND|IS_OR|IS_XOR|IS_EQ|IS_NEQ|IS_LT|IS_LTE|IS_GT|IS_GTE =>
							cpu_raddr <= operand;
						when IS_WRITE|IS_BRANCH =>
							cpu_raddr <= cpu_pc;
						when others =>
					end case;

					cpu_stat <= 1;
				when 1 =>	-- Read Memory
					cpu_opdata <= cpu_rdata;
					cpu_stat <= 2;
				when 2 =>	-- Operation
					operand := cpu_opdata mod 16777216;

					case cpu_inst is
						when IS_READ =>
							cpu_wdata <= cpu_opdata;
							cpu_waddr <= 1;
						when IS_WRITE =>
							cpu_wdata <= cpu_work;
							cpu_waddr <= operand;
							
						when IS_ADD =>
							cpu_wdata <= cpu_work + cpu_opdata;
							cpu_waddr <= 1;
						when IS_SUB =>
							cpu_wdata <= cpu_work - cpu_opdata;
							cpu_waddr <= 1;
						when IS_MUL =>
							cpu_wdata <= cpu_work * cpu_opdata;
							cpu_waddr <= 1;
						when IS_DIV =>
							--cpu_wdata <= cpu_work / cpu_opdata;
							cpu_waddr <= 1;
						when IS_AND =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, 32) and conv_std_logic_vector(cpu_opdata, 32));
							cpu_waddr <= 1;
						when IS_OR =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, 32) or conv_std_logic_vector(cpu_opdata, 32));
							cpu_waddr <= 1;
						when IS_XOR =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, 32) xor conv_std_logic_vector(cpu_opdata, 32));
							cpu_waddr <= 1;

						when IS_BRANCH =>
							if (cpu_work=1) then
								cpu_wdata <= operand;
							else
								cpu_wdata <= cpu_pc;
							end if;
							cpu_waddr <= 0;
						when IS_EQ =>
							cpu_wdata <= bool_to_integer(cpu_work = cpu_opdata);
							cpu_waddr <= 1;
						when IS_NEQ =>
							cpu_wdata <= bool_to_integer(cpu_work /= cpu_opdata);
							cpu_waddr <= 1;
						when IS_LT =>
							cpu_wdata <= bool_to_integer(cpu_work < cpu_opdata);
							cpu_waddr <= 1;
						when IS_LTE =>
							cpu_wdata <= bool_to_integer(cpu_work <= cpu_opdata);
							cpu_waddr <= 1;
						when IS_GT =>
							cpu_wdata <= bool_to_integer(cpu_work > cpu_opdata);
							cpu_waddr <= 1;
						when IS_GTE =>
							cpu_wdata <= bool_to_integer(cpu_work >= cpu_opdata);
							cpu_waddr <= 1;
						when others =>
					end case;

					cpu_stat <= 3;
				when 3 =>	-- Write memory
					--case cpu_inst is
						--when IS_READ|IS_WRITE|IS_ADD|IS_SUB|IS_MUL|IS_DIV|IS_AND|IS_OR|IS_XOR| =>
							if (cpu_waddr=0) then
								cpu_pc <= cpu_wdata;
							elsif (cpu_waddr=1) then
								cpu_work <= cpu_wdata;
							elsif (cpu_waddr>=128 and cpu_waddr<=255) then
								cpu_greg((cpu_waddr - 128)mod 128) <= cpu_wdata;
							elsif (cpu_waddr>=1024 and cpu_waddr<=2047) then
								vram_1_addrb <= CONV_std_logic_vector(((cpu_waddr-1024)/32 mod 32)*32 + ((cpu_waddr-1024)mod 32), 10);
								vram_1_dinb <= CONV_std_logic_vector(cpu_wdata, 8);
							end if;
						--when others =>
					--end case;
					
					cpu_stat <= 0;
				when others =>
			end case;
		end if;
	end process;
	
	cpu_addr <= cpu_pc when cpu_stat=0
		else cpu_raddr when cpu_stat=1;

	cpu_rdata <= cpu_pc when cpu_addr=0
		else cpu_work when cpu_addr=1
		else cpu_greg((cpu_addr - 128) mod 128) when cpu_addr>=128 and cpu_addr<=255
		else boot((cpu_addr - ADDR_BOOT) mod SIZE_BOOT) when cpu_addr>=ADDR_BOOT and cpu_addr<(ADDR_BOOT + SIZE_BOOT);
	
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
