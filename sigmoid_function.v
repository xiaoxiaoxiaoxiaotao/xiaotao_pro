`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/30 11:09:28
// Design Name: 
// Module Name: sigmoid_function
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


module sigmoid_function(
    input clk,
    input rst,
    input idle,
    input [15:0] one_elements_in,
    input [12:0]  counter,
    output reg [15:0] res_sigmoid,
    output reg sigmoid_dateout,
    output reg start_C_bram
    );
// the implementation of sigmoid function by linear fitting 
// it's latency is 5 clocks  
    // the reg to store temp result 
    reg        [15:0]     cur_mult1 ;     // the x
    reg        [15:0]     cur_mult2 ;     // the k
    reg        [15:0]     cur_add1  ;     // the buffer of  b
    reg        [15:0]     cur_add2  ;     // the buffer of  b
    reg        [15:0]     cur_add3  ;     // the buffer of  b
    reg        [15:0]     cur_add4  ;     // the buffer of  b
    wire        [31:0]     multer_out;
    reg                   sign0     ;     //the buffer of x sign
    reg                   sign1     ;     //the buffer of x sign
    reg                   sign2     ;     //the buffer of x sign
    reg                   sign3     ;     //the buffer of x sign
    reg                   sign4     ;     //the buffer of x sign
    reg      [15:0]      one_elements ;   // the buffer of one_elements_in

    // the reg for control signal 
    reg                   enmult    ;
    reg        [3:0]      state     ;
    reg        [12:0]     statecount ;

    sigmoid_multer mysigmoid_multer (
  .CLK(clk),  // input wire CLK
  .A(cur_mult1),      // input wire [15 : 0] A
  .B(cur_mult2),      // input wire [15 : 0] B
  .CE(enmult),    // input wire CE
  .P(multer_out)      // output wire [15 : 0] P
);
    parameter  RRR                                    =    8;
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
            state <= RRR ;
            statecount <= 'd0;
            enmult <= 0 ;
            sigmoid_dateout <= 0;
            start_C_bram<=0;

        end
        else if (idle) begin
            state <= Wait ;
            statecount <= 'd0;
            enmult <= 0 ;
            sigmoid_dateout <= 0;
            start_C_bram<=0;
        end
        else begin
            case(state)
            Wait:begin
                state <= Start ;
                statecount <= 'd0;
                enmult <= 0 ;
                sigmoid_dateout <= sigmoid_dateout;
                start_C_bram<=start_C_bram;
            end
            Start:begin
                enmult <= 1;
                state <= Mul1;
                statecount <= 'd0;
                start_C_bram <= 1;
                sigmoid_dateout <= sigmoid_dateout;

            end
            Mul1:begin
                enmult <= enmult;
                state <= Mul2; 
                statecount <= 'd0 ;
                sigmoid_dateout <= sigmoid_dateout;
                start_C_bram<=start_C_bram;
            end

            Mul2:begin
                state <= Mul3;
                enmult <= enmult; 
                statecount <= statecount + 1 ;
                sigmoid_dateout <= sigmoid_dateout;
                start_C_bram<=start_C_bram;
            end

            Mul3:begin
              sigmoid_dateout <= 1;
              start_C_bram<=start_C_bram;
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
              start_C_bram<=start_C_bram;
              sigmoid_dateout <= sigmoid_dateout;
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
               start_C_bram<=start_C_bram;
                enmult <= enmult; 
                state <= Stop;
                statecount <= statecount ;
                sigmoid_dateout<=0;
            end

            Stop:begin
                start_C_bram<=start_C_bram;
                sigmoid_dateout <= sigmoid_dateout ;
                enmult <= enmult; 
                state <= state;
                statecount <= statecount ;
            end

            default:begin
                start_C_bram<=start_C_bram;
                sigmoid_dateout <= sigmoid_dateout ;
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
                res_sigmoid <= 'd0;
                sign2 <= 'd0 ;
                sign3 <= 'd0 ;
                sign4 <= 'd0 ;

        end
        else if (idle) begin
                cur_add2 <= 'd0 ;
                cur_add3 <= 'd0 ;
                cur_add4 <= 'd0 ;
                res_sigmoid <= 'd0;
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
                res_sigmoid <= res_sigmoid;
                sign2 <= sign2 ;
                sign3 <= sign3 ;
                sign4 <= sign4 ;
            end
            Start:begin
                cur_add2 <= cur_add2 ;
                cur_add3 <= cur_add3 ;
                cur_add4 <= cur_add4 ;
                res_sigmoid <= res_sigmoid;
                sign2 <= sign2 ;
                sign3 <= sign3 ;
                sign4 <= sign4 ;
                
            end

            Mul1:begin
                cur_add2 <= cur_add1;
                cur_add3 <= cur_add3;
                cur_add4 <= cur_add4 ;
                res_sigmoid <= res_sigmoid;
                sign2 <= sign1 ;
                sign3 <= sign3 ;
                sign4 <= sign4 ;
            end

            Mul2:begin
                cur_add2 <= cur_add1;
                cur_add3 <= cur_add2;
                cur_add4 <= cur_add4 ;
                res_sigmoid <= res_sigmoid;
                sign2 <= sign1 ;
                sign3 <= sign2 ;
                sign4 <= sign4 ;
            end

            Mul3:begin
                cur_add2 <= cur_add1;
                cur_add3 <= cur_add2;
                cur_add4 <= cur_add3 ;
                res_sigmoid <= res_sigmoid;
                sign2 <= sign1 ;
                sign3 <= sign2 ;
                sign4 <= sign3 ;
            end

            Mul3_Add:begin
                if (!sign4) begin
                  res_sigmoid <= {multer_out[31],multer_out[26:12]} + cur_add4;
                end
                else begin
                  res_sigmoid <='b1000000000000000- ({multer_out[31],multer_out[26:12]} + cur_add4);
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
                  res_sigmoid <= {multer_out[31],multer_out[26:12]} + cur_add4;
                end
                else begin
                  res_sigmoid <='b1000000000000000- ({multer_out[31],multer_out[26:12]} + cur_add4);
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
                res_sigmoid <= 'd0;
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
              case(one_elements[14:10])
                'b00000:begin
                  cur_mult2<= 'b0001111111010101;   // 0.24871
                  cur_add1 <= 'b0100000000000000;   // 0.5
                end

                'b00001:begin
                  cur_mult2<= 'b0001111011011101;   // 0.24113
                  cur_add1 <= 'b0100000000111101;   // 0.50189
                end

                'b00010:begin
                  cur_mult2<= 'b0001110100001010;   // 0.22688
                  cur_add1 <= 'b0100000100100111;   // 0.50902
                end

                'b00011:begin
                  cur_mult2<= 'b0001101010010000;   // 0.20752
                  cur_add1 <= 'b0100001100000011;   // 0.52354
                end

                'b00100:begin
                  cur_mult2<= 'b0001011110101101;   // 0.18497
                  cur_add1 <= 'b0100010111100110;   // 0.54609
                end

                'b00101:begin
                  cur_mult2<= 'b0001010010011110;   // 0.1611
                  cur_add1 <= 'b0100100110111000;   // 0.57593
                end

                'b00110:begin
                  cur_mult2<= 'b0001000110011001;   // 0.13751
                  cur_add1 <= 'b0100111000111111;   // 0.6113
                end

                'b00111:begin
                  cur_mult2<= 'b0000111011000100;   // 0.11538
                  cur_add1 <= 'b0101001100110100;   // 0.65004
                end

                'b01000:begin
                  cur_mult2<= 'b0000110000110110;   // 0.095414
                  cur_add1 <= 'b0101100001010000;   // 0.68997
                end

                'b01001:begin
                  cur_mult2<= 'b0000100111111010;   // 0.077965
                  cur_add1 <= 'b0101110101010111;   // 0.72923
                end

                'b01010:begin
                  cur_mult2<= 'b0000100000010011;   // 0.063086
                  cur_add1 <= 'b0110001000011010;   // 0.76643
                end

                'b01011:begin
                  cur_mult2<= 'b0000011001111011;   // 0.050643
                  cur_add1 <= 'b0110011001111011;   // 0.80064
                end

                'b01100:begin
                  cur_mult2<= 'b0000010100101011;   // 0.040396
                  cur_add1 <= 'b0110101001101010;   // 0.83139
                end

                'b01101:begin
                  cur_mult2<= 'b0000010000011010;   // 0.032059
                  cur_add1 <= 'b0110110111100010;   // 0.85848
                end

                'b01110:begin
                  cur_mult2<= 'b0000001100111110;   // 0.025339
                  cur_add1 <= 'b0111000011100101;   // 0.882
                end

                'b01111:begin
                  cur_mult2<= 'b0000001010001110;   // 0.019965
                  cur_add1 <= 'b0111001101111001;   // 0.90216
                end

                'b10000:begin
                  cur_mult2<= 'b0000001000000010;   // 0.01569
                  cur_add1 <= 'b0111010110101001;   // 0.91925
                end

                'b10001:begin
                  cur_mult2<= 'b0000000110010011;   // 0.012307
                  cur_add1 <= 'b0111011110000001;   // 0.93363
                end

                'b10010:begin
                  cur_mult2<= 'b0000000100111011;   // 0.0096378
                  cur_add1 <= 'b0111100100001010;   // 0.94564
                end

                'b10011:begin
                  cur_mult2<= 'b0000000011110111;   // 0.0075385
                  cur_add1 <= 'b0111101001010001;   // 0.95561
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
