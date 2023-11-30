	library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	use ieee.std_logic_unsigned.all;

	entity testbench_IP_mux is
	end entity;

	architecture behv of testbench_IP_mux is

		component IP_mux is
		port (ALU_C, T2 : in std_logic_vector (15 downto 0);
				state : in std_logic_vector (4 downto 0);
				ALU_Z : in std_logic;
				IP_mux_out : out std_logic_vector (15 downto 0));
		end component IP_mux;
		
		signal ALU_C, T2 : std_logic_vector (15 downto 0);
		signal state : std_logic_vector (4 downto 0);
		signal ALU_Z : std_logic := '0';
		signal IP_mux_out : std_logic_vector (15 downto 0);
		
	begin
		
		ALU_C <= std_logic_vector(to_unsigned(69,16));
		T2 <= std_logic_vector(to_unsigned(813,16));
		state <= "00001" , "10000" after 20 ns, "10010" after 40 ns, "01110" after 60 ns;
		ALU_Z <= '0', '1' after 60 ns, '0' after 100 ns;
		
		IP_mux_instance : IP_mux port map (ALU_C, T2, state, ALU_Z, IP_mux_out);
		
	end behv;