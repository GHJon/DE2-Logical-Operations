LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

Entity RODR_MASTERMAP IS
	generic(N : natural := 32);
	
	PORT(RODR_InstRegIN : in std_logic_vector(N-1 downto 0);
		  RODR_Data: in std_logic_vector(N-1 downto 0);
		  RODR_InstRegCLK   : in std_logic;
		  RODR_RegArrCLK   : in std_logic;
		  RODR_SWDataCLK   : in std_logic;
		  RODR_CLRBUT   : in std_logic;
		  RODR_RegSel   : in std_logic_vector(2 downto 0);
		  RODR_BUTData_SEL : in std_logic_vector(2 downto 0);
		  RODR_RegSelBut   : in std_logic;
		  RODR_Output: out std_logic_vector(N-1 downto 0));
			  
END RODR_MASTERMAP;

ARCHITECTURE CONNECTIONS of RODR_MASTERMAP IS
	Component RODR_InstructionReg IS
		generic(nbits : natural := N);
		PORT(RODR_IN  : in std_logic_vector (nbits-1 downto 0);
		  RODR_CLK : in std_logic;
		  RODR_CLR : in std_logic;
		  RODR_OUT : out std_logic_vector (nbits-1 downto 0));
	END Component;
	
	Component RODR_RegisterArray IS
		generic(nbits : natural := N);
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
	END Component ;
	
	signal RODR_InstructionRegOut : std_logic_vector(N-1 downto 0);
	signal RODR_out1 : std_logic_vector(N-1 downto 0);
	signal RODR_out2 : std_logic_vector(N-1 downto 0);
	signal RODR_out3 : std_logic_vector(N-1 downto 0);
	signal RODR_out4 : std_logic_vector(N-1 downto 0);
	signal RODR_out5 : std_logic_vector(N-1 downto 0);
	signal RODR_out6 : std_logic_vector(N-1 downto 0);
	signal RODR_out7 : std_logic_vector(N-1 downto 0);
	signal RODR_out8 : std_logic_vector(N-1 downto 0);
BEGIN

uut1: RODR_InstructionReg PORT MAP(RODR_InstRegIN, RODR_InstRegCLK, RODR_CLRBUT, RODR_InstructionRegOut);
uut2: RODR_RegisterArray  PORT MAP(RODR_InstructionRegOut, RODR_Data, open, RODR_CLRBUT, open, RODR_RegArrCLK, RODR_SWDataCLK, RODR_BUTData_SEL, RODR_out1, RODR_out2, RODR_out3,
											  RODR_out4, RODR_out5, RODR_out6, RODR_out7, RODR_out8);
											  
process(RODR_out1, RODR_out2, RODR_out3, RODR_out4, RODR_out5, RODR_out6, RODR_out7, RODR_out8, RODR_RegSel, RODR_RegSelBut)
begin
	if(rising_edge(RODR_RegSelBut)) then
		case RODR_RegSel is 
			when "000" =>
				RODR_Output <= RODR_out1;
					
			when "001" =>
				RODR_Output <= RODR_out2;
					
			when "010" =>
				RODR_Output <= RODR_out3;
				
			when "011" =>
				RODR_Output <= RODR_out4;
				
			when "100" =>
				RODR_Output <= RODR_out5;
				
			when "101" =>
				RODR_Output <= RODR_out6;
				
			when "110" =>
				RODR_Output <= RODR_out7;
				
			when "111" =>	
				RODR_Output <= RODR_out8;
				
			when others =>
				null;
				
		end case;
	end if;
end process;
	
END CONNECTIONS;