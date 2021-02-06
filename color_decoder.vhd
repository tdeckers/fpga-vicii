LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

ENTITY color_decoder IS
	PORT
	(
		pixel_clk	: IN STD_LOGIC ;
		data			: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		red			: OUT STD_LOGIC_VECTOR (1 DOWNTO 0) ;
		green			: OUT STD_LOGIC_VECTOR (1 DOWNTO 0) ;
		blue			: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
	);
END color_decoder;


ARCHITECTURE behavior OF color_decoder IS
	signal red1:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal red2:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal red3:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal green1:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal green2:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal green3:	STD_LOGIC_VECTOR (1 DOWNTO 0);	
	signal blue1:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal blue2:	STD_LOGIC_VECTOR (1 DOWNTO 0);
	signal blue3:	STD_LOGIC_VECTOR (1 DOWNTO 0);
BEGIN
	-- https://www.c64-wiki.com/wiki/Color
	
 red3 <=		"00" when data="0000" else	-- black
				"11" when data="0001" else	-- white
				"10" when data="0010" else	-- red
				"10" when data="0011" else	-- cyan
				"11" when data="0100" else  -- purple
				"00" when data="0101" else 	-- green
				"00" when data="0110" else	-- blue
				"11" when data="0111" else	-- yellow
				"11" when data="1000" else	-- orange
				"01" when data="1001" else 	-- brown
				"11" when data="1010" else	-- light red
				"01" when data="1011" else	-- dark grey / grey 1
				"10" when data="1100" else	-- grey 2
				"11" when data="1101" else	-- light green
				"00" when data="1110" else	-- light blue
				"10" when data="1111";		-- light grey / grey 3

 green3 <=	"00" when data="0000" else	-- black
				"11" when data="0001" else	-- white
				"00" when data="0010" else	-- red
				"11" when data="0011" else	-- cyan
				"01" when data="0100" else  -- purple
				"11" when data="0101" else 	-- green
				"00" when data="0110" else	-- blue
				"11" when data="0111" else	-- yellow
				"10" when data="1000" else	-- orange
				"01" when data="1001" else 	-- brown
				"01" when data="1010" else	-- light red
				"01" when data="1011" else	-- dark grey / grey 1
				"10" when data="1100" else	-- grey 2
				"11" when data="1101" else	-- light green
				"10" when data="1110" else	-- light blue
				"10" when data="1111";		-- light grey / grey 3

 blue3 <=	"00" when data="0000" else	-- black
				"11" when data="0001" else	-- white
				"00" when data="0010" else	-- red
				"11" when data="0011" else	-- cyan
				"11" when data="0100" else  -- purple
				"01" when data="0101" else 	-- green
				"11" when data="0110" else	-- blue
				"01" when data="0111" else	-- yellow
				"01" when data="1000" else	-- orange
				"00" when data="1001" else 	-- brown
				"01" when data="1010" else	-- light red
				"01" when data="1011" else	-- dark grey / grey 1
				"10" when data="1100" else	-- grey 2
				"01" when data="1101" else	-- light green
				"11" when data="1110" else	-- light blue
				"10" when data="1111";		-- light grey / grey 3	
		
	-- implement 4 clock cycles delay to sync with pixels (see pixel generator).
	PROCESS(pixel_clk)
	BEGIN
		IF(pixel_clk'EVENT AND pixel_clk = '1') THEN
			red <= red1;
			red1 <= red2;
			red2 <= red3;
			
			green <= green1;
			green1 <= green2;
			green2 <= green3;

			blue <= blue1;
			blue1 <= blue2;
			blue2 <= blue3;			
		END IF;
	END PROCESS;
END behavior;