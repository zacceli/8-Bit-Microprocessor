----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2023 05:06:07
-- Design Name: 
-- Module Name: ad_tb - Behavioral
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

entity ad_tb is
--  Port ( );
end ad_tb;

architecture Behavioral of ad_tb is

    component addr_data_buffer_unit
        Port (  data_out : in std_logic_vector (7 downto 0);
                mem_data_out : in std_logic_vector (7 downto 0);
                addr : in std_logic_vector (15 downto 0);
                ad : in std_logic_vector (1 downto 0);
                data_in : out std_logic_vector (7 downto 0);
                output : out std_logic_vector (7 downto 0);
                msb : out std_logic_vector (7 downto 0));
    end component;
    
    signal data_out : std_logic_vector (7 downto 0);
    signal mem_data_out : std_logic_vector (7 downto 0);
    signal addr : std_logic_vector (15 downto 0);
    signal ad : std_logic_vector (1 downto 0);
    signal data_in : std_logic_vector (7 downto 0);
    signal output : std_logic_vector (7 downto 0);
    signal msb : std_logic_vector (7 downto 0);
    
begin

uut : addr_data_buffer_unit port map (
    data_out,
    mem_data_out,
    addr,
    ad,
    data_in,
    output,
    msb
);


stim_proc: process
begin
    
    data_out <= "01101101";
    mem_data_out <= "11100011";
    addr <= "0000111100001111";
    ad <= "01";
    wait for 40 ns;
    ad <= "00";
    wait for 40 ns;
    ad <= "11";
    wait for 40 ns;
    ad <= "10";
    wait for 40 ns;
    

end process;

end Behavioral;
