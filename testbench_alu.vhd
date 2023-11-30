library ieee;
use ieee.std_logic_1164.all;

entity testbench_alu is
end entity;

architecture struct of testbench_alu is

	component ALU is
		port(IP_in, T1_in, T2_in, SE6_in, LS_in: in std_logic_vector(15 downto 0);
				state:in std_logic_vector(4 downto 0);
				op_code: in std_logic_vector(3 downto 0);
				output_c: out std_logic_vector(15 downto 0);
				ALU_Z: out std_logic);
	end component;
	
	signal IP_in, T1_in, T2_in, SE6_in, LS_in, output_c:std_logic_vector(15 downto 0);
	signal state:std_logic_vector(4 downto 0);
	signal op_code:std_logic_vector(3 downto 0);
	signal ALU_Z:std_logic;
	signal ip,t1,t2,se6,ls,outp:INTEGER;
begin

	state<="01001","01101" after 20 ns, "01110" after 40 ns, "10000" after 60 ns, "10011" after 80 ns;
	op_code<= "1010", "1100" after 20 ns, "1100" after 40 ns, "1101" after 60 ns, "0001" after 80 ns;
	IP_in<="0000000000001111";
	T1_in<="0000001110101100";
	T2_in<="0000001110101100";
	SE6_in<="0000000000111101";
	LS_in<="0101010010101100";
	
	alu1: ALU port map(IP_in=>IP_in, T1_in=>T1_in, T2_in=>T2_in, SE6_in=>SE6_in, LS_in=>LS_in, state=>state, op_code=>op_code, output_c=>output_c, ALU_Z=>ALU_Z);
	
	
	--expected output : 1001 - 0 - 21691 - 21691 - 1001 ( for ouput_c ) - decimal value given here
	--ALU_Z should be 1 ( needed only for BEQ state s13 ( 01101 ) and op-code (1100) )

end struct;