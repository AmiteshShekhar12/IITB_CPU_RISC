library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity register_file_array is
	port ( clk, rf_w: in std_logic;
			 a1, a2, a3 : in std_logic_vector (2 downto 0);
			 d3 : in std_logic_vector (15 downto 0);
			 d1, d2 : out std_logic_vector (15 downto 0));
end entity register_file_array;


architecture struct of register_file_array is

	type rf_array is array (0 to 7) of std_logic_vector (15 downto 0);
	signal RF : rf_array := (others => ( others => '0'));
	
	begin
	
		p1 : process (clk)
		begin 
		
			if(clk'event and clk = '1') then
				if(rf_w= '1') then
				
					case a3 is
						
						when "000" => 
							rf(0) <= d3;
						when "001" => 
							rf(1) <= d3;
						when "010" => 
							rf(2) <= d3;
						when "011" => 
							rf(3) <= d3;
						when "100" => 
							rf(4) <= d3;
						when "101" => 
							rf(5) <= d3;
						when "110" => 
							rf(6) <= d3;
						when "111" => 
							rf(7) <= d3;
						when others =>
							rf(0) <= "0000000000000000";
							
					end case;
							
				else
					d1 <= rf(to_integer(unsigned(a1)));
					d2 <= rf (to_integer(unsigned(a2)));
				end if;
			end if;
			
		end process p1;
			
end struct;
						