library ieee;
use ieee.std_logic_1164.all;

entity IP_mux is
	port (ALU_C, T2 , IP_in: in std_logic_vector (15 downto 0);
			state : in std_logic_vector (4 downto 0);
			ALU_Z : in std_logic;
			IP_mux_out : out std_logic_vector (15 downto 0));
end entity IP_mux;

architecture struct of IP_mux is 

signal s1, s14, s16, s18 : std_logic := '0';

	begin
	
	s1 <= not(state(4)) and not(state(3)) and not(state(2)) and not (state(1)) and state(0);
	s14 <= not(state(4)) and state(3) and state(2) and state(1) and not(state(0));
	s16 <= state(4) and not(state(3)) and not(state(2)) and not(state(1)) and not(state(0));
	s18 <= state(4) and not(state(3)) and not(state(2)) and state(1) and not(state(0));
	
	g1 : for i in 0 to 15 generate
		IP_mux_out(i) <= ((s1 or (s14 and ALU_Z) or s16) and ALU_C(i)) or (s18 and T2(i)) or (s14 and not(ALU_Z)) and IP_in;
	end generate g1;
	
end struct;
