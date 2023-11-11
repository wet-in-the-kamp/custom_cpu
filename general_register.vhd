library ieee;
use ieee.std_logic_1164.all;

entity general_register is 
port(
	--Clk and Reset 
	Clk:				in std_logic;
	Reset:			in std_logic;
	
	--To/from bus
	busOut:			out std_logic_vector(31 downto 0);
	busIn:			in std_logic_vector(31 downto 0);
	
	--Control signals
	--No out signal needed, constantly output to bus, mux handles it
	register_in:	in std_logic
	
);
end entity general_register;

architecture Descr of general_register is

--Register
signal iValue: 	std_logic_vector(31 downto 0);


begin

busOut <= iValue; --always output to the bus

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