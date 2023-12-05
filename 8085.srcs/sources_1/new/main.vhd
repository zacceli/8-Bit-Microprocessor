----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.06.2023 23:46:23
-- Design Name: 
-- Module Name: main - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
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
    end main;
    
    architecture Behavioral of main is

    signal addr : STD_LOGIC_VECTOR (6 downto 0);
    signal data : STD_LOGIC_VECTOR (7 downto 0);
    signal addr_data_sw : std_logic;
    signal prog_run : STD_LOGIC;
    signal hex_dec : STD_LOGIC;
    signal write : STD_LOGIC;
    signal clr : STD_LOGIC;
    signal reset : STD_LOGIC;
    signal cathodes : STD_LOGIC_VECTOR (6 downto 0);
    signal display_select : STD_LOGIC_VECTOR (3 downto 0);
    signal CLK_p : STD_LOGIC;
    signal CLK_ram : std_logic;
    
    --control signals
    signal control_Word : std_logic_vector(20 downto 0);
    signal RSU : std_logic_vector(5 downto 0);
    signal ALU_Op : std_logic_vector(1 downto 0);
    signal AD : std_logic_vector(1 downto 0);
    signal ALE : std_logic;
    signal WR: std_logic;
    signal RD: std_logic;
    signal Li : std_logic;
    signal La : std_logic;
    signal Ea : std_logic;
    signal Lt : std_logic;
    signal Et : std_logic;
    signal Cp : std_logic;
    signal HLT : STD_LOGIC;

    --bus connections
    signal data_in_reg : std_logic_vector(7 downto 0);
    signal data_out_reg : std_logic_vector(7 downto 0);
    signal bus_to_buffer : std_logic_vector(7 downto 0);
    signal buffer_to_bus : std_logic_vector(7 downto 0);
    signal D_instr_reg : std_logic_vector(7 downto 0);
    signal D_accu : std_logic_vector(7 downto 0);
    signal Q_accu : std_logic_vector(7 downto 0);
    signal D_temp : std_logic_vector(7 downto 0);
    signal Q_temp : std_logic_vector(7 downto 0);
    
    
    --register control unit controls
    signal mux_sel : std_logic_vector(3 downto 0);
    signal dmx_sel : std_logic_vector(3 downto 0);
    signal dmx_e: std_logic;
    signal mux_e: std_logic;
    signal M : std_logic;
    signal SP : std_logic;
    signal PC : std_logic;
    signal WZ : std_logic;
    
    --other connections
    signal reg_addr : std_logic_vector(15 downto 0);
    signal Q_int_addr : std_logic_vector(15 downto 0);
    signal mem_to_buff : std_logic_vector(7 downto 0);
    signal buff_out : std_logic_vector(7 downto 0);
    signal msb_addr : std_logic_vector(7 downto 0);
    signal instr_to_controller : std_logic_vector(7 downto 0);
    signal ALin : std_logic_vector(7 downto 0);
    signal IO : std_logic;
    signal number_seven_segment_driver : STD_LOGIC_VECTOR (15 downto 0);
    signal hex_dec_new : std_logic;
    signal O_D : std_logic_vector(7 downto 0);
    signal O_Q : std_logic_vector(7 downto 0);
    
    --ALU
    signal accu_to_alu : std_logic_vector(7 downto 0);
    signal alu_to_accu : std_logic_vector(7 downto 0);
    signal temp_to_alu : std_logic_vector(7 downto 0);
    signal carry_in: std_logic;
    signal PC_to_alu: std_logic_vector(15 downto 0);
    signal SP_to_alu: std_logic_vector(15 downto 0);
    signal alu_to_PC, alu_to_SP: std_logic_vector(15 downto 0);
    
    --Flags
    signal ACout, Cout: std_logic;
    
    -- RAM
    signal ram_lsb: std_logic_vector(7 downto 0);
    signal ram_addr: std_logic_vector(15 downto 0);
    signal ram_data: std_logic_vector(7 downto 0);
    signal str_ram: std_logic;
    signal ld_ram: std_logic;
    signal clr_ram: std_logic;
    signal write_ram: std_logic;

    signal W_bus: std_logic_vector(7 downto 0);
    
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
    
    component register_select_unit
        Port (  RSU : in STD_LOGIC_VECTOR (5 downto 0);
            mux_sel : out std_logic_vector (3 downto 0);
            dmx_sel : out std_logic_vector (3 downto 0);
            mux_e : out std_logic;
            dmx_e : out std_logic;
            M : out std_logic;
            SP : out std_logic;
            PC : out std_logic;
            WZ : out std_logic);
    end component;
    
    component internal_addr_latch
        port (
            clk : in std_logic;
            data_in : in std_logic_vector(15 downto 0);
            data_out : out std_logic_vector(15 downto 0)
        );
    end component;
    
    component addr_data_buffer_unit
        Port (  data_out : in std_logic_vector (7 downto 0);
            mem_data_out : in std_logic_vector (7 downto 0);
            addr : in std_logic_vector (15 downto 0);
            ad : in std_logic_vector (1 downto 0);
            data_in : out std_logic_vector (7 downto 0);
            output : out std_logic_vector (7 downto 0);
            msb : out std_logic_vector (7 downto 0));
    end component;
    
    component instruction_reg
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Li : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component accumulator
        Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           D_Alu : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           La : in STD_LOGIC;
           Ea : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0);
           Q_tri : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component temp_reg is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Lt : in STD_LOGIC;
           Et : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : inout STD_LOGIC_VECTOR (7 downto 0);
           Q_tri : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component ALU is
        port (
            A, B : in std_logic_vector(7 downto 0);  -- Input operands
            Op   : in std_logic_vector(1 downto 0);  -- Operation selection
            Cin  : in std_logic;  -- Carry flagSP
            Result : out std_logic_vector(7 downto 0);  -- Output result
            Cout : out std_logic;  -- Carry flag output
            ACout : out std_logic -- Auxiliary carry flag output
        );
    end component;
    
    component ram is
        Port ( addr : in STD_LOGIC_VECTOR (15 downto 0);
               Din : in STD_LOGIC_VECTOR (7 downto 0);
               trigger : in STD_LOGIC;
               str : in STD_LOGIC;
               ld : in STD_LOGIC;
               CLR : in STD_LOGIC;
               Dout : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component address_latch is
        port (
            clk : in std_logic;
            data_in : in std_logic_vector(7 downto 0);
            ALE: in std_logic;
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;
    
    component controller is
        Port ( I : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           control_word : out STD_LOGIC_VECTOR (20 downto 0);
           HLT : out STD_LOGIC;
           IO: out std_logic);
    end component;
    
    component seven_segment_driver is
        Port ( clk : in STD_LOGIC;
           num : in unsigned(15 downto 0);
           LED_out : out std_logic_vector(6 downto 0);
           Anode_Activate : out std_logic_vector(3 downto 0));
    end component;
    
    component eight_bit_register_general
        port (
            clk : in std_logic;
            clr : in std_logic;
            enable: in std_logic;
            data_in : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
        );
    end component;
    
    COMPONENT u_ila_0

    PORT (
        clk : IN STD_LOGIC;
    
    
    
        probe0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT  ;

    
begin
    
    addr <= sw(15 downto 9);
    data <= sw(8 downto 1);
    
    hex_dec <= btnU;
    prog_run <= sw(0);
    clr <= btnL; 
    write <= btnC;
    reset <= btnR;
    
    seg <= cathodes;
    an <= display_select; 
    led <= sw; 


    CLK_p <= clk when prog_run = '1' and HLT = '0' else 'Z';
     
    -- Control Words
    RSU <= control_Word(20 downto 15);
    ALU_Op <= control_Word(14 downto 13);
    AD <= control_Word(12 downto 11);
    ALE <= control_Word(10);
    RD <= control_Word(9);
    WR <= control_Word(8);
    Li <= control_Word(7);
    La <= control_Word(6);
    Ea <= control_Word(5);
    Lt <= control_Word(4);
    Et <= control_Word(3);
    Cp <= control_Word(0);
    
    W_bus <= Q_accu when Ea = '0' else
            buffer_to_bus when AD = "01" else
            data_out_reg when mux_e = '1' else
            Q_temp when Et = '0';
    
    CLK_ram <= write and (not prog_run);
    str_ram <= (not prog_run) or (not WR); 
    ld_ram <= '0' when prog_run = '0' else (not RD);
    clr_ram <= clr and (not prog_run);
    ram_addr <= "000000000" & addr when prog_run = '0' else msb_addr & ram_lsb;
    ram_data <= data when prog_run = '0' else buff_out;
    
    hex_dec_new <= '0' when prog_run = '0' else hex_dec; 
    number_seven_segment_driver <= '0' & addr & data when prog_run = '0' else "00000000" & O_Q;
            

    U0: register_select_unit port map (RSU, mux_sel, dmx_sel, mux_e, dmx_e, M, SP, PC, WZ);
    U1: register_block port map (dmx_sel, mux_sel, dmx_e, mux_e, M, SP, PC, WZ, CLK_p, reset, Cp, W_bus, data_out_reg, reg_addr);
    U2: internal_addr_latch port map (CLK_p, reg_addr, Q_int_addr);
    U3: addr_data_buffer_unit port map (W_bus, mem_to_buff, Q_int_addr, AD, buffer_to_bus, buff_out, msb_addr);
    U4: instruction_reg port map (W_bus, CLK_p, Li, reset, instr_to_controller);
    U5: accumulator port map (W_bus, alu_to_accu, CLK_p, La, Ea, reset, accu_to_alu, Q_accu);
    U6: temp_reg port map (W_bus, CLK_p, Lt, Et, reset, temp_to_alu, Q_temp);
    U7: ALU port map (accu_to_alu, temp_to_alu, ALU_Op, carry_in, alu_to_accu, ACout, Cout);
    U8: ram port map (ram_addr, ram_data, CLK_ram, str_ram, ld_ram, clr_ram, mem_to_buff);
    U9: address_latch port map (CLK_p, buff_out, ALE, ram_lsb);
    U10: controller port map (instr_to_controller, CLK_p, reset, control_Word, HLT, IO);
    U11: seven_segment_driver port map (clk, unsigned(number_seven_segment_driver), cathodes, display_select);
    U12: eight_bit_register_general port map (CLK_p, reset, IO, W_bus, O_Q);
    your_instance_name : u_ila_0
        PORT MAP (
            clk => clk,
        
        
        
        probe0 => D_accu
    );
    

end Behavioral;
