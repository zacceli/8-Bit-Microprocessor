library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ram is
    Port ( addr : in STD_LOGIC_VECTOR (15 downto 0);
           Din : in STD_LOGIC_VECTOR (7 downto 0);
           trigger : in STD_LOGIC;
           str : in STD_LOGIC;
           ld : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Dout : out STD_LOGIC_VECTOR (7 downto 0));
end ram;

architecture Behavioral of ram is
    type mem is array (0 to 1023) of  STD_LOGIC_VECTOR (7 downto 0);
    
    signal memory : mem := (others => "00000000"); 
    signal addr_int : integer range 0 to 15;

begin
    process(addr, Din, trigger, str, ld, CLR)
    begin
        addr_int <= to_integer(unsigned(addr));
        if CLR = '1' then
            memory <= (others => "00000000"); 
        end if;
        if str = '1' and rising_edge(trigger) then
            memory(addr_int) <= Din; 
        end if;
        if ld = '1' then
            Dout <= memory(addr_int); 
        else Dout <= (others => 'Z');
        end if;
    end process;

end Behavioral;
