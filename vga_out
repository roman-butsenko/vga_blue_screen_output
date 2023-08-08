// reference:
// https://embeddedthoughts.com/2016/07/29/driving-a-vga-monitor-using-an-fpga/

`timescale 1ns / 1ps

module top_level_module(
    input wire CLK100MHZ,
    output wire hsync,
    output wire vsync,
    output wire [11:0] pix_color
);

// this code is intended to output to 640x480 screen,
// but this can be changed with this parameters
  
// Screen parameters
    parameter [9:0]
    H_FPORCH        =  10'd16,          // need to be set as parameters, since used in other modules
    H_SYNCPULS      =  10'd96,          // I haven't been able to find any shorter path to pass these
    H_BPORCH        =  10'd48,          // parameters both to sync signal forming module and pixel
    H_ACTIVE        = 10'd640,          // color forming module
    H_LINE_LENGTH   = H_FPORCH + H_BPORCH + H_ACTIVE + H_SYNCPULS - 10'd1;
    
    parameter [9:0]
    V_FPORCH        =  10'd10,
    V_SYNCPULS       =  10'd2,
    V_BPORCH        =  10'd33, 
    V_ACTIVE        = 10'd480,
    V_LINE_LENGTH   = V_FPORCH + V_BPORCH + V_ACTIVE + V_SYNCPULS - 10'd1;
    // "-1" since we are counting from 0;

wire clk_25; // 25 MHZ clk wire

reg reset_screen_reg = 0;
assign reset_screen = reset_screen_reg;

clk_25mhz_gen clock_gen(
    .CLK100MHZ (CLK100MHZ),
    .clk (clk_25)
    );
    
wire [9:0] h_count;
wire [9:0] v_count;    

sync_gen sync_gen(
    .clk (clk_25),
    .reset_screen (reset_screen),
    .hsync (hsync),
    .vsync (vsync),
    .h_count (h_count),
    .v_count (v_count),
    .H_FPORCH (H_FPORCH),       // Passing parameters to submodule
    .H_SYNCPULS (H_SYNCPULS),
    .H_BPORCH (H_BPORCH),
    .H_LINE_LENGTH (H_LINE_LENGTH),
    .V_FPORCH (V_FPORCH),
    .V_SYNCPULS (V_SYNCPULS),
    .V_BPORCH (V_BPORCH),
    .V_LINE_LENGTH (V_LINE_LENGTH)
    );
   
pix_color_data pix_color_data_gen(
    .clk (clk_25),
    .h_count (h_count),
    .v_count (v_count),
    .pix_color (pix_color),
    .H_FPORCH (H_FPORCH),       // Passing parameters to submodule
    .H_SYNCPULS (H_SYNCPULS),
    .H_BPORCH (H_BPORCH),
    .H_LINE_LENGTH (H_LINE_LENGTH),
    .V_FPORCH (V_FPORCH),
    .V_SYNCPULS (V_SYNCPULS),
    .V_BPORCH (V_BPORCH),
    .V_LINE_LENGTH (V_LINE_LENGTH)
    );

endmodule

module clk_25mhz_gen( //Clock generator
    input CLK100MHZ,
    output clk
    );

    reg count_4bit_reg = 0;         // Always define the starting values (without it, they'll appear unknown in simulation)
    reg clock_reg_tfmhz = 0;        // Registers for counter and output of the clock signal generator
    
    always @(posedge CLK100MHZ) begin
        if (count_4bit_reg) begin
                count_4bit_reg <= 0;                    // if counting register is in 
                clock_reg_tfmhz <= ~clock_reg_tfmhz;
            end
            else
                count_4bit_reg <= count_4bit_reg + 1'b1; 
        end
    assign clk = clock_reg_tfmhz;
endmodule

module sync_gen( //Generator of sincronisation impulses and counter values
    input clk,
    input reset_screen,
    output hsync,                      //This are the signals, that'll be directed to the 
    output vsync,
    output [9:0] h_count,
    output [9:0] v_count,
    input [9:0] H_FPORCH,       // Add input parameters for HORIZONTAL parameters
    input [9:0] H_SYNCPULS,
    input [9:0] H_BPORCH,
    input [9:0] H_LINE_LENGTH,
    input [9:0] V_FPORCH,       // Add input parameters for VERTICAL parameters
    input [9:0] V_SYNCPULS,
    input [9:0] V_BPORCH,
    input [9:0] V_LINE_LENGTH
    );
    
    reg [9:0] h_count_reg = 10'b0;      // registers for counters that will be keeping current pixel location
    reg [9:0] v_count_reg = 10'b0;      // this can be usefull to adress some LUTs with image data
    
//    wire [9:0] h_count;
//    wire [9:0] v_count;
    
    assign h_count = h_count_reg;       // connecting counters register outputs directly to the output wires maybe I could  
    assign v_count = v_count_reg;       // pass the signal from registers directly, but I've decided to take this simpler route
    
    
   
   // Counters for syncronization impulses
   always @(posedge clk or posedge reset_screen) begin
        if (reset_screen) begin
            {h_count_reg, v_count_reg} <= {10'b0, 10'b0};
        end
        else begin
            h_count_reg <= (h_count_reg == H_LINE_LENGTH) ?  0 : h_count_reg + 10'b1;
   
            if (h_count_reg == H_LINE_LENGTH)
            v_count_reg <= (v_count_reg == V_LINE_LENGTH) ?  0 : v_count_reg + 10'b1;

        end
    end
   
   assign hsync = ~(h_count_reg > H_FPORCH && h_count_reg < H_FPORCH + H_SYNCPULS); // sync signal is low only after the front porch
   assign vsync = ~(v_count_reg > V_FPORCH && v_count_reg < V_FPORCH + V_SYNCPULS); // and before f. porch + sync signal length

endmodule


module pix_color_data(
    input clk,
    input [9:0] h_count,
    input [9:0] v_count,
    output [11:0] pix_color,
    input [9:0] H_FPORCH,       // Add input parameters for HORIZONTAL parameters
    input [9:0] H_SYNCPULS,
    input [9:0] H_BPORCH,
    input [9:0] H_LINE_LENGTH,
    input [9:0] V_FPORCH,       // Add input parameters for VERTICAL parameters
    input [9:0] V_SYNCPULS,
    input [9:0] V_BPORCH,
    input [9:0] V_LINE_LENGTH
    );

    // color driving (all blue for now)
    reg [11:0] pix_color_reg;
    assign pix_color = pix_color_reg;
    
    always @(*) begin
        if (h_count > H_FPORCH + H_SYNCPULS + H_BPORCH && h_count < H_LINE_LENGTH) 
            pix_color_reg <= 12'b100011111000;
        else
            pix_color_reg = 12'b0000000000000;
    end
endmodule
