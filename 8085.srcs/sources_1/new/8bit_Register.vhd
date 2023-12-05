library ieee;
use ieee.std_logic_1164.all;

entity eight_bit_register_general is
    port (
        clk : in std_logic;
        clr: in std_logic;
        enable: in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end entity eight_bit_register_general;

architecture behavioral of eight_bit_register_general is
    signal reg : std_logic_vector(7 downto 0);
begin
    process (clk, clr, data_in)
    begin
        if clr = '1' then
            reg <= (others => '0');
        end if;
        if rising_edge(clk) and enable = '1' and data_in /= "ZZZZZZZZ" then
            reg <= data_in;
        end if;
    end process;
    data_out <= reg;
end architecture behavioral;
