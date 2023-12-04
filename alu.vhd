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
	neg_pos_n:		out std_logic; --when high, negative result, when low positive
	zero:				out std_logic --high when result is zero
	
);
end entity alu;

architecture Descr of alu is

--Register
signal iSum: 			std_logic_vector(31 downto 0);


begin

busOut 		<= iSum; --always output to the bus
neg_pos_n  	<= iSum(31); --two's complement

pCalc:
	process(Clk, Reset)
	begin
		if Reset = '1' then
			iSum <= (others=> '0');		
		elsif rising_edge(Clk) then
			if add_sub_n = '1' then
				iSum <= std_logic_vector(signed(aIn) + signed(bIn));
			else
				iSum <= std_logic_vector(signed(aIn) - signed(bIn));
			end if;		
		end if;
	end process pCalc;
	
pZero:
	process(iSum)
	begin
		if iSum = X"00000000" then
			zero <= '1';
		else
			zero <= '0';
		end if;
	end process pZero;
		
end architecture Descr;