`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/21 21:06:49
// Design Name: 
// Module Name: A_control
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


module A_control(
    input clk,
    input rst,
    input idle,
    input spv_dateout,
    input tanh_dateout,
    input driver_I_bram ,
    output reg tanh_idle,
    output reg multer_CE,
    output reg I_bram_En,
    output reg C_bram_Wea,
    output reg C_bram_En ,
    output reg A_done ,
    output reg A_Start_Add
    );

    // the reg of control 
    reg  [4:0]  state ;


    parameter        RRR                                     =  0;
    parameter        Start                                   =  1;
    parameter        Wait_tanh                               =  2;
    parameter        Start_tanh                              =  3;
    parameter        Wait_I_Bram_read1                       =  4;
    parameter        Wait_I_Bram_read2                       =  5;
    parameter        Start_Multer                            =  6;
    parameter        Wait_multer1_Cread                      =  7;
    parameter        Wait_multer2                            =  8;
    parameter        Wait_multer3                            =  9;
    parameter        Start_Add                               = 17;
    parameter        Start_C_Bram_write                      = 10;
    parameter        Spv_tanh_Iread_multer_Cread_Add_Cwrite  = 11;
    parameter        Wait_I1                                 = 20;
    parameter        Wait_I2                                 = 21;
    parameter        Wait_I3                                 = 22;
    parameter        Tanh_Iread_multer_Cread_Add_Cwrite      = 12;
    parameter        Iread_multer_Cread_Add_Cwrite           = 13;
    parameter        Multer_Cread_Add_Cwrite                 = 14;
    parameter        Add_Cwrite                              = 15;
    parameter        Cwrite                                  = 18;
    parameter        Stop                                    = 16;


    // the reg of temp result 
    reg [15:0] temptanh;


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
                    state <= Wait_tanh;
                end
            end

            Wait_tanh:begin
                state <= Start_tanh;
            end

            Start_tanh:begin   // Start tanh
                if(!driver_I_bram) begin
                    state<= state ;
                end
                else begin
                    state <= Wait_I_Bram_read1;
                end
            end

            Wait_I_Bram_read1:begin
                state <= Wait_I_Bram_read2 ;
            end

            Wait_I_Bram_read2:begin
                state <= Start_Multer;
            end

            Start_Multer:begin  // Start multer
                state <= Wait_multer1_Cread ;
            end

            Wait_multer1_Cread:begin
                state <= Wait_multer2 ;
            end

            Wait_multer2 :begin
                state<= Wait_multer3 ;
            end

            Wait_multer3:begin  
                state  <= Start_Add;
            end

            Start_Add:begin  
                state  <= Start_C_Bram_write;
            end

            Start_C_Bram_write:begin
                state <= Spv_tanh_Iread_multer_Cread_Add_Cwrite;
            end

            Spv_tanh_Iread_multer_Cread_Add_Cwrite:begin
                if (spv_dateout) begin
                    state <= state ;
                end
                else begin
                    state <= Wait_I1;
                end
            end
            Wait_I1:begin
                state <= Wait_I2 ;
            end
            Wait_I2:begin
                state <= Wait_I3 ;
            end
            Wait_I3:begin
                state <= Tanh_Iread_multer_Cread_Add_Cwrite ;
            end

            Tanh_Iread_multer_Cread_Add_Cwrite:begin
                if (tanh_dateout) begin
                    state <= state;
                end
                else begin
                    state <= Iread_multer_Cread_Add_Cwrite ;
                end
            end

            Iread_multer_Cread_Add_Cwrite:begin
                state <= Multer_Cread_Add_Cwrite ;
            end

            Multer_Cread_Add_Cwrite:begin
                state <= Add_Cwrite ;
            end

            Add_Cwrite:begin
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


    always @ (posedge clk) begin  // the control of tanh_idle
        if(!rst) begin
            tanh_idle <= 0;
        end
        else if (idle) begin
            tanh_idle <=0 ;
        end
        else begin
            case(state)
            Start:begin    //  Start spmxv
                if (spv_dateout) begin
                    tanh_idle <= 1 ;
                end
                else begin
                    tanh_idle <= tanh_idle ;
                end
            end

            default:begin
                tanh_idle <= tanh_idle ;
            end
            endcase
            end
    end

    always @ (posedge clk) begin  // the control of I_bram_En
        if(!rst) begin
            I_bram_En <= 0;
        end
        else if (idle) begin
            I_bram_En <= 0;
        end
        else begin
            case(state)
            Start_tanh:begin    //  Start Ibram_read
                if (!driver_I_bram) begin
                    I_bram_En <= I_bram_En ;
                end
                else begin
                    I_bram_En <= 1 ;
                end
            end

            Tanh_Iread_multer_Cread_Add_Cwrite:begin
                I_bram_En <= 0 ;
            end
            default:begin
                I_bram_En <= I_bram_En ;
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

            Tanh_Iread_multer_Cread_Add_Cwrite:begin
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

    always @ (posedge clk) begin  // the control of C_bram_read
        if(!rst) begin
            C_bram_En <= 0;
        end
        else if (idle) begin
            C_bram_En <= 0;
        end
        else begin
            case(state)
            Wait_multer1_Cread:begin    //  Start cbram_read
                C_bram_En <= 1 ;
            end

            Iread_multer_Cread_Add_Cwrite:begin
                C_bram_En <= 0 ;
            end
            default:begin
                C_bram_En <= C_bram_En ;
            end
            endcase
            end
    end

    always @ (posedge clk) begin  // the control of I_bram_write
        if(!rst) begin
            C_bram_Wea <= 0;
            A_done <= 0 ;
        end
        else if (idle) begin
            C_bram_Wea <= 0;
            A_done <= 0;
        end
        else begin
            case(state)
            Start_C_Bram_write:begin    //  Start spmxv
                C_bram_Wea <= 1;
                A_done <= 0 ;
            end

            Stop:begin
                C_bram_Wea <= 0 ;
                A_done <= 1 ;
            end
            default:begin
                C_bram_Wea<= C_bram_Wea ;
                A_done <= A_done  ;
            end
            endcase
            end
    end

    always @ (posedge clk) begin  // the control of Add
        if(!rst) begin
            A_Start_Add <= 0;
        end
        else if (idle) begin
            A_Start_Add <= 0;
        end
        else begin
            case(state)
            Start_Add:begin    //  Start Add
                A_Start_Add <= 1;
            end

            Cwrite:begin
                A_Start_Add <= 0 ;
            end
            default:begin
                A_Start_Add<= A_Start_Add ;
            end
            endcase
            end
    end
endmodule
