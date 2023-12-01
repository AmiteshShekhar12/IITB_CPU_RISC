library ieee;
use ieee.std_logic_1164.all;

entity T3_mux is
	port (ALU_C : in std_logic_vector (15 downto 0);
			state : in std_logic_vector (4 downto 0);
			T3_mux_out : out std_logic_vector (15 downto 0));
end entity T3_mux;

architecture struct of T3_mux is

	signal s3, s9, s19: std_logic;
	
begin

	s3 <= not(state(4)) and not(state(3)) and not(state(2)) and (state(1)) and state(0);
	s9<= not(state(4)) and state(3) and not(state(2)) and not(state(1)) and state(0);
	s19<= state(4) and not(state(3)) and not(state(2)) and state(1) and state(1);
	
	g1 : for i in 0 to 15 generate
		T3_mux_out(i) <= ((s3 or s9 or s19) and ALU_C(i));
	end generate g1;
	
end struct;