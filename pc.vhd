library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is 
port(
	--Clk and Reset 
	Clk:				in std_logic;
	Reset:			in std_logic;
	
	--To/from bus
	busOut:			out std_logic_vector(15 downto 0);
	busIn:			in std_logic_vector(15 downto 0);
	
	--Control signals
	--pc_out excluded, only needed for the bus logic
	pc_in:			in std_logic;
	pc_enable:		in std_logic
	
);
end entity pc;

architecture Descr of pc is

--Register
signal iPCValue: 	  std_logic_vector(15 downto 0);


begin

busOut <= iPCValue; --always output to the bus

pCount:
	process(Clk, Reset)
	begin
		if Reset = '1' then
			iPCValue <= X"0000";		
		elsif rising_edge(Clk) then
			if pc_in = '1' then
				iPCValue <= busIn;
			elsif pc_enable = '1' then
				iPCValue <= std_logic_vector(unsigned(iPCValue) + 1); --increment counter
			end if;		
		end if;
	end process pCount;
		
end architecture Descr;