library ieee;
use ieee.std_logic_1164.all;

entity ir is 
port(
	--Clk and Reset 
	Clk:				in std_logic;
	Reset:			in std_logic;
	
	--To/from bus
	busOut:			out std_logic_vector(15 downto 0);
	busIn:			in std_logic_vector(31 downto 0);
	
	--To instruction decoder
	decodeOut:		out std_logic_vector(15 downto 0);
	
	--Control signals
	--No out signal needed, constantly output to bus, mux handles it
	register_in:	in std_logic
	
);
end entity ir;

architecture Descr of ir is

--Register
signal iValue: 	std_logic_vector(31 downto 0);


begin

busOut    <= iValue(15 downto 0); --always output LSB (operand) to the bus
decodeOut <= iValue(31 downto 16); --MSB (operator) to instruction decoder

pStore:
	process(Clk, Reset)
	begin
		if Reset = '1' then
			iValue <= X"00000000";		
		elsif rising_edge(Clk) then
			if register_in = '1' then
				iValue <= busIn;
			end if;		
		end if;
	end process pStore;
		
end architecture Descr;