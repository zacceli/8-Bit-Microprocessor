----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.06.2023 23:36:03
-- Design Name: 
-- Module Name: internal_addr_latch - Behavioral
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

entity internal_addr_latch is
    port (
            clk : in std_logic;
            data_in : in std_logic_vector(15 downto 0);
            data_out : out std_logic_vector(15 downto 0)
        );
end internal_addr_latch;

architecture Behavioral of internal_addr_latch is
    signal reg : std_logic_vector(15 downto 0);
    begin
        process (clk)
        begin
            if rising_edge(clk) then
                if data_in = "ZZZZZZZZZZZZZZZZ" then
                reg <= reg;
                
                else
                reg <= data_in;
                end if;
            end if;
        end process;
        data_out <= reg;
end Behavioral;
