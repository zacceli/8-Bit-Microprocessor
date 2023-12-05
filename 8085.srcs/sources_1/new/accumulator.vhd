library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity accumulator is
    Port ( D : in STD_LOGIC_VECTOR (7 downto 0);
           D_Alu : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           La : in STD_LOGIC;
           Ea : in STD_LOGIC;
           CLR : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0);
           Q_tri : out STD_LOGIC_VECTOR (7 downto 0));
end accumulator;

architecture Behavioral of accumulator is

    signal reg : std_logic_vector(7 downto 0);
begin

    reg <= D_Alu when D_Alu /= "ZZZZZZZZ" else D when rising_edge(CLK) and La = '0';
    Q <= reg when falling_edge(CLK);
    Q_tri <= reg when Ea = '0' else (others => 'Z');

end Behavioral;
