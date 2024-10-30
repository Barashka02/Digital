library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TOP is
    Port ( 
        clk    : in STD_LOGIC;
        rst    : in STD_LOGIC;
        switch   : in STD_LOGIC_VECTOR (7 downto 0);
        freq   : out STD_LOGIC;
        gain   : out STD_LOGIC;
        shutdown     : out STD_LOGIC;
        led   : out STD_LOGIC_VECTOR (7 downto 0);
        an: out STD_LOGIC_VECTOR(3 downto 0);
        cat: out STD_LOGIC_VECTOR(6 downto 0)
    );
    
end TOP;

architecture Behavioral of TOP is
    signal addr_s : std_logic_vector (3 downto 0);
    signal note_select : std_logic_vector ( 3 downto 0);
    signal mapped_note_select : std_logic_vector (7 downto 0);
    
    component SwitchPiano is
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
     end component;
    
    component blk_mem_gen_0 is
        PORT (
            clka : IN STD_LOGIC;
            ena : IN STD_LOGIC;
            wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            addra : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            dina : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
          );
    end component;
        
    component clk_count is
        Port ( clk_fast : in STD_LOGIC;
               reset : in STD_LOGIC;
               count_s : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
begin
    with note_select select
        mapped_note_select <=
            "00000001" when "0001",  -- Corresponds to C note (1)
            "00000010" when "0010",  -- Corresponds to D note (2)
            "00000100" when "0011",  -- Corresponds to E note (3)
            "00001000" when "0100",  -- Corresponds to F note (4)
            "00010000" when "0101",  -- Corresponds to G note (5)
            "00100000" when "0110",  -- Corresponds to A note (6)
            "01000000" when "0111",  -- Corresponds to B note (7)
            "10000000" when "1000",  -- Corresponds to C' note (8)
            "00000000" when others;  -- Default or unused value
    -- Instantiate the SwitchPiano module
    U1: SwitchPiano
    port map (
        clk_s      => clk,
        switch_s   => mapped_note_select,
        stop_s     => rst,
        freq_s     => freq,
        LED_s      => led,
        gain_s     => gain,
        shutdown_s => shutdown,
        an_s       => an,
        cat_s      => cat
        
    );
    U2: blk_mem_gen_0
    port map (
        clka => clk, 
        ena => '1',
        wea => "0",
        addra => addr_s,
        dina => "0000",
        douta => note_select
    );
    U3: clk_count
    port map (
        clk_fast => clk,
        reset => rst,
        count_s => addr_s
     );



end Behavioral;