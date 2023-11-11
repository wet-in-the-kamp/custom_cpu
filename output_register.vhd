library ieee;
use ieee.std_logic_1164.all;

entity output_register is 
port(
	--Clk and Reset 
	Clk:				in std_logic;
	Reset:			in std_logic;
	
	--To/from bus
	busIn:			in std_logic_vector(31 downto 0);
	
	--Output
	dataOut:			out std_logic_vector(31 downto 0);
	
	--Control signals
	register_in:	in std_logic
	
);
end entity output_register;

architecture Descr of output_register is

--Register
signal iValue: 	std_logic_vector(31 downto 0);


begin

dataOut <= iValue; --to LED matrix

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