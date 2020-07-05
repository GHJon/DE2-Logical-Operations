LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use IEEE.numeric_std.ALL;

	ENTITY RODR_RegisterArray IS
	generic(nbits : natural := 32);
	PORT(RODR_IN  : IN STD_LOGIC_VECTOR (nbits-1 downto 0);
		  RODR_Data: IN std_logic_vector (nbits-1 downto 0);
		  RODR_SET	   : in std_logic := '0';
		  RODR_Clear  : in std_logic;
		  RODR_Load	  : in std_logic := '0';
		  RODR_Clock : in std_logic;
		  RODR_DataCLK : in std_logic;
		  RODR_DataSEL : in std_logic_vector (2 downto 0);
	     output1  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output2  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output3  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output4  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output5  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output6  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output7  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0);
	     output8  : OUT STD_LOGIC_VECTOR (nbits-1 downto 0));
END RODR_RegisterArray ;


ARCHITECTURE LogicFunction OF RODR_RegisterArray IS

type RODR_RegInput is array (0 to 7) of std_logic_vector(nbits-1 downto 0);

signal r : RODR_RegInput := ((Others => '0'), (Others => '0') , (Others => '0') , (Others => '0'), (Others => '0') , (Others => '0') , (Others => '0') , (Others => '0'));
							
	Component RODR_NBit_Shift_Register
		generic(nbits : natural := nbits);
		Port (RODR_CLK : in STD_LOGIC;
				RODR_SET : in STD_LOGIC := '0';
				RODR_CLR : in STD_LOGIC;
				RODR_INS : in STD_LOGIC_VECTOR (7 downto 0) := (Others => '0');
				RODR_INP : in std_LOGIC_VECTOR (nbits-1 downto 0) := (Others => '0');
				Load		: in std_logic := '0';
				RODR_OUT : out STD_LOGIC_VECTOR (nbits-1 downto 0));
	END Component;
			
	signal RODR_OPCODE : std_logic_vector(5 downto 0);
	signal RODR_RS : std_logic_vector(4 downto 0);
	signal RODR_RT: std_logic_vector(4 downto 0);
	signal RODR_RD: std_logic_vector(4 downto 0);
	signal RODR_SHAMT: std_logic_vector(4 downto 0);
	signal RODR_FUNCT: std_logic_vector(5 downto 0);
	signal RODR_IMMEDIATE : std_logic_vector(31 downto 0) := (others => '0');
--	signal RODR_ADDRESS: std_logic_vector(25 downto 0);
	signal RODR_tempData : std_logic_vector(nbits-1 downto 0);
	signal RODR_MultData: integer := 0;
	
BEGIN
			Register1  : RODR_NBit_Shift_Register PORT MAP(RODR_Clock, open, RODR_Clear, open, r(0), '0', output1); 
			Register2  : RODR_NBit_Shift_Register PORT MAP(RODR_Clock, open, RODR_Clear, open, r(1), '0', output2); 
			Register3  : RODR_NBit_Shift_Register PORT MAP(RODR_Clock, open, RODR_Clear, open, r(2), '0', output3); 
			Register4  : RODR_NBit_Shift_Register PORT MAP(RODR_Clock, open, RODR_Clear, open, r(3), '0', output4); 
			Register5  : RODR_NBit_Shift_Register PORT MAP(RODR_Clock, open, RODR_Clear, open, r(4), '0', output5); 
			Register6  : RODR_NBit_Shift_Register PORT MAP(RODR_Clock, open, RODR_Clear, open, r(5), '0', output6); 
			Register7  : RODR_NBit_Shift_Register PORT MAP(RODR_Clock, open, RODR_Clear, open, r(6), '0', output7); 
			Register8  : RODR_NBit_Shift_Register PORT MAP(RODR_Clock, open, RODR_Clear, open, r(7), '0', output8);
			
			RODR_OPCODE <= RODR_IN(nbits-1 downto nbits-6);
			RODR_RS <= RODR_IN(nbits-7 downto nbits-11);
			RODR_RT <= RODR_IN(nbits-12 downto nbits-16);
			RODR_RD <= RODR_IN(nbits-17 downto nbits-21);
			RODR_SHAMT <= RODR_IN(nbits-22 downto nbits-26);
			RODR_FUNCT <= RODR_IN(nbits-27 downto nbits-32);
		   RODR_IMMEDIATE <= std_logic_vector(resize(unsigned(RODR_IN(nbits-17 downto nbits-32)), RODR_IMMEDIATE'length));
--	      RODR_ADDRESS <= RODR_IN(nbits-7 downto nbits-32);
			RODR_tempData <= RODR_Data;



	process(RODR_MultData, r, RODR_OPCODE, RODR_RS, RODR_RT, RODR_RD, RODR_SHAMT, RODR_FUNCT, RODR_IMMEDIATE, RODR_Clock, RODR_tempData, RODR_DataSEL, RODR_DataCLK)	-- STORAGE OF INPUTS INTO REGISTER
	variable temp : std_logic_vector(63 downto 0);
	variable tempOUT : std_logic_Vector(31 downto 0);
	variable remOUT : std_logic_vector(31 downto 0);
	variable temp1 : std_logic_vector(63 downto 0);
	variable temp2 : std_logic_vector(63 downto 0);
	BEGIN
	if(rising_edge(RODR_Clock)) then
		if(RODR_DataCLK = '1') then
			case RODR_DataSEL is 
				when "000" =>
					r(0) <= RODR_tempData;
					
				when "001" =>
					r(1) <= RODR_tempData;
					
				when "010" =>
					r(2) <= RODR_tempData;
				
				when "011" =>
					r(3) <= RODR_tempData;
				
				when "100" =>
					r(4) <= RODR_tempData;
				
				when "101" =>
					r(5) <= RODR_tempData;
				
				when "110" =>
					r(6) <= RODR_tempData;
				
				when "111" =>	
					r(7) <= RODR_tempData;
				
				when others =>
					null;
			end case;
		elsif(RODR_DataCLK = '0') then 
			if(RODR_OPCODE = "000000") then
				case RODR_FUNCT is 
					when "000001" => -- not (1 HEX)
						r(to_integer(unsigned(RODR_RD))) <= not r(to_integer(unsigned(RODR_RS)));
					
					when "100100" => -- AND (24 HEX)
						r(to_integer(unsigned(RODR_RD))) <= r(to_integer(unsigned(RODR_RS))) AND r(to_integer(unsigned(RODR_RT)));
			
					when "100111" => -- NOR (27 HEX)
						r(to_integer(unsigned(RODR_RD))) <= r(to_integer(unsigned(RODR_RS))) NOR r(to_integer(unsigned(RODR_RT)));				
					when "100101" => -- OR  (25 HEX)
						r(to_integer(unsigned(RODR_RD))) <= r(to_integer(unsigned(RODR_RS))) OR r(to_integer(unsigned(RODR_RT)));				
					when "100110" => -- XOR (26 HEX)
						r(to_integer(unsigned(RODR_RD))) <= r(to_integer(unsigned(RODR_RS))) XOR r(to_integer(unsigned(RODR_RT)));				
					when "000000" => -- Shift Left (0 HEX)
						r(to_integer(unsigned(RODR_RD))) <= to_stdlogicvector(to_bitvector(r(to_integer(unsigned(RODR_RT)))) sll to_integer(unsigned(RODR_SHAMT)));
				
					when "000010" => -- Shift Right (2 HEX)
						r(to_integer(unsigned(RODR_RD))) <= to_stdlogicvector(to_bitvector(r(to_integer(unsigned(RODR_RT)))) srl to_integer(unsigned(RODR_SHAMT)));				
					when "000111" => -- Rotate Left (7 HEX)
						r(to_integer(unsigned(RODR_RD))) <= to_stdlogicvector(to_bitvector(r(to_integer(unsigned(RODR_RT)))) rol to_integer(unsigned(RODR_SHAMT)));
				
					when "001000" => -- Rotate Right (8 HEX)
						r(to_integer(unsigned(RODR_RD))) <= to_stdlogicvector(to_bitvector(r(to_integer(unsigned(RODR_RT)))) ror to_integer(unsigned(RODR_SHAMT)));
				
					when "101010" =>	-- slt (2A HEX)
						if(r(to_integer(unsigned(RODR_RS))) < r(to_integer(unsigned(RODR_RT)))) then
							r(to_integer(unsigned(RODR_RD))) <= "00000000000000000000000000000001";
						else
							r(to_integer(unsigned(RODR_RD))) <= "00000000000000000000000000000000";
						end if;
					when "101011" => -- sltu (2B HEX)
						if(r(to_integer(unsigned(RODR_RS))) < r(to_integer(unsigned(RODR_RT)))) then
							r(to_integer(unsigned(RODR_RD))) <= "00000000000000000000000000000001";
						else
							r(to_integer(unsigned(RODR_RD))) <= "00000000000000000000000000000000";
						end if;
					when "001011" => -- slts (B HEX)
						if(signed(r(to_integer(unsigned(RODR_RS)))) < signed(r(to_integer(unsigned(RODR_RT))))) then
							r(to_integer(unsigned(RODR_RD))) <= "00000000000000000000000000000001";
						else
							r(to_integer(unsigned(RODR_RD))) <= "00000000000000000000000000000000";
						end if;
					when "111111" => -- Multiply (3F HEX)
					
						RODR_MultData <= to_integer(unsigned(r(to_integer(unsigned(RODR_RS))))) * to_integer(unsigned(r(to_integer(unsigned(RODR_RT)))));
						temp := std_logic_vector(to_unsigned(RODR_MultData, 64));
						r(to_integer(unsigned(RODR_RD))) <= temp(31 downto 0);
						r(to_integer(unsigned(RODR_RD))+1) <= temp(63 downto 32);
					
					when "111110" => -- Divide (3E HEX)
						temp1 := std_logic_vector(resize(unsigned( r(to_integer(unsigned(RODR_RS))) ), temp1'length));
						temp2 := std_logic_vector(resize(unsigned( r(to_integer(unsigned(RODR_RS))) ), temp2'length));
						temp2 := to_stdlogicvector(to_bitvector(temp2) sll 31);
						
						for i in 31 downto 0 loop
							if(temp1 < temp2) then
								tempOUT(i) := '0';
								temp2 := to_stdlogicvector(to_bitvector(temp2) srl 1);
							elsif(temp1 > temp2) then
								tempOUT(i) := '1';
								temp1 := temp1 - temp2;

								temp2 := to_stdlogicvector(to_bitvector(temp2) srl 1);
							end if;
							remOUT := temp1(31 downto 0);
							r(to_integer(unsigned(RODR_RD))) <= tempOUT;
							r(to_integer(unsigned(RODR_RD))+1) <= remOUT;
						end loop;
						
					when others =>
						null;
				
				end case;
			elsif (RODR_OPCODE /= "000000") then
				case RODR_OPCODE is 
					when "001100" => -- AND IMMEDIATE (C HEX)
						r(to_integer(unsigned(RODR_RT))) <= r(to_integer(unsigned(RODR_RS))) AND RODR_IMMEDIATE;
					when "001101" => -- OR IMMEDIATE (D HEX)
						r(to_integer(unsigned(RODR_RT))) <= r(to_integer(unsigned(RODR_RS))) OR RODR_IMMEDIATE;
					when "001010" => -- slti (A HEX)
						if(r(to_integer(unsigned(RODR_RS))) < RODR_IMMEDIATE) then
							r(to_integer(unsigned(RODR_RT))) <= "00000000000000000000000000000001";
						else
							r(to_integer(unsigned(RODR_RT))) <= "00000000000000000000000000000000";
						end if;
					when "001011" =>	-- sltiu (B HEX)
						if(unsigned(r(to_integer(unsigned(RODR_RS)))) < unsigned(RODR_IMMEDIATE)) then
							r(conv_integer(RODR_RT)) <= "00000000000000000000000000000001";
						else
							r(conv_integer(RODR_RT)) <= "00000000000000000000000000000000";
						end if;
					when "000001" =>	-- sltiu (1 HEX)
						if(signed(r(to_integer(unsigned(RODR_RS)))) < signed(RODR_IMMEDIATE)) then
							r(to_integer(unsigned(RODR_RT))) <= "00000000000000000000000000000001";
						else
							r(to_integer(unsigned(RODR_RT))) <= "00000000000000000000000000000000";
						end if;	
				
					when others =>
						null;
				
				end case;
			end if;
		end if;
	end if;
	end process;
END LogicFunction;