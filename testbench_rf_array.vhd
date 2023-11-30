-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;
-- use ieee.std_logic_unsigned.all;

-- entity testbench_rf_array is
-- end entity testbench_rf_array;


-- architecture behv of testbench_rf_array is

-- 	component register_file_array is
-- 		port ( clk, rf_w: in std_logic;
-- 				 a1, a2, a3 : in std_logic_vector (2 downto 0);
-- 				 d3 : in std_logic_vector (15 downto 0);
-- 				 d1, d2 : out std_logic_vector (15 downto 0));
-- 	end component register_file_array;

-- 	signal clk, rf_w : std_logic := '0';
-- 	signal a1, a2, a3 : std_logic_vector (2 downto 0):="000" ;
-- 	signal d1, d2, d3 : std_logic_vector (15 downto 0):= (others => '0');
	
-- 	begin
	
-- 		clk <= not(clk) after 10 ns;
-- 		rf_w <= '1' , '0' after 40 ns;
-- 		a1 <= "010";
-- 		a2 <= "001";
-- 		a3 <= "010", "001" after 30 ns;
-- 		d3 <= std_logic_vector(to_unsigned(224,16)),std_logic_vector(to_unsigned(069,16)) after 30 ns;
		
-- 		rf1 : register_file_array port map (clk, rf_w, a1, a2, a3, d3, d1, d2);
		
-- end behv;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testbench_rf_array is
end entity testbench_rf_array;


architecture behv of testbench_rf_array is

	component register_file_array is
		port ( clk, rf_w, IP_W: in std_logic;
			 a1, a2, a3 : in std_logic_vector (2 downto 0);
			 d3, IP_in : in std_logic_vector (15 downto 0);
			 d1, d2, IP_out : out std_logic_vector (15 downto 0):="0000000000000000");
	end component register_file_array;

	signal clk, rf_w,IP_W : std_logic := '0';
	signal a1, a2, a3 : std_logic_vector (2 downto 0):="000" ;
	signal d1, d2, d3,IP_out,IP_in : std_logic_vector (15 downto 0):= (others => '0');
	
	begin
	
		clk <= not(clk) after 10 ns;
		rf_w <= '1' , '0' after 150 ns;
		IP_W <= '0', '1' after 300 ns,'0' after 500 ns;
		IP_in <= "0000000000000101";
		a3 <= "010", "100" after 50 ns;
		d3 <= std_logic_vector(to_unsigned(224,16)),std_logic_vector(to_unsigned(069,16)) after 50 ns;
		a1 <= "010";
		a2 <= "100";
		
		rf1 : register_file_array port map (clk, rf_w,IP_w, a1, a2, a3, d3, IP_in, d1, d2, IP_out);
		
end behv;
