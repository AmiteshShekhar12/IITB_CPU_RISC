library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
	port (A,B:in std_logic_vector(3 downto 0); outp : out std_logic_vector(15 downto 0):="0000000000000000");
end entity;

architecture Struct of multiplier is

	component add_sub_16 is
		port(A,B: std_logic_vector(15 downto 0); M: in std_logic; Cout: out std_logic; S: out std_logic_vector(15 downto 0));
	end component add_sub_16;

	signal T1,T2,T3,T4,T5,T6 : std_logic_vector(15 downto 0):="0000000000000000";
	signal temp,temp1,temp2 : std_logic;

begin
	
	n1 : for i in 0 to 3 generate
		T1(i)<=A(i) and B(0);
	end generate;
	
	n2 : for i in 1 to 4 generate
		T2(i)<=A(i-1) and B(1);
	end generate;

	n3 : for i in 2 to 5 generate
		T3(i)<=A(i-2) and B(2);
	end generate;

	n4 : for i in 3 to 6 generate
		T4(i)<=A(i-3) and B(3);
	end generate;

	AS1 : add_sub_16 port map(A=>T1,B=>T2,M=>'0',Cout=>temp,S=>T5);
	AS2 : add_sub_16 port map(A=>T3,B=>T4,M=>'0',Cout=>temp1,S=>T6);
	AS3 : add_sub_16 port map(A=>T5,B=>T6,M=>'0',Cout=>temp2,S=>outp);

end Struct;