--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:22:23 05/31/2017
-- Design Name:   
-- Module Name:   C:/Users/Danilo/Documents/ISEPrj/Project/TestSquareRoot.vhd
-- Project Name:  Project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: squareRoot
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
 
ENTITY TestSquareRoot IS
END TestSquareRoot;
 
ARCHITECTURE behavior OF TestSquareRoot IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT squareRoot
    PORT(
         x_in : IN  std_logic_vector(15 downto 0);
         x_out : OUT  std_logic_vector(8 downto 0);
         rdy : OUT  std_logic;
         clk : IN  std_logic;
			ce : IN STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
	signal x_in : std_logic_vector(15 downto 0) := (others => '0');
   signal x_in_1 : std_logic_vector(15 downto 0) := (others => '0');
	signal x_in_2 : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';
	signal ce : std_logic := '1';

 	--Outputs
   signal x_out_1 : std_logic_vector(8 downto 0);
	signal x_out_2 : std_logic_vector(8 downto 0);
   signal rdy_1 : std_logic;
	signal rdy_2 : std_logic;

   -- Clock period definitions
   constant clk_period : time := 6666 ps;
	
BEGIN
	
	x_in_1 <= x_in;
	x_in_2 <= x_in;
	
	-- Instantiate the Unit Under Test (UUT)
   uut_1: squareRoot PORT MAP (
          x_in => x_in_1,
          x_out => x_out_1,
          rdy => rdy_1,
          clk => clk,
			 ce => ce
        );
	
	uut_2: squareRoot PORT MAP (
          x_in => x_in_2,
          x_out => x_out_2,
          rdy => rdy_2,
          clk => clk,
			 ce => ce
        );
		  
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

		x_in <= X"0000";
		
		for index in 0 to 100 loop
		
			wait for clk_period;
			x_in <= x_in + 10;
		end loop;
		
      wait;
   end process;

END;
