library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity register_file is
	port ( clk, RF_W : in std_logic;
					A1, A2, A3 : in std_logic_vector (2 downto 0);
					DD3 : in std_logic_vector (15 downto 0);
					DD1, DD2 : out std_logic_vector (15 downto 0));
end register_file;

architecture struct of register_file is

component custom_demux is
	port ( x : in std_logic_vector (15 downto 0);
			sel : in std_logic_vector (2 downto 0);
			y0, y1, y2, y3, y4, y5, y6, y7 : out std_logic_vector (15 downto 0));

end component custom_demux;

component custom_mux is
	port ( x0, x1, x2, x3, x4 ,x5, x6, x7 : in std_logic_vector (15 downto 0) ;
			sel : in std_logic_vector(2 downto 0);
			y : out std_logic_vector (15 downto 0));
end component custom_mux;

component register_16bit is
	port(Clk, Reset, reg_w : in std_logic;
	data_in : in std_logic_vector(15 downto 0);
	data_out : out std_logic_vector(15 downto 0));
end component;

signal d0, d1, d2, d3, d4, d5, d6, d7 : std_logic_vector (15 downto 0); -- input data lines of the regsiters R0 to R7
signal q0, q1, q2, q3, q4, q5, q6, q7 : std_logic_vector (15 downto 0); -- output data lines of the registers R0 to R7

begin

	r0 : register_16bit port map (Clk => clk, Reset => '0', reg_w => RF_W, data_in => d0, data_out => q0);
	r1 : register_16bit port map (Clk => clk, Reset => '0', reg_w => RF_W, data_in => d1, data_out => q1);
	r2 : register_16bit port map (Clk => clk, Reset => '0', reg_w => RF_W, data_in => d2, data_out => q2);
	r3 : register_16bit port map (Clk => clk, Reset => '0', reg_w => RF_W, data_in => d3, data_out => q3);
	r4 : register_16bit port map (Clk => clk, Reset => '0', reg_w => RF_W, data_in => d4, data_out => q4);
	r5 : register_16bit port map (Clk => clk, Reset => '0', reg_w => RF_W, data_in => d5, data_out => q5);
	r6 : register_16bit port map (Clk => clk, Reset => '0', reg_w => RF_W, data_in => d6, data_out => q6);
	r7 : register_16bit port map (Clk => clk, Reset => '0', reg_w => RF_W, data_in => d7, data_out => q7);
	
	demux_1 : custom_demux port map (x => DD3, sel => A3, y0 => d0, y1 => d1, y2=>d2, y3 => d3, y4 => d4, y5 => d5, y6 => d6, y7 => d7);
	mux_1 : custom_mux port map (x0 => q0, x1 => q1, x2 => q2, x3 => q3, x4 => q4, x5 => q5, x6 => q6, x7 => q7, sel => A1, y => DD1);
	mux_2 : custom_mux port map (x0 => q0, x1 => q1, x2 => q2, x3 => q3, x4 => q4, x5 => q5, x6 => q6, x7 => q7, sel => A2, y => DD2);
	
end struct;
