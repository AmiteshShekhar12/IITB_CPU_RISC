--takes one 16 bits input and based on the select line "sel" value, takes that value to one of the eight 16 bits ouptut lines

library ieee;
use ieee.std_logic_1164.all;

entity custom_demux is
	port ( x : in std_logic_vector (15 downto 0);
			sel : in std_logic_vector (2 downto 0);
			y0, y1, y2, y3, y4, y5, y6, y7 : out std_logic_vector (15 downto 0));

end custom_demux;

architecture struct of custom_demux is
begin

	with sel select
	y0 <= x when "000", "0000000000000000" when others;
	
	with sel select
	y1 <= x when "001", "0000000000000000" when others;
	
	with sel select
	y2 <= x when "010", "0000000000000000" when others;
	
	with sel select
	y3 <= x when "011", "0000000000000000" when others;
	
	with sel select
	y4 <= x when "100", "0000000000000000" when others;
	
	with sel select
	y5 <= x when "101", "0000000000000000" when others;
	
	with sel select
	y6 <= x when "110", "0000000000000000" when others;
	
	with sel select
	y7 <= x when "111", "0000000000000000" when others;
	
	
end struct;
