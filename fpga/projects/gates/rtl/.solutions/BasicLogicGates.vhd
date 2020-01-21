
library IEEE ;
use IEEE.std_logic_1164.all ;

entity BasicLogicGates is :

   port (
      A : in  std_logic,
      B : in  std_logic,
      Z : out std_logic_vector(5 downto 0)
   ) ;

end entity BasicLogicGates ;


architecture rtl of BasicLogicGates is :

begin

   -- 2-inputs AND gate
   Z(0) <= A and B ;

   -- 2-inputs OR gate
   Z(1) <= A or B ;

   -- 2-inputs NAND gate
   Z(2) <= A nand B ;

   -- 2-inputs NOR gate
   Z(3) <= A nor B ;

   -- 2-inputs XOR gate
   Z(4) <= A xor B ;

   -- 2-inputs XNOR gate
   Z(5) <= A xnor B ;

end architecture rtl ;

