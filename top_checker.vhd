----------------------------------------------------------------------------------
-- Company                       :
-- Engineer                      :
--
-- Create Date                   : 11:04:06 06/01/2017
-- Design Name                   :
-- Module Name                   : top_checker - Behavioral
-- Project Name                  :
-- Target Devices                :
-- Tool versions                 :
-- Description                   :
--
-- Dependencies                  :
--
-- Revision                      :
-- Revision 0.01 - File Created
-- Additional Comments           :
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

entity top_checker is

    Port ( powerOn               : in STD_LOGIC;
           clock                 : in STD_LOGIC;
           reset                 : in STD_LOGIC;
           okStatus              : out STD_LOGIC;
           faultStatus           : out STD_LOGIC;
           debugPort             : out STD_LOGIC_VECTOR (15 downto 0));
end top_checker;

architecture Behavioral of top_checker is

    component dataRAM
        port (
          clka                   : IN STD_LOGIC;
          ena                    : IN STD_LOGIC;
          wea                    : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
          addra                  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
          dina                   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
          douta                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component dataRAM;

    component patternsRom
        port (
          clka                   : IN STD_LOGIC;
          ena                    : IN STD_LOGIC;
          addra                  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
          douta                  : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component patternsRom;

    component squareRoot
        port (
          x_in                   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
          x_out                  : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
          rdy                    : OUT STD_LOGIC;
          clk                    : IN STD_LOGIC;
			 ce 				 : IN STD_LOGIC
        );
    end component squareRoot;

    component checkerCU
        port (
          clock                  : in std_logic;
          reset                  : in std_logic;
          powerOn                : in std_logic;
          okStatus               : out std_logic;
          faultStatus            : out std_logic;
		    debugPort		     : out std_logic_vector(15 downto 0);
          RAMEnable              : out std_logic;
          RAMWriteEnable         : out std_logic;
          RAMAddr                : out std_logic_vector(7 downto 0);
          RAMDataIn              : out std_logic_vector(15 downto 0);
          RAMDataOut             : in std_logic_vector(15 downto 0);
          ROMEnable              : out std_logic;
          ROMAddr                : out std_logic_vector(7 downto 0);
			 SR_1Enable 		 : out std_logic;
          SR_1Ready              : in std_logic;
          SR_1DataOut            : in std_logic_vector(8 downto 0);
			 SR_2Enable 		 : out std_logic;
          SR_2Ready              : in std_logic;
          SR_2DataOut            : in std_logic_vector(8 downto 0)
);
end component checkerCU;

---signals

signal SR_s                      : std_logic_vector(15 downto 0);

signal SR_1Ready_s               : std_logic;
signal SR_1Enable_s 			 : std_logic;
signal SR_1DataIn_s              : std_logic_vector(15 downto 0);
signal SR_1DataOut_s             : std_logic_vector(8 downto 0);

signal SR_2Ready_s               : std_logic;
signal SR_2Enable_s 			 : std_logic;
signal SR_2DataIn_s              : std_logic_vector(15 downto 0);
signal SR_2DataOut_s             : std_logic_vector(8 downto 0);

signal ROMData_s                 : std_logic_vector(15 downto 0);
signal ROMEnable_s               : std_logic;
signal ROMAddr_s                 : std_logic_vector(7 downto 0);

signal RAMEnable_s               : std_logic;
signal RAMWriteEnable_s          : std_logic;
signal RAMAddr_s                 : std_logic_vector(7 downto 0);
signal RAMDataIn_s               : std_logic_vector(15 downto 0);
signal RAMDataOut_s              : std_logic_vector(15 downto 0);

begin

    SR_s <= ROMData_s;
    SR_1DataIn_s <= SR_s;
    SR_2DataIn_s <= SR_s;

    core_1                       : squareRoot port map (
                                  x_in => SR_1DataIn_s,
                                  x_out => SR_1DataOut_s,
                                  rdy => SR_1Ready_s,
                                  clk => clock,
								  ce	=> SR_1Enable_s
                                );

    core_2                       : squareRoot port map (
                                  x_in => SR_2DataIn_s,
                                  x_out => SR_2DataOut_s,
                                  rdy => SR_2Ready_s,
                                  clk => clock,
								  ce	=> SR_1Enable_s
                                );

    patternsRom_1                : patternsRom port map (
                                  clka => clock,
                                  ena => ROMEnable_s,
                                  addra => ROMAddr_s,
                                  douta => ROMData_s
                                );

    dataRAM_1                    : dataRAM port map (
                                  clka => clock,
                                  ena => RAMEnable_s,
                                  wea(0)=> RAMWriteEnable_s,
                                  addra => RAMAddr_s,
                                  dina => RAMDataIn_s,
                                  douta => RAMDataOut_s
                                );

    checkerCU_i                  : checkerCU port map (
                                  clock => clock,
                                  reset => reset,
                                  powerOn => powerOn,
                                  okStatus => okStatus,
                                  faultStatus => faultStatus,
                                  debugPort => debugPort,
                                  RAMEnable => RAMEnable_s,
                                  RAMWriteEnable => RAMWriteEnable_s,
                                  RAMAddr => RAMAddr_s,
                                  RAMDataIn => RAMDataIn_s,
                                  RAMDataOut => RAMDataOut_s,
                                  ROMEnable => ROMEnable_s,
                                  ROMAddr => ROMAddr_s,
							      SR_1Enable => SR_1Enable_s,
                                  SR_1Ready => SR_1Ready_s,
                                  SR_1DataOut => SR_1DataOut_s,
							      SR_2Enable => SR_2Enable_s,
                                  SR_2Ready => SR_2Ready_s,
                                  SR_2DataOut => SR_2DataOut_s
                                );

end Behavioral;
