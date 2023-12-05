----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.06.2023 03:35:00
-- Design Name: 
-- Module Name: addr_data_buffer_unit - Behavioral
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

entity addr_data_buffer_unit is
    Port (  data_out : in std_logic_vector (7 downto 0);
            mem_data_out : in std_logic_vector (7 downto 0);
            addr : in std_logic_vector (15 downto 0);
            ad : in std_logic_vector (1 downto 0);
            data_in : out std_logic_vector (7 downto 0);
            output : out std_logic_vector (7 downto 0);
            msb : out std_logic_vector (7 downto 0));
end addr_data_buffer_unit;

architecture Behavioral of addr_data_buffer_unit is

    signal out_data_buf_en : std_logic;
    signal addr_buf_en : std_logic;
    signal in_buf_en : std_logic;
    signal out_data_out : std_logic_vector (7 downto 0);
    signal addr_buf_out : std_logic_vector (7 downto 0);
    signal out_buf_in: std_logic_vector (7 downto 0);
    signal lsb : std_logic_vector (7 downto 0);

    component tri_buffer
        port (
            data_in   : in  std_logic_vector(7 downto 0);
            enable    : in  std_logic;
            data_out  : out std_logic_vector(7 downto 0)
        );
    end component;

begin
    
    msb <= addr(15 downto 8);
    lsb <= addr(7 downto 0);
    out_data_buf_en <= ad(1) and ad(0);
    addr_buf_en <= ad(1) and (not ad(0));
    in_buf_en <= (not ad(1)) and ad(0);
    
    out_buf_in <= out_data_out when ad(0) = '1' else addr_buf_out;
    
    
    out_data_buffer : tri_buffer port map (data_out, out_data_buf_en, out_data_out );
    addr_buf : tri_buffer port map (lsb, addr_buf_en, addr_buf_out);
    out_buffer : tri_buffer port map (out_buf_in, ad(1), output);
    in_buffer : tri_buffer port map (mem_data_out, in_buf_en, data_in);

end Behavioral;
