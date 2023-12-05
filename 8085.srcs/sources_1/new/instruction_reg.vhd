library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instruction_reg is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Li : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end instruction_reg;

architecture Behavioral of instruction_reg is
signal reg : std_logic_vector(7 downto 0);
begin
    process(D, CLK, Li, CLR)
    begin
        if CLR = '1' then
            reg <= (others => '0');
        end if;
        if rising_edge(CLK) and Li = '0' then
                reg <= D;
             
        end if; 
        
    end process; 
    
    Q <= reg;

end Behavioral;
