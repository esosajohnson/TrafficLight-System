library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Traffic_Lights_TB is
end entity;
  
architecture Behavioral of Traffic_Lights_TB is
  
     -- Define clock frequency and period (low frequency for faster simulation)
    constant ClockFreq : integer := 100; -- 1 Hz
    constant ClockPeriod : time := 1000 ms / ClockFreq;
 
    -- Signals for the testbench
    signal Clk           : std_logic := '1'; -- Clock signal
    signal negReset      : std_logic := '0'; -- Active negative reset
    signal NorthLight    : std_logic_vector(2 downto 0); -- North traffic light
    signal EastWestLight : std_logic_vector(2 downto 0); -- East-West traffic light
  
begin
  
    -- The Device Under Test (DUT)
    i_Traffic_Lights : entity work.Traffic_Lights(Behavioral)
    port map (
        Clk             => Clk,
        negReset        => negReset,
        NorthLight      => NorthLight,
        EastWestLight   => EastWestLight);
  
    -- Process for generating clock
    Clk <= not Clk after ClockPeriod / 2;
  
  -- Testbench sequence process (no nested clock statements)
  process
  begin
    -- Wait for two clock cycles without nested clock statements
    for i in 1 to 2 loop
      wait until rising_edge(Clk);
    end loop;

    -- Take the DUT out of reset
    negReset <= '1';

    -- Wait for simulation to run
    wait;
  end process;
  
end Behavioral;
