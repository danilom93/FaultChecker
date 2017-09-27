library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity checkerCU is
    port (
            -- control unit signals
            clock                  : in std_logic;
            reset                  : in std_logic;
            powerOn                : in std_logic;
            okStatus               : out std_logic;
            faultStatus            : out std_logic;
			debugPort              : out std_logic_vector(15 downto 0);

            -- RAM signals
            RAMEnable              : out std_logic;
            RAMWriteEnable         : out std_logic;
            RAMAddr                : out std_logic_vector(7 downto 0);
            RAMDataIn              : out std_logic_vector(15 downto 0);
            RAMDataOut             : in std_logic_vector(15 downto 0);

            --ROM signals
            ROMEnable              : out std_logic;
            ROMAddr                : out std_logic_vector(7 downto 0);

            --Square Root one
			SR_1Enable 		       : out std_logic;
            SR_1Ready              : in std_logic;
            SR_1DataOut            : in std_logic_vector(8 downto 0);

            --Square Root two
			SR_2Enable 		       : out std_logic;
            SR_2Ready              : in std_logic;
            SR_2DataOut            : in std_logic_vector(8 downto 0)
         );

end entity;

architecture behavioral of checkerCU is

    type state_type is (RST_STATE, IDLE_A, IDLE_B, START, S0, S1, S2, S3, S5,
                        COMPARE, ERROR, STOP, DEBUG, FINAL, F0, F1, F2, F3);
    signal currentState            : state_type;
    signal nextState               : state_type;
    signal addrROM                 : std_logic_vector(7 downto 0);
	signal addrRAM			       : std_logic_vector(7 downto 0);
    constant numChecks             : std_logic_vector(7 downto 0) := X"10";
begin

    ROMAddr <= addrROM;
    RAMAddr <= addrRAM;
	RAMDataIn <= "0000000" & SR_1DataOut;

    sync_proc                      : process (clock)

	 begin
        if clock = '1' and clock'event then

            currentState <= nextState;
        end if;
    end process;

    asyn_proc                      : process (currentState, SR_1Ready, SR_2Ready)
        variable count             : std_logic_vector(7 downto 0);
        variable endCompare        : std_logic_vector(7 downto 0);
        variable endCounter        : std_logic_vector(8 downto 0);
    begin

        if (reset = '1') then

            nextState <= RST_STATE;
        elsif (reset = '0') then

            case(currentState) is

                when RST_STATE =>

                    okStatus        <= '0';
                    faultStatus     <= '0';
                    RAMEnable       <= '0';
                    RAMWriteEnable  <= '0';
                    ROMEnable       <= '0';
                    SR_1Enable		<= '0';
                    SR_2Enable		<= '0';
                    debugPort       <= (others => 'Z');
                    addrROM         <= (others => '0');
                    addrRAM		    <= (others => '0');
                    endCounter      := (others => '0');
                    endCompare      := (others => '0');
                    count           := (others => '0');
                    nextState       <= IDLE_A;
                when IDLE_A =>

                    if( powerOn = '1') then

                        nextState <= START;
                    else

                        nextState <= IDLE_B;
                    end if;
                when IDLE_B =>

                    if( powerOn = '1') then

                        nextState <= START;
                    else

                        nextState <= IDLE_A;
                    end if;
                when START =>

                    ROMEnable <= '1';
                    RAMEnable <= '1';
		            nextState <= S0;
                when S0 =>

                    if endCompare = numChecks then

                        addrRAM   <= X"00";
                        nextState <= STOP;
                    else
                        if SR_1Ready = '1' and SR_2Ready = '1' then

                            nextState <= COMPARE;
                        else

                            SR_1Enable  <= '1';
                            SR_2Enable	<= '1';
                            nextState   <= S1;
                        end if;
                    end if;
                when S1 =>

                    nextState <= S2;
                when S2 =>

                    addrROM     <= addrROM + 1;
                    nextState   <= S0;
                when COMPARE =>

                    endCompare  := endCompare + 1;
                    if SR_1DataOut = SR_2DataOut then

                        nextState <= S3;
                    else

                        RAMWriteEnable <= '1';

                        nextState <= ERROR;
                    end if;
                when S3 =>

                    addrROM   <= addrROM + 1;
                    nextState <= S0;

                when ERROR =>

                    count           := count + 1;
                    RAMWriteEnable  <= '0';
                    addrRAM         <= addrRAM + 1;
                    addrROM         <= addrROM + 1;
                    nextState       <= S0;
                when STOP =>

                    if count = 0 then

                        endCounter  := "101110111";
                        okStatus    <= '1';
                        nextState   <= F0;
                    else

                        endCounter  := "001001011";
                        faultStatus <= '1';
                        debugPort   <= X"00" & count;
                        nextState   <= F2;
                    end if;
                when DEBUG =>

                    if addrRAM = count then

                        faultStatus <= '0';
                        debugPort   <= (others => 'Z');
                        nextState   <= FINAL;
                    else

                        debugPort   <= RAMDataOut;
                        addrRAM     <= addrRAM + 1;
                        nextState   <= S5;
                    end if;
                when S5 =>

                    nextState <= DEBUG;
                when FINAL =>

                    okStatus <= '0';
                when F0 =>

                    endCounter  := endCounter - 1;
                    nextState   <= F1;
                when F1 =>

                    if endCounter = 0 then

                        nextState <= FINAL;
                    else

                        nextState <= F0;
                    end if;
                when F2 =>

                    endCounter  := endCounter - 1;
                    nextState   <= F3;
                when F3 =>
                    if endCounter = 0 then

                        nextState <= DEBUG;
                    else

                        nextState <= F2;
                    end if;
                when others =>
            end case;
        end if;
    end process;
end architecture;
