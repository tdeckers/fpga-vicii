
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is
   port(
		pixel_clk	:	IN		STD_LOGIC;
      row: in INTEGER;
      column: in INTEGER;
		address: out std_logic_vector(9 downto 0);
		charx: out INTEGER;
		chary: out INTEGER
   );
end decoder;

ARCHITECTURE behavior OF decoder IS	
BEGIN
--	PROCESS(pixel_clk)
--		variable addr_temp : INTEGER;
--	BEGIN
--		IF(pixel_clk'EVENT AND pixel_clk = '1') THEN
--			addr_temp := (column / 8) + (row / 8) * 40;
			address <= std_logic_vector(to_unsigned((column / 8) + (row / 8) * 40, address'length));
--		END IF;
--	END PROCESS;

END behavior;