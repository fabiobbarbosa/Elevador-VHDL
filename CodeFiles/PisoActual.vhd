 -------------------------------------------------------------------------------
 -- Title : Piso Actual
 -- Project : Elevator-VHDL
 -------------------------------------------------------------------------------
 -- File : PisoActual.vhd
 -- Author : EnriqueHE
 -- Created : 2016/12/26
 -- Last modified : 2017/01/11
 -------------------------------------------------------------------------------
 -- Description :
 -- Implements the filter of the endstops
 -------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PisoActual is
    Port ( SensorEstoy : in  STD_LOGIC_VECTOR (3 downto 0);
           PisoEstoy : out  STD_LOGIC_VECTOR (3 downto 0)
			 );
end entity PisoActual;

architecture Dataflow of PisoActual is

signal aux1: STD_LOGIC_VECTOR (SensorEstoy'range) := (others => '0');

begin
	process (SensorEstoy)
	begin
		IF (sensorEstoy = "0001" or "0010" or "0100" or "1000") then
		aux1 <= sensorEstoy;
		end if;
	end process;

	PisoEstoy <= aux1;
		 
end architecture Dataflow;

