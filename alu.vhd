library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is 
port(
	--Clk and Reset 
	Clk:				in std_logic;
	Reset:			in std_logic;
	
	--From bus
	busOut:			out std_logic_vector(31 downto 0);
	
	--From registers
	aIn:				in std_logic_vector(31 downto 0);
	bIn:				in std_logic_vector(31 downto 0);
	
	--Control signals
	add_sub_n:		in std_logic; --when high, add when low, subtract
	
	--Flags
	carry:			out std_logic
	
);
end entity alu;

architecture Descr of alu is

--Register
signal iSum: 			std_logic_vector(32 downto 0);
signal iAextend:		std_logic_vector(32 downto 0);
signal iBextend:		std_logic_vector(32 downto 0);


begin

busOut 		<= iSum(31 downto 0); --always output to the bus
carry  		<= iSum(32);
iAextend		<= "0" & aIn; --extend the signal with an extra bit
iBextend		<= "0" & bIn;

pCalc:
	process(Clk, Reset)
	begin
		if Reset = '1' then
			iSum <= B"0" & X"00000000"; --33 bit value through concatenation		
		elsif rising_edge(Clk) then
			if add_sub_n = '1' then
				iSum <= std_logic_vector(unsigned(iAextend) + unsigned(iBextend));
			else
				iSum <= std_logic_vector(signed(iAextend) - signed(iBextend));
			end if;		
		end if;
	end process pCalc;
		
end architecture Descr;