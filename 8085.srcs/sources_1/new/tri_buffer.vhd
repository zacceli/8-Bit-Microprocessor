----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.06.2023 03:19:55
-- Design Name: 
-- Module Name: tri_buffer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tri_buffer is
--  Port ( );
    port (
        data_in   : in  std_logic_vector(7 downto 0);
        enable    : in  std_logic;
        data_out  : out std_logic_vector(7 downto 0)
    );
end tri_buffer;

architecture Behavioral of tri_buffer is

begin
    process (data_in, enable)
    begin
        if enable = '1' then
            data_out <= data_in;
        else
            data_out <= (others => 'Z');
        end if;
    end process;

end Behavioral;
