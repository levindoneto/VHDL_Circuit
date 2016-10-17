----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:40:45 03/31/2016 
-- Design Name: 
-- Module Name:    registrador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador is
    Port ( dado : in  STD_LOGIC_VECTOR (3 downto 0);
           cont_out : out STD_LOGIC_VECTOR (3 downto 0);
			  cont_enable : in STD_LOGIC;
			  CLK : in  STD_LOGIC;
           init : in  STD_LOGIC;
			  up_down : in STD_LOGIC;
           RST : in  STD_LOGIC);
end contador;

architecture Behavioral of contador is
signal contador: std_logic_vector (3 downto 0);
begin
-- process (CLK)
-- begin
-- if (CLK'event and CLK = '1') then
-- if (RST = '1') then
-- Q <= "00000000";
-- elsif SET ='1' then
-- Q <= "00000000";
-- else
-- Q <= D;
-- end if;
-- end if;
-- end process;  
process (clk,rst)
begin
if rst='1' then
	contador<= (others=>'0');
	elsif (clk'event and clk='1') then
		if (init='1') then
		contador <=dado;
		else
		if(cont_enable='1') then
			if(up_down='0') then
			contador <= contador + 1;
			else
			contador<= contador - 1;
			
			end if;
		else
		contador<=contador;
	end if;
end if;
end if;
end process;
cont_out<= contador;

end Behavioral;

