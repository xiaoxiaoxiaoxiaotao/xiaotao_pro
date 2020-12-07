`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/22 22:23:06
// Design Name: 
// Module Name: Output_control
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


module Output_control(
    input clk,
    input rst,
    input idle,
    input spv_dateout,
    input tanh_dateout,
    input driver_C_bram ,  // is a output of spv module to driver C bram _read
    output reg tanh_idle,  // is a output signal to driver the tanh  mudule 
    output reg sigmoid_idle, // is a output signal to driver the sigmoid   mudule 
    output reg multer_CE,// is a output signal to driver the 8*16 bit multer   mudule 
    output reg H_bram_Wea,// is a output signal  of  to driver H bram _read
    output reg C_bram_En ,// is a output signal  of  to driver C bram _read
    output reg Output_done  // is a output signal  of  to Output stage is done 
    );

    // the reg of control 
    reg  [4:0]  state ;


    parameter        RRR                                     =  0;
    parameter        Wait_C_Bram_read                        =  1;
    parameter        Wait_C_Bram_read1                       = 17;
    parameter        Wait_C_Bram_read2                       = 18;
    parameter        Start                                   =  2;
    parameter        Wait_sigmoid_tanh                       =  3;
    parameter        Start_sigmoid_tanh                      =  4;
    parameter        Wait_sigmoid_tanh1                      =  5;
    parameter        Wait_sigmoid_tanh2                      =  6;
    parameter        Start_Multer                            =  7;
    parameter        Wait_multer1                            =  8;
    parameter        Wait_multer2                            =  9;
    parameter        Wait_multer3                            = 10;
    parameter        Start_H_Bram_write                      = 11;
    parameter        Spv_cread_sigmoid_tanh_multer_hwrite    = 12;
    parameter        Sigmoid_tanh_multer_hwrite              = 13;
    parameter        Multer_hwrite                           = 14;
    parameter        Wait_Hwrite                             = 19 ;
    parameter        Hwrite                                  = 15;
    parameter        Stop                                    = 16;


    // the reg of temp result 
    reg [15:0] temptanh;


    // the change of state 
    always @ (posedge clk) begin
        if(!rst) begin
            state <= RRR ;
        end
        else if (idle) begin
            state <= Wait_C_Bram_read ;
        end
        else begin
            case(state)
            Wait_C_Bram_read:begin
                state <= Wait_C_Bram_read1;
            end
            Wait_C_Bram_read1:begin
                state <= Wait_C_Bram_read2;
            end
            Wait_C_Bram_read2:begin
                state <= Start;
            end
            Start:begin    //  Start spmxv
                if (!spv_dateout) begin
                    state <= state;
                end
                else begin
                    state <= Wait_sigmoid_tanh;
                end
            end

            Wait_sigmoid_tanh:begin
                state <= Start_sigmoid_tanh;
            end

            Start_sigmoid_tanh:begin   // Start tanh
                if(!driver_C_bram) begin
                    state<= state ;
                end
                else begin
                    state <= Wait_sigmoid_tanh1;
                end
            end

            Wait_sigmoid_tanh1:begin
                state <= Wait_sigmoid_tanh2 ;
            end

            Wait_sigmoid_tanh2:begin
                state <= Start_Multer;
            end

            Start_Multer:begin  // Start multer
                state <= Wait_multer1 ;
            end

            Wait_multer1:begin
                state <= Wait_multer2 ;
            end

            Wait_multer2 :begin
                state<= Wait_multer3 ;
            end

            Wait_multer3:begin  
                state  <= Start_H_Bram_write;
            end

            Start_H_Bram_write:begin
                state <= Spv_cread_sigmoid_tanh_multer_hwrite;
            end

            Spv_cread_sigmoid_tanh_multer_hwrite:begin
                if (spv_dateout) begin
                    state <= state ;
                end
                else begin
                    state <= Sigmoid_tanh_multer_hwrite;
                end
            end

            Sigmoid_tanh_multer_hwrite:begin
                if (tanh_dateout) begin
                    state <= state;
                end
                else begin
                    state <= Multer_hwrite ;
                end
            end

            Multer_hwrite:begin
                state <= Wait_Hwrite ;
            end
            Wait_Hwrite:begin
                state <= Hwrite ;
            end

            Hwrite:begin
                state <= Stop ;
            end

            Stop:begin
                state <= state ;
            end

            default:begin
                state <= state ;
            end
            
            endcase
            end
    end


    always @ (posedge clk) begin  // the control of sigmoid_idle and tanh idle 
        if(!rst) begin
            sigmoid_idle <= 0;
            tanh_idle <= 0;
        end
        else if (idle) begin
            sigmoid_idle <=0 ;
            tanh_idle <= 0;
        end
        else begin
            case(state)
            Start:begin    //  Start spmxv
                if (spv_dateout) begin
                    sigmoid_idle <= 1 ;
                    tanh_idle <= 1;
                end
                else begin
                    sigmoid_idle <= sigmoid_idle ;
                    tanh_idle <= tanh_idle;
                end
            end

            default:begin
                sigmoid_idle <= sigmoid_idle ;
                tanh_idle <= tanh_idle;
            end
            endcase
            end
    end

    always @ (posedge clk) begin  // the control of C_bram_En
        if(!rst) begin
            C_bram_En <= 0;
        end
        else if (idle) begin
            C_bram_En <= 0;
        end
        else begin
            case(state)
            Wait_C_Bram_read:begin
                C_bram_En <= 1;
            end

            Sigmoid_tanh_multer_hwrite:begin
                C_bram_En <= 0 ;
            end
            default:begin
                C_bram_En <= C_bram_En ;
            end
            endcase
            end
    end

    always @ (posedge clk) begin  // the control of multer
        if(!rst) begin
            multer_CE <= 0;
        end
        else if (idle) begin
            multer_CE <= 0;
        end
        else begin
            case(state)
            Start_Multer:begin    //  Start multer
                multer_CE <= 1;
            end

            Sigmoid_tanh_multer_hwrite:begin
                if (tanh_dateout) begin
                    multer_CE <= multer_CE;
                end
                else begin
                    multer_CE <= 0 ;
                end
            end
            default:begin
                multer_CE <= multer_CE ;
            end
            endcase
            end
    end


    always @ (posedge clk) begin  // the control of H_bram_write
        if(!rst) begin
            H_bram_Wea <= 0;
            Output_done <= 0 ;
        end
        else if (idle) begin
            H_bram_Wea <= 0;
            Output_done <= 0;
        end
        else begin
            case(state)
            Start_H_Bram_write:begin    //  Start spmxv
                H_bram_Wea <= 1;
                Output_done <= 0 ;
            end

            Stop:begin
                H_bram_Wea <= 0 ;
                Output_done <= 1 ;
            end
            default:begin
                H_bram_Wea<= H_bram_Wea ;
                Output_done <= Output_done  ;
            end
            endcase
            end
    end

endmodule
