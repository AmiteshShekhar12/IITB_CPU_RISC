library ieee;
use ieee.std_logic_1164.all;

entity RF_mux is
	port(IR_9to11_in, IR_6to8_in, IR_3to5_in: in std_logic_vector(2 downto 0);
			T3_in, LZE_in, MZE_in, T1_in, IP_in: in std_logic_vector(15 downto 0);
			A1, A2, address_in: out std_logic_vector(2 downto 0);
			data_in: out std_logic_vector(15 downto 0);
			state: in std_logic_vector(4 downto 0));
end entity;

architecture struct of RF_mux is 
	
	signal s2,s4,s5,s6,s7,s8,s11,s15,s17,s20:std_logic:='0';
	
	
begin

	s2<=not(state(4)) and not(state(3)) and not(state(2)) and (state(1)) and not(state(0));
	s4<=not(state(4)) and not(state(3)) and (state(2)) and not(state(1)) and not(state(0));
	s5<=not(state(4)) and not(state(3)) and (state(2)) and not(state(1)) and (state(0));
	s6<=not(state(4)) and not(state(3)) and (state(2)) and (state(1)) and not(state(0));
	s7<=not(state(4)) and not(state(3)) and (state(2)) and (state(1)) and (state(0));
	s8<=not(state(4)) and (state(3)) and not(state(2)) and not(state(1)) and not(state(0));
	s11<=not(state(4)) and (state(3)) and not(state(2)) and (state(1)) and (state(0));
	s15<=not(state(4)) and (state(3)) and (state(2)) and (state(1)) and (state(0));
	s17<=(state(4)) and not(state(3)) and not(state(2)) and not(state(1)) and (state(0));
	s20<=(state(4)) and not(state(3)) and (state(2)) and not(state(1)) and not(state(0));
	
	A1<=IR_9to11_in;
	A2<=IR_6to8_in;
	
	n1: for i in 2 downto 0 generate
		address_in(i)<= (s4 and IR_3to5_in(i)) or ((s6 or s7 or s11 or s15 or s17) and IR_9to11_in(i)) or (s20 and IR_6to8_in(i));
	end generate n1;
	
	n2: for i in 15 downto 0 generate
		data_in(i)<= ((s4 or s20) and T3_in(i)) or (s6 and LZE_in(i)) or (s7 and MZE_in(i)) or (s11 and T1_in(i)) or ((s15 or s17) and IP_in(i));
	end generate n2;
	
end struct;