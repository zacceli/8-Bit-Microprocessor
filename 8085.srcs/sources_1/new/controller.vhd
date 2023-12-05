library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controller is
    Port ( I : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           CLR : in STD_LOGIC;
           control_word : out STD_LOGIC_VECTOR (20 downto 0);
           HLT : out STD_LOGIC;
           IO: out std_logic);
end controller;

architecture Behavioral of controller is
    type mem1 is array (0 to 255) of std_logic_vector(7 downto 0);
    type mem2 is array (0 to 255) of std_logic_vector(20 downto 0);
    
    constant rom1: mem1 := (
        0 => "00000000",
        1 => "00000001",
        2 => "00000010",
        38 => "00001001",
        103 => "00000100",
        111 => "00000101",
        120 => "00000011",
        136 => "00000110",
        144 => "00000111",
        211 => "00001000",
        others => "00000000"
    );
    
    constant rom2: mem2 := (
        0 => "011110001011111111110",
        1 => "011111000000111111111",
        2 => "011111000100101111110",
        3 => "010100000001110111110",
        4 => "010010000001111011110",
        5 => "010011000001111011110",
        6 => "010100100001111100110",
        7 => "011111000001111011110",
        8 => "011111000001111011110",
        9 => "011111000001111111110",
        10 => "011110001011111111110",
        11 => "011111000000111111111",
        12 => "010000000100111111110",
        
        others => "011111000001111111110"
    );
    
    signal addr1 : integer range 0 to 255;
    signal addr2 : integer range 0 to 15 := 0;
    signal data1 : STD_LOGIC_VECTOR (7 downto 0); 
    signal T : integer range 0 to 5 := 0; 
    signal statusSignals : std_logic_vector(1 downto 0);
    signal count : integer range 0 to 3;
    
    
begin
    addr1 <= to_integer(unsigned(I));
    data1 <= rom1(addr1);
    IO <= '1' when I = "11010011" and T = 3 else '0';
    count <= 1 when I = "00100110" and T = 3 and addr2 = 9 and statusSignals = "11" else count - 1 when T = 1 and count > 0;
    statusSignals <= "11" when count = 0 or CLR = '1' else "01" when I = "00100110" and T = 3 and rom2(addr2) /= "011111000001111111110";
    control_word <= rom2(addr2); 
    HLT <= I(7) and (not I(6)) and (not I(5)) and (not I(4)) and (not I(3)) and (not I(2)) and (not I(1)) and (not I(0)); 
    
    process(CLK, CLR, T, addr2, I, statusSignals, count)
    begin
        if CLR = '1' then 
            T <= 0; 
            addr2 <= 0;
        elsif falling_edge(CLK) then
            if T = 3 then
                if count = 0 then
                     T <= 0;
                     addr2 <= 0;
                else
                    T <= (T + 1) mod 4;
                    addr2 <= addr2 + 1;
                end if;
               
            elsif T = 2 and addr2 = 2 then
                if statusSignals = "11" then
                    T <= (T + 1) mod 4; 
                    addr2 <= to_integer(unsigned(data1));
                else
                    T <= 0;
                    if count = 0 then
                        addr2 <= 0;
                    else 
                        addr2 <= addr2 + 1;
                    end if;
                    
                end if;
            else 
                T <= (T + 1) mod 4; 
                addr2 <= addr2 + 1;
            end if;
            
        end if;
    end process;

end Behavioral;
