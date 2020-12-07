`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/16 20:33:09
// Design Name: 
// Module Name: similarity_check_top
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

`define threshold 4080
module similarity_check_top(
    input clk,
    input rst,
    input idle,
    input [1023:0] xt,
    input [1023:0] xt_1,
    input [7:0] count,
    output reg similarity_flag,
    output reg SM_done
    );


    // bram control signal 
    reg  similarity_idle;
    reg  [1:0] state ;

    // the reg to store the temp result 
    reg  [12:0] all_nozero_num     ; 
    reg  [7:0]  add_count       ;
    wire  [6:0]  temp_nozero_num    ;
    wire         is_SM_out ;

    // state parameter
    parameter  Start         =    0;
    parameter  Add           =    1;
    parameter  Stop          =    2;
    
   similarity_check mysimilarity_check(
     .clk(clk),
     .idle(similarity_idle),
     .rst(rst),
     .counter(count),
     .xt(xt),
     .xt_1(xt_1),
     .nozero_num(temp_nozero_num),
     .isout(is_SM_out)
);
   always @ (posedge clk) begin
        if(!rst) begin
            state <= Start ;
            add_count <= 'd0 ;
            similarity_idle  <= 1;

        end
        else if (idle) begin
            state <= Start ;
            add_count <= 'd0 ;
            similarity_idle  <= 1;
        end
        else begin
            case(state)
                Start:begin
                  add_count<= 'd0;
                  similarity_idle <= 0;
                  state <= Add ;
                end
                Add :begin
                  similarity_idle <= similarity_idle ;
                  if (is_SM_out) begin
                    add_count <= add_count + 1;
                  end
                  else begin
                    add_count <= add_count;
                  end
                  if (add_count < count) begin
                    state <= state;
                  end
                  else begin
                    state <= Stop;
                  end
                end

                Stop:begin
                  similarity_idle <= similarity_idle ;
                  state <= state;
                  add_count <= add_count ;
                end

                default:begin
                  similarity_idle <= similarity_idle ;
                  state <= state;
                  add_count <= add_count ;
                end
            endcase
        end
   end


   always @ (posedge clk) begin
        if(!rst) begin
            all_nozero_num <= 'd0 ;
            similarity_flag <= similarity_flag ;
            SM_done <= 0 ;
        end
        else if (idle) begin
            all_nozero_num <= 'd0 ;
            similarity_flag <= similarity_flag ;
            SM_done <= 0 ;
        end
        else begin
            case(state)
                Start:begin
                  SM_done <= SM_done ;
                  all_nozero_num <= 'd0 ;
                  similarity_flag <= similarity_flag ;
                end
                Add:begin
                  SM_done <= SM_done ;
                  similarity_flag <= similarity_flag ;
                  if (is_SM_out) begin
                    all_nozero_num <= all_nozero_num + temp_nozero_num ;
                  end
                  else begin
                    all_nozero_num <= all_nozero_num ;
                  end
                end
                Stop:begin
                  SM_done <= 1 ;
                  all_nozero_num <= all_nozero_num;
                  if(all_nozero_num >`threshold )begin
                    similarity_flag <= 1;
                  end
                  else begin
                    similarity_flag <= 0;
                  end
                end
                default:begin
                  SM_done <= SM_done ;
                  all_nozero_num <= all_nozero_num;
                  similarity_flag <= similarity_flag;
                end
        endcase
        end
   end




endmodule
