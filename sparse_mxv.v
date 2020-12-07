`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 09:57:04
// Design Name: 
// Module Name: sparse_mxv
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


module sparse_mxv(
    input clk,
    input rst,
    input idle,
    input [511:0] inputx,
    input [31:0]  inputw,
    input [19:0]  inputw_index,
    input [13:0]  counter,
    output reg [15:0] output_onebank
    );
    

    // the  reg to store  temp result 
    
    reg    [63:0]     sparse_bank_32_1_output ;
    reg    [19:0]     sparse_bank_index_32_1_output;
    reg    [15:0]     xt      [31:0];
    wire    [23:0]     mul_result  [3:0];
    reg    [15:0]     add_result2 [1:0];
    

    // state parameter
    parameter  Start                                  =    0;
    parameter  Mul1                                   =    1;
    parameter  Mul2                                   =    2;
    parameter  Mul3                                   =    3;
    parameter  Mul3_Add4to2                           =    4;
    parameter  Mul3_Add4to2_Add2to1                   =    5;
    parameter  Add4to2_Add2to1                        =    6;
    parameter  Add2to1                                =    7;
    parameter  Stop                                   =    8;
    parameter  RRR                                    =    9;

    // control singnal 
    reg    enmult ;
    reg   [3:0] state ;
    reg   [12:0] statecount ;


    
   multer_8x16bit mxvelement_mult1 (
  .CLK(clk),  // input wire CLK
  .A(sparse_bank_32_1_output[7:0]),      // input wire [7 : 0] A
  .B(xt[sparse_bank_index_32_1_output[4:0]]),      // input wire [15 : 0] B
  .CE(enmult),    // input wire CE
  .P(mul_result[0])      // output wire [23 : 0] P
);
   multer_8x16bit mxvelement_mult2 (
  .CLK(clk),  // input wire CLK
  .A(sparse_bank_32_1_output[15:8]),      // input wire [7 : 0] A
  .B(xt[sparse_bank_index_32_1_output[9:5]]),      // input wire [15 : 0] B
  .CE(enmult),    // input wire CE
  .P(mul_result[1])      // output wire [23 : 0] P
);

   multer_8x16bit mxvelement_mult3 (
  .CLK(clk),  // input wire CLK
  .A(sparse_bank_32_1_output[23:16]),      // input wire [7 : 0] A
  .B(xt[sparse_bank_index_32_1_output[14:10]]),      // input wire [15 : 0] B
  .CE(enmult),    // input wire CE
  .P(mul_result[2])      // output wire [23 : 0] P
);

   multer_8x16bit mxvelement_mult4 (
  .CLK(clk),  // input wire CLK
  .A(sparse_bank_32_1_output[31:24]),      // input wire [7 : 0] A
  .B(xt[sparse_bank_index_32_1_output[19:15]]),      // input wire [15 : 0] B
  .CE(enmult),    // input wire CE
  .P(mul_result[3])      // output wire [23 : 0] P
);
   

always @ (posedge clk) begin
        if(!rst) begin
            state <= RRR ;
            statecount <= 'd0;

        end
        else if (idle) begin
            state <= Start ;
            statecount <= 'd0;
        end
        else begin
            case(state)
            Start:begin
                enmult <= 1;
                state <= Mul1;
                statecount <= 'd0;
            end

            Mul1:begin
                enmult <= enmult;
                state <= Mul2; 
                statecount <= 'd0 ;
            end

            Mul2:begin
                state <= Mul3;
                enmult <= enmult; 
                statecount <= statecount + 1 ;
            end

            Mul3:begin
                if (statecount >= counter) begin
                    enmult <= 0; 
                    state <= Add4to2_Add2to1;
                    statecount <= statecount ;
                end
                else begin
                    enmult <= enmult; 
                    state <= Mul3_Add4to2;
                    statecount <= statecount + 1 ;
                end
            end
            
            Mul3_Add4to2:begin
                if (statecount >= counter) begin
                    enmult <= 0; 
                    state <= Add4to2_Add2to1;
                    statecount <= statecount ;
                end
                else begin
                    enmult <= enmult; 
                    state <= Mul3_Add4to2_Add2to1;
                    statecount <= statecount + 1 ;
                end
            end

            Mul3_Add4to2_Add2to1:begin
                if (statecount >= counter) begin
                    enmult <= 0; 
                    state <= Add4to2_Add2to1;
                    statecount <= statecount ;
                end
                else begin
                    enmult <= enmult; 
                    state <= state;
                    statecount <= statecount + 1 ;
                end
            end

            Add4to2_Add2to1:begin
                enmult <= enmult; 
                state <= Add2to1;
                statecount <= statecount ;
            end

            Add2to1:begin
                enmult <= enmult; 
                state <= Stop;
                statecount <= statecount ;
            end


            Stop:begin
                enmult <= enmult; 
                state <= state;
                statecount <= statecount ;
            end

            default:begin
                enmult <= enmult; 
                state <= state;
                statecount <= statecount ;
            end
            endcase
        end
end

always @ (posedge clk) begin
        if(!rst) begin
               xt[0] <= xt[0];
                xt[1] <= xt[1];
                xt[2] <= xt[2];
                xt[3] <= xt[3];
                xt[4] <= xt[4];
                xt[5] <= xt[5];
                xt[6] <= xt[6];
                xt[7] <= xt[7];
                xt[8] <= xt[8];
                xt[9] <= xt[9];
                xt[10] <= xt[10];
                xt[11] <= xt[11];
                xt[12] <= xt[12];
                xt[13] <= xt[13];
                xt[14] <= xt[14];
                xt[15] <= xt[15];
                xt[16] <= xt[16];
                xt[17] <= xt[17];
                xt[18] <= xt[18];
                xt[19] <= xt[19];
                xt[20] <= xt[20];
                xt[21] <= xt[21];
                xt[22] <= xt[22];
                xt[23] <= xt[23];
                xt[24] <= xt[24];
                xt[25] <= xt[25];
                xt[26] <= xt[26];
                xt[27] <= xt[27];
                xt[28] <= xt[28];
                xt[29] <= xt[29];
                xt[30] <= xt[30];
                xt[31] <= xt[31];

        end
        else if (idle) begin
                xt[0] <= xt[0];
                xt[1] <= xt[1];
                xt[2] <= xt[2];
                xt[3] <= xt[3];
                xt[4] <= xt[4];
                xt[5] <= xt[5];
                xt[6] <= xt[6];
                xt[7] <= xt[7];
                xt[8] <= xt[8];
                xt[9] <= xt[9];
                xt[10] <= xt[10];
                xt[11] <= xt[11];
                xt[12] <= xt[12];
                xt[13] <= xt[13];
                xt[14] <= xt[14];
                xt[15] <= xt[15];
                xt[16] <= xt[16];
                xt[17] <= xt[17];
                xt[18] <= xt[18];
                xt[19] <= xt[19];
                xt[20] <= xt[20];
                xt[21] <= xt[21];
                xt[22] <= xt[22];
                xt[23] <= xt[23];
                xt[24] <= xt[24];
                xt[25] <= xt[25];
                xt[26] <= xt[26];
                xt[27] <= xt[27];
                xt[28] <= xt[28];
                xt[29] <= xt[29];
                xt[30] <= xt[30];
                xt[31] <= xt[31];
        end
        else begin
            case(state)
            Start:begin
                xt[0] <= inputx[15:0];
                xt[1] <= inputx[31:16];
                xt[2] <= inputx[47:32];
                xt[3] <= inputx[63:48];
                xt[4] <= inputx[79:64];
                xt[5] <= inputx[95:80];
                xt[6] <= inputx[111:96];
                xt[7] <= inputx[127:112];
                xt[8] <= inputx[143:128];
                xt[9] <= inputx[159:144];
                xt[10] <= inputx[175:160];
                xt[11] <= inputx[191:176];
                xt[12] <= inputx[207:192];
                xt[13] <= inputx[223:208];
                xt[14] <= inputx[239:224];
                xt[15] <= inputx[255:240];
                xt[16] <= inputx[271:256];
                xt[17] <= inputx[287:272];
                xt[18] <= inputx[303:288];
                xt[19] <= inputx[319:304];
                xt[20] <= inputx[335:320];
                xt[21] <= inputx[351:336];
                xt[22] <= inputx[367:352];
                xt[23] <= inputx[383:368];
                xt[24] <= inputx[399:384];
                xt[25] <= inputx[415:400];
                xt[26] <= inputx[431:416];
                xt[27] <= inputx[447:432];
                xt[28] <= inputx[463:448];
                xt[29] <= inputx[479:464];
                xt[30] <= inputx[495:480];
                xt[31] <= inputx[511:496];
            end

            default:begin
                xt[0] <= xt[0];
                xt[1] <= xt[1];
                xt[2] <= xt[2];
                xt[3] <= xt[3];
                xt[4] <= xt[4];
                xt[5] <= xt[5];
                xt[6] <= xt[6];
                xt[7] <= xt[7];
                xt[8] <= xt[8];
                xt[9] <= xt[9];
                xt[10] <= xt[10];
                xt[11] <= xt[11];
                xt[12] <= xt[12];
                xt[13] <= xt[13];
                xt[14] <= xt[14];
                xt[15] <= xt[15];
                xt[16] <= xt[16];
                xt[17] <= xt[17];
                xt[18] <= xt[18];
                xt[19] <= xt[19];
                xt[20] <= xt[20];
                xt[21] <= xt[21];
                xt[22] <= xt[22];
                xt[23] <= xt[23];
                xt[24] <= xt[24];
                xt[25] <= xt[25];
                xt[26] <= xt[26];
                xt[27] <= xt[27];
                xt[28] <= xt[28];
                xt[29] <= xt[29];
                xt[30] <= xt[30];
                xt[31] <= xt[31];
            end
        endcase
        end
end

always @ (posedge clk) begin
        if(!rst) begin
            sparse_bank_32_1_output <= sparse_bank_32_1_output;
            sparse_bank_index_32_1_output <= sparse_bank_index_32_1_output;

        end
        else if (idle) begin
            sparse_bank_32_1_output <= sparse_bank_32_1_output;
            sparse_bank_index_32_1_output <= sparse_bank_index_32_1_output;
        end
        else begin
            case(state)
            Start:begin
                sparse_bank_32_1_output <= inputw;
                sparse_bank_index_32_1_output <= inputw_index;
            end
            Mul1:begin
                sparse_bank_32_1_output <= inputw;
                sparse_bank_index_32_1_output <= inputw_index;
            end
            Mul2:begin
                sparse_bank_32_1_output <= inputw;
                sparse_bank_index_32_1_output <= inputw_index;
            end
            Mul3:begin
                sparse_bank_32_1_output <= inputw;
                sparse_bank_index_32_1_output <= inputw_index;
            end
            Mul3_Add4to2:begin
                sparse_bank_32_1_output <= inputw;
                sparse_bank_index_32_1_output <= inputw_index;
            end
            Mul3_Add4to2_Add2to1:begin
                sparse_bank_32_1_output <= inputw;
                sparse_bank_index_32_1_output <= inputw_index;
            end
            default:begin
                sparse_bank_32_1_output <= sparse_bank_32_1_output;
                sparse_bank_index_32_1_output <= sparse_bank_index_32_1_output;
            end

        endcase
        end
end

always @ (posedge clk) begin
        if(!rst) begin
            output_onebank <= output_onebank;
            add_result2[0] <= add_result2[0];
            add_result2[1] <= add_result2[1];
        end
        else if (idle) begin
            output_onebank <= output_onebank;

            add_result2[0] <= add_result2[0];
            add_result2[1] <= add_result2[1];
        end
        else begin
            case(state)
            Mul3_Add4to2:begin
                output_onebank <= output_onebank;

                add_result2[0] <= {mul_result[0][23],mul_result[0][21:7]} + {mul_result[1][23],mul_result[1][21:7]};
                add_result2[1] <= {mul_result[2][23],mul_result[2][21:7]} + {mul_result[3][23],mul_result[3][21:7]};
            end

            Mul3_Add4to2_Add2to1:begin
                output_onebank <= add_result2[0] + add_result2[1];

                add_result2[0] <= {mul_result[0][23],mul_result[0][21:7]} + {mul_result[1][23],mul_result[1][21:7]};
                add_result2[1] <= {mul_result[2][23],mul_result[2][21:7]} + {mul_result[3][23],mul_result[3][21:7]};
            end

            Add4to2_Add2to1:begin
                output_onebank <= add_result2[0] + add_result2[1];

                add_result2[0] <= {mul_result[0][23],mul_result[0][21:7]} + {mul_result[1][23],mul_result[1][21:7]};
                add_result2[1] <= {mul_result[2][23],mul_result[2][21:7]} + {mul_result[3][23],mul_result[3][21:7]};
            end

            Add2to1:begin
                add_result2[0] <= add_result2[0];
                add_result2[1] <= add_result2[1];
                output_onebank <= add_result2[0] + add_result2[1];
            end

            default:begin
                output_onebank <= output_onebank;

                add_result2[0] <= add_result2[0];
                add_result2[1] <= add_result2[1];
            end

        endcase
        end
end
endmodule
