library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

--------------------------------------------------------

entity RODR_MultAccum is

	generic(nbits: natural := 32);
port(	RODR_A:	in std_logic_vector(nbits-1 downto 0);
		RODR_B:	in std_logic_vector(nbits-1 downto 0);
		RODR_overflow:	out std_logic;
		RODR_CIN : in std_logic := '0';
		RODR_sum:	out std_logic_vector(nbits+31 downto 0);
		RODR_Clock : in std_logic;
		RODR_CLR: in std_logic);

end RODR_MultAccum;

--------------------------------------------------------

architecture LogicFunction of RODR_MultAccum is
-- define a temparary signal to store the result

signal result: std_logic_vector(nbits+96 downto 0);		-- Extra bit to accomodate for overflow
signal addsubflag : std_logic_vector (nbits-1 downto 0);
signal temp : std_logic_vector(nbits+96 downto 0);

signal tempA: std_logic_vector(nbits-1 downto 0);
signal tempB: std_logic_vector(nbits-1 downto 0);

signal temp2: std_logic_vector(nbits-1 downto 0);
begin
	addsubflag <= (Others => RODR_CIN);
	tempA <= RODR_A;
	tempB <= RODR_B;
	
	process(RODR_Clock, RODR_CLR, temp, tempA, tempB, addsubflag, RODR_CIN, result)
	begin 
		if(RODR_CLR = '1') then
			temp <= (Others => '0');
			result <= (Others => '0');
		elsif(rising_edge(RODR_Clock)) then
			temp <= result;
			temp2 <= ((tempB XOR addsubflag) + RODR_CIN);
			result <= ('0' & temp(nbits+31 downto 0)) * std_logic_vector(resize(unsigned(temp2), 64));
		end if;
			RODR_sum <= result(nbits+31 downto 0);
	end process;
end LogicFunction;