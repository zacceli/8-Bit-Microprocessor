----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.06.2023 23:43:14
-- Design Name: 
-- Module Name: temp_reg - Behavioral
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

entity temp_reg is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Lt : in STD_LOGIC;
           Et : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : inout STD_LOGIC_VECTOR (7 downto 0);
           Q_tri : out STD_LOGIC_VECTOR (7 downto 0));
end temp_reg;

architecture Behavioral of temp_reg is

begin
    process(D, CLK, Lt, Et, CLR)
    begin
        if CLR = '1' then
            Q <= (others => '0');
        elsif (rising_edge(CLK) and Lt = '0') then
            Q <= D; 
        end if; 
        if Et = '0' then
            Q_tri <= Q; 
        else
            Q_tri <= (others => 'Z');
        end if; 
    end process; 

end Behavioral;
