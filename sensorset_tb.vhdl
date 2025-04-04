-- Aljon A. Novelo 
-- 2021-05111
-- AB - 1L

--  A testbench has no ports.
     entity sensorset_tb is
     end sensorset_tb;
     
     architecture behav of sensorset_tb is
        --  Declaration of the component that will be instantiated.
        component sensorset
          port (i0, i1, i2, i3 : in bit; retval1, retval2 : out bit);
        end component;
        --  Specifies which entity is bound with the component.
        for sensorset_0: sensorset use entity work.sensorset;
        signal temperature, co2, moisture, gasleakage, fixalarm, evacuatealarm : bit;
     begin
        --  Component instantiation.
        sensorset_0: sensorset port map (i0 => temperature, i1 => co2, i2 => moisture, i3 => gasleakage, retval1 => fixalarm, retval2 => evacuatealarm);
     
        --  This process does the real job.
        process
           type pattern_type is record
              --  The inputs of the sensorset.
              temperature, co2, moisture, gasleakage : bit;
              --  The expected outputs of the sensorset.
              fixalarm, evacuatealarm : bit;
           end record;
           --  The patterns to apply.
           type pattern_array is array (natural range <>) of pattern_type;
           constant patterns : pattern_array :=
             (('0', '0', '0', '0', '0', '0'),
 	      ('0', '0', '0', '1', '0', '1'),
              ('0', '0', '1', '0', '0', '0'),
              ('0', '0', '1', '1', '0', '1'),
              ('0', '1', '0', '0', '0', '1'),
              ('0', '1', '0', '1', '0', '1'),
              ('0', '1', '1', '0', '0', '1'),
              ('0', '1', '1', '1', '0', '1'),
              ('1', '0', '0', '0', '0', '0'),
              ('1', '0', '0', '1', '0', '1'),
              ('1', '0', '1', '0', '1', '0'),
              ('1', '0', '1', '1', '1', '1'),
              ('1', '1', '0', '0', '0', '1'),
              ('1', '1', '0', '1', '0', '1'),
              ('1', '1', '1', '0', '1', '1'),
              ('1', '1', '1', '1', '1', '1'));
        begin
           --  Check each pattern.
           for i in patterns'range loop
              --  Set the inputs.
              temperature <= patterns(i).temperature;
              co2 <= patterns(i).co2;
              moisture <= patterns(i).moisture;
              gasleakage <= patterns(i).gasleakage;
              --  Wait for the results.
              wait for 1 ns;
              --  Check the outputs.
              assert fixalarm = patterns(i).fixalarm
                 report "bad fix alarm value" severity error;
              assert evacuatealarm = patterns(i).evacuatealarm
                 report "bad evacuate alarm value" severity error;
           end loop;
           assert false report "end of test" severity note;
           --  Wait forever; this will finish the simulation.
           wait;
        end process;
     end behav;
