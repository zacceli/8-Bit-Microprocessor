library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter_Register is
    port (
        clk    : in  STD_LOGIC;     -- Clock input
        reset  : in  STD_LOGIC;     -- Reset input
        Cp : in  STD_LOGIC;     -- Enable input
        output : out STD_LOGIC_VECTOR (7 downto 0);  -- Output of the counter register
        carry_out : out STD_LOGIC  
    );
end Counter_Register;

architecture Behavioral of Counter_Register is
    signal count : unsigned(7 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then  -- Synchronous reset
            count <= (others => '0');
        elsif rising_edge(clk) then  -- Rising edge of the clock
            if Cp = '1' then  -- Counter is enabled
                count <= count + 1;
            end if;
        end if;
    end process;

    output <= std_logic_vector(count);
    carry_out <= '1' when (count = "11111111") else '0';
end Behavioral;
