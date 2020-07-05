LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all;

	ENTITY RODR_OPS IS
	generic(nbits : natural := 32);
	PORT(RODR_Input1 : in std_logic_vector (nbits-1 downto 0);
		  RODR_Input2 : in std_logic_vector (nbits-1 downto 0);
		  RODR_OP	  : in std_logic_vector (2 downto 0);
		  RODR_Key	  : in std_logic;
		  RODR_Output : out std_logic_vector (nbits-1 downto 0));
		  
	END RODR_OPS ;

ARCHITECTURE LogicFunction OF RODR_OPS IS
signal RODR_IN1: std_logic_vector (5 downto 0);
signal RODR_IN2: std_logic_vector (5 downto 0);
signal RODR_out: std_logic_vector (5 downto 0);

begin 

	
RODR_IN1 <= RODR_Input1;
RODR_IN2 <= RODR_Input2;
RODR_Output <= RODR_out;

process(RODR_IN1, RODR_IN2, RODR_Key, RODR_OP)
begin
	if(rising_edge(RODR_Key)) then
		case RODR_OP is 
			when "000" =>
				RODR_out <= not RODR_IN1;
			when "001" =>
				RODR_out <= RODR_IN1 AND RODR_IN2;
			when "010" =>
				RODR_out <= RODR_IN1 OR RODR_IN2;
			when "011" =>
				RODR_out <= RODR_IN1 XOR RODR_IN2;
			when "100" =>
				RODR_out <= to_stdlogicvector(to_bitvector(RODR_IN1) sll 1);
			when "101" =>
				RODR_out <= to_stdlogicvector(to_bitvector(RODR_IN1) srl 1);
			when "110" =>
				RODR_out <= to_stdlogicvector(to_bitvector(RODR_IN1) rol 1);
			when "111" =>
				RODR_out <= to_stdlogicvector(to_bitvector(RODR_IN1) ror 1);
			when others =>
				null;
		end case;
	end if;
end process;
END LogicFunction;