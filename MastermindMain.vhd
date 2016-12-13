
-- Create Date: 12/07/2016 02:49:48 AM


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MastermindMain is
    Port ( Color1 : in STD_LOGIC_VECTOR (2 downto 0);
           Color2 : in STD_LOGIC_VECTOR (2 downto 0);
           Color3 : in STD_LOGIC_VECTOR (2 downto 0);
           Color4 : in STD_LOGIC_VECTOR (2 downto 0);
           Rbtn : in STD_LOGIC;
           SubmitBtn : in STD_LOGIC;
           Clk : in STD_LOGIC;
           segment7 : out std_logic_vector(6 downto 0);
           a1, a2, a3, a0 : out STD_LOGIC;
           LED1 : out std_logic_vector(2 downto 0);
           LED2 : out std_logic_vector(2 downto 0);
           LED3 : out std_logic_vector(2 downto 0);
           LED4 : out std_logic_vector(2 downto 0));
end MastermindMain;

architecture Behavioral of MastermindMain is



    component randomgen Port (clk:in std_logic;
                                a:out std_logic_vector(11 downto 0));
    end component;
    
    component ClkDivider port (ClkIn : in std_logic;
                               Divisor : in std_logic_vector(31 downto 0);
                               ClkOut : out std_logic);
    end component;
    
    component Source1 Port (RSPOT : in std_logic_vector(3 downto 0);
                           RCOLOR : in std_logic_vector(3 downto 0);
                        Countdown : in std_logic_vector(3 downto 0);
                            clk : in STD_LOGIC;
                            segment7 : out std_logic_vector(6 downto 0);
                 a1, a2, a3, a0 : out STD_LOGIC);
    end component;
    
    Type StateM is (Initial, SubAns, Dis, CheckEnd);
    signal State : StateM;
    
    signal RandNum : std_logic_vector(11 downto 0);
    signal change : std_logic;
    signal check1 : std_logic_vector(2 downto 0);
    signal check2 : std_logic_vector(2 downto 0);
    signal check3 : std_logic_vector(2 downto 0);
    signal check4 : std_logic_vector(2 downto 0);
    signal RSConnect : std_logic_vector(3 downto 0);
    signal RCConnect : std_logic_vector(3 downto 0);
    signal CountdownConnect : std_logic_vector(3 downto 0);
    signal RSpotCount : integer;
    signal RColorCount : integer;
    signal Countdown : integer;
    signal X : integer range 0 to 5;
    signal Y : integer range 0 to 5;
    signal smallcountdown : integer range 0 to 10;
    signal rs1, rs2, rs3, rs4, rc1, rc2, rc3, rc4 : integer;
    signal r1, r2, r3, r4 : std_logic_vector(2 downto 0);

begin
    
    RandomGenerator : randomgen port map (clk => Clk, a => RandNum);
    SevSegment : Source1 port map (clk => Clk, RSPOT => RSConnect, RCOLOR => RCConnect, Countdown => CountdownConnect, a1 => a1, a2 => a2, a3 => a3, a0 => a0, segment7 => segment7);
    
     r1 <= RandNum(11 downto 9);
     r2 <= RandNum(8 downto 6);
     r3 <= RandNum(5 downto 3);
     r4 <= RandNum(2 downto 0);
     RSConnect <= std_logic_vector(to_unsigned(RSpotCount, 4));
     RCConnect <= std_logic_vector(to_unsigned(RColorCount , 4));
     CountdownConnect <= std_logic_vector(to_unsigned(Countdown , 4));
    
     statemachine : process (Clk, Rbtn) is
     begin
         if (Rbtn = '1') then
             State <= Initial;
         elsif (rising_edge(Clk)) then
             case State is
                 when Initial =>
                     Countdown <= 9;
                     RSpotCount <= 0;
                     RColorCount <= 0;
                     smallcountdown <= 9;
                     check1 <= r1;
                     check2 <= r2;
                     check3 <= r3;
                     check4 <= r4;
                     if (SubmitBtn = '1') then
                         State <= SubAns;
                     end if;
                 when SubAns =>
                     change <= '1';
                     if (Color1 = check1) then
                         rs1 <= 1;
                         rc1 <= 0;
                     elsif (Color2 = check1) then
                         rs1 <= 0;
                         rc1 <= 1;
                     elsif (Color3 = check1) then
                         rs1 <= 0;
                         rc1 <= 1; 
                     elsif (Color4 = check1) then
                         rs1 <= 0;
                         rc1 <= 1; 
                     else
                         rs1 <= 0;
                         rc1 <= 0;                     
                     end if;
                     if (Color1 = check2) then
                         rs2 <= 0;
                         rc2 <= 1;
                     elsif (Color2 = check2) then
                         rs2 <= 1;
                         rc2 <= 0;            
                     elsif (Color3 = check2) then
                         rs2 <= 0;
                         rc2 <= 1;         
                     elsif (Color4 = check2) then
                         rs2 <= 0;
                         rc2 <= 1;
                     else
                         rs2 <= 0;
                         rc2 <= 0;            
                     end if;
                     if (Color1 = check3) then
                         rs3 <= 0;
                         rc3 <= 1;
                     elsif (Color2 = check3) then
                         rs3 <= 0;
                         rc3 <= 1;       
                     elsif (Color3 = check3) then
                         rs3 <= 1;
                         rc3 <= 0;            
                     elsif (Color4 = check3) then
                         rs3 <= 0;
                         rc3 <= 1;
                     else
                         rs3 <= 0;
                         rc3 <= 0;            
                     end if;
                     if (Color1 = check4) then
                         rs4 <= 0;
                         rc4 <= 1;
                     elsif (Color2 = check4) then
                         rs4 <= 0;
                         rc4 <= 1;
                     elsif (Color3 = check4) then
                         rs4 <= 0;
                         rc4 <= 1;
                     elsif (Color4 = check4) then
                         rs4 <= 1;
                         rc4 <= 0;
                     else 
                         rs4 <= 0;
                         rc4 <= 0;
                     end if;                      
                     if (SubmitBtn = '0') then
                         State <= Dis;
                     end if;
                 when Dis =>
                     if (change = '1') then
                         smallcountdown <= (smallcountdown - 1);
                         change <= '0';
                     else
                     end if; 
                     RSpotCount <= (rs1 + rs2 + rs3 + rs4);
                     RColorCount <= (rc1 + rc2 + rc3 + rc4);                   
                     Countdown <= smallcountdown;                                
                     if ((Countdown = 0) or (RSpotCount = 4)) then
                         State <= CheckEnd;
                     elsif (SubmitBtn = '1') then
                         State <= SubAns;
                     end if;
                 when CheckEnd =>
                     if(Countdown = 0) then
                         RSpotCount <= 6;
                         RColorCount <= 0;
                     elsif(RSpotCount = 4) then
                         RSpotCount <= 6;
                         RColorCount <= 6;
                     else
                     end if;                   
                     if (Rbtn = '1') then
                         State <= Initial;
                     else
                     end if;
                 when others =>
                     State <= Initial;
             end case;  
         end if;
     end process statemachine;
        

    LED : process (Clk) is
    begin
    if (rising_edge(Clk)) then
        LED1 <= Color1;
        LED2 <= Color2;
        LED3 <= Color3;
        LED4 <= Color4;
    end if;
    end process LED;
    
    

end Behavioral;
