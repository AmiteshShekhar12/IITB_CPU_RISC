library ieee;
use ieee.std_logic_1164.all;

entity testbench_cpu is
end entity;

architecture struct of testbench_cpu is

	component CPU is
		port(clk,reset: in std_logic; state_out: out std_logic_vector(4 downto 0));
	end component;
	
	signal clk: std_logic:='0';
	signal reset: std_logic;
	signal state_out:std_logic_vector(4 downto 0);
	
begin
	
	clk<=not clk after 10ns;
	reset<='1', '0' after 32ns;
	
	c: CPU port map(clk, reset, state_out);

end struct;