----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.06.2023 01:32:10
-- Design Name: 
-- Module Name: rsu_tb - Behavioral
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

entity rsu_tb is
--  Port ( );
end rsu_tb;

architecture Behavioral of rsu_tb is

    component register_select_unit
    port (
        RSU : in STD_LOGIC_VECTOR (5 downto 0);
        mux_sel : out std_logic_vector (3 downto 0);
        dmx_sel : out std_logic_vector (3 downto 0);
        mux_e : out std_logic;
        dmx_e : out std_logic;
        M : out std_logic;
        SP : out std_logic;
        PC : out std_logic;
        WZ : out std_logic);
    end component;
    
    component register_block
        Port (  dmx_sel : in std_logic_vector (3 downto 0);
            mux_sel : in std_logic_vector(3 downto 0);
            dmx_e : in std_logic;
            mux_e : in std_logic;
            M : in std_logic;
            SP : in std_logic;
            PC : in std_logic;
            WZ : in std_logic;
            clk : in std_logic;
            clr : in std_logic;
            Cp : in std_logic;
            data_in : in std_logic_vector (7 downto 0);
            data_out : out std_logic_vector (7 downto 0);
            addr: out std_logic_vector (15 downto 0));
    end component;
    
    signal RSU : std_logic_vector (5 downto 0); 
    signal dmx_sel : std_logic_vector (3 downto 0);
    signal mux_sel : std_logic_vector (3 downto 0);
    signal mux_e : std_logic;
    signal dmx_e : std_logic;
    signal M : std_logic;
    signal SP : std_logic;
    signal PC : std_logic;
    signal WZ : std_logic;
    signal Cp : std_logic;
    signal clk : std_logic;
    signal clr : std_logic;
    signal data_in : std_logic_vector(7 downto 0);
    signal data_out : std_logic_vector(7 downto 0);
    signal addr : std_logic_vector(15 downto 0);
    
    constant clk_period : time := 10 ns;
    
begin
    uut: register_select_unit port map (
        RSU => RSU,
        dmx_sel => dmx_sel,
        mux_sel => mux_sel,
        dmx_e => dmx_e,
        mux_e => mux_e,
        M => M,
        SP => SP,
        PC => PC,
        WZ => WZ);
        
    uut1 : register_block port map (
        dmx_sel,
        mux_sel,
        dmx_e,
        mux_e,
        M,
        SP,
        PC,
        WZ,
        clk,
        clr,
        Cp,
        data_in,
        data_out,
        addr
    );
    
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;
        
    stim_proc: process
    begin
        clr <= '1';
        data_in <= "11111111";
        wait for 200ns;
        clr <= '0';
        RSU <= "001111";
        wait for 100ns;
        RSU <= "011110";
        wait for 100ns;
        Cp <= '1';
        wait for 100ns;
        RSU <= "011110";
        wait for 100ns;
        Cp <= '0';
        RSU <= "100000";
        wait for 100ns;
        RSU <= "010010";
        wait for 100ns;
        RSU <= "010000";
        wait for 100ns;
        RSU <= "010100";
        wait for 100ns;
    end process;

end;
