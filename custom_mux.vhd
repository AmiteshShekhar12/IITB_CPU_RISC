library ieee;
use ieee.std_logic_1164.all;

entity custom_mux is
	port ( x0, x1, x2, x3, x4 ,x5, x6, x7 : in std_logic_vector (15 downto 0) ;
			sel : in std_logic_vector(2 downto 0);
			y : out std_logic_vector (15 downto 0));
end entity custom_mux;


architecture struct of custom_mux is
begin
	with sel select 
	y <= x0 when "000",
		  x1 when "001",
		  x2 when "010",
		  x3 when "011",
		  x4 when "100",
		  x5 when "101",
		  x6 when "110",
		  x7 when others;
end struct;