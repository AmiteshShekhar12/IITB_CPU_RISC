library ieee;
use ieee.std_logic_1164.all;

entity MZE is
	port(IR_0to7_in: in std_logic_vector(7 downto 0); MZE_out : out std_logic_vector(15 downto 0));
end entity;

architecture Struct of MZE is

begin

	n1: for i in 0 to 7 generate
		MZE_out(i)<=IR_0to7_in(i);
	end generate;
	
	n2: for i in 8 to 15 generate
		MZE_out(i)<='0';
	end generate;
end Struct;