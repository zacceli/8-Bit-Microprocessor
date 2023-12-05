----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.06.2023 16:25:10
-- Design Name: 
-- Module Name: register_select_unit - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_select_unit is
--  Port ( );
    Port (  RSU : in STD_LOGIC_VECTOR (5 downto 0);
            mux_sel : out std_logic_vector (3 downto 0);
            dmx_sel : out std_logic_vector (3 downto 0);
            mux_e : out std_logic;
            dmx_e : out std_logic;
            M : out std_logic;
            SP : out std_logic;
            PC : out std_logic;
            WZ : out std_logic);
end register_select_unit;

architecture Behavioral of register_select_unit is
    type mem1 is array (0 to 40) of std_logic_vector(13 downto 0);
    
    constant rom1: mem1 := (
        0 => "00000000000011",
        1 => "00010000000011",
        2 => "00100000000011",
        3 => "00110000000011",
        4 => "00000001000011",
        5 => "00010001000011",
        6 => "00100001000011",
        7 => "00110001000011",
        8 => "00000010000011",
        9 => "00010010000011",
        10 => "00100010000011",
        11 => "00110010000011",
        12 => "00000011000011",
        13 => "00010011000011",
        14 => "00100011000011",
        15 => "00110011000011",
        16 => "00000000000010",
        17 => "00010000000010",
        18 => "00100000000010",
        19 => "00110000000010",
        20 => "00000000000001",
        21 => "00000001000001",
        22 => "00000010000001",
        23 => "00000011000001",
        24 => "01010000000010",
        25 => "01000000000010",
        26 => "00000101000001",
        27 => "00000100000001",
        28 => "00000000100000",
        29 => "00000000010000",
        30 => "00000000001000",
        31 => "00000000000000",
        32 => "00000111000001",
        33 => "00000110000001",
        34 => "01110000000010",
        35 => "01100000000010",
        36 => "10010000000010",
        37 => "10000000000010",
        38 => "00001001000001",
        39 => "00001000000001",
        40 => "00000000000100",
        others => "00000000000000");
        
    signal addr : integer range 0 to 40;
    signal data : std_logic_vector (13 downto 0);
        
begin
    addr <= to_integer(unsigned(RSU));
    data <= rom1(addr);
    dmx_sel <= data(13 downto 10);
    mux_sel <= data(9 downto 6);
    M <= data(5);
    SP <= data(4);
    PC <= data(3);
    WZ <= data(2);
    dmx_e <= data(1);
    mux_e <= data(0);

end Behavioral;
