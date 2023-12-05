----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2023 10:45:23
-- Design Name: 
-- Module Name: int_add_latch_tb - Behavioral
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

entity int_add_latch_tb is
--  Port ( );
end int_add_latch_tb;

architecture Behavioral of int_add_latch_tb is

    component internal_addr_latch
        port (
            clk : in std_logic;
            data_in : in std_logic_vector(15 downto 0);
            data_out : out std_logic_vector(15 downto 0));

        end component;
        
        signal clk : std_logic;
        signal data_in : std_logic_vector(15 downto 0);
        signal data_out: std_logic_vector(15 downto 0);
        
        constant clk_period : time := 10 ns;

begin

    uut : internal_addr_latch port map (
        clk,
        data_in,
        data_out
    );

    clk_process : process
    begin
        CLK <= '0';
        wait for clk_period / 2;
        CLK <= '1';
        wait for clk_period / 2;
    end process;
    
    stim_proc: process
    begin
        data_in <= "1111000011110000";
        wait for 50ns;
        data_in <= (others => 'Z');
        wait for 50ns;
        data_in <= (others => '0');
        wait for 50ns;
    end process;

end Behavioral;
