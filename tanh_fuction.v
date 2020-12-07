`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/01 11:17:09
// Design Name: 
// Module Name: tanh_fuction
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


module tanh_function(
    input clk,
    input rst,
    input idle,
    input [15:0] one_elements_in,
    input [12:0]  counter,
    output reg [15:0] res_tanh,
    output reg tanh_dateout,
    output reg start_I_bram
    );
// the implementation of tanh function by linear fitting 
// it's latency is 5 clocks  
    // the reg to store temp result 
    reg        [15:0]     cur_mult1 ;     // the x
    reg        [15:0]     cur_mult2 ;     // the k
    reg        [15:0]     cur_add1  ;     // the buffer of  b
    reg        [15:0]     cur_add2  ;     // the buffer of  b
    reg        [15:0]     cur_add3  ;     // the buffer of  b
    reg        [15:0]     cur_add4  ;     // the buffer of  b
    wire       [31:0]     multer_out;
    reg                   sign0     ;     //the buffer of x sign
    reg                   sign1     ;     //the buffer of x sign
    reg                   sign2     ;     //the buffer of x sign
    reg                   sign3     ;     //the buffer of x sign
    reg                   sign4     ;     //the buffer of x sign
    reg      [15:0]      one_elements ;   // the buffer of one_elements_in

    // the reg for control signal 
    reg                   enmult    ;
    reg        [2:0]      state     ;
    reg        [12:0]     statecount ;

    sigmoid_multer mytanh_multer (
  .CLK(clk),  // input wire CLK
  .A(cur_mult1),      // input wire [15 : 0] A
  .B(cur_mult2),      // input wire [15 : 0] B
  .CE(enmult),    // input wire CE
  .P(multer_out)      // output wire [15 : 0] P
);
    
    parameter  Wait                                   =    7;
    parameter  Start                                  =    0;
    parameter  Mul1                                   =    1;
    parameter  Mul2                                   =    2;
    parameter  Mul3                                   =    3;
    parameter  Mul3_Add                               =    4;
    parameter  Add                                    =    5;
    parameter  Stop                                   =    6;


    always @ (posedge clk) begin
        if(!rst) begin
            state <= Wait ;
            statecount <= 'd0;
            enmult <= 0 ;
            tanh_dateout <= 0;
            start_I_bram<=0;

        end
        else if (idle) begin
            state <= Wait ;
            statecount <= 'd0;
            enmult <= 0 ;
            tanh_dateout <= 0;
            start_I_bram<=0;
        end
        else begin
            case(state)
            Wait:begin
                state <= Start ;
                statecount <= 'd0;
                enmult <= 0 ;
                tanh_dateout <= tanh_dateout;
                start_I_bram<=start_I_bram;
            end
            Start:begin
                enmult <= 1;
                state <= Mul1;
                statecount <= 'd0;
                tanh_dateout <= tanh_dateout;
                start_I_bram  <= 1;
            end
            Mul1:begin
                enmult <= enmult;
                state <= Mul2; 
                statecount <= 'd0 ;
                tanh_dateout <= tanh_dateout;
                start_I_bram<=start_I_bram;
            end

            Mul2:begin
                state <= Mul3;
                enmult <= enmult; 
                statecount <= statecount + 1 ;
                tanh_dateout <= tanh_dateout;
                start_I_bram<=start_I_bram;
            end

            Mul3:begin
                tanh_dateout <= 1;
                start_I_bram<=start_I_bram;
                if (statecount >= counter) begin
                    enmult <= 0; 
                    state <= Add;
                    statecount <= statecount ;
                end
                else begin
                    enmult <= enmult; 
                    state <= Mul3_Add;
                    statecount <= statecount + 1 ;
                end
            end

            Mul3_Add:begin
                start_I_bram<=start_I_bram;
                tanh_dateout <= tanh_dateout;
                if (statecount >= counter) begin
                    enmult <= 0; 
                    state <= Add;
                    statecount <= statecount ;
                end
                else begin
                    enmult <= enmult; 
                    state <= state;
                    statecount <= statecount + 1 ;
                end
            end
            Add:begin
                start_I_bram<=start_I_bram;
                tanh_dateout <= 0;
                enmult <= enmult; 
                state <= Stop;
                statecount <= statecount ;
            end

            Stop:begin
                start_I_bram<=start_I_bram;
                tanh_dateout <= tanh_dateout;
                enmult <= enmult; 
                state <= state;
                statecount <= statecount ;
            end

            default:begin
                start_I_bram<=start_I_bram;
                tanh_dateout <= tanh_dateout;
                enmult <= enmult; 
                state <= state;
                statecount <= statecount ;
            end
            endcase
        end
    end

always @ (posedge clk) begin
        if(!rst) begin
                cur_mult1 <= 'd0 ;
                sign1 <= 'd0 ;

        end
        else if (idle) begin
                cur_mult1 <= 'd0 ;
                sign1 <= 'd0 ;
        end
        else begin
            case(state)
            Wait:begin
                if (one_elements_in[15]) begin
                  one_elements <= -one_elements_in;
                end
                else begin
                  one_elements <= one_elements_in ;
                end
                sign0 <= one_elements_in[15];
                cur_mult2  <= cur_mult2;
                cur_add1  <= cur_add1 ;
            end
            Start:begin
                if (one_elements_in[15]) begin
                  one_elements <= -one_elements_in;
                end
                else begin
                  one_elements <= one_elements_in ;
                end
                sign0 <= one_elements_in[15];
                cur_mult1 <= one_elements ;
                sign1 <= sign0;
            end

            Mul1:begin
                
                if (one_elements_in[15]) begin
                  one_elements <= -one_elements_in;
                end
                else begin
                  one_elements <= one_elements_in ;
                end
                sign0 <= one_elements_in[15];
                cur_mult1 <= one_elements ;
                sign1 <= sign0;
                
            end

            Mul2:begin
                if (one_elements_in[15]) begin
                  one_elements <= -one_elements_in;
                end
                else begin
                  one_elements <= one_elements_in ;
                end
                sign0 <= one_elements_in[15];
                cur_mult1 <= one_elements ;
                sign1 <= sign0;
                
            end

            Mul3:begin
                if (one_elements_in[15]) begin
                  one_elements <= -one_elements_in;
                end
                else begin
                  one_elements <= one_elements_in ;
                end
                sign0 <= one_elements_in[15];
                cur_mult1 <= one_elements ;
                sign1 <= sign0;
                
            end

            Mul3_Add:begin
                if (one_elements_in[15]) begin
                  one_elements <= -one_elements_in;
                end
                else begin
                  one_elements <= one_elements_in ;
                end
                sign0 <= one_elements_in[15];
                cur_mult1 <= one_elements ;
                sign1 <= sign0;
            end

            default:begin
                one_elements <= 'd0;
                sign0 <= sign0 ;
                sign1 <= sign1 ;
                cur_mult1 <= cur_mult1 ;
                cur_mult2 <= cur_mult2 ;
                cur_add1 <= cur_add1 ;
            end

        endcase
        end
end

always @ (posedge clk) begin
        if(!rst) begin
                cur_add2 <= 'd0 ;
                cur_add3 <= 'd0 ;
                cur_add4 <= 'd0 ;
                res_tanh <= 'd0;
                sign2 <= 'd0 ;
                sign3 <= 'd0 ;
                sign4 <= 'd0 ;

        end
        else if (idle) begin
                cur_add2 <= 'd0 ;
                cur_add3 <= 'd0 ;
                cur_add4 <= 'd0 ;
                res_tanh <= 'd0;
                sign2 <= 'd0 ;
                sign3 <= 'd0 ;
                sign4 <= 'd0 ;
        end
        else begin
            case(state)
            Wait:begin
                cur_add2 <= cur_add2 ;
                cur_add3 <= cur_add3 ;
                cur_add4 <= cur_add4 ;
                res_tanh <= res_tanh;
                sign2 <= sign2 ;
                sign3 <= sign3 ;
                sign4 <= sign4 ;
            end
            Start:begin
                cur_add2 <= cur_add2 ;
                cur_add3 <= cur_add3 ;
                cur_add4 <= cur_add4 ;
                res_tanh <= res_tanh;
                sign2 <= sign2 ;
                sign3 <= sign3 ;
                sign4 <= sign4 ;
                
            end

            Mul1:begin
                cur_add2 <= cur_add1;
                cur_add3 <= cur_add3;
                cur_add4 <= cur_add4 ;
                res_tanh <= res_tanh;
                sign2 <= sign1 ;
                sign3 <= sign3 ;
                sign4 <= sign4 ;
            end

            Mul2:begin
                cur_add2 <= cur_add1;
                cur_add3 <= cur_add2;
                cur_add4 <= cur_add4 ;
                res_tanh <= res_tanh;
                sign2 <= sign1 ;
                sign3 <= sign2 ;
                sign4 <= sign4 ;
            end

            Mul3:begin
                cur_add2 <= cur_add1;
                cur_add3 <= cur_add2;
                cur_add4 <= cur_add3 ;
                res_tanh <= res_tanh;
                sign2 <= sign1 ;
                sign3 <= sign2 ;
                sign4 <= sign3 ;
            end

            Mul3_Add:begin
                if (!sign4) begin
                  res_tanh <= {multer_out[31],multer_out[26:12]} + cur_add4;
                end
                else begin
                  res_tanh <= - ({multer_out[31],multer_out[26:12]} + cur_add4);
                end
                
                cur_add2 <= cur_add1;
                cur_add3 <= cur_add2;
                cur_add4 <= cur_add3 ;
                sign2 <= sign1 ;
                sign3 <= sign2 ;
                sign4 <= sign3 ;

            end

            Add:begin
                if (!sign4) begin
                  res_tanh <= {multer_out[31],multer_out[26:12]} + cur_add4;
                end
                else begin
                  res_tanh <= - ({multer_out[31],multer_out[26:12]} + cur_add4);
                end
                cur_add2 <= cur_add2 ;
                cur_add3 <= cur_add3 ;
                cur_add4 <= cur_add4 ;
                sign2 <= sign2 ;
                sign3 <= sign3 ;
                sign4 <= sign4 ;
            end
            default:begin
                cur_add2 <= cur_add2 ;
                cur_add3 <= cur_add3 ;
                cur_add4 <= cur_add4 ;
                res_tanh <= 'd0;
                sign2 <= sign2 ;
                sign3 <= sign3 ;
                sign4 <= sign4 ;
            end

        endcase
        end
end


always @ (posedge clk) begin
        if(!rst) begin
          cur_mult2<= 'd0;
          cur_add1 <= 'd0;
        end
        else if (idle) begin
          cur_mult2<= 'd0;
          cur_add1 <= 'd0;
        end
        else begin
            case(state)
            Wait:begin
              cur_mult2 <= cur_mult2 ;
              cur_add1 <= cur_add1 ;
            end

            Add:begin
              cur_mult2 <= cur_mult2 ;
              cur_add1 <= cur_add1 ;
            end
            Stop:begin
              cur_mult2 <= cur_mult2 ;
              cur_add1 <= cur_add1 ;
            end
            default:begin
              case(one_elements[14:9])
                'b000000:begin
                  cur_mult2<= 'b0111111101100110;   // 0.995320233
                  cur_add1 <= 'b0000000000000100;   // 0.00012877
                end

                'b000001:begin
                  cur_mult2<= 'b0111101110000011 ;   // 0.964962008
                  cur_add1 <= 'b0000000010001000;   // 0.004165444
                end

                'b000010:begin
                  cur_mult2<= 'b0111010000110100 ;   // 0.907842228
                  cur_add1 <= 'b0000001001100010 ;   // 0.018644266
                end

                'b000011:begin
                  cur_mult2<= 'b0110101001000110 ;   // 0.830284488
                  cur_add1 <= 'b0000011000100000 ;   // 0.047867016
                end

                'b000100:begin
                  cur_mult2<= 'b0101111010110110 ;   // 0.739943219
                  cur_add1 <= 'b0000101111101011 ;   // 0.093111184
                end

                'b000101:begin
                  cur_mult2<= 'b0101001001111010 ;   // 0.644372559
                  cur_add1 <= 'b0001001110010000 ;   // 0.152857346
                end

                'b000110:begin
                  cur_mult2<= 'b0100011001100100 ;   // 0.549956371
                  cur_add1 <= 'b0001110010100000 ;   // 0.223637735
                end

                'b000111:begin
                  cur_mult2<= 'b0011101100001110 ;   // 0.461365233
                  cur_add1 <= 'b0010011010001010 ;   // 0.301092079
                end

                'b001000:begin
                  cur_mult2<= 'b0011000011010100 ;   // 0.381490736
                  cur_add1 <= 'b0011000011000000 ;   // 0.38088659
                end

                'b001001:begin
                  cur_mult2<= 'b0010011111100101 ;   // 0.311693113
                  cur_add1 <= 'b0011101011001011 ;   // 0.459323032
                end

                'b001010:begin
                  cur_mult2<= 'b0010000001000111 ;   // 0.25218625
                  cur_add1 <= 'b0100010001001101 ;   // 0.53362265
                end

                'b001011:begin
                  cur_mult2<= 'b0001100111101001 ;   // 0.202430152
                  cur_add1 <= 'b0100110100001101 ;   // 0.601960003
                end

                'b001100:begin
                  cur_mult2<= 'b0001010010101010 ;   // 0.16146026
                  cur_add1 <= 'b0101010011101000 ;   // 0.663346617
                end

                'b001101:begin
                  cur_mult2<= 'b0001000001100110 ;   // 0.128130013
                  cur_add1 <= 'b0101101111010101 ;   // 0.717449829
                end

                'b001110:begin
                  cur_mult2<= 'b0000110011110110 ;   // 0.10127106
                  cur_add1 <= 'b0110000111010111 ;   // 0.764404047
                end

                'b001111:begin
                  cur_mult2<= 'b0000101000110110 ;   // 0.079787642
                  cur_add1 <= 'b0110011011111110 ;   // 0.804645139
                end

                'b010000:begin
                  cur_mult2<= 'b0000100000000110 ;   // 0.062703969
                  cur_add1 <= 'b0110101101011101 ;   // 0.838779699
                end

                'b010001:begin
                  cur_mult2<= 'b0000011001001011  ;   // 0.049180954
                  cur_add1 <= 'b0110111100001001 ;   // 0.867489704
                end

                'b010010:begin
                  cur_mult2<= 'b0000010011101110  ;   // 0.038514672
                  cur_add1 <= 'b0111001000011011  ;   // 0.891467739
                end

                'b010011:begin
                  cur_mult2<= 'b0000001111011011  ;   // 0.030125107
                  cur_add1 <= 'b0111010010100111  ;   // 0.911376189
                end

                'b010100:begin
                  cur_mult2<= 'b0000001100000011  ;   // 0.023540672
                  cur_add1 <= 'b0111011011000010  ;   // 0.927824013
                end

                'b010101:begin
                  cur_mult2<= 'b0000001001011010  ;   // 0.018381758
                  cur_add1 <= 'b0111100001111110  ;   // 0.941355708
                end

                'b010110:begin
                  cur_mult2<= 'b0000000111010110  ;   // 0.014345104
                  cur_add1 <= 'b0111100111101001  ;   // 0.952448286
                end

                'b010111:begin
                  cur_mult2<= 'b0000000101101110  ;   // 0.011189845
                  cur_add1 <= 'b0111101100010010  ;   // 0.961513207
                end

                'b011000:begin
                  cur_mult2<= 'b0000000100011101  ;   // 0.00872552
                  cur_add1 <= 'b0111110000000100  ;   // 0.968901131
                end

                'b011001:begin
                  cur_mult2<= 'b0000000011011110  ;   // 0.00680204
                  cur_add1 <= 'b0111110011001001  ;   // 0.974908056
                end

                'b011010:begin
                  cur_mult2<= 'b0000000010101101  ;   // 0.005301441 
                  cur_add1 <= 'b0111110101101001  ;   // 0.979781914
                end

                'b011011:begin
                  cur_mult2<= 'b0000000010000111  ;   // 0.004131199
                  cur_add1 <= 'b0111110111101010  ;   // 0.983729069
                end

                'b011100:begin
                  cur_mult2<= 'b0000000001101001  ;   // 0.003218858
                  cur_add1 <= 'b0111111001010011  ;   // 0.986920381
                end

                'b011101:begin
                  cur_mult2<= 'b0000000001010010   ;   // 0.002507745
                  cur_add1 <= 'b0111111010100111  ;   // 0.989496696
                end

                'b011110:begin
                  cur_mult2<= 'b0000000001000000  ;   // 0.001953578
                  cur_add1 <= 'b0111111011101011  ;   // 0.99157368
                end

                'b011111:begin
                  cur_mult2<= 'b0000000000110001  ;   // 0.001521778
                  cur_add1 <= 'b0111111100100010  ;   // 0.993246012
                end



                default:begin
                  cur_mult2<= 'b0000000000000000;   // 0
                  cur_add1 <= 'b1000000000000000;   // 1
                end
            endcase
            end

        endcase
        end
end
endmodule
