library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity testbench_memory is
end entity;

architecture struct of testbench_memory is
	component memory_16bit is 
	port (clk : in std_logic;
			MEM_W : in std_logic;
			ADD : in std_logic_vector (15 downto 0);
			data_in : in std_logic_vector (15 downto 0);
			data_out : out std_logic_vector (15 downto 0));
	end component memory_16bit;
	
	signal clk, MEM_W : std_logic := '0';
	signal ADD, data_in, data_out : std_logic_vector (15 downto 0) := (others =>'0');

begin
		
		memory_instance : memory_16bit port map (clk, MEM_W, ADD, data_in, data_out);
		
		clk <= not(clk) after 10 ns;
		
		MEM_W <= '1', '0' after 100 ns;
		
		ADD <= std_logic_vector(to_unsigned(12, 16));
		
		data_in <= std_logic_vector(to_unsigned(69, 16));
		
end struct;