 -------------------------------------------------------------------------------
 -- Title : Entidad Acensor (tb)
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : EntidadAscensor_tb.vhd
 -- Author : AranchaCM, AlbertoBB, EnriqueHA
 -- Created : 2017/01/11
 -- Last modified : 2017/01/11
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements the testbench of EntidadAscensor.vhd
 -------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
 
ENTITY EntidadAscensor_tb IS
END EntidadAscensor_tb;
 
ARCHITECTURE behavior OF EntidadAscensor_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EntidadAscensor
    Port ( SensorVoy         : in  STD_LOGIC_VECTOR (3 downto 0);
           SensorEstoy       : in  STD_LOGIC_VECTOR (3 downto 0);
           CLK 			   : in STD_LOGIC;
           A0              : out  STD_LOGIC;
           A1              : out  STD_LOGIC;
           A2              : out  STD_LOGIC;
           A3              : out  STD_LOGIC;
		     Salida7s        : out  STD_LOGIC_VECTOR(6 downto 0)
		  );
    END COMPONENT;
    

   --Inputs
   signal SensorVoy : STD_LOGIC_VECTOR (3 downto 0);
   signal SensorEstoy : STD_LOGIC_VECTOR (3 downto 0);
   signal CLK 		:  STD_LOGIC;

   --Outputs
   signal A0  :   STD_LOGIC;
   signal A1  :   STD_LOGIC;
   signal A2  :   STD_LOGIC;
   signal A3  :   STD_LOGIC;
   signal Salida7s :  STD_LOGIC_VECTOR(6 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;

   type vtest is record 
	   A0  :   STD_LOGIC;
	   A1  :   STD_LOGIC;
	   A2  :   STD_LOGIC;
	   A3  :   STD_LOGIC;
	   Salida7s :  STD_LOGIC_VECTOR(6 downto 0);
   end record;
	
   type vtest_vector is array (natural range <>) of vtest;
 
   constant test: vtest_vector := ( 
		(A0=> '1', A1=> '0', A2=> '0', A3=> '0',Salida7s => "1011011"),
		(A0=> '0', A1=> '1', A2=> '0', A3=> '0',Salida7s => "1001110"),
		(A0=> '0', A1=> '0', A2=> '1', A3=> '0',Salida7s => "1001100"),
		(A0=> '0', A1=> '0', A2=> '0', A3=> '1',Salida7s => "1001111")	 
	);
 
BEGIN

-- Instantiate the Unit Under Test (UUT)
   uut: EntidadAscensor PORT MAP (
          SensorVoy => SensorVoy,
          SensorEstoy => SensorEstoy,
          Clk => Clk,
          A0 => A0,
          A1 => A1,
          A2 => A2,
          A3 => A3,
          Salida7s => Salida7s
        );
  
-- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 
tb: process
	
	begin
		for i in 0 to test'high loop
			SensorVoy <= "1000";
			SensorEstoy <= "0001";
			WAIT FOR 40 ns;
				ASSERT A0 = test(i).A0 and 
					   A1 = test(i).A1 and
					   A2 = test(i).A2 and
					   A3 = test(i).A3 and 
					   Salida7s = test(i).Salida7s 

				REPORT "Salida incorrecta." 
				SEVERITY FAILURE;
		END LOOP;
		
		assert false
			report "simulacion finalizada. Test superado."
			severity failure;
				
end process;

END;
