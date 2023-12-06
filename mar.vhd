library ieee;
use ieee.std_logic_1164.all;

entity mar is 
port(
	--Clk and Reset 
	Clk:				in std_logic;
	Reset:			in std_logic;
	
	--To/from bus
	--no bus output for MAR
	busIn:			in std_logic_vector(15 downto 0);
	
	--Control signals
	register_in:	in std_logic;
	
	--To RAM
	ramOut:			out std_logic_vector(15 downto 0)
	
);
end entity mar;

architecture Descr of mar is

--Register
signal iValue: 	std_logic_vector(15 downto 0);


begin

ramOut <= iValue; --always output to RAM

pStore:
	process(Clk, Reset)
	begin
		if Reset = '1' then
			iValue <= X"0000";		
		elsif rising_edge(Clk) then
			if register_in = '1' then
				iValue <= busIn;
			end if;		
		end if;
	end process pStore;
		
end architecture Descr;