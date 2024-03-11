library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instr_d is 
port(
	--Clk and Reset 
	Clk:				in std_logic;
	Reset:			in std_logic;
	
	--From Instruction Register
	IRin:				in std_logic_vector(15 downto 0);
	
	--Flags from ALU
	neg_pos_n:		in std_logic;
	zero:				in std_logic;
	
	--Control signals out
	pc_in:			out std_logic;
	pc_enable:		out std_logic;
	pc_out:			out std_logic;
	a_in:				out std_logic;
	a_out:			out std_logic;
	b_in:				out std_logic;
	b_out:			out std_logic;
	add_sub_n:		out std_logic;
	alu_out:			out std_logic;
	output_in:		out std_logic;
	mar_in:			out std_logic;
	ram_wren:		out std_logic;
	ram_out:			out std_logic;
	ir_in:			out std_logic;
	ir_out:			out std_logic
	
);
end entity instr_d;

architecture Descr of instr_d is

--Counter value
signal iCount: 	  std_logic_vector(2 downto 0);

--Control word
signal iControl:	  std_logic_vector(14 downto 0);


begin

	pc_in 		<= iControl(14);
	pc_enable 	<= iControl(13);
	pc_out 		<= iControl(12);
	a_in 			<= iControl(11);
	a_out 		<= iControl(10);
	b_in 			<= iControl(9);
	b_out 		<= iControl(8);
	add_sub_n 	<= iControl(7);
	alu_out 		<= iControl(6);
	output_in 	<= iControl(5);
	mar_in 		<= iControl(4);
	ram_wren 	<= iControl(3);
	ram_out 		<= iControl(2);
	ir_in 		<= iControl(1);
	ir_out 		<= iControl(0);

pControl:
	process(iCount, IRin, neg_pos_n, zero)
	begin
		case iCount is
			when B"000" => iControl <= B"001000000010000";
			when B"001" => iControl <= B"010000000000110";
			when B"010" => 
				case IRin is
					when X"0000" => iControl <= B"000000000000000"; --NOP
					when X"0001" => iControl <= B"000000000010001"; --LDA
					when X"0002" => iControl <= B"000000010010001"; --ADD
					when X"0003" => iControl <= B"000000000010001"; --SUB
					when X"0004" => iControl <= B"000000000010001"; --STA
					when X"0005" => iControl <= B"000100000000001"; --LDI
					when X"0006" => iControl <= B"100000000000001"; --JMP
					when X"0007" => iControl <= B"000010000100000"; --OUT
					when X"0008" => iControl <= B"000000000010001"; --LDB
					when X"0009" => if neg_pos_n = '1' then
											iControl <= B"100000000000001"; --JPN
										 else
											iControl <= B"000000000000000";
										 end if;
					when X"000A" => if zero = '1' then
											iControl <= B"100000000000001"; --JPZ
										 else
											iControl <= B"000000000000000";
										 end if;
					when others => iControl <= B"000000000000000";
				end case;
			when B"011" => 
				case IRin is
					when X"0000" => iControl <= B"000000000000000"; --NOP
					when X"0001" => iControl <= B"000100000000100"; --LDA
					when X"0002" => iControl <= B"000001010000100"; --ADD
					when X"0003" => iControl <= B"000001000000100"; --SUB
					when X"0004" => iControl <= B"000010000001000"; --STA
					when X"0005" => iControl <= B"000000000000000"; --LDI
					when X"0006" => iControl <= B"000000000000000"; --JMP
					when X"0007" => iControl <= B"000000000000000"; --OUT
					when X"0008" => iControl <= B"000001000000100"; --LDB
					when X"0009" => iControl <= B"000000000000000"; --JPN
					when X"000A" => iControl <= B"000000000000000"; --JPZ
					when others  => iControl <= B"000000000000000";
				end case;
			when B"100" => 
				case IRin is
					when X"0000" => iControl <= B"000000000000000"; --NOP
					when X"0001" => iControl <= B"000000000000000"; --LDA
					when X"0002" => iControl <= B"000100011000000"; --ADD
					when X"0003" => iControl <= B"000100001000000"; --SUB
					when X"0004" => iControl <= B"000000000000000"; --STA
					when X"0005" => iControl <= B"000000000000000"; --LDI
					when X"0006" => iControl <= B"000000000000000"; --JMP
					when X"0007" => iControl <= B"000000000000000"; --OUT
					when X"0008" => iControl <= B"000000000000000"; --LDB
					when X"0009" => iControl <= B"000000000000000"; --JPN
					when X"000A" => iControl <= B"000000000000000"; --JPZ
					when others  => iControl <= B"000000000000000";
					
				end case;
			when others => iControl <= B"000000000000000";
		end case;
	end process pControl;
	
pCount:
	process(Clk, Reset)
	begin
		if Reset = '1' then
			iCount <= B"000";		
		elsif rising_edge(Clk) then
			if unsigned(iCount) = 4 then
				iCount <= B"000";
			else
				iCount <= std_logic_vector(unsigned(iCount) + 1); 
			end if;
		end if;
	end process pCount;
		
end architecture Descr;