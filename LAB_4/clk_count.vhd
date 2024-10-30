----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/29/2024 03:09:48 PM
-- Design Name: 
-- Module Name: clk_count - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_count is
    Port ( clk_fast : in STD_LOGIC;
           reset : in STD_LOGIC;
           count_s : out STD_LOGIC_VECTOR (3 downto 0));
end clk_count;

architecture Behavioral of clk_count is

    signal count: integer := 0; 
    signal freq_sel : STD_LOGIC_VECTOR (3 downto 0);

begin
    
process(clk_fast, reset)
    begin 
    if rising_edge(clk_fast) then
        if reset = '1' then    
            count <= count; 
        else
            if count = 50000000 then 
                freq_sel <= std_logic_vector(unsigned(freq_sel) + 1);
                count <= 0;
            else 
                count <= count + 1;
            end if;
         end if;
     end if;
end process;
            
count_s <= freq_sel;

end Behavioral;
