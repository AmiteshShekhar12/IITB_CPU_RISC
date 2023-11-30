library ieee;
use ieee.std_logic_1164.all;

entity register_16bit is
	port(Clk, Reset, reg_w : in std_logic;
	data_in : in std_logic_vector(15 downto 0);
	data_out : out std_logic_vector(15 downto 0));
end entity;

architecture struct of register_16bit is 

	component d_flipFlop is
		port (D, CLK, EN, Pres, Res : in std_logic; Q, Q_bar : out std_logic);
	end component;
	
	signal j : std_logic := '0';

begin

	L1 : for i in 0 to 15 generate
		FF : d_flipflop port map ( D => data_in(i), CLK => CLK, EN => reg_w, PRes => '0', Res => Reset, Q => data_out(i), Q_bar => j);
	end generate L1;


--	FF0: d_flipFlop port map ( D => data_in(0), CLK => CLK, EN => '1', PRes => '0', Res => Reset, Q => data_out(0), Q_bar => j);
--	FF1: d_flipFlop port map ( D => data_in(1), CLK => CLK, EN => '1', PRes => '0', Res => Reset, Q => data_out(1), Q_bar => j);
--	FF2: d_flipFlop port map ( D => data_in(2), CLK => CLK, EN => '1', PRes => '0', Res => Reset, Q => data_out(2), Q_bar => j);
--	FF3: d_flipFlop port map ( D => data_in(3), CLK => CLK, EN => '1', PRes => '0', Res => Reset, Q => data_out(3), Q_bar => j);
--	FF4: d_flipFlop port map ( D => data_in(4), CLK => CLK, EN => '1', PRes => '0', Res => Reset, Q => data_out(4), Q_bar => j);
--	FF5: d_flipFlop port map ( D => data_in(5), CLK => CLK, EN => '1', PRes => '0', Res => Reset, Q => data_out(5), Q_bar => j);
end struct;