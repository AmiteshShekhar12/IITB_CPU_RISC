library ieee;
use ieee.std_logic_1164.all;

entity CPU is
	port(clk,reset: in std_logic; state_out: out std_logic_vector(4 downto 0));
end entity;

architecture struct of CPU is


	component state_transition is
		port(op_code: in std_logic_vector(3 downto 0);
				state: in std_logic_vector(4 downto 0);
				clk: in std_logic;
				reset: in std_logic;
				out_state: out std_logic_vector(4 downto 0);Mem_R, Mem_W, IR_W,IP_W, T1_W,T2_W,T3_W,RF_W : out std_logic);
	end component state_transition;
	
	component ALU is
		port(IP_in, T1_in, T2_in, SE6_in, LS_in: in std_logic_vector(15 downto 0);
				state:in std_logic_vector(4 downto 0);
				op_code: in std_logic_vector(3 downto 0);
				output_c: out std_logic_vector(15 downto 0);
				ALU_Z: out std_logic);
	end component;
	
	component SE6 is
		port(IR_0to5_in: in std_logic_vector(5 downto 0); SE6_out: out std_logic_vector(15 downto 0));
	end component SE6;
	
	component SE9 is
		port(IR_8to0_in: in std_logic_vector(8 downto 0); SE9_out: out std_logic_vector(15 downto 0));
	end component SE9;
	
	component LS is
		port (SE6_in,SE9_in: in std_logic_vector(15 downto 0); op_code:std_logic_vector(3 downto 0); LS_out : out std_logic_vector(15 downto 0));
	end component;
	
	component LZE is
		port(IR_0to7_in: in std_logic_vector(7 downto 0); LZE_out : out std_logic_vector(15 downto 0));
	end component;
	
	component MZE is
		port(IR_0to7_in: in std_logic_vector(7 downto 0); MZE_out : out std_logic_vector(15 downto 0));
	end component;

	component memory_16bit is 
		port (clk : in std_logic;
				MEM_W, Mem_R : in std_logic;
				ADDRESS : in std_logic_vector (15 downto 0);
				data_in : in std_logic_vector (15 downto 0);
				data_out : out std_logic_vector (15 downto 0):="0000000000000000");
	end component memory_16bit;
	
	component RF is
		port ( clk, rf_w, IP_W: in std_logic;
				a1, a2, a3 : in std_logic_vector (2 downto 0);
				d3, IP_in : in std_logic_vector (15 downto 0);
				d1, d2, IP_out : out std_logic_vector (15 downto 0):="0000000000000000");
	end component RF;
	
	component RF_mux is
		port(IR_9to11_in, IR_6to8_in, IR_3to5_in: in std_logic_vector(2 downto 0);
				T3_in, LZE_in, MZE_in, T1_in, IP_in: in std_logic_vector(15 downto 0);
				A1, A2, address_in: out std_logic_vector(2 downto 0);
				data_in: out std_logic_vector(15 downto 0);
				state: in std_logic_vector(4 downto 0));
	end component;
	
	component IP_mux is
		port (ALU_C, T2 : in std_logic_vector (15 downto 0);
				state : in std_logic_vector (4 downto 0);
				ALU_Z : in std_logic;
				IP_mux_out : out std_logic_vector (15 downto 0));
	end component IP_mux;

	component memory_mux is
		port( T3_in, IP_in: in std_logic_vector(15 downto 0);
				state : in std_logic_vector(4 downto 0);
				ADDRESS : out std_logic_vector(15 downto 0):="0000000000000000");
	end component;
	
	component T1_mux is
		port (RF_D1, mem_data : in std_logic_vector (15 downto 0);
				state : in std_logic_vector (4 downto 0);
				T1_mux_out : out std_logic_vector (15 downto 0));
	end component T1_mux;
	
	component T2_mux is
		port (RF_D2 : in std_logic_vector (15 downto 0);
				state : in std_logic_vector (4 downto 0);
				T2_mux_out : out std_logic_vector (15 downto 0));
	end component T2_mux;
	
	component T3_mux is
		port (ALU_C : in std_logic_vector (15 downto 0);
				state : in std_logic_vector (4 downto 0);
				T3_mux_out : out std_logic_vector (15 downto 0));
	end component T3_mux;

	component register_16bit is
		port(Clk, Reset, reg_w : in std_logic;
		data_in : in std_logic_vector(15 downto 0);
		data_out : out std_logic_vector(15 downto 0));
	end component;

	signal state:std_logic_vector(4 downto 0):="11111";
	signal IR_s, IP_s, T1_s, T2_s, T3_s, SE6_s, SE9_s, LS_s, ALU_C_s, LZE_s, MZE_s, mem_add_s, mem_dout_s, RF_data_in_s:std_logic_vector(15 downto 0);
	signal ALU_Z_s: std_logic;
	signal Mem_R_s, Mem_W_s, IR_W_s, IP_W_s, T1_W_s, T2_W_s, T3_W_s, RF_W_s: std_logic;
	signal A1_s, A2_s, RF_address_in_s: std_logic_vector(2 downto 0);
	signal IP_in_s, T1_in_s, T2_in_s, T3_in_s, RF_D1_s, RF_D2_s:std_logic_vector(15 downto 0);
	
begin
	
	state_out<=state;
	
	st_tr: state_transition port map(IR_s(15 downto 12), state, clk, reset, state, Mem_R_s, Mem_W_s, IR_W_s, IP_W_s, T1_W_s, T2_W_s, T3_W_s, RF_W_s);
	
	alu_c: alu port map(IP_s, T1_s, T2_s, SE6_s, LS_s, state, IR_s(15 downto 12), ALU_C_s, ALU_Z_s);
	
	SE6_c: SE6 port map(IR_s(5 downto 0), SE6_s);
	
	SE9_c: SE9 port map(IR_s(8 downto 0), SE9_s);
	
	LS_c: LS port map(SE6_s, SE9_s, IR_s(15 downto 12), LS_s);
	
	LZE_c: LZE port map(IR_s(7 downto 0), LZE_s);
	
	MZE_c: MZE port map(IR_s(7 downto 0), MZE_s);
	
	mem: memory_16bit port map(clk, Mem_W_s, Mem_R_s, mem_add_s, T1_s, mem_dout_s);
	
	mem_mux_c: memory_mux port map(T3_s, IP_s, state, mem_add_s);
	
	RF_mux_c: RF_mux port map(IR_s(11 downto 9), IR_s(8 downto 6), IR_s(5 downto 3), T3_s, LZE_s, MZE_s, T1_s, IP_s, A1_s, A2_s, RF_address_in_s, RF_data_in_s, state);
	
	RF_c: RF port map(clk, RF_W_s, IP_W_s, A1_s, A2_s, RF_address_in_s, RF_data_in_s, IP_in_s, RF_D1_S, RF_D2_s, IP_s);
	
	IP_mux_c: IP_mux port map(ALU_C_s, T2_s, state, ALU_Z_s, IP_in_s);
	
	T1_mux_c: T1_mux port map(RF_D1_s, mem_dout_s, state, T1_in_s);
	
	T2_mux_c: T2_mux port map(RF_D2_S, state, T2_in_s);
	
	T3_mux_c: T3_mux port map(ALU_C_s, state, T3_in_s);
	
	T1_c: register_16bit port map(clk, reset, T1_W_s, T1_in_s, T1_s);
	
	T2_c: register_16bit port map(clk, reset, T2_W_s, T2_in_s, T2_s);
	
	T3_c: register_16bit port map(clk, reset, T3_W_s, T3_in_s, T3_s);
	
	IR_c: register_16bit port map(clk, reset, IR_W_s, IP_s, IR_s);
	
end struct;