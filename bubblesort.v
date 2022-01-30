`timescale 1ns / 1ps


module bubblesort(
    clk,
    reset, 
    done, 
    rd_en, 
    dat_out0,
    dat_out1,
    dat_out2,
    dat_out3,
    dat_out4,
    dat_out5,
    dat_out6,
    dat_out7,
    dat_out8,
    dat_out9
);
    
    input clk;
    input reset;
    input rd_en;
    output [15:0] dat_out0;
    output [15:0] dat_out1;
    output [15:0] dat_out2;
    output [15:0] dat_out3;
    output [15:0] dat_out4;
    output [15:0] dat_out5;
    output [15:0] dat_out6;
    output [15:0] dat_out7;
    output [15:0] dat_out8;
    output [15:0] dat_out9;
    output done; 
 
    parameter NumItm = 10 ;

    reg[15:0] dmem [9:0];

    assign dat_out0 = dmem[0];
    assign dat_out1 = dmem[1];
    assign dat_out2 = dmem[2];
    assign dat_out3 = dmem[3];
    assign dat_out4 = dmem[4];
    assign dat_out5 = dmem[5];
    assign dat_out6 = dmem[6];
    assign dat_out7 = dmem[7];
    assign dat_out8 = dmem[8];
    assign dat_out9 = dmem[9];   
   
    /*
        please consider dmem as memory from wich you will read values.
    */
    initial begin
        $readmemh("ex1.mem", dmem);
    end
  
    reg done;
   reg [15:0] temp;
   reg [1:0] state_reg;
   reg [9:0] count; 
   integer i; 
   integer wr_l;
   integer wr_h;
   integer j;
   integer addr;
   
   
    // --------- Design implementation ----------
    // 
      always @(posedge clk or posedge reset) begin
            if (dmem[0] > dmem[1]) begin
                addr <=0;   //locate swapping address
                temp <= dmem[0]; // S1 - read low mem [0]
                wr_l <=1;       //enable write low
            end
            else if (dmem[1] > dmem[2]) begin
                addr <=1;
                temp <= dmem[1];
                wr_l <=1;
            end
            else if (dmem[2] > dmem[3]) begin
                addr <=2;
                temp <= dmem[2];
                wr_l <=1;
            end
            else if (dmem[3] > dmem[4])begin
                addr <=3;
                temp <= dmem[3];
                wr_l <=1;              
            end
            else if (dmem[4] > dmem[5])begin
                addr <=4;
                temp <= dmem[4]; 
                wr_l <=1;
            end
            else if (dmem[5] > dmem[6])begin
                addr <=5;
                temp <= dmem[5];    
                wr_l <=1;
            end
            else if (dmem[6] > dmem[7])begin
                addr <=6;
                temp <= dmem[6];
                wr_l <=1;
            end
            else if (dmem[7] > dmem[8]) begin            
                addr <=7;
                temp <= dmem[7];
                wr_l <=1;
            end
            else if (dmem[8] > dmem[9]) begin
                addr <=8;
                temp <= dmem[8];
                wr_l <=1;               
            end
            
            // write low memory in State 2
            if (wr_l) begin
                dmem[addr] <= dmem[addr + 1];
                wr_l <=0;   //reset write low
                wr_h <=1;   //enable write high
            end
            else done <=1;
            // write high memory in state 3 
            if (wr_h) begin
                    dmem[addr + 1] <= temp;
                    wr_h <=0; //reset write high
            end    
    end // always  

    endmodule