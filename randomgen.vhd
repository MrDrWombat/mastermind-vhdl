----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2016 12:59:26 PM
-- Design Name: 
-- Module Name: randomgen - Behavioral
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

entity randomgen is
  Port (
   clk:in std_logic;
   a:out std_logic_vector(11 downto 0));
end randomgen;

architecture Behavioral of randomgen is

begin

    Gen:process is
    variable temp:std_logic_vector(11 downto 0) := "000000000001";
    begin
        temp := temp(10 downto 0 )  & (temp(11) xor temp(10) );
        a <= temp;
        wait until (clk = '0');
    end process Gen;

end Behavioral;
