----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2023 10:59:27
-- Design Name: 
-- Module Name: accu_tb - Behavioral
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

entity accu_tb is
--  Port ( );
end accu_tb;

architecture Behavioral of accu_tb is

    component accumulator
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           D_Alu : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           La : in STD_LOGIC;
           Ea : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : inout STD_LOGIC_VECTOR (7 downto 0);
           Q_tri : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal D : STD_LOGIC_VECTOR (7 downto 0);
    signal D_Alu : STD_LOGIC_VECTOR (7 downto 0);
    signal CLK : STD_LOGIC;
    signal La : STD_LOGIC;
    signal Ea : STD_LOGIC;
    signal CLR : STD_LOGIC;
    signal Q : STD_LOGIC_VECTOR (7 downto 0);
    signal Q_tri : STD_LOGIC_VECTOR (7 downto 0);
    
     constant clk_period : time := 10 ns;

begin

    uut : accumulator port map (
        D,
        D_Alu,
        CLK,
        La,
        Ea,
        CLR,
        Q,
        Q_tri
    );

    clk_process : process
    begin
        CLK <= '0';
        wait for clk_period / 2;
        CLK <= '1';
        wait for clk_period / 2;
    end process;
    
    stim_proc : process
    begin
        CLR <= '1';
        wait for 10ns;
        CLR <= '0';
        D <= "00010001";
        D_Alu <= (others => 'Z');
        La <= '1';
        Ea <= '0';
        wait for 100ns;
        La <= '0';
        wait for 100ns;
    end process;

end Behavioral;
