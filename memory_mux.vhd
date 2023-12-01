library ieee;
use ieee.std_logic_1164.all;

entity memory_mux is
	port( T3_in, IP_in: in std_logic_vector(15 downto 0);
			state : in std_logic_vector(4 downto 0);
			ADDRESS : out std_logic_vector(15 downto 0):="0000000000000000");
end entity;

architecture Struct of Memory_mux is

signal s1,s10,s12 : std_logic;
	begin
	s1<=not(state(4)) and not(state(3)) and not(state(2)) and not(state(1)) and state(0);
	s10<=not(state(4)) and state(3) and not(state(2)) and state(1) and not(state(0));
	s12<=not(state(4)) and state(3) and state(2) and not(state(1)) and not(state(0));
	n : for i in 0 to 15 generate
	ADDRESS(i) <=  ((s1) and IP_in(i)) or ((s10 or s12) and T3_in(i));
	end generate;
end Struct;