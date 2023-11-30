library ieee;
use ieee.std_logic_1164.all;

entity d_flipFlop is
	port (D, CLK, EN, Pres, Res : in std_logic; Q, Q_bar : out std_logic);
end entity;

architecture struct of d_flipFlop is
	
	component jk_flipFlop is
	port (J, K, CLK, EN, PRes, Res : in std_logic ; Q, Q_bar : out std_logic);
	end component;
	
	signal dd_bar : std_logic;
	
begin
	dd_bar <= not(D);
	jk : jk_flipFlop port map ( J => D, K => dd_bar,CLK => CLK, EN => EN, Pres => Pres, Res => Res, Q => Q, Q_bar => Q_bar);
end;
	