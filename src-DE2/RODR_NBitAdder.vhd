library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RODR_NBitAdder is
generic (nbits : integer := 32);
port( RODR_A : in std_logic_vector(nbits-1 downto 0);
		RODR_B : in std_logic_vector(nbits-1 downto 0);
		RODR_S : out std_logic_vector(nbits downto 0));
end RODR_NBitAdder;

Architecture LogicFunction of RODR_NBitAdder is
begin
	RODR_S <= std_logic_vector(('0' & unsigned(RODR_A)) + unsigned(RODR_B));
end LogicFunction;