library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_count is
    Port ( clk_fast : in STD_LOGIC;
           reset : in STD_LOGIC;
           count_s : out STD_LOGIC_VECTOR (3 downto 0));
end clk_count;

architecture Behavioral of clk_count is
    signal count : integer := 0; 
    signal freq_sel : STD_LOGIC_VECTOR (3 downto 0) := "0000";  -- Initialize to 0
    constant COUNT_MAX : integer := 50000000;  -- Adjust based on 0.5s interval at 100 MHz
begin
    process(clk_fast, reset)
    begin 
        if rising_edge(clk_fast) then
            if reset = '1' then    
                count <= 0;             -- Reset counter on reset signal
                freq_sel <= "0000";      -- Reset freq_sel to start song from beginning
            else
                if count = COUNT_MAX then 
                    if freq_sel = "1111" then
                        freq_sel <= "0000";   -- Reset to 0 when reaching 16
                    else
                        freq_sel <= std_logic_vector(unsigned(freq_sel) + 1);  -- Increment address
                    end if;
                    count <= 0;
                else 
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;
            
    count_s <= freq_sel;  -- Output the address for BRAM

end Behavioral;
