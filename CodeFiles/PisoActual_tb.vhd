 -------------------------------------------------------------------------------
 -- Title : Piso Actual (tb)
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : PisoActual_tb.vhd
 -- Author : EnriqueHE (and  modified by AranchaCM)
 -- Created : 2016/12/26
 -- Last modified : 2017/01/11 
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements the testbench of PisoActual.vhd
 -------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
 
ENTITY PisoActual_tb IS
END PisoActual_tb;
 
ARCHITECTURE behavior OF PisoActual_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PisoActual
    PORT(
         SensorEstoy : IN  std_logic_vector(3 downto 0);
			CLK: IN STD_LOGIC;
         PisoEstoy : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SensorEstoy : std_logic_vector(3 downto 0);
	signal CLK: std_logic;

 	--Outputs
   signal PisoEstoy : std_logic_vector(3 downto 0);
	
	-- Clock period definitions
   constant CLK_period : time := 10 ns;
	
	type vtest is record 
			SensorEstoy : std_logic_vector(3 downto 0);
			PisoEstoy : std_logic_vector(3 downto 0);
	end record;
	
	type vtest_vector is array (natural range <>) of vtest;
 
   constant test: vtest_vector := ( 
				 (sensorEstoy => "0000", pisoEstoy => "0000"), 
				 (sensorEstoy => "0001", pisoEstoy => "0001"),
				 (sensorEstoy => "0000", pisoEstoy => "0001"),
				 (sensorEstoy => "0010", pisoEstoy => "0010"),
				 (sensorEstoy => "0000", pisoEstoy => "0010"),
				 (sensorEstoy => "0100", pisoEstoy => "0100"),
				 (sensorEstoy => "0000", pisoEstoy => "0100"),				 
				 (sensorEstoy => "0110", pisoEstoy => "0100"),
				 (sensorEstoy => "0010", pisoEstoy => "0010"),
				 (sensorEstoy => "1000", pisoEstoy => "1000")		 
	);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PisoActual PORT MAP (
          SensorEstoy => SensorEstoy,
			 CLK => CLK,
          PisoEstoy => PisoEstoy
        );
   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for Clk_period/2;
		CLK <= '1';
		wait for Clk_period/2;
   end process;
	
	tb: process
	
	begin
		for i in 0 to test'high loop
			SensorEstoy <= test(i).SensorEstoy;
			wait for 200 ns;
			assert PisoEstoy = test(i).PisoEstoy
				report "salida incorrecta"
				severity failure;
		end loop;
		
		assert false
			report "simulacion finalizada. Test superado."
			severity failure;
				
	end process;

END;
