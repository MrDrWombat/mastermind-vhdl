----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2016 04:17:09 AM
-- Design Name: 
-- Module Name: ClkDivider - Behavioral
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

entity ClkDivider is
    Port (ClkIn : in std_logic;
          Divisor : in std_logic_vector(31 downto 0);
          ClkOut : out std_logic);
end ClkDivider;

architecture Behavioral of ClkDivider is

    signal ClkToggle : std_logic := '0';

begin

    ClkOut <= ClkToggle;
    
    process (ClkIn) is
        variable counter : unsigned(31 downto 0) := x"00000000";
        begin
            if rising_edge(ClkIn) then
                counter := counter + 1;
                if (std_logic_vector(counter) = Divisor) then
                    ClkToggle <= not ClkToggle;
                    counter := x"00000000";
                end if;
            end if;
    end process;
end Behavioral;
