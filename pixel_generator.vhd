LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY pixel_generator IS
	GENERIC(
		columns 	:	INTEGER := 40
		);
	PORT(
		pixel_clk	:  IN 	STD_LOGIC;
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		h_sync		:	IN		STD_LOGIC;
		v_sync		:	IN		STD_LOGIC;
		char_address:  OUT 	std_logic_vector(9 downto 0);
		byte_load	:  OUT 	STD_LOGIC := '0';
		h_sync_delay:	OUT	STD_LOGIC;
		v_sync_delay:	OUT 	STD_LOGIC;
		disp_ena_delay		:  OUT	STD_LOGIC
--		red			:	OUT	STD_LOGIC := '0';  --red magnitude output to DAC
--		green			:	OUT	STD_LOGIC := '0';  --green magnitude output to DAC
--		blue			:	OUT	STD_LOGIC := '0'   --blue magnitude output to DAC
); 
END pixel_generator;

ARCHITECTURE behavior OF pixel_generator IS	
	signal h_sync_delay1:	STD_LOGIC;
	signal h_sync_delay2:	STD_LOGIC;
	signal v_sync_delay1:	STD_LOGIC;
	signal v_sync_delay2:	STD_LOGIC;
	signal disp_ena_delay1:	STD_LOGIC;
	signal disp_ena_delay2:	STD_LOGIC;
	
BEGIN
	
	-- Note:  /16 to scale from 640*400 to 320*200.
	-- Also, divide the pixel shifter clock (see TFF)
	-- Also, feed row[3..1] into ROM (instead of row[2..1]
	
	char_address <= std_logic_vector(to_unsigned((column / 16) + (row / 16) * columns, char_address'length));
	
	PROCESS(pixel_clk)
	BEGIN
		IF(pixel_clk'EVENT AND pixel_clk = '1') THEN
			-- ROM is setup on the 2nd clock, load it in the shift register.
			IF (column mod 16 = 1) THEN
			-- output column mod 8 bit of rom
				byte_load <= '1';
			ELSE
				byte_load <= '0';
			END IF;
		END IF;		
	END PROCESS;
	
	-- implement 4 clock cycles delay to allow for fetching RAM/ROM and load shift reg.
	PROCESS(pixel_clk)
	BEGIN
		IF(pixel_clk'EVENT AND pixel_clk = '1') THEN
			h_sync_delay <= h_sync_delay1;
			h_sync_delay1 <= h_sync_delay2;
			h_sync_delay2 <= h_sync;
			
			v_sync_delay <= v_sync_delay1;
			v_sync_delay1 <= v_sync_delay2;
			v_sync_delay2 <= v_sync;
			
			disp_ena_delay <= disp_ena_delay1;
			disp_ena_delay1 <= disp_ena_delay2;
			disp_ena_delay2 <= disp_ena;			
		END IF;		
	END PROCESS;
	
END behavior;