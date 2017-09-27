--------------------------------------------------------------------------------
-- Company                                  :
-- Engineer                                 :
--
-- Create Date                              : 12:58:15 06/01/2017
-- Design Name                              :
-- Module Name                              : C:/Users/Danilo/Documents/ISEPrj/Project/TestChecker.vhd
-- Project Name                             : Project
-- Target Device                            :
-- Tool versions                            :
-- Description                              :
--
-- VHDL Test Bench Created by ISE for module: top_checker
--
-- Dependencies                             :
--
-- Revision                                 :
-- Revision 0.01 - File Created
-- Additional Comments                      :
--
-- Notes                                    :
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test. Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY TestChecker IS
END TestChecker;

ARCHITECTURE behavior OF TestChecker IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT top_checker
    PORT(
         powerOn                            : IN std_logic;
         clock                              : IN std_logic;
         reset                              : IN std_logic;
         okStatus                           : OUT std_logic;
         faultStatus                        : OUT std_logic;
         debugPort                          : OUT std_logic_vector(15 downto 0)
        );
    END COMPONENT;


   --Inputs
   signal powerOn                           : std_logic := '0';
   signal clock                             : std_logic := '0';
   signal reset                             : std_logic := '0';

 	--Outputs
   signal okStatus                          : std_logic;
   signal faultStatus                       : std_logic;
   signal debugPort                         : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clock_period                    : time := 6666 ps;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut                                      : top_checker PORT MAP (
          powerOn => powerOn,
          clock => clock,
          reset => reset,
          okStatus => okStatus,
          faultStatus => faultStatus,
          debugPort => debugPort
        );

   -- Clock process definitions
   clock_process                            :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;


   -- Stimulus process
   stim_proc                                : process
   begin

		powerOn <= '0';
		reset <= '0';
		wait for clock_period*2;
		reset <= '1';
		wait for clock_period;
		reset <= '0';
		wait for clock_period*7;
		powerOn <= '1';
		wait for 1500 ns;
		powerOn <= '0';

      wait;
   end process;

END;
