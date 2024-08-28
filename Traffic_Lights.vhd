library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Traffic_Lights is
port(
    Clk, negReset   : in std_logic;
    NorthLight      : out std_logic_vector(2 downto 0);  -- North traffic light (Red, Yellow, Green)
    EastWestLight   : out std_logic_vector(2 downto 0));  -- East-West traffic light (Red, Yellow, Green)
end entity;
  
architecture Behavioral of Traffic_Lights is

    constant ClockFreq   : integer := 100;
    constant ClockPeriod : time := 1000 ms / ClockFreq;
  
    -- Enumerated type declaration and state signal declaration
    type t_State is (AllRed, NorthWait, NorthGo, EndNorth,
                        AllRedAgain, EastWestWait, EastWestGo, EndEastWest);
    signal State : t_State;
  
    -- Counter for counting clock periods, 1 minute max
    signal CycleCounter : integer range 0 to ClockFreq * 60;
  
begin
  
    process(Clk) is
    begin
        if rising_edge(Clk) then
            if negReset = '0' then
                -- Reset values
                State   <= AllRed;
                CycleCounter <= 0;
                -- Red (MSB), Yellow, Green (LSB)   
                NorthLight      <= "100";  
                EastWestLight   <= "100";
  
            else
            -- Default values (all lights off during reset)
            NorthLight      <= "000";
            EastWestLight   <= "000";
  
                CycleCounter <= CycleCounter + 1;
  
                case State is
  
                    -- Red light in all directions
                    when AllRed =>
                        NorthLight      <= "100";
                        EastWestLight   <= "100";
                        -- If 2 seconds have passed
                        if CycleCounter = ClockFreq * 2 - 1 then
                            CycleCounter <= 0;
                            State <= NorthWait;
                        end if;
  
                    -- Red and yellow lights in north direction
                    when NorthWait =>
                        NorthLight      <= "110";
                        EastWestLight   <= "100";
                        -- If 2 seconds have passed
                        if CycleCounter = ClockFreq * 2 - 1 then
                            CycleCounter <= 0;
                            State <= NorthGo;
                        end if;
  
                    -- Green light in north direction
                    when NorthGo =>
                        NorthLight      <= "001";
                        EastWestLight   <= "100";
                        -- If 30 seconds has passed
                        if CycleCounter = ClockFreq * 30 - 1 then
                            CycleCounter <= 0;
                            State <= EndNorth;
                        end if;
  
                    -- Yellow light in north direction
                    when EndNorth =>
                        NorthLight      <= "010";
                        EastWestLight   <= "100";
                        -- If 2 seconds have passed
                        if CycleCounter = ClockFreq * 2 - 1 then
                            CycleCounter <= 0;
                            State <= AllRedAgain;
                        end if;
  
                    -- Red light in all directions
                    when AllRedAgain =>
                        NorthLight      <= "100";
                        EastWestLight   <= "100";
                        -- If 2 seconds have passed
                        if CycleCounter = ClockFreq * 2 - 1 then
                            CycleCounter <= 0;
                            State <= EastWestWait;
                        end if;
  
                    -- Red and yellow lights in west/east direction
                    when EastWestWait =>
                        NorthLight      <= "100";
                        EastWestLight   <= "110";
                        -- If 2 seconds have passed
                        if CycleCounter = ClockFreq * 2 - 1 then
                            CycleCounter <= 0;
                            State <= EastWestGo;
                        end if;
  
                    -- Green light in west/east direction
                    when EastWestGo =>
                        NorthLight      <= "100";
                        EastWestLight   <= "001";
                        -- If 30 seconds has passed
                        if CycleCounter = ClockFreq * 30 -1 then
                            CycleCounter <= 0;
                            State <= EndEastWest;
                        end if;
  
                    -- Yellow light in west/east direction
                    when EndEastWest =>
                        NorthLight      <= "100";
                        EastWestLight   <= "010";
                        -- If 2 seconds have passed
                        if CycleCounter = ClockFreq * 2 - 1 then
                            CycleCounter <= 0;
                            State <= AllRed;
                        end if;
  
                end case;
  
            end if;
        end if;
    end process;
  
end Behavioral;
