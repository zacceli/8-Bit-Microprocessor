library ieee;
use ieee.std_logic_1164.all;

entity mux_10to1_with_enable is
    port (
        data_in0  : in std_logic_vector(7 downto 0);
        data_in1  : in std_logic_vector(7 downto 0);
        data_in2  : in std_logic_vector(7 downto 0);
        data_in3  : in std_logic_vector(7 downto 0);
        data_in4  : in std_logic_vector(7 downto 0);
        data_in5  : in std_logic_vector(7 downto 0);
        data_in6  : in std_logic_vector(7 downto 0);
        data_in7  : in std_logic_vector(7 downto 0);
        data_in8  : in std_logic_vector(7 downto 0);
        data_in9  : in std_logic_vector(7 downto 0);
        sel       : in std_logic_vector(3 downto 0);
        enable    : in std_logic;
        data_out  : out std_logic_vector(7 downto 0)
    );
end entity mux_10to1_with_enable;

architecture behavioral of mux_10to1_with_enable is
begin
    process (enable, sel, data_in0, data_in1, data_in2, data_in3, data_in4, data_in5, data_in6, data_in7, data_in8, data_in9)
    begin
        if enable = '1' then
            case sel is
                when "0000" =>
                    data_out <= data_in0;
                when "0001" =>
                    data_out <= data_in1;
                when "0010" =>
                    data_out <= data_in2;
                when "0011" =>
                    data_out <= data_in3;
                when "0100" =>
                    data_out <= data_in4;
                when "0101" =>
                    data_out <= data_in5;
                when "0110" =>
                    data_out <= data_in6;
                when "0111" =>
                    data_out <= data_in7;
                when "1000" =>
                    data_out <= data_in8;
                when "1001" =>
                    data_out <= data_in9;
                when others =>
                    data_out <= (others => '0');
            end case;
        else
            data_out <= (others => 'Z');
        end if;
    end process;
end architecture behavioral;
