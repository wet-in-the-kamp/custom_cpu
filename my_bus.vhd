library ieee;
use ieee.std_logic_1164.all;

entity my_bus is 
port(
	
	--Data lines
	pc_data_in:			out std_logic_vector(15 downto 0);
	pc_data_out:		in std_logic_vector(15 downto 0);
	a_data_in:			out std_logic_vector(31 downto 0);
	a_data_out:			in std_logic_vector(31 downto 0);
	b_data_in:			out std_logic_vector(31 downto 0);
	b_data_out:			in std_logic_vector(31 downto 0);
	alu_data_out:		in std_logic_vector(31 downto 0);
	output_data_in:	out std_logic_vector(31 downto 0);
	mar_data_in:		out std_logic_vector(15 downto 0);
	ram_data_in:		out std_logic_vector(31 downto 0);
	ram_data_out:		in std_logic_vector(31 downto 0);
	ir_data_in:			out std_logic_vector(31 downto 0);
	ir_data_out:		in std_logic_vector(15 downto 0);
	
	--Control signals
	pc_in:				in std_logic;        
	pc_out:				in std_logic;    
	a_in:					in std_logic;	  
	a_out:				in std_logic;	  
	b_in:					in std_logic;  
	b_out:				in std_logic;
	output_in:			in std_logic; 
	alu_out:				in std_logic;
	mar_in:				in std_logic;	
	ram_wren:			in std_logic;
	ram_out:				in std_logic; 
	ir_in:				in std_logic;	 
	ir_out:				in std_logic	
	
);
end entity my_bus;

architecture Descr of my_bus is

signal iBus: std_logic_vector(31 downto 0);
signal iOutSignals: std_logic_vector(5 downto 0);
signal iInSignals: std_logic_vector(6 downto 0);

begin

iOutSignals <= pc_out & a_out & b_out & alu_out & ram_out & ir_out;
iInSignals <= pc_in & a_in & b_in & output_in & mar_in & ram_wren & ir_in;
	
--This process takes inputs and puts them on the bus
pInputData:
	process(iOutSignals, ir_data_out, ram_data_out, alu_data_out, b_data_out, a_data_out, pc_data_out)
	begin
		case iOutSignals is
			when B"000001" => iBus(15 downto 0)  <= ir_data_out;
									iBus(31 downto 16) <= (others => '0'); 
			when B"000010" => iBus <= ram_data_out;
			when B"000100" => iBus <= alu_data_out;
			when B"001000" => iBus <= b_data_out;
			when B"010000" => iBus <= a_data_out;
			when B"100000" => iBus(15 downto 0)  <= pc_data_out;
									iBus(31 downto 16) <= (others => '0');
			when others => iBus <= X"00000000";
		end case;
	end process pInputData;

--This process takes the bus and outputs it to the correct component
pOutputData:
	process(iInSignals, iBus)
	begin
		case iInSignals is
			when B"0000001" => ir_data_in <= iBus;
			when B"0000010" => ram_data_in <= iBus;
			when B"0000100" => mar_data_in <= iBus(15 downto 0);
			when B"0001000" => output_data_in <= iBus;
			when B"0010000" => b_data_in <= iBus;
			when B"0100000" => a_data_in <= iBus;
			when B"1000000" => pc_data_in <= iBus(15 downto 0);
			when others => null;
		end case;
	end process pOutputData;
		
end architecture Descr;