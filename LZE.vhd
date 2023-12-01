--least significant zero extender
library ieee;
use ieee.std_logic_1164.all;

entity LZE is
	port(IR_0to7_in: in std_logic_vector(7 downto 0); LZE_out : out std_logic_vector(15 downto 0));
end entity;

architecture Struct of LZE is

begin

	n2: for i in 0 to 7 generate
		LZE_out(i)<='0';
	end generate;
	
	n1: for i in 8 to 15 generate
		LZE_out(i)<=IR_0to7_in(i-8);
	end generate;

end Struct;