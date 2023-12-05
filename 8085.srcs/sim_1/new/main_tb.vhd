----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.06.2023 22:56:17
-- Design Name: 
-- Module Name: main_tb - Behavioral
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

entity main_tb is
--  Port ( );
end main_tb;

architecture Behavioral of main_tb is
    component main
        port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR(15 downto 0); 
           led : out STD_LOGIC_VECTOR(15 downto 0); 
           seg : out STD_LOGIC_VECTOR(6 downto 0); 
           an : out STD_LOGIC_VECTOR(3 downto 0);
           btnU : in std_logic;
           btnL : in STD_LOGIC;
           btnC : in STD_LOGIC;
           btnR : in STD_LOGIC
           );
    end component;
    
    signal clk : std_logic;
    signal sw : STD_LOGIC_VECTOR(15 downto 0); 
    signal led : STD_LOGIC_VECTOR(15 downto 0); 
    signal seg : STD_LOGIC_VECTOR(6 downto 0); 
    signal an : STD_LOGIC_VECTOR(3 downto 0);
    signal btnU : std_logic;
    signal btnL : STD_LOGIC;
    signal btnC : STD_LOGIC;
    signal btnR : STD_LOGIC;
    
    constant clk_period : time := 10 ns;

begin
    uut : main port map (
        clk => clk,
        sw => sw,
        led => led,
        seg => seg,
        an => an,
        btnU => btnU,
        btnL => btnL,
        btnC => btnC,
        btnR => btnR
    );
    
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;
    
    stim_process: process
    begin
        btnL <= '1';
        btnR <= '1';
        
        wait for 50 ns;
        btnL <= '0';
        btnR <= '0';
        wait for 50 ns;
        
        btnC <= '0';
        wait for 10ns;
        sw <= "0000000011110000";
        btnC <= '1';
        wait for 10 ns;
        btnC <= '0';
        wait for 10ns;
        sw <= "0000001001001100";
        btnC <= '1';
        wait for 10 ns;
        btnC <= '0';
        wait for 10ns;
        sw <= "0000010011110000";
        btnC <= '1';
        wait for 10 ns;
        btnC <= '0';
        wait for 10ns;
        sw <= "0000011011110000";
        btnC <= '1';
        wait for 10 ns;
        btnC <= '0';
        wait for 10ns;
        sw <= "0000100110100110";
        btnC <= '1';
        wait for 10 ns;
        btnC <= '0';
        wait for 10ns;
        sw <= "0000101100010000";
        btnC <= '1';
        wait for 10 ns;
        btnC <= '0';
        wait for 10ns;
        sw <= "0000110100000000";
        btnC <= '1';
        wait for 10 ns;
        btnC <= '0';
        btnR <= '1';
        wait for 5ns;
        btnR <= '0';
        sw(0) <= '1';
        wait for 500 ns;
    end process;

end Behavioral;
