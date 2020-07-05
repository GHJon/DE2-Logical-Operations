library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

ENTITY RODR_Comparator is
GENERIC (nbits : INTEGER := 4);
PORT ( RODR_a : IN STD_LOGIC_VECTOR (nbits-1 downto 0);
       RODR_b : IN STD_LOGIC_VECTOR (nbits-1 downto 0);
       RODR_sw : IN STD_Logic;
       RODR_less : OUT STD_LOGIC ;
       RODR_equal : OUT STD_LOGIC);
END RODR_Comparator;

architecture Behavioral of RODR_Comparator is
  
  Component RODR_1BitComp
  port (RODR_I0, RODR_I1, prevL, prevE : in std_logic ;
        lessFlag, equalFlag  : out std_logic);   
  end Component RODR_1BitComp;

  signal lessVector : std_logic_vector(nbits downto 0); -- Vector not only to hold comparison bits but also LSB being the flag
  signal equalVector : std_logic_vector(nbits downto 0);
  
  begin

    lessVector(nbits) <= '0';  --Start of check for equality for less and Equal Vectors
    equalVector(nbits) <= '1';
    
  gen: for i in 0 to nbits-1 generate
  biti: RODR_1BitComp port map ( RODR_I0 => RODR_a(i),
                                 RODR_I1 => RODR_b(i),
                                 prevL => lessVector(i+1),
                                 prevE => equalVector(i+1),  
                                 lessFlag => lessVector(i), 
                                 equalFlag => equalVector(i));
  end generate gen;
--    RODR_less <= not lessVector(0) WHEN (RODR_sw = '1' AND (((RODR_a(nbits-1) XOR RODR_b(nbits-1)) = '1')))
--                                        OR (RODR_sw = '1' AND (RODR_a(nbits-1) = '0' AND RODR_b(nbits-1) = '1')) ELSE lessVector(0);
  
  process(RODR_sw, lessVector, equalVector)
  begin
  Case RODR_sw is
  When '0' =>
    RODR_equal <= equalVector(0);
    RODR_less  <= lessVector(0);
  When '1' =>
    RODR_equal <=  equalVector(0);
    if((RODR_a(nbits-1) XOR RODR_b(nbits-1)) = '1') OR (RODR_a(nbits-1) = '0' AND RODR_b(nbits-1) = '1') then
      RODR_less <= not lessVector(0);
    else
      RODR_less <= lessVector(0);
    end if;
  When others =>
  end case;
end process; 
end architecture Behavioral;
