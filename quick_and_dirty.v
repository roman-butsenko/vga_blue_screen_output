//tidying up the code. Here is the backup:
//`timescale 1ns / 1ps

//module top_level_module(
//    input wire CLK100MHZ,
//    output wire hsync,
//    output wire vsync,
//    output wire [11:0] pix_color
//);

//wire clk_25;


//reg reset_screen_reg = 0;
//assign reset_screen = reset_screen_reg;

//wire [9:0] hsync_count;
//wire [9:0] vsync_count;


//clk_25mhz_gen clock_gen(
//    .CLK100MHZ (CLK100MHZ),
//    .clk (clk_25)
//    );
    

//sync_gen sync_gen(
//    .clk (clk_25),
//    .reset_screen (reset_screen),
//    .hsync (hsync),
//    .vsync (vsync),
//    .pix_color (pix_color)

//    );

//endmodule

//module clk_25mhz_gen(
//    input CLK100MHZ,
//    output clk
//    );

//    reg [2:0] count_4bit_reg = 0; // Always define the starting values (without it, they'll appear unknown in simulation)
//    reg clock_reg_tfmhz = 0;
    
//    always @(posedge CLK100MHZ) begin
//        if (count_4bit_reg == 3'b001) begin
//                count_4bit_reg <= 0;
//                clock_reg_tfmhz <= ~clock_reg_tfmhz;
//            end
//            else
//                count_4bit_reg <= count_4bit_reg + 1'b1; 
//        end
    
//    assign clk = clock_reg_tfmhz;
    
//endmodule

//module sync_gen(
//    input clk,
//    input reset_screen,
//    output hsync,
//    output vsync,
//    output [11:0] pix_color

//    );
    
//    wire [9:0] hsync_count;
//    wire [9:0] vsync_count;
    
//    reg [9:0] h_count_reg = 10'b0;      // registers for counters that will be keeping
//    reg [9:0] v_count_reg = 10'b0;      // current and next pixel location
    
//    assign hsync_count = h_count_reg;   // above-mentioned registors drive
//    assign vsync_count = v_count_reg;   // output wires

//    // reference:
//    // https://embeddedthoughts.com/2016/07/29/driving-a-vga-monitor-using-an-fpga/

//    parameter [9:0]
//    H_FPORCH        =  10'd16, // paremeters that define the timing of horizontal
//    H_SYNCPULS      =  10'd96, // scanning
//    H_BPORCH        =  10'd48,
//    H_ACTIVE        = 10'd640,
//    H_LINE_LENGTH   = H_FPORCH + H_BPORCH + H_ACTIVE + H_SYNCPULS - 10'd1;
    
//    parameter [9:0]
//    V_FPORCH        =  10'd10, // paremeters that define the timing of vertical
//    V_SYNCPULS       =  10'd2, // scanning
//    V_BPORCH        =  10'd33, 
//    V_ACTIVE        = 10'd480,
//    V_LINE_LENGTH   = V_FPORCH + V_BPORCH + V_ACTIVE + V_SYNCPULS - 10'd1;
//    // "-1" since we are counting from 0;
    
    

   
//   // "IS NOT A TYPE WAS CAUSED BY "||" INSTEAD OF "OR" IS ALWAYS
//   // I WHOLEHEARTEDLY HATE THIS THING ALREADY
   
//   // Counters for syncronization impulses
//   always @(posedge clk or posedge reset_screen) begin
//        if (reset_screen) begin
//            {h_count_reg, v_count_reg} <= {10'b0, 10'b0};
            
//        end
//        else begin

//            h_count_reg <= (h_count_reg == H_LINE_LENGTH) ?  0 : h_count_reg + 10'b1;
            
//            if (h_count_reg == H_LINE_LENGTH)
//            v_count_reg <= (v_count_reg == V_LINE_LENGTH) ?  0 : v_count_reg + 10'b1;

//        end
//    end
   
//   assign hsync = ~(h_count_reg > H_FPORCH && h_count_reg < H_FPORCH + H_SYNCPULS);
//   assign vsync = ~(v_count_reg > V_FPORCH && v_count_reg < V_FPORCH + V_SYNCPULS);
//   // checked the timing of the signals. Looks about right (keeping in mind .175 MHz ofset clock
    
    
//    // color driving (all white for now)
//    reg [11:0] pix_color_reg;
//    assign pix_color = pix_color_reg;
    
//    reg [9:0] sync_control_1; // for controlling the value of the
//    reg [9:0] sync_control_2; // equations that define pix_color
    
//    always @(*) begin
        
//        sync_control_1 = H_FPORCH + H_SYNCPULS + H_BPORCH;
//        sync_control_2 = H_LINE_LENGTH;
        
//        if (hsync_count > H_FPORCH + H_SYNCPULS + H_BPORCH && hsync_count < H_LINE_LENGTH) 
//            pix_color_reg <= 12'b100011111000;
//        else
//            pix_color_reg = 12'b0000000000000;
//    end
    
//endmodule
