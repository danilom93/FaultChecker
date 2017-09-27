--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:21:12 06/01/2017
-- Design Name:   
-- Module Name:   C:/Users/Danilo/Documents/ISEPrj/Project/TestRAM.vhd
-- Project Name:  Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dataRAM
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
use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestRAM IS
END TestRAM;
 
ARCHITECTURE behavior OF TestRAM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dataRAM
    PORT(
         clka : IN  std_logic;
         ena : IN  std_logic;
         wea : IN  std_logic_vector(0 downto 0);
         addra : IN  std_logic_vector(7 downto 0);
         dina : IN  std_logic_vector(15 downto 0);
         douta : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clka : std_logic := '0';
   signal ena : std_logic := '0';
   --signal wea : std_logic_vector(0 downto 0) := (others => '0');
	signal wea : std_logic := '0';
   signal addra : std_logic_vector(7 downto 0) := (others => '0');
   signal dina : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal douta : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clka_period : time := 6666 ps;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dataRAM PORT MAP (
          clka => clka,
          ena => ena,
          wea(0) => wea,
          addra => addra,
          dina => dina,
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
		
		wea <= '1';
		dina <= X"0001";
		addra <= X"00";
		
		for index in 0 to 20 loop
		
			dina <= dina + index*2;
			addra <= std_logic_vector(to_unsigned(index, addra'length));
			wait for clka_period;
		end loop;
		
		wea <= '0';
		addra <= X"00";
		
		for i in 0 to 20 loop
		
			wait for clka_period;
			addra <= std_logic_vector(to_unsigned(i, addra'length));
		end loop;
		
      wait;
   end process;

END;
