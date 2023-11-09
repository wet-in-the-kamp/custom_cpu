# custom_cpu
The goal of this personal project is to create a custom CPU from scratch in VHDL. 
A C compiler will then be made using [LLVM](https://llvm.org/) in order to write simple C programs on it. 

## Hardware
The hardware used for this project is the [Cyclone IV Altera EP4CE30F23C7 FPGA](https://www.mouser.fr/datasheet/2/612/cyiv_53001-1299432.pdf).
To be completely honest, I am using this hardware simply because it is what I have at the moment. 
My Master's degree program [MSE](https://www.hes-so.ch/en/master/hes-so-master/programmes/engineering-mse) made the development board I am using. 
A link to the technical description is [here](https://mse-wiki.ti.bfh.ch/).

For anyone wanting to replicate my work, the workflow should be hardware independant. 
The development board is pretty simple, and I am only using the most basic features (such as the LED matrix).
It should be easy to replicate this for another target. 

## Software
I will be using [Quartus Lite 18.1 by Intel](https://www.intel.com/content/www/us/en/software-kit/665990/intel-quartus-prime-lite-edition-design-software-version-18-1-for-windows.html?). 
Once again this should be easy to replicate with other software packages. 

## Planning
This README document will serve as a way to document my progress on this project. As of right now, I am in the planning phase of this project. 
[Ben Eater's 8-bit computer](https://eater.net/8bit/) is a huge inspiration for the architecture I plan to implement.
In his videos he explains that his design is based off of the SAP1/SAP2 computer in [Digital Computer Electronics
by Malvino and Brown](https://archive.org/details/367026792DigitalComputerElectronicsAlbertPaulMalvinoAndJeraldABrownPdf1).
I have acquired a copy of this 24 year old book in order to benefit from the details there.

The main differences that I've noticed so far between Eater's version and Malvino and Brown's lie mainly in the 
instruction set and other hardware choices. I think for now I am going to follow Malvino and Brown's instruction set
for the most part, as I think it may facilate making the compiler later on (I admit openly that 
the compiler is the part I know the least about and so will be the hardest for me). I will however make the buses
larger (32-bit) since I am not limited to a breadboard like Ben Eater is. This will give me more
memory for my programs. 

Here is my main plan:

1. Create each individual component of the processor
2. Test each component with ModelSim
3. Assemble the processor as a whole
4. Create the desired instruction set and micro-instructions
5. Test the processor with ModelSim using hand-written instructions
6. Write an assembler for the instruction set
7. Test the assembler
8. Test the processor with a blinky program written in assembly
9. Start writing the compiler using LLVM
10. Test the compiler by manually reading the assembly output and machine code
11. Make a C-program that shows that the whole thing works. I want something that would be too hard to do in assembly like a scrolling text effect using the 32 LED matrix.

I have been anticipating a couple of problems that might come along the way and one of these is initializing
the memory used by the CPU (RAM). I have a couple of options here. I can use the external SDRAM which has the 
benefit of giving me a lot more memory (4Mb). The problem with this is that I wasn't able to find any 
easy way to load my program into the SDRAM without putting on a full-fledged niosii processor, which then
defeats the purpose of using external SDRAM. I am sure there is another way to do this, but I don't want to spend
too much time on this specific ascept of things. So the easiest solution I found is to use the RAM IP core provided
by Intel ([see IP core documentation](https://www.intel.com/content/www/us/en/docs/programmable/683285/18-1/core-user-guide.html)).
This will faciliate things since I can initialize the RAM using a mif file. This can supposedly be done without
needing to recompile the whole design everytime I want to put my code in RAM. I will see down the road how this works,
for now this is the plan. 

The only added difficulty to using an IP core for RAM is that I have to then address it as an Avalon Slave through
the Avalon bus. But this shouldn't be too difficult to do. This just means that the data coming from RAM isn't guarenteed
to arrive at a specific time and the validity of the data is dictated by a dedicated signal. So the processor will
have to freeze until the RAM data is valid. This is true when either reading from or writing to RAM. To implement this
I plan on making a state machine in the instruction decoder of the CPU that freezes everything until the Avalon
bus inidicates that the transfer has been made successfully. 

One last detail about my implementation is that the main bus connecting all registers together is going to made
using one giant multiplexer. I am not so sure how the compiler will react to me trying to implement a bunch of 
internal tri-state signals that are all linked together. From a logic hardware perspective (RTL) using a multiplexer or 
a real tri-state bus is equivalent. 

I will update this README little by little as I make progress. I consider myself a novice in this domain so I accept any 
pointers or comments openly. 

## License
This software is open source according to the Apache License 2.0. 
