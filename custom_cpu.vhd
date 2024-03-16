library ieee;
use ieee.std_logic_1164.all;

entity custom_cpu is 
port(
	Clk:				in std_logic;
	Reset:			in std_logic;
	Output:   		out std_logic_vector(31 downto 0)
);
end entity custom_cpu;

architecture Descr of custom_cpu is

--Internal signals:
signal ipc_out:	  std_logic_vector(15 downto 0);
signal ipc_in:		  std_logic_vector(15 downto 0);
signal i_c_pc_in:   std_logic;
signal i_c_pc_en:   std_logic;
signal ia_out:		  std_logic_vector(31 downto 0);
signal ia_in:		  std_logic_vector(31 downto 0);
signal i_c_a_in:    std_logic;
signal ib_out:		  std_logic_vector(31 downto 0);
signal ib_in:		  std_logic_vector(31 downto 0);
signal i_c_b_in:    std_logic;
signal iout_in:	  std_logic_vector(31 downto 0);
signal i_c_out_in:  std_logic;
signal ialu_out:	  std_logic_vector(31 downto 0);
signal i_c_asn:	  std_logic;
signal i_f_npn:	  std_logic;
signal i_f_zero:	  std_logic;
signal imar_in:	  std_logic_vector(15 downto 0);
signal i_c_mar_in:  std_logic;
signal imar_ram:	  std_logic_vector(15 downto 0);
signal iir_out:	  std_logic_vector(15 downto 0);
signal iir_in:		  std_logic_vector(31 downto 0);
signal iir_decode:  std_logic_vector(15 downto 0);
signal i_c_ir_in:   std_logic;
signal iram_in:	  std_logic_vector(31 downto 0);
signal i_c_wren:    std_logic;
signal iram_out:	  std_logic_vector(31 downto 0);
signal i_c_pc_out:  std_logic;
signal i_c_a_out:   std_logic;
signal i_c_b_out:   std_logic;
signal i_c_alu_out: std_logic;
signal i_c_ram_out: std_logic;
signal i_c_ir_out:  std_logic;

-- All components:

component pc is 
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
end component pc;

component general_register is 
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
end component general_register;

component output_register is 
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
end component output_register;

component alu is 
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
end component alu;

component mar is 
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
end component mar;

component ir is 
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
end component ir;

component ram is
port(
	address: in std_logic_vector (12 DOWNTO 0);
	clock: 	in std_logic  := '1';
	data: 	in std_logic_vector (31 DOWNTO 0);
	wren: 	in std_logic;
	q: 		out std_logic_vector (31 DOWNTO 0)
);
end component ram;

component my_bus is 
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
end component my_bus;

component instr_d is 
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
end component instr_d;

begin

c_pc: pc port map( Clk				=> Clk,
						 Reset			=> Reset,
						 busOut			=> ipc_out,
						 busIn			=> ipc_in,
						 pc_in			=> i_c_pc_in,
						 pc_enable		=> i_c_pc_en
						);

c_a_reg: general_register port map( Clk				=> Clk,
												Reset			   => Reset,
												busOut			=> ia_out,
												busIn 			=> ia_in,
												register_in 	=> i_c_a_in
											 );
											 
c_b_reg: general_register port map( Clk				=> Clk,
												Reset			   => Reset,
												busOut			=> ib_out,
												busIn 			=> ib_in,
												register_in 	=> i_c_b_in
											 );

c_out_reg: output_register port map( Clk				=> Clk,
												 Reset		   => Reset,
												 busIn			=> iout_in,
												 dataOut			=> Output,
												 register_in	=> i_c_out_in
												);
												
c_alu: alu port map( Clk				=> Clk,
							Reset		      => Reset,
							busOut			=> ialu_out,
							aIn				=> ia_out,
							bIn				=> ib_out,
							add_sub_n		=> i_c_asn,
							neg_pos_n		=> i_f_npn,
							zero				=> i_f_zero
						 );
						 
c_mar: mar port map( Clk				=> Clk,
							Reset		      => Reset,
							busIn			   => imar_in,
							register_in	   => i_c_mar_in,
							ramOut			=> imar_ram
						 );
						 
c_ir: ir port map( Clk				=> Clk,
						 Reset		   => Reset,
						 busOut			=> iir_out,
						 busIn			=> iir_in,
						 decodeOut		=> iir_decode,
						 register_in	=> i_c_ir_in
						);
						
c_ram: ram port map( address			=> imar_ram(12 downto 0),
							clock				=> Clk,
							data				=> iram_in,
							wren				=> i_c_wren,
							q					=> iram_out
						 );
						 
c_my_bus: my_bus port map( pc_data_in		=> ipc_in,
									pc_data_out		=> ipc_out,
									a_data_in		=> ia_in,
									a_data_out		=> ia_out,
									b_data_in		=> ib_in,
									b_data_out		=> ib_out,
									alu_data_out	=> ialu_out,
									output_data_in => iout_in,
									mar_data_in		=> imar_in,
									ram_data_in		=> iram_in,
									ram_data_out	=> iram_out,
									ir_data_in		=> iir_in,
									ir_data_out		=> iir_out,
									pc_in				=> i_c_pc_in,       
									pc_out			=> i_c_pc_out,   
									a_in				=> i_c_a_in,	  
									a_out				=> i_c_a_out,	  
									b_in				=> i_c_b_in, 
									b_out				=> i_c_b_out,
									output_in		=> i_c_out_in, 
									alu_out			=> i_c_alu_out,
									mar_in			=> i_c_mar_in,
									ram_wren			=> i_c_wren,
									ram_out			=> i_c_ram_out,
									ir_in				=> i_c_ir_in, 
									ir_out			=> i_c_ir_out	
								 );
								 
c_instr_d: instr_d port map( Clk				=> Clk,
									  Reset			=> Reset,
									  IRin			=> iir_decode,
									  neg_pos_n		=> i_f_npn,
									  zero			=> i_f_zero,
									  pc_in			=> i_c_pc_in,
									  pc_enable		=> i_c_pc_en,
									  pc_out			=> i_c_pc_out,
									  a_in			=> i_c_a_in,
									  a_out			=> i_c_a_out,
									  b_in			=> i_c_b_in,
									  b_out			=> i_c_b_out,
									  add_sub_n		=> i_c_asn,
									  alu_out		=> i_c_alu_out,
									  output_in		=> i_c_out_in,
									  mar_in			=> i_c_mar_in,
									  ram_wren		=> i_c_wren,
									  ram_out		=> i_c_ram_out,
									  ir_in			=> i_c_ir_in,
									  ir_out			=> i_c_ir_out
									 );
																	 
end architecture Descr;
