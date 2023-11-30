library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testbench_rf is
end entity testbench_rf;


architecture behv of testbench_rf is

	component register_file_array is
		port ( clk, rf_w: in std_logic;
				 a1, a2, a3 : in std_logic_vector (2 downto 0);
				 d3 : in std_logic_vector (15 downto 0);
				 d1, d2 : out std_logic_vector (15 downto 0));
	end component register_file_array;

	signal clk, rf_w : std_logic := '0';
	signal a1, a2, a3 : std_logic_vector (2 downto 0):="000" ;
	signal d1, d2, d3 : std_logic_vector (15 downto 0):= (others => '0');
	
	begin
	
		clk <= not(clk) after 10 ns;
		rf_w <= '1' , '0' after 40 ns;
		a1 <= "010";
		a2 <= "001";
		a3 <= "010", "001" after 30 ns;
		d3 <= std_logic_vector(to_unsigned(224,16)),std_logic_vector(to_unsigned(069,16)) after 30 ns;
		
		rf1 : register_file_array port map (clk, rf_w, a1, a2, a3, d3, d1, d2);
		
end behv;
