library ieee;
use ieee.std_logic_1164.all;

entity T2_mux is
	port (RF_D2 : in std_logic_vector (15 downto 0);
			state : in std_logic_vector (4 downto 0);
			T2_mux_out : out std_logic_vector (15 downto 0));
end entity T2_mux;

architecture struct of T2_mux is

	signal s2, s8: std_logic;
	
begin

	s2 <= not(state(4)) and not(state(3)) and not(state(2)) and (state(1)) and not(state(0));
	s8 <= not(state(4)) and state(3) and not(state(2)) and not(state(1)) and not(state(1));
	
	g1 : for i in 0 to 15 generate
		T2_mux_out(i) <= ((s2 or s8) and RF_D2(i));
	end generate g1;
	
end struct;