library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity testbench_memory is
end entity;

architecture struct of testbench_memory is
	component memory_16bit is 
	port (clk : in std_logic;
			MEM_W, Mem_R : in std_logic;
			ADDRESS : in std_logic_vector (15 downto 0);
			data_in : in std_logic_vector (15 downto 0);
			data_out : out std_logic_vector (15 downto 0):="0000000000000000");
	end component memory_16bit;
	
	signal clk, MEM_W,Mem_R : std_logic := '0';
	signal ADDRESS, data_in, data_out : std_logic_vector (15 downto 0):="0000000000000000";

begin
		memory_instance : memory_16bit port map (clk, MEM_W, Mem_R, ADDRESS, data_in, data_out);
		
		clk <= not(clk) after 10ns;
		
		MEM_W <= '1', '0' after 100ns;
		Mem_R <= '0', '1' after 100ns;
		
		ADDRESS <= std_logic_vector(to_unsigned(12, 16)), std_logic_vector(to_unsigned(30, 16)) after 50ns, std_logic_vector(to_unsigned(12, 16)) after 150ns;
		
		data_in <= std_logic_vector(to_unsigned(69, 16)), std_logic_vector(to_unsigned(79, 16)) after 50ns;
		
end struct;