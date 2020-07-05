LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

Entity RODR_Multiply IS
	generic(N : natural := 32);
	
	PORT(RODR_InstRegIN1 : in std_logic_vector(N-1 downto 0);
		  RODR_InstRegIN2 : in std_logic_vector(N-1 downto 0);
		  RODR_MultOUT    : out std_logic_vector(N-1 downto 0));
			  
END RODR_Multiply;

ARCHITECTURE CONNECTIONS of RODR_Multiply IS

BEGIN

	
END CONNECTIONS;