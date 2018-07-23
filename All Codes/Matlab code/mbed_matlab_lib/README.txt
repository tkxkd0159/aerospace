MATLAB Interface to mbed

1. Add the mbed package (aka. namespace) to your MATLAB path

   The folder containing this README.txt file should also have
   a MATLAB function, add_mbed_to_path.m. Run this function:

   >> add_mbed_to_path


2. Make sure your mbed has the RPC server code. Go to this page:
        http://mbed.org/cookbook/Interfacing-Using-RPC
   and follow the instructions in the "RPC over Serial" section.


3. To access the mbed class or variable, you need to prefix the
   classname with "mbed.", e.g., mbed.SerialRPC or mbed.LED1.

   Use "import mbed.*" to avoid having to specify the namespace 
   every time.
     BEFORE
       mymbed = mbed.SerialRPC('COM5',9600);
       ao = mbed.AnalogOut(mymbed, mbed.p18);
     AFTER
       import mbed.*
       mymbed = SerialRPC('COM5',9600);
       ao = AnalogOut(mymbed, p18);


4. To get help on the mbed classes, type the following
   >> help mbed

   Also see the mbed MATLAB web page:
   http://mbed.org/cookbook/Interfacing-with-Matlab

----
