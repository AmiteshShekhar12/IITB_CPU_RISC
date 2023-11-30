-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;
-- use ieee.std_logic_unsigned.all;

-- entity testbench_RF is
-- end testbench_RF;

-- architecture behv of testbench_RF is

-- component register_file is
-- 	port ( clk, RF_W : in std_logic;
-- 					A1, A2, A3 : in std_logic_vector (2 downto 0);
-- 					DD3 : in std_logic_vector (15 downto 0);
-- 					DD1, DD2 : out std_logic_vector (15 downto 0));
-- end component register_file;

-- signal clk, RF_W : std_logic := '0';
-- signal A1, A2, A3 : std_logic_vector (2 downto 0);
-- signal DD1, DD2, DD3 : std_logic_vector (15 downto 0);

-- begin

-- RF : register_file port map (clk => clk, RF_W => RF_W, A1 => A1, A2 => A2, A3 => A3, DD3 => DD3, DD1 => DD1, DD2 => DD2);

-- clk <= not(clk) after 10 ns;
-- RF_W <= '0', '1' after 20 ns, '0' after 80 ns, '1' after 160 ns, '0' after 240 ns;
-- A3 <="000", "010" after 20 ns, "100" after 160ns;
-- DD3 <= std_logic_vector(to_unsigned(69,16)), std_logic_vector(to_unsigned(256,16)) after 160 ns;
-- A1 <= "000", "010" after 80 ns, "100" after 160 ns;

-- end behv;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity testbench_rf is
end entity testbench_rf;


architecture behv of testbench_rf is

	component RF is
		port ( clk, rf_w, IP_W: in std_logic;
			 a1, a2, a3 : in std_logic_vector (2 downto 0);
			 d3, IP_in : in std_logic_vector (15 downto 0);
			 d1, d2, IP_out : out std_logic_vector (15 downto 0):="0000000000000000");
	end component RF;

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
		
		rf1 : RF port map (clk, rf_w,IP_w, a1, a2, a3, d3, IP_in, d1, d2, IP_out);
		
end behv;
