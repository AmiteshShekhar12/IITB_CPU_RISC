library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port(IP_in, T1_in, T2_in, SE6_in, LS_in: in std_logic_vector(15 downto 0);
			state:in std_logic_vector(4 downto 0);
			op_code: in std_logic_vector(3 downto 0);
			output_c: out std_logic_vector(15 downto 0);
			ALU_Z: out std_logic);
end entity;


architecture struct of ALU is

	component add_sub_16 is
		port(A,B: std_logic_vector(15 downto 0); M: in std_logic; Cout: out std_logic; S: out std_logic_vector(15 downto 0));
	end component add_sub_16;
	
	component multiplier is
		port (A,B:in std_logic_vector(3 downto 0); outp : out std_logic_vector(15 downto 0):="0000000000000000");
	end component;

	signal ALU_A, ALU_B, ALU_C:std_logic_vector(15 downto 0);
	signal s1,s3,s9,s13,s14,s16,s19,couta,couts:std_logic;
	signal add, sub, mul, and1, or1, imp: std_logic_vector(15 downto 0);
	signal uns_2: std_logic_vector(15 downto 0):="0000000000000010";
	signal add_s, sub_s, mul_s, and1_s, or1_s, imp_s: std_logic;

begin

	s1<=not(state(4)) and not(state(3)) and not(state(2)) and not(state(1)) and state(0);
	s3<=not(state(4)) and not(state(3)) and not(state(2)) and (state(1)) and state(0);
	s9<=not(state(4)) and (state(3)) and not(state(2)) and not(state(1)) and state(0);
	s13<=not(state(4)) and (state(3)) and (state(2)) and not(state(1)) and state(0);
	s14<=not(state(4)) and (state(3)) and (state(2)) and (state(1)) and not(state(0));
	s16<=(state(4)) and not(state(3)) and not(state(2)) and not(state(1)) and not(state(0));
	s19<=(state(4)) and not(state(3)) and not(state(2)) and (state(1)) and state(0);
	
	n: for i in 15 downto 0 generate
		ALU_A(i)<= ((s1 or s14 or s16) and IP_in(i)) or ((s3 or s13 or s19) and T1_in(i)) or (s9 and T2_in(i));
		ALU_B(i)<= (s1 and uns_2(i)) or ((s3 or s13) and T2_in(i)) or ((s9 or s19) and SE6_in(i)) or ((s14 or s16) and LS_in(i));
		ALU_C(i)<= (add_s and add(i)) or (sub_s and sub(i)) or (mul_s and mul(i)) or (and1_s and and1(i)) or (or1_s and or1(i)) or (imp_s and imp(i));
	end generate n;
	
	add_s<=s1 or s9 or s14 or s16 or s19 or (s3 and not(op_code(3)) and not(op_code(2)) and not(op_code(1)) and not(op_code(0)));
	sub_s<=s13 or (s3 and not(op_code(3)) and not(op_code(2)) and (op_code(1)) and not(op_code(0)));
	mul_s<=s3 and not(op_code(3)) and not(op_code(2)) and (op_code(1)) and (op_code(0));
	and1_s<= s3 and not(op_code(3)) and (op_code(2)) and not(op_code(1)) and not(op_code(0));
	or1_s<= s3 and not(op_code(3)) and (op_code(2)) and not(op_code(1)) and (op_code(0));
	imp_s<= s3 and not(op_code(3)) and (op_code(2)) and (op_code(1)) and not(op_code(0));
	
	add_ins: add_sub_16 port map(A=>ALU_A, B=>ALU_B, M=>'0', Cout=>couta, S=>add);
	sub_ins: add_sub_16 port map(A=>ALU_A, B=>ALU_B, M=>'1', Cout=>couts, S=>sub);
	and1<= ALU_A and ALU_B;
	or1<=ALU_A or ALU_B;
	imp<=not(ALU_A) or ALU_B;
	m1: multiplier port map(A=>ALU_A(3 downto 0), B=>ALU_B(3 downto 0), outp=>mul);
	output_C<=ALU_C;
	ALU_Z<=not(not(couts) or sub(15) or sub(14) or sub(13) or sub(12) or sub(11) or sub(10) or sub(9) or sub(8) or sub(7) or sub(6) or sub(5) or sub(4) or sub(3) or sub(2) or sub(1) or sub(0));
	
end struct;
	