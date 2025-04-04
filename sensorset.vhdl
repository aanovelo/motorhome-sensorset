-- Aljon A. Novelo 
-- 2021-05111
-- AB - 1L
entity sensorset is
       port (i0, i1, i2, i3 : in bit; retval1, retval2 : out bit);
     end sensorset;
     
     architecture rtl of sensorset is
     begin
        retval1 <= (i0 and i2);
        retval2 <= ((i1 or i3) or (i0 and i3));
     end rtl;
