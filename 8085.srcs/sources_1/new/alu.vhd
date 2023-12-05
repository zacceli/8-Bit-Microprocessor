library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        A, B : in std_logic_vector(7 downto 0);  -- Input operands
        Op   : in std_logic_vector(1 downto 0);  -- Operation selection
        Cin  : in std_logic;  -- Carry flagSP
        Result : out std_logic_vector(7 downto 0);  -- Output result
        Cout : out std_logic;  -- Carry flag output
        ACout : out std_logic -- Auxiliary carry flag output
    );
end entity ALU;

architecture behavioral of ALU is
    signal sum : unsigned(7 downto 0);
    signal diff : unsigned(7 downto 0);
    signal borrow : std_logic;
    signal carry_out : std_logic;

begin
    
    sum <= unsigned(A) + unsigned(B);
    diff <= unsigned(A) + unsigned(B);
    Result <= std_logic_vector(sum) when Op = "10" else std_logic_vector(diff) when Op = "11" else (others => 'Z');
   
    -- Output carry and auxiliary carry
    Cout <= carry_out;
    ACout <= (A(3) and B(3)) or (B(3) and (not Cin)) or (A(3) and (not Cin));

end architecture behavioral;