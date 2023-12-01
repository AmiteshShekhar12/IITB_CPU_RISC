--Left Shifter (shifts the 16 bit input by 1 to the left effectively multiplying it by 2)
library ieee;
use ieee.std_logic_1164.all;

entity LS is
	port (SE6_in,SE9_in: in std_logic_vector(15 downto 0); op_code:std_logic_vector(3 downto 0); LS_out : out std_logic_vector(15 downto 0));
end entity;

architecture Struct of LS is
	
	signal sel:std_logic;
	signal A:std_logic_vector(15 downto 0);
	
begin
	sel<=op_code(3) and op_code(2) and not(op_code(1)) and op_code(0);
	
	n: for i in 15 downto 0 generate
		A(i)<=(SE9_in(i) and (sel)) or (SE6_in(i) and not(sel));
	end generate n;
	
	LS_out(0)<='0';
	
	n1 : for i in 0 to 14 generate
		LS_out(i+1)<=A(i);
	end generate n1;

end Struct;