--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:20:03 05/31/2017
-- Design Name:   
-- Module Name:   C:/Users/Danilo/Documents/ISEPrj/Project/TestROM.vhd
-- Project Name:  Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: patternsRom
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestROM IS
END TestROM;
 
ARCHITECTURE behavior OF TestROM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT patternsRom
    PORT(
         clka : IN  std_logic;
         ena : IN  std_logic;
         addra : IN  std_logic_vector(7 downto 0);
         douta : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clka : std_logic := '0';
   signal ena : std_logic := '0';
   signal addra : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal douta : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clka_period : time := 6666 ps;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: patternsRom PORT MAP (
          clka => clka,
          ena => ena,
          addra => addra,
          douta => douta
        );

   -- Clock process definitions
   clka_process :process
   begin
		clka <= '0';
		wait for clka_period/2;
		clka <= '1';
		wait for clka_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		
		ena <= '1';
      
      for index in 0 to 100 loop
		
			wait for clka_period;
			addra <= addra + 1;
		end loop;
      wait;
   end process;

END;
