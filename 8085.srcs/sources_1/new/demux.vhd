library ieee;
use ieee.std_logic_1164.all;

entity demux_10to1_with_enable is
    port (
        data_in   : in std_logic_vector(7 downto 0);
        sel       : in std_logic_vector(3 downto 0);
        enable    : in std_logic;
        data_out0 : out std_logic_vector(7 downto 0);
        data_out1 : out std_logic_vector(7 downto 0);
        data_out2 : out std_logic_vector(7 downto 0);
        data_out3 : out std_logic_vector(7 downto 0);
        data_out4 : out std_logic_vector(7 downto 0);
        data_out5 : out std_logic_vector(7 downto 0);
        data_out6 : out std_logic_vector(7 downto 0);
        data_out7 : out std_logic_vector(7 downto 0);
        data_out8 : out std_logic_vector(7 downto 0);
        data_out9 : out std_logic_vector(7 downto 0)
    );
end entity demux_10to1_with_enable;

architecture behavioral of demux_10to1_with_enable is
begin  
    data_out0 <= data_in when sel = "0000" and enable = '1' else (others => 'Z');
    data_out1 <= data_in when sel = "0001" and enable = '1' else (others => 'Z');
    data_out2 <= data_in when sel = "0010" and enable = '1' else (others => 'Z');
    data_out3 <= data_in when sel = "0011" and enable = '1' else (others => 'Z');
    data_out4 <= data_in when sel = "0100" and enable = '1' else (others => 'Z');
    data_out5 <= data_in when sel = "0101" and enable = '1' else (others => 'Z');
    data_out6 <= data_in when sel = "0110" and enable = '1' else (others => 'Z');
    data_out7 <= data_in when sel = "0111" and enable = '1' else (others => 'Z');
    data_out8 <= data_in when sel = "1000" and enable = '1' else (others => 'Z');
    data_out9 <= data_in when sel = "1001" and enable = '1' else (others => 'Z');
            
end architecture behavioral;
