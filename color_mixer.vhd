LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY lpm;
USE lpm.all;

ENTITY color_mixer IS
	PORT
	(
		pixels			: IN STD_LOGIC ;
		disp_ena			: IN STD_LOGIC ;
		
		red_fg			: IN STD_LOGIC_VECTOR (1 DOWNTO 0) ;
		green_fg			: IN STD_LOGIC_VECTOR (1 DOWNTO 0) ;
		blue_fg			: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		red_bg			: IN STD_LOGIC_VECTOR (1 DOWNTO 0) ;
		green_bg			: IN STD_LOGIC_VECTOR (1 DOWNTO 0) ;
		blue_bg			: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		
		red				: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		green				: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
		blue				: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
		
	);
END color_mixer;


ARCHITECTURE behavior OF color_mixer IS

BEGIN
	
	red <=		red_fg when pixels='1' and disp_ena = '1' else
					red_bg when pixels='0' and disp_ena = '1' else
					"00";
					
	green <= 	green_fg when pixels='1'and disp_ena = '1' else
					green_bg when pixels='0' and disp_ena = '1' else
					"00";
					
	blue <= 		blue_fg when pixels='1' and disp_ena = '1' else
					blue_bg when pixels='0' and disp_ena = '1' else
					"00";

END behavior;