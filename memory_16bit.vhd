library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity memory_16bit is 
	port (clk : in std_logic;
			MEM_W : in std_logic;
			ADD : in std_logic_vector (15 downto 0);
			data_in : in std_logic_vector (15 downto 0);
			data_out : out std_logic_vector (15 downto 0));
end memory_16bit;

architecture mem of memory_16bit is
	
	type memory_array is array (0 to 32) of std_logic_vector (7 downto 0);
	
	signal memory : memory_array := (others => (others => '0'));
	
	begin
	p1 : process (clk)
		begin 
			if(clk'event and clk = '1') then
				if(MEM_W = '0') then
					data_out <= memory(to_integer(unsigned(ADD))+1) & memory(to_integer(unsigned(ADD))) ;
				elsif (MEM_W = '1') then
					memory(to_integer(unsigned(ADD))) <= data_in(7 downto 0);
					memory(to_integer(unsigned(ADD))+1) <= data_in(15 downto 8);
				end if;
			end if;	
		end process p1;
end mem;
					