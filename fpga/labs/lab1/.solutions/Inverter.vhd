--
-- A simple inverter in VHDL. Compare the syntax with its Verilog counterpart.
-- 


-- include extended logic values (by default VHDL only provides 0/1 with the 'bit' data type)
library ieee ;
use ieee.std_logic_1164.all ;


entity Inverter is

   port (
      X  : in  std_logic ;
      ZN : out std_logic
   ) ;

end entity Inverter ;


architecture rtl of Inverter is

begin

   ZN <= not X ; 

end architecture rtl ;

