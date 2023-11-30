library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testbench_custom_demux is
end entity testbench_custom_demux;

architecture behv of testbench_custom_demux is

	component custom_demux is
		port ( x : in std_logic_vector (15 downto 0);
				sel : in std_logic_vector (2 downto 0);
				y0, y1, y2, y3, y4, y5, y6, y7 : out std_logic_vector (15 downto 0));

	end component custom_demux;
	
	signal x, y0, y1, y2, y3, y4, y5, y6, y7 : std_logic_vector (15 downto 0);
	signal sel : std_logic_vector (2 downto 0);
	
	begin
	
	x <= std_logic_vector(to_unsigned(69,16));
	sel <= "000", "001" after 10 ns, "010" after 20 ns, "011" after 30 ns, "100" after 40 ns, "101" after 50 ns, "110" after 60 ns, "111" after 70 ns;
	
	custom_demux_1 : custom_demux port map (x, sel, y0, y1, y2, y3, y4, y5, y6, y7);
	
end behv;