# Creative Embedded Systems - Module 3: Installation Art
Based on the effect of contact with still water, this piece takes senory input through a portable intrument to produce a visual and auditory experience. A video demo can be found [here](https://www.youtube.com/watch?v=vu6zhwcQaBI)

## The Enclosure
The enclosure can be created from a paper towel roll core for the sides, and a chipboard botton. The paper towl roll core was then wrapped with 6 strips of tinfoil. It is important that these strips do not touch. 

## Wiring
For the battery, the power pin was connected to the 5V pin on the ESP32, and the ground pin was connected to GRD on the ESP32. The green light on the ESP32 will light up without blinking if you have connected the battery correctly. 

6 GPIOs were used as capacitive touch sensors and connected to the six in order strips on the enclosure/instrument
In order to maintain the color and sound assignments they should be connected in the following way:
- tinfoil strip 1 --> GPIO4 aka T0
- tinfoil strip 2 --> GPIO33 aka T8
- tinfoil strip 3 --> GPIO32 aka T9
- tinfoil strip 4 --> GPIO15 aka T3
- tinfoil strip 5 --> GPIO13 aka T4
- tinfoil strip 6 --> GPIO14 aka T6
  
 A visual of the wiring can be seen here: 
 <br>
 <img src="https://github.com/Cina10/EmbeddedSys_Installation/blob/main/IMG_3300.jpg" width="500">
 <img src="https://github.com/Cina10/EmbeddedSys_Installation/blob/main/IMG_3302.jpg" width="500">

## Arduino
First, flash the Arduino code ESP32_Wifi.ino onto your ESP32 from your computer. Much of the set up for using the Arduino software with the ESP32 is detailed [here](https://github.com/Freenove/Freenove_Ultimate_Starter_Kit_for_ESP32)
For those using the Big Sur Mac Operating System, you may have to adjust the board manager, using the JSON file [here](https://github.com/espressif/esptool/issues/540#issuecomment-747185562) or changing the upload speed to the lowest possible upload speed.

Once you have wired everthing up, and the code is flashed to your ESP32, open the Serial Monitor. If you have suggessfully connected to WIFI, "Connected to wifi" will print. If the numbers are not showing up, try reseting the ESP32 and checking the baud rate. I used 115200 in the code, but it may vary for you. From the Serial minotor, reord the IP that is printing and edit line 6 in the Processing file to match. If there are any issues, try reseting the ESP32 first.

## Processing
In order to use the Processing code, you will have to install two libraries.
The sound libirary can be installed when you have Processing open and then clicking Sketch—>Import Library—>Add Library, searching for sound and the clicking "install".
The UDP library can be installed [here](http://ubaa.net/shared/processing/udp/). First download the package, unzip it then place the folder labeled "udp" into your Processing/libraries folder. 

Your directory structure should ultimately look something like this: 

```
 Documents
           Processing
                 your sketch folders
                 libraries
                       other imported libraries
                       udp
                             examples
                             library
                                   udp.jar
                             reference
                             libary.properties
                             src
                        sound
                          examples
                             library
                                   .jar files
                             reference
                             libary.properties
                             ...
```

More detail about using outside libraries [here](https://github.com/processing/processing/wiki/How-to-Install-a-Contributed-Library).


After install the libraries, restart Processing for the changes to take effect. 

Once this is conpleted and you've flashed the Ardino code onto the ESP32, you can unplug the mirco-controller, and it should continue running if you have connected the battery correctly. Finally, run the Processing script to begin.
