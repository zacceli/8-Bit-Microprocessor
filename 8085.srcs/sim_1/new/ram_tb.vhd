----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2023 11:12:47
-- Design Name: 
-- Module Name: ram_tb - Behavioral
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

entity ram_tb is
--  Port ( );
end ram_tb;

architecture Behavioral of ram_tb is

    component ram
        Port ( addr : in STD_LOGIC_VECTOR (15 downto 0);
           Din : in STD_LOGIC_VECTOR (7 downto 0);
           trigger : in STD_LOGIC;
           str : in STD_LOGIC;
           ld : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal addr : STD_LOGIC_VECTOR (15 downto 0);
    signal Din : STD_LOGIC_VECTOR (7 downto 0);
    signal trigger : STD_LOGIC;
    signal str : STD_LOGIC;
    signal ld : STD_LOGIC;
    signal CLR : STD_LOGIC;
    signal Dout : STD_LOGIC_VECTOR (7 downto 0);

begin

    uut : ram port map (
        addr,
        Din,
        trigger,
        str,
        ld,
        CLR,
        Dout
    );
    
    stim_proc : process
    begin
    
        CLR <= '1';
        wait for 100ns;
        CLR <= '0';
        addr <= "0000000011001010";
        Din <= "01010101";
        str <= '1';
        ld <= '0';
        trigger <= '1';
        wait for 50ns;
        str <= '0';
        trigger <= '0';
        ld <= '1';
        wait for 100ns;
    end process;


end Behavioral;
