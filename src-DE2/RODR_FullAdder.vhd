library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity RODR_FullAdder is
 Port ( RODR_A : in STD_LOGIC;
		  RODR_B : in STD_LOGIC;
      RODR_Cin : in STD_LOGIC;
		RODR_S   : out STD_LOGIC;
     RODR_Cout : out STD_LOGIC);
end RODR_FullAdder;
 
architecture LogicFunction of RODR_FullAdder is
 
begin
 
 RODR_S <= RODR_A XOR RODR_B XOR RODR_Cin ;
 RODR_Cout <= (RODR_A AND RODR_B) OR (RODR_Cin AND RODR_A) OR (RODR_Cin AND RODR_B);
 
end LogicFunction;