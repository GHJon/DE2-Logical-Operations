library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

ENTITY RODR_1BitComp is
port (RODR_I0 : IN std_logic ;
      RODR_I1 : IN std_logic ;
      prevL : IN std_logic ;  --Takes previous state of Less flag
      prevE : IN std_logic ; --Takes previous state of Equal flag
      lessFlag : OUT std_logic ;
      equalFlag : OUT std_logic );
END RODR_1BitComp;

ARCHITECTURE Behavioral OF RODR_1BitComp IS
signal check1, check2: std_logic;
 begin
    check1  <= RODR_I0 XNOR RODR_I1;
    check2 <= (RODR_I1 and (not RODR_I0));

    equalFlag <= (prevE and check1);
    lessFlag  <= (prevL or(prevE and check2));

end Behavioral;
