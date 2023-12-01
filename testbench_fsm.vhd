library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testbench_fsm is
end entity testbench_fsm;

architecture behv of testbench_fsm is

	component fsm is
	port(op_code: in std_logic_vector(3 downto 0);
			state: in std_logic_vector(4 downto 0);
			clk: in std_logic;
			reset: in std_logic;
			out_state: out std_logic_vector(4 downto 0);Mem_R, Mem_W, IR_W,IP_W, T1_W,T2_W,T3_W,RF_W : out std_logic);
	end component fsm;
	
	signal op_code : std_logic_vector (3 downto 0) := "0000";
	signal state, out_state : std_logic_vector (4 downto 0) := "00000";
	signal clk, reset : std_logic := '0';
	signal Mem_R, Mem_W, IR_W,IP_W, T1_W,T2_W,T3_W,RF_W : std_logic := '0';
	
	begin
	
	clk <= not(clk) after 10 ns;
	state <= "00000";
	op_code <= "1011", "0001" after 30 ns;
	
	fsm_ins : fsm port map (op_code, state, clk, reset, out_state, Mem_R, Mem_W, IR_W, IP_W, T1_W, T2_W, T3_W, RF_W);
end behv;