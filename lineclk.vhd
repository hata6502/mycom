library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lineclk_gen is
	Port (
		clk : in STD_LOGIC;
		lineclk: out std_logic
	);
end lineclk_gen;

architecture Behavioral of lineclk_gen is
	signal clkcnt: integer := 0;
begin 
	process(clk) begin
		if (rising_edge(clk)) then
			case clkcnt is
				when 1016 =>
					lineclk <= '0';
				when 2032 =>
					lineclk <= '1';
					clkcnt <= 0;
				when others =>
					clkcnt <= clkcnt + 1;
			end case;
		end if;
	end process;
end Behavioral;
