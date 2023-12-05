----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2023 04:00:35
-- Design Name: 
-- Module Name: controller_tb - Behavioral
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

entity controller_tb is
--  Port ( );
end controller_tb;

architecture Behavioral of controller_tb is

    component controller is
        Port ( I : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               CLR : in STD_LOGIC;
               control_word : out STD_LOGIC_VECTOR (20 downto 0);
               HLT : out STD_LOGIC;
               IO: out std_logic);
    end component;
    
    signal I : STD_LOGIC_VECTOR (7 downto 0);
    signal CLK : STD_LOGIC;
    signal CLR : STD_LOGIC;
    signal control_word : STD_LOGIC_VECTOR (20 downto 0);
    signal HLT : STD_LOGIC;
    signal IO: std_logic;

constant clk_period : time := 10 ns;
    
begin

    uut : controller port map (
        I,
        CLK,
        CLR,
        control_word,
        HLT,
        IO
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
        CLR <= '1';
        wait for 10ns;
        CLR <= '0';
        I <= "00000110";
        wait for 100ns;
        I <= "11010011";
        WAIT for 100ns;
        
    end process;


end Behavioral;
