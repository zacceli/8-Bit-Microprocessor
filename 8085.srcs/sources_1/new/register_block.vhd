----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.06.2023 02:12:23
-- Design Name: 
-- Module Name: register_block - Behavioral
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

entity register_block is
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
            
end register_block;

architecture Behavioral of register_block is

    signal b_q : std_logic_vector(7 downto 0);
    signal c_q : std_logic_vector(7 downto 0);
    signal h_q : std_logic_vector(7 downto 0);
    signal l_q : std_logic_vector(7 downto 0);
    signal pc_h_q : std_logic_vector(7 downto 0);
    signal pc_l_q : std_logic_vector(7 downto 0);
    signal sp_h_q : std_logic_vector(7 downto 0);
    signal sp_l_q :std_logic_vector(7 downto 0);
    signal w_q : std_logic_vector(7 downto 0);
    signal z_q : std_logic_vector(7 downto 0);
    signal mux_out : std_logic_vector(7 downto 0);
    
    signal b_d : std_logic_vector(7 downto 0);
    signal c_d : std_logic_vector(7 downto 0);
    signal h_d : std_logic_vector(7 downto 0);
    signal l_d : std_logic_vector(7 downto 0);
    signal temp_pc : std_logic_vector(15 downto 0);
    signal pc_h_d : std_logic_vector(7 downto 0);
    signal pc_l_d : std_logic_vector(7 downto 0);
    signal sp_h_d : std_logic_vector(7 downto 0);
    signal sp_l_d :std_logic_vector(7 downto 0);
    signal w_d : std_logic_vector(7 downto 0);
    signal z_d : std_logic_vector(7 downto 0);
    signal dmx_in : std_logic_vector(7 downto 0);
    
    signal carryOut : std_logic;
    

    component demux_10to1_with_enable
        port (
            data_in   : in std_logic_vector(7 downto 0);
            sel       : in std_logic_vector(3 downto 0);
            enable    : in std_logic;
            data_out0 : out std_logic_vector(7 downto 0);
            data_out1 : out std_logic_vector(7 downto 0);
            data_out2 : out std_logic_vector(7 downto 0);
            data_out3 : out std_logic_vector(7 downto 0);
            data_out4 : out std_logic_vector(7 downto 0);
            data_out5 : out std_logic_vector(7 downto 0);
            data_out6 : out std_logic_vector(7 downto 0);
            data_out7 : out std_logic_vector(7 downto 0);
            data_out8 : out std_logic_vector(7 downto 0);
            data_out9 : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component mux_10to1_with_enable
        port (
            data_in0  : in std_logic_vector(7 downto 0);
            data_in1  : in std_logic_vector(7 downto 0);
            data_in2  : in std_logic_vector(7 downto 0);
            data_in3  : in std_logic_vector(7 downto 0);
            data_in4  : in std_logic_vector(7 downto 0);
            data_in5  : in std_logic_vector(7 downto 0);
            data_in6  : in std_logic_vector(7 downto 0);
            data_in7  : in std_logic_vector(7 downto 0);
            data_in8  : in std_logic_vector(7 downto 0);
            data_in9  : in std_logic_vector(7 downto 0);
            sel       : in std_logic_vector(3 downto 0);
            enable    : in std_logic;
            data_out  : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component eight_bit_register_general
        port (
            clk : in std_logic;
            clr: in std_logic;
            enable: in std_logic;
            data_in : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component Counter_Register
    port (
            clk    : in  STD_LOGIC;     -- Clock input
            reset  : in  STD_LOGIC;     -- Reset input
            Cp : in  STD_LOGIC;     -- Enable input
            output : out STD_LOGIC_VECTOR (7 downto 0);  -- Output of the counter register
            carry_out : out STD_LOGIC  
        );
    end component;
begin
    
    dmx_in <= data_in;
    data_out <= mux_out;
    
    process(M, PC, SP, WZ, Cp, h_q, l_q, pc_h_q, pc_l_q, sp_h_q, sp_l_q, w_q, z_q)
    begin
        
        if M = '1' then
            addr <= h_q & l_q;
        elsif PC = '1' then
            addr <= pc_h_q & pc_l_q;
        elsif SP = '1' then
            addr <= sp_h_q & sp_l_q;
        elsif WZ = '1' then
            addr <= w_q & z_q;
        else
            addr <= (others => 'Z');
        end if;
        
       
    end process;
    
    mux : mux_10to1_with_enable port map (b_q, c_q, h_q, l_q, pc_h_q, pc_l_q, sp_h_q, sp_l_q, w_q, z_q, mux_sel, mux_e, mux_out);
    dmx : demux_10to1_with_enable port map (dmx_in, dmx_sel, dmx_e, b_d, c_d, h_d, l_d, pc_h_d, pc_l_d, sp_h_d, sp_l_d, w_d, z_d);
    b_reg : eight_bit_register_general port map (clk, clr, dmx_e, b_d, b_q);
    c_reg : eight_bit_register_general port map (clk, clr, dmx_e, c_d, c_q);
    h_reg : eight_bit_register_general port map (clk, clr, dmx_e, h_d, h_q);
    l_reg : eight_bit_register_general port map (clk, clr, dmx_e, l_d, l_q);
    pc_h : Counter_Register port map (clk, clr, carryOut, pc_h_q);
    pc_l : Counter_Register port map (clk, clr, Cp, pc_l_q, carryOut);
    sp_h : eight_bit_register_general port map (clk, clr, dmx_e, sp_h_d, sp_h_q);
    sp_l : eight_bit_register_general port map (clk, clr, dmx_e, sp_l_d, sp_l_q);
    w_reg : eight_bit_register_general port map (clk, clr, dmx_e, w_d, w_q);
    z_reg : eight_bit_register_general port map (clk, clr, dmx_e, z_d, z_q);

end Behavioral;
