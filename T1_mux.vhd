library ieee;
use ieee.std_logic_1164.all;

entity T1_mux is
	port (RF_D1, mem_data : in std_logic_vector (15 downto 0);
			state : in std_logic_vector (4 downto 0);
			T1_mux_out : out std_logic_vector (15 downto 0));
end entity T1_mux;

architecture struct of T1_mux is

	signal s2, s5, s10 : std_logic;
	
begin

	s2 <= not(state(4)) and not(state(3)) and not(state(2)) and (state(1)) and not(state(0));
	s5 <= not(state(4)) and not(state(3)) and state(2) and not(state(1)) and state(0);
	s10 <= not(state(4)) and state(3) and not(state(2)) and state(1) and not(state(0));
	
	g1 : for i in 0 to 15 generate
		T1_mux_out(i) <= ((s2 or s5) and RF_D1(i)) or (s10 and mem_data(i));
	end generate g1;
	
end struct;