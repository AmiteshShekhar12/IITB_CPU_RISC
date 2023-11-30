library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testbench_custom_mux is
end entity testbench_custom_mux;

architecture behv of  testbench_custom_mux is

	component custom_mux is
		port ( x0, x1, x2, x3, x4 ,x5, x6, x7 : in std_logic_vector (15 downto 0) ;
				sel : in std_logic_vector(2 downto 0);
				y : out std_logic_vector (15 downto 0));
	end component custom_mux;


	signal x0, x1, x2, x3, x4, x5, x6, x7, y : std_logic_vector (15 downto 0):= (others=> '0');
	signal sel : std_logic_vector ( 2 downto 0) := "000";
	
	begin
	
	sel <= "000", "001" after 10 ns,"010" after 20 ns,"011" after 30 ns, "100" after 40 ns,"101" after 50 ns,"110" after 60 ns,"111" after 70 ns;
	x0 <= std_logic_vector(to_unsigned(69, 16));
	x1 <= std_logic_vector(to_unsigned(12, 16));
	x2 <= std_logic_vector(to_unsigned(24, 16));
	x3 <= std_logic_vector(to_unsigned(48, 16));
	x4 <= std_logic_vector(to_unsigned(60, 16));
	x5 <= std_logic_vector(to_unsigned(72, 16));
	x6 <= std_logic_vector(to_unsigned(84, 16));
	x7 <= std_logic_vector(to_unsigned(96, 16));
	
	custom_mux_1 : custom_mux port map (x0, x1, x2, x3, x4, x5, x6, x7, sel, y);
	
end behv;
	
	

