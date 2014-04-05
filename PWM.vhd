----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:07:36 04/05/2014 
-- Design Name: 
-- Module Name:    PWM - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PWM is
    Port ( CLK : in  STD_LOGIC;
           LD : out  STD_LOGIC_vector (4 downto 0);
			  SW: in std_logic_vector (4 downto 0);
			  btn_pl: in std_logic;
			  btn_min: in std_logic
			  );
end PWM;

architecture Behavioral of PWM is
	
signal clk_cnt: integer range 0 to 10000 := 0;
signal clk_alt: std_logic :='1';
signal clk_alt_old: std_logic :='1';

signal btn_min_old: std_logic :='1';
signal btn_pl_old: std_logic := '1';
signal mm: integer range 0 to 10000:= 1000;

signal a, d: integer range 0 to 10000:= 0;


begin

process (CLK)
begin
		if rising_edge(CLK) then
			if clk_cnt < 10000 then
				clk_cnt <= clk_cnt + 1;
				
			else
				clk_cnt <= 0;
				if clk_alt = '0' then
					clk_alt <= '1';
				else
					clk_alt <= '0';
				end if;
			end if;
		end if;
end process;


process (CLK)
begin 
	if rising_edge(clk) then
			
		if SW(0) = '1' then 
			LD(0) <= '1';
		else
			LD(0) <= '0';
		end if;
		
	end if;
end process;
		
process(clk)		
	begin 
	if rising_edge(clk) then
		if clk_alt_old = '1' and clk_alt = '0' then
			d<= 0;
		else
			if SW(1) = '1' and d <8000 then  --
				d <= d+1;
				LD(1) <= '1';
			else
				--if d >= 9999 then
					--d <= 0;
				--end if;
				LD(1) <= '0';
			end if;
		end if;
		
	end if;
end process;	



process(clk)		
	begin 
	if rising_edge(clk)then

		if clk_alt_old = '1' and clk_alt = '0' then
			a<= 0;
		else
			if  a < mm then  --SW(2) = '1' and 
				a <= a+1;
				LD(2) <= '1';
			else
				if a >= 99999 then
					a <= 0;
				end if;
			LD(2) <= '0';
			end if;	
		
		end if;
		
		if btn_pl_old ='0' and btn_pl = '1' and mm < 10000 then
			mm <= mm +1000;
		else 
			if btn_min_old ='0' and btn_min = '1' and mm >= 1000  then
				mm <= mm - 1000;
			end if;
		end if;
		
		btn_pl_old <= btn_pl;
		btn_min_old <= btn_min;
		clk_alt_old <= clk_Alt;
	end if;
end process;
end Behavioral;

