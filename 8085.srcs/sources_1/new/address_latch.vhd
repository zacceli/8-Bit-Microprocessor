library ieee;
use ieee.std_logic_1164.all;

entity address_latch is
    port (
        clk : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        ALE: in std_logic;
        data_out : out std_logic_vector(7 downto 0)
    );
end entity address_latch;

architecture behavioral of address_latch is
    signal reg : std_logic_vector(7 downto 0);
begin
    process (clk)
    begin
        if rising_edge(clk) and ALE = '1' then
            reg <= data_in;
        end if;
    end process;
    data_out <= reg;
end architecture behavioral;
