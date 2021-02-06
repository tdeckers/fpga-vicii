LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY write_mem IS
	PORT(
		clk	:  IN 	STD_LOGIC;
		address:  OUT 	std_logic_vector(11 downto 0);
		data:  OUT 	std_logic_vector(7 downto 0);
		we: OUT STD_LOGIC
); 
END write_mem;

ARCHITECTURE behavior OF write_mem IS
	
BEGIN
	
	address <= std_logic_vector(to_unsigned(20, address'length));
	
	PROCESS(clk)
		VARIABLE refresh_cnt : INTEGER := 0;
		VARIABLE counter	:	INTEGER RANGE 1 TO 26 := 1;
	BEGIN
		IF (clk'event AND clk = '1') THEN
			refresh_cnt := refresh_cnt + 1;
			IF (refresh_cnt = 60) THEN 
				refresh_cnt := 0;
				data <= std_logic_vector(to_unsigned(counter, data'length));
				we <= '1';	
				counter := counter + 1;
				IF (counter = 27) THEN
					counter := 1;
				END IF;
			ELSE
				we <= '0';
			END IF;			
		END IF;
	END PROCESS;

END behavior;
