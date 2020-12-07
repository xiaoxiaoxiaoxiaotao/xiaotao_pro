`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/20 16:30:42
// Design Name: 
// Module Name: I_control
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


module I_control(
    input clk,
    input rst,
    input idle,
    input spv_dateout,  // the signal of spv module output  date is out
    input sigmoid_dateout, // the signal of sigmoid module output date is out 
    output reg sigmoid_idle, // the signal driver sigmoid mudule idle 
    output reg I_bram_Wea,  // the sigal driver I bram write 
    output reg I_done // the signal I control is done 
    );

    // the reg of control 
    reg  [4:0]  state ;


    parameter        RRR                                 =  0;
    parameter        Start                               =  1;
    parameter        Wait_sigmoid                        =  2;
    parameter        Spv_sigmoid_cwrite                  =  3;
    parameter        Sigmoid_cwrite                      =  4;
    parameter        Cwrite                              =  5;
    parameter        Stop                                =  6;

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
                if (sigmoid_dateout) begin
                    state <= Spv_sigmoid_cwrite;
                end
                else begin
                    state <= state ;
                end
            end

            Spv_sigmoid_cwrite:begin
                if (spv_dateout) begin
                    state <= state ;
                end
                else begin
                    state <= Sigmoid_cwrite;
                end
            end

            Sigmoid_cwrite:begin
                if (sigmoid_dateout) begin
                    state <= state;
                end
                else begin
                    state <= Cwrite ;
                end
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




    always @ (posedge clk) begin  // the control of c_bram_write
        if(!rst) begin
            I_bram_Wea <= 0;
            I_done <= 0 ;
        end
        else if (idle) begin
            I_bram_Wea <= 0;
            I_done <= 0;
        end
        else begin
            case(state)
            Wait_sigmoid:begin
                I_done <= 0;
                if (sigmoid_dateout) begin
                    I_bram_Wea <= 1;
                end
                else begin
                    I_bram_Wea <= 0;
                end
            end

            Sigmoid_cwrite:begin
                if (sigmoid_dateout) begin
                    I_bram_Wea <= 1;
                end
                else begin
                    I_bram_Wea <= 0;
                end
                I_done <= I_done;
            end

            Cwrite:begin
                I_done <= 1;
            end

            default:begin
                I_bram_Wea<= I_bram_Wea ;
                I_done <= I_done  ;
            end
            endcase
            end
    end
endmodule
