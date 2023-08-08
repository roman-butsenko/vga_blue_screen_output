# vga_blue_screen_output
This repository contains my code for creating VGA output. It represents another episode in my journey to better understand Verilog.

VGA, when done right, is among the most visually pleasing outputs on the Basys3 board. Thus, it would be a shame not to dedicate some attention to it.

Similar to my previous repository, this one comprises three types of files necessary for crafting an FPGA design: Verilog code describing the circuit behavior, a constraints file detailing the physical connections of nets in the design to the FPGA pins, and a testbench enabling the verification of timing diagrams for any signal in the circuit before programming it onto the board.

The repository features two design sources. The first, "quick_and_dirty.v," stands as the initial iteration of the design. It was created hastily, leaving much to be dealt with in the future. When the time arrived, I meticulously reworked it into "vga_out.v."

Presently, the code is user-friendly for integration into future projects. It encompasses three distinct modules, each parameterizable: a clock generator, a sync signal generator, and a module responsible for determining the color of each individual pixel. During the cleanup phase, I separated the latter two components to create more distinct boundaries between different logic blocks. The pixel color block was designed with the intention of accessing the LUT with picture data in the future.

________________________

Links on the resourses that were helpful to me:

Already completed project, that I've used as a reference: https://embeddedthoughts.com/2016/07/29/driving-a-vga-monitor-using-an-fpga/

Another finished project in the form of a "core," as stated by the creator, available for anyone to use: https://www.instructables.com/Video-Interfacing-With-FPGA-Using-VGA/

Calculator for the signal parameters for any resilution and framerate: https://www.monitortests.com/pixelclock.php

Signal parameters for the resolution implemented in my design: http://tinyvga.com/vga-timing/640x480@60Hz

Clock divider explanation: https://www.fpga4student.com/2017/08/verilog-code-for-clock-divider-on-fpga.html

VGA interface required sugnal forms: 
http://web.archive.org/web/20191101194557/http://www.xess.com/static/media/appnotes/vga.pdf
https://nerdhut.de/2018/08/08/vga-signal-generation/#:~:text=VGA%20is%20an%20analog%20standard,%2C%20R%2C%20G%20and%20B.&text=Each%20pixel%20is%20composed%20of,an%20impedance%20of%2075%20Ohms.

