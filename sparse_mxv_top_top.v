`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/03 09:37:55
// Design Name: 
// Module Name: sparse_mxv_top_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`define counter 64
`define counter_1 63
`define counter_2 62
module sparse_mxv_top_top(
input clk,
    input rst,
    input idle,
    input [1023:0] inputx_output,
    input [1023:0] inputw0,
    input [1023:0] inputw1,
    input [1023:0] inputw2,
    input [1023:0] inputw3,
    input [1023:0] inputw4,
    input [1023:0] inputw5,
    input [1023:0] inputw6,
    input [1023:0] inputw7,
   
    input [159:0] inputw_index0,
    input [159:0] inputw_index1,
    input [159:0] inputw_index2,
    input [159:0] inputw_index3,
    input [159:0] inputw_index4,
    input [159:0] inputw_index5,
    input [159:0] inputw_index6,
    input [159:0] inputw_index7,

    output wire [15:0] one_elements0,
    output wire [15:0] one_elements1,
    output wire [15:0] one_elements2,
    output wire [15:0] one_elements3,
    output wire [15:0] one_elements4,
    output wire [15:0] one_elements5,
    output wire [15:0] one_elements6,
    output wire [15:0] one_elements7,

    output reg ena,
    output reg wea,
    output reg eninput ,
    output reg weainput ,
    output reg dateout ,
    output reg spv_driver_C_bram,
    output reg [7:0] input_addr,
    output  reg [10:0] addra 
    );
    
    //latency is 33
    //the control signal 
    reg  [2:0] state ;
    reg  [11:0] statecount;

    sparse_mxv_top sparse_mxv_top_test0(.clk(clk),.rst(rst),.idle(idle)
    ,.one_elements(one_elements0),.one_elements1(one_elements1),.one_elements4(one_elements2),.one_elements5(one_elements3)
    ,.one_elements8(one_elements4),.one_elements9(one_elements5),.one_elements12(one_elements6),.one_elements13(one_elements7)


    ,.inputx_output(inputx_output),.inputw0(inputw0),.inputw4(inputw1),.inputw5(inputw2),.inputw8(inputw3)
    ,.inputw9(inputw4),.inputw12(inputw5),.inputw13(inputw6)


    ,.inputw0_index(inputw_index0),.inputw1_index(inputw_index1),.inputw4_index(inputw_index2),.inputw5_index(inputw_index3)
    ,.inputw8_index(inputw_index4),.inputw9_index(inputw_index5),.inputw12_index(inputw_index6),.inputw13_index(inputw_index7));
 
    //sparse_mxv_top sparse_mxv_top_test1(.clk(clk),.rst(rst),.idle(idle),.one_elements(one_elements1),.inputx_output(inputx_output),.inputw0(inputw1),.inputw0_index(inputw_index1));

    

    parameter RRR =      6 ;
    parameter Start =    0 ;
    parameter Load1 =    1 ;
    parameter Load2 =    2 ;
    parameter Wait  =    3 ;
    parameter Out   =    4 ;
    parameter Stop  =    5 ;

    always @ (posedge clk) begin // state change 
        if(!rst) begin
            state <= RRR ;
            statecount <= 'd0 ;
            input_addr <= 'd0;
            addra <= 'd0;
            eninput <= 'd0;
            ena <= 'd0;
            weainput <= 'd0;
            wea <= 'd0 ;
            dateout <= 0;
            spv_driver_C_bram <=0 ;
        end
        else if (idle) begin
            state <= Start ;
            statecount <= 'd0;
            input_addr <= 'd0;
            addra <= 'd0;
            eninput <= 'd0;
            ena <= 'd0;
            weainput <= 'd0;
            wea <= 'd0 ;
            dateout <= 0 ;
            spv_driver_C_bram <=0 ;
        end
        else begin
            case(state)
            Start:begin
                state <= Load1;
                statecount <= 'd0;
                input_addr <= 'd0;
                eninput <= 1;
                weainput <= 0;
                ena <= 0;
                wea <= 0;
                addra <= 'd0;
                dateout<=0 ;
                spv_driver_C_bram <=0 ;

            end

            Load1:begin   // latency of Load
                   spv_driver_C_bram <=spv_driver_C_bram ;
                    ena <= ena;
                    wea <= wea;
                    addra <= addra;
                    dateout<=dateout ;
                    statecount <= statecount + 1;
                    input_addr <= input_addr + 1;
                    eninput <= eninput;
                    weainput <= weainput;
                if (statecount <2) begin
                    state <= state;
                end 
                else begin
                    state <= Load2;
                end
                
            end

            Load2:begin   
                spv_driver_C_bram <=spv_driver_C_bram ;
                dateout<=dateout ;
                wea <= wea ;
                addra <= addra ;
                weainput <= weainput;
                if (statecount <63) begin  //  is Load 16 elements  of active_xt
                    state <= state;
                    statecount <= statecount + 1;
                    input_addr <= input_addr + 1;
                    eninput <= eninput;
                    ena <= ena ;
                    
                end 
                else if (statecount == 64) begin
                    state <= state;
                    statecount <= statecount + 1;
                    input_addr <= input_addr;
                    eninput <= eninput;
                    ena <= ena ;
                end
                else begin
                    state <= Wait;
                    statecount <= 'd0;
                    input_addr <= input_addr ;
                    eninput <= 0 ;
                    ena <= 1 ;


                end
                
            end

            Wait:begin
                input_addr <= input_addr;
                eninput <= eninput;
                weainput <= weainput;
                ena <= ena;
                wea <= wea;
                addra <= addra + 1;
                if (statecount <15) begin  
                    state <= state;
                    statecount <= statecount + 1;
                    dateout<=dateout ;
                end 
                else begin
                    state <= Out;
                    dateout<=1 ;
                    statecount <= 'd1 ;
                end


                if (statecount <13) begin  // early two clocks output the signal 
                    spv_driver_C_bram <=spv_driver_C_bram ;
                end
                else begin
                    spv_driver_C_bram <= 1;
                end

            end

            Out:begin
                spv_driver_C_bram <=spv_driver_C_bram ;
                input_addr <= input_addr;
                eninput <= eninput;
                weainput <= weainput;
                if (addra < `counter_1) begin
                    ena <= ena;
                    wea <= wea;
                    addra <= addra + 1;
                    
                end
                else begin
                    ena <= 0;
                    wea <= wea;
                    addra <= addra;
                    
                end
                if (statecount < `counter_2) begin
                    spv_driver_C_bram <=spv_driver_C_bram ;
                end
                else begin
                    spv_driver_C_bram <=0 ;
                end
                if (statecount <`counter) begin  
                    state <= state;
                    statecount <= statecount + 1;
                    dateout<=dateout ;
                end 
                else begin
                    state <= Stop;
                    statecount <= 'd0;
                    dateout<=0 ;
                end
            end

            Stop:begin
                spv_driver_C_bram <=spv_driver_C_bram;
                input_addr <= input_addr;
                eninput <= eninput;
                weainput <= weainput;
                statecount <= statecount;
                state <= state ;
                ena <= ena ;
                wea <= wea ;
                addra <= addra ;
                dateout<=dateout ;
            end

            default:begin
                spv_driver_C_bram <=spv_driver_C_bram;
                input_addr <= input_addr;
                eninput <= eninput;
                weainput <= weainput;
                statecount <= statecount;
                state <= state ;
                ena <= ena ;
                wea <= wea ;
                addra <= addra ;
                dateout<=dateout ;
            end
            endcase
        end
    end
    
            
endmodule
