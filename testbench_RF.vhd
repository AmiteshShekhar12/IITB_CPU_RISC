library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testbench_register_file is
end testbench_register_file;

architecture behv of testbench_register_file is

component register_file is
	port ( clk, RF_W : in std_logic;
					A1, A2, A3 : in std_logic_vector (2 downto 0);
					DD3 : in std_logic_vector (15 downto 0);
					DD1, DD2 : out std_logic_vector (15 downto 0));
end component register_file;

signal clk, RF_W : std_logic := '0';
signal A1, A2, A3 : std_logic_vector (2 downto 0);
signal DD1, DD2, DD3 : std_logic_vector (15 downto 0);

begin

RF : register_file port map (clk => clk, RF_W => RF_W, A1 => A1, A2 => A2, A3 => A3, DD3 => DD3, DD1 => DD1, DD2 => DD2);

clk <= not(clk) after 10 ns;
RF_W <= '0', '1' after 20 ns, '0' after 80 ns, '1' after 160 ns, '0' after 240 ns;
A3 <="000", "010" after 20 ns, "100" after 160ns;
DD3 <= std_logic_vector(to_unsigned(69,16)), std_logic_vector(to_unsigned(256,16)) after 160 ns;
A1 <= "000", "010" after 80 ns, "100" after 160 ns;

end behv;
