----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2024 11:05:20 AM
-- Design Name: 
-- Module Name: SwitchPiano - Behavioral
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

entity SwitchPiano is
    Port ( clk_s : in STD_LOGIC;
           stop_s : in STD_LOGIC;
           switch_s : in STD_LOGIC_VECTOR (7 downto 0);
           freq_s : out STD_LOGIC;
           gain_s : out STD_LOGIC;
           shutdown_s : out STD_LOGIC;
           LED_s : out STD_LOGIC_VECTOR (7 downto 0);
           an_s: out STD_LOGIC_VECTOR(3 downto 0);
           cat_s: out STD_LOGIC_VECTOR(6 downto 0)
           );
end SwitchPiano;

architecture Behavioral of SwitchPiano is
    constant C4 : integer := 382219/2;
    constant D4 : integer := 340530/2;
    constant E4 : integer := 303379/2;
    constant F4 : integer := 286345/2;
    constant G4 : integer := 255102/2;
    constant A4 : integer := 227273/2;
    constant B4 : integer := 202478/2;
    constant C5 : integer := 191113/2;
    
    signal count : integer := 0;
    signal freq_reg: std_logic := '0';
begin
   process(clk_s)
   begin 
   if rising_edge(clk_s) then
        if stop_s = '1' then
            freq_reg <= '0';
            LED_s <= "00000000";
            an_s <= "0000";
            cat_s <= "0000001";
            
        else  
            an_s <= "0111";
            case switch_s is 
                when "10000000" =>
                    LED_s <= "10000000";
                    cat_s <= "0000000";
                    if count = C5 then 
                        freq_reg <= not freq_reg;
                        count <= 0;
                    else
                        count <= count + 1;
                    end if;
 
                 when "01000000" =>
                    LED_s <= "01000000";
                    cat_s <= "0001111";
                    if count = B4 then 
                        freq_reg <= not freq_reg;
                        count <= 0;
                    else
                        count <= count + 1;
                    end if;
                 when "00100000" =>
                    LED_s <= "00100000";
                    cat_s <= "0100000";
                    if count = A4 then 
                        freq_reg <= not freq_reg;
                        count <= 0;
                    else
                        count <= count + 1;
                    end if;
                 when "00010000" =>
                    LED_s <= "00010000";
                    cat_s <= "0100100";
                    if count = G4 then 
                        freq_reg <= not freq_reg;
                        count <= 0;
                    else
                        count <= count + 1;
                    end if;
                 when "00001000" =>
                    LED_s <= "00001000";
                    cat_s <= "1001100";
                    if count = F4 then 
                        freq_reg <= not freq_reg;
                        count <= 0;
                    else
                        count <= count + 1;
                    end if;     
                 when "00000100" =>
                    LED_s <= "00000100";
                    cat_s <= "0000110";
                    if count = E4 then 
                        freq_reg <= not freq_reg;
                        count <= 0;
                    else
                        count <= count + 1;
                    end if;
                 when "00000010" =>
                    LED_s <= "00000010";
                    cat_s <= "0010010";
                    if count = D4 then 
                        freq_reg <= not freq_reg;
                        count <= 0;
                    else
                        count <= count + 1;
                    end if; 
                 when "00000001" =>
                    LED_s <= "00000001";
                    cat_s <= "1001111";
                    if count = C4 then 
                        freq_reg <= not freq_reg;
                        count <= 0;
                    else
                        count <= count + 1;
                    end if;   
                 when others =>
                    LED_s <= "00000000";
                    cat_s <= "1111111";
                    freq_reg <= '0';
                end case;
            end if;
        end if;
  end process;
  
  freq_s <= freq_reg;
  gain_s <= '1';
  shutdown_s <= '1';

  
                    
end Behavioral;