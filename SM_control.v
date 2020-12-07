`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/19 12:46:57
// Design Name: 
// Module Name: SM_control
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

`define  add_count  16 
module SM_control(
    input clk,
    input rst,
    input idle,
    input SM_out,
    output reg Start_SM,
    output reg X_bram_En,
    output reg X_bram_Wea
    );
    reg  [3:0]  state;


    parameter     RRR            =  0 ;
    parameter     Start          =  1 ;
    parameter     Start_Xram     =  2 ;
    parameter     Wait_Xram1     =  3 ;
    parameter     Wait_Xram2     =  4 ;
    parameter     Start_SM_check       =  5 ;
    parameter     Wait_SM_check  =  6 ;
    parameter     Stop           =  7 ;
    

    reg      [4:0]       X_bram_read_count    ;
    // the change of state 
    always @ (posedge clk) begin
        if(!rst) begin
            state <= RRR ;
            X_bram_read_count  <= 'd0;
        end
        else if (idle) begin
            state <= Start_Xram ;
            X_bram_read_count  <= 'd0;
        end
        else begin
            case(state)
            Start_Xram:begin    //  Start X_bram
                 state  <= Start_SM_check;
                 X_bram_read_count <= X_bram_read_count + 1;
            end

            // Wait_Xram1:begin    //  Wait X_bram
            //      state  <= Wait_Xram2;
            //      X_bram_read_count <= X_bram_read_count + 1;
            // end


            // Wait_Xram2:begin    //  Wait X_bram
            //      state  <= Start_SM_check;
            //      X_bram_read_count <= X_bram_read_count + 1;
            // end

            Start_SM_check:begin
                state <= Wait_SM_check ;
                X_bram_read_count <= X_bram_read_count + 1;
            end

            Wait_SM_check:begin
                if (SM_out) begin
                    state <= Stop ;
                end
                else begin
                    state <= state ;
                end
                if (X_bram_read_count < `add_count ) begin
                    X_bram_read_count <= X_bram_read_count + 1;
                end
                else begin
                    X_bram_read_count <= X_bram_read_count ;
                end
            end

            Stop :begin
                state <= state ;
                X_bram_read_count <= X_bram_read_count ;
            end

            default:begin
                state <= state ;
                X_bram_read_count <= X_bram_read_count ;
            end
            endcase
        end
    end


    always @ (posedge clk) begin   // the state change of X_bram
        if(!rst) begin
            X_bram_En <= 0;
            X_bram_Wea <= 0;
        end
        else if (idle) begin
            X_bram_En <= 0;
            X_bram_Wea <= 0;
        end
        else begin
            case(state)
            Start_Xram:begin    //  Start X_bram
                X_bram_En <= 1;
                X_bram_Wea <= 0;
            end


            Wait_SM_check:begin
                 X_bram_Wea <= X_bram_Wea;
                if (X_bram_read_count < `add_count ) begin
                    X_bram_En <= X_bram_En;
                end
                else begin
                    X_bram_En <= 0;
                end
            end

            default:begin
                X_bram_En <= X_bram_En;
                X_bram_Wea <= X_bram_Wea;
            end
            endcase
        end
    end


    always @ (posedge clk) begin   // the state change of SM_check
        if(!rst) begin
            Start_SM <= 0;
        end
        else if (idle) begin
            Start_SM <= 0;
        end
        else begin
            case(state)

            Start_SM_check:begin
                Start_SM <= 1;
            end
            Stop :begin
                Start_SM <= 0;
            end

            default:begin
                Start_SM <= Start_SM;
            end
            endcase
        end
    end
    
endmodule
