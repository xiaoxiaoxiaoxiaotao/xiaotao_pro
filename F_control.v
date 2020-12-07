`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/10 20:16:19
// Design Name: 
// Module Name: F_control
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


module F_control(
    input clk,
    input rst,
    input idle,
    input spv_dateout,
    input sigmoid_dateout,
    input driver_C_bram ,
    output reg sigmoid_idle,
    output reg multer_CE,
    output reg C_bram_En,
    output reg C_bram_Wea,
    output reg F_done
    );

    // the reg of control 
    reg  [4:0]  state ;


    parameter        RRR                                 =  0;
    parameter        Start                               =  1;
    parameter        Wait_sigmoid                        =  2;
    parameter        Start_sigmoid                       =  3;
    parameter        Wait_C_Bram_read1                   =  4;
    parameter        Wait_C_Bram_read2                   =  5;
    parameter        Start_Multer                        =  6;
    parameter        Wait_multer1                        =  7;
    parameter        Wait_multer2                        =  8;
    parameter        Wait_multer3                        =  9;
    parameter        Start_C_Bram_write                  = 10;
    parameter        Spv_sigmoid_cread_multer_cwrite     = 11;
    parameter        Wait_C1                             = 17;
    parameter        Wait_C2                             = 18;
    parameter        Wait_C3                             = 19;
    parameter        Sigmoid_cread_multer_cwrite         = 12;
    parameter        Cread_multer_cwrite                 = 13;
    parameter        Multer_cwrite                       = 14;
    parameter        Cwrite                              = 15;
    parameter        Stop                                = 16;

    // the reg of temp result 
    reg [15:0] tempsigmoid;

    // the change of state 
    always @ (posedge clk) begin
        if(!rst) begin
            state <= RRR ;
        end
        else if (idle) begin
            state <= Start ;
        end
        else begin
            case(state)
            Start:begin    //  Start spmxv
                if (!spv_dateout) begin
                    state <= state;
                end
                else begin
                    state <= Wait_sigmoid;
                end
            end

            Wait_sigmoid:begin
                state <= Start_sigmoid;
            end

            Start_sigmoid:begin   // Start sigmoid
                if(!driver_C_bram) begin
                    state<= state ;
                end
                else begin
                    state <= Wait_C_Bram_read1;
                end
            end

            Wait_C_Bram_read1:begin
                state <= Wait_C_Bram_read2 ;
            end

            Wait_C_Bram_read2:begin
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
                state  <= Start_C_Bram_write;
            end

            Start_C_Bram_write:begin
                state <= Spv_sigmoid_cread_multer_cwrite;
            end

            Spv_sigmoid_cread_multer_cwrite:begin
                if (spv_dateout) begin
                    state <= state ;
                end
                else begin
                    state <= Wait_C1;
                end
            end
            Wait_C1:begin
                state <= Wait_C2 ;
            end
            Wait_C2:begin
                state <= Wait_C3 ;
            end
            Wait_C3:begin
                state <= Sigmoid_cread_multer_cwrite ;
            end

            Sigmoid_cread_multer_cwrite:begin
                if (sigmoid_dateout) begin
                    state <= state;
                end
                else begin
                    state <= Cread_multer_cwrite ;
                end
            end

            Cread_multer_cwrite:begin
                state <= Multer_cwrite ;
            end

            Multer_cwrite:begin
                state <= Cwrite ;
            end

            Cwrite:begin
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


    always @ (posedge clk) begin  // the control of sigmoid_idle
        if(!rst) begin
            sigmoid_idle <= 0;
        end
        else if (idle) begin
            sigmoid_idle <=0 ;
        end
        else begin
            case(state)
            Start:begin    //  Start spmxv
                if (spv_dateout) begin
                    sigmoid_idle <= 1 ;
                end
                else begin
                    sigmoid_idle <= sigmoid_idle ;
                end
            end

            default:begin
                sigmoid_idle <= sigmoid_idle ;
            end
            endcase
            end
    end

    always @ (posedge clk) begin  // the control of C_bram_read
        if(!rst) begin
            C_bram_En <= 0;
        end
        else if (idle) begin
            C_bram_En <= 0;
        end
        else begin
            case(state)
            Start_sigmoid:begin    //  Start cbram_read
                if (!driver_C_bram) begin
                    C_bram_En <= C_bram_En ;
                end
                else begin
                    C_bram_En <= 1 ;
                end
            end

            Sigmoid_cread_multer_cwrite:begin
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

            Cwrite:begin
                multer_CE <= 0 ;
            end
            default:begin
                multer_CE <= multer_CE ;
            end
            endcase
            end
    end


    always @ (posedge clk) begin  // the control of c_bram_write
        if(!rst) begin
            C_bram_Wea <= 0;
            F_done <= 0 ;
        end
        else if (idle) begin
            C_bram_Wea <= 0;
            F_done <= 0;
        end
        else begin
            case(state)
            Start_C_Bram_write:begin    //  Start spmxv
                C_bram_Wea <= 1;
                F_done <= 0 ;
            end

            Stop:begin
                C_bram_Wea <= 0 ;
                F_done <= 1 ;
            end
            default:begin
                C_bram_Wea<= C_bram_Wea ;
                F_done <= F_done  ;
            end
            endcase
            end
    end
    
        
endmodule
