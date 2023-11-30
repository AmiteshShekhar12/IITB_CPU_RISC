library ieee;
use ieee.std_logic_1164.all;

entity jk_flipFlop is
    port (
        J, K, CLK, EN, PRes, Res : in std_logic;
        Q, Q_bar : out std_logic
    );
end entity jk_flipFlop;

architecture behv of jk_flipFlop is
    signal a, b : std_logic := '0';

begin
    P : process(CLK, EN, PRes, Res)
    begin
        if (Pres = '1') then
            a <= '1';
            b <= '0';
        elsif (Res = '1') then
            a <= '0';
            b <= '1';
        elsif rising_edge(CLK) then
            if (EN = '1') then
                if (J = '0' and K = '1') then
                    a <= '0';
                    b <= '1';
                elsif (J = '1' and K = '0') then
                    a <= '1';
                    b <= '0';
                elsif (J = '1' and K = '1') then
                    a <= not a;
                    b <= not b;
                elsif (J = '0' and K = '0') then
                    a <= a;
                    b <= b;
                end if;
            end if;
        end if;
    end process P;

    Q <= a;
    Q_bar <= b;

end architecture behv;
