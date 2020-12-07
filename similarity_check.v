`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/09 12:27:45
// Design Name: 
// Module Name: similarity_check
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


module similarity_check(
    input             clk,
    input             rst,
    input             idle,
    input             [1023:0] xt,
    input             [1023:0] xt_1,
    input       [7:0]    counter,
    output  reg [6:0]    nozero_num,
    output  reg          isout 
    );
    
    // the reg to store the temp result 
    // reg      [5:0]    uper6xt   [255:0] ;
    // reg      [5:0]    uper6xt_1 [255:0] ;


    reg      [63:0]   count64    ;
    reg      [1:0]    count32   [31:0] ;
    reg      [2:0]    count16   [15:0] ;
    reg      [3:0]    count8    [7:0]  ;
    reg      [4:0]    count4    [3:0]  ;
    reg      [5:0]    count2    [1:0]  ;
 
    // the control signal 
    reg      [4:0]    state  ;
    reg      [7:0]    my_counter;
    reg      comparator_Ce;
    wire      comparator_result;

    //state parameter 
    parameter     RRR                                             =   0;
    parameter     Sub                                             =   1 ;
    parameter     Sub_Add64to32                                  =   2 ;
    parameter     Sub_Add64to32_32to16                           =   3 ;
    parameter     Sub_Add64to32_32to16_16to8                     =   4 ;
    parameter     Sub_Add64to32_32to16_16to8_8to4                =   5 ;   
    parameter     Sub_Add64to32_32to16_16to8_8to4_4to2           =   6 ;    
    parameter     Sub_Add64to32_32to16_16to8_8to4_4to2_2to1      =   7 ;    
    parameter     Add64to32_32to16_16to8_8to4_4to2_2to1           =   8 ;   
    parameter     Add32to16_16to8_8to4_4to2_2to1                  =   9 ; 
    parameter     Add16to8_8to4_4to2_2to1                         =   10;
    parameter     Add8to4_4to2_2to1                               =   11;
    parameter     Add4to2_2to1                                    =   12;
    parameter     Add2to1                                         =   13;
    parameter     Stop                                            =   14;
    //  state change 
    always @ (posedge clk) begin
        if(!rst) begin
            state <= RRR ;
            my_counter <= 'd0;
            isout <= 0 ;
        end
        else if (idle) begin
            state <= Sub ;
            my_counter <= 'd0;
            isout <= 0;
        end
        else begin
            case(state)
                // Start:begin
                //     my_counter <= my_counter;
                //     state <= Sub;
                // end


                Sub:begin
                    my_counter <= my_counter + 1 ;
                    if (my_counter >= counter) begin
                        state <= Add64to32_32to16_16to8_8to4_4to2_2to1;
                    end
                    else begin
                        state <= Sub_Add64to32;
                    end
                end


                Sub_Add64to32:begin
                    my_counter <= my_counter + 1 ;
                    isout <= isout ;
                    if (my_counter >= counter) begin
                        state <= Add64to32_32to16_16to8_8to4_4to2_2to1;
                    end
                    else begin
                        state <= Sub_Add64to32_32to16;
                    end
                end


                Sub_Add64to32_32to16:begin
                    isout <= isout ;
                    my_counter <= my_counter + 1 ;
                    if (my_counter >= counter) begin
                        state <= Add64to32_32to16_16to8_8to4_4to2_2to1;
                    end
                    else begin
                        state <= Sub_Add64to32_32to16_16to8;
                    end
                end


                Sub_Add64to32_32to16_16to8:begin
                    isout <= isout ;
                    my_counter <= my_counter + 1 ;
                    if (my_counter >= counter) begin
                        state <= Add64to32_32to16_16to8_8to4_4to2_2to1;
                    end
                    else begin
                        state <= Sub_Add64to32_32to16_16to8_8to4;
                    end
                end


                Sub_Add64to32_32to16_16to8_8to4:begin
                    isout <= isout ;
                    my_counter <= my_counter + 1 ;
                    if (my_counter >= counter) begin
                        state <= Add64to32_32to16_16to8_8to4_4to2_2to1;
                    end
                    else begin
                        state <= Sub_Add64to32_32to16_16to8_8to4_4to2;
                    end
                end

                Sub_Add64to32_32to16_16to8_8to4_4to2:begin
                    isout <= isout ;
                    my_counter <= my_counter + 1 ;
                    if (my_counter >= counter) begin
                        state <= Add64to32_32to16_16to8_8to4_4to2_2to1;
                    end
                    else begin
                        state <= Sub_Add64to32_32to16_16to8_8to4_4to2_2to1;
                    end
                end

                Sub_Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                    isout <= 1 ;
                    my_counter <= my_counter + 1 ;
                    if (my_counter >= counter) begin
                        state <= Add64to32_32to16_16to8_8to4_4to2_2to1;
                    end
                    else begin
                        state <= state;
                    end
                end

                Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                    isout <= isout ;
                    my_counter <= my_counter ;
                    state <= Add32to16_16to8_8to4_4to2_2to1;
                end

                Add32to16_16to8_8to4_4to2_2to1:begin
                    isout <= isout ;
                    my_counter <= my_counter ;
                    state <= Add16to8_8to4_4to2_2to1;
                end

                Add16to8_8to4_4to2_2to1:begin
                    isout <= isout ;
                    my_counter <= my_counter ;
                    state <= Add8to4_4to2_2to1;
                end


                Add8to4_4to2_2to1:begin
                    isout <= isout ;
                    my_counter <= my_counter ;
                    state <= Add4to2_2to1;
                end

                Add4to2_2to1:begin
                    isout <= isout ;
                    my_counter <= my_counter ;
                    state <= Add2to1;
                end


                Add2to1:begin
                    isout <= isout ;
                    my_counter <= my_counter ;
                    state <= Stop;
                end


                Stop:begin
                    isout <= 0;
                    my_counter <= my_counter ;
                    state <= state;
                end

                default:begin
                    isout <= isout ;
                    my_counter <= my_counter ;
                    state <= state;
                end

            endcase
        end
    end

    always @ (posedge clk) begin
        if(!rst) begin
            count64 <=  0 ;
        end
        else if (idle) begin
            count64 <=  0 ;
        end
        else begin
            case(state)
                Sub:begin
                    if (xt[15:10]==xt_1[15:10]) begin
                        count64[0]<=1;
                    end
                    else begin
                        count64[0] <= 0;
                    end
                    if (xt[31:26]==xt_1[31:26]) begin
                        count64[1]<=1;
                    end
                    else begin
                        count64[1] <= 0;
                    end
                    if (xt[47:42]==xt_1[47:42]) begin
                        count64[2]<=1;
                    end
                    else begin
                        count64[2] <= 0;
                    end
                    if (xt[63:58]==xt_1[63:58]) begin
                        count64[3]<=1;
                    end
                    else begin
                        count64[3] <= 0;
                    end
                    if (xt[79:74]==xt_1[79:74]) begin
                        count64[4]<=1;
                    end
                    else begin
                        count64[4] <= 0;
                    end
                    if (xt[95:90]==xt_1[95:90]) begin
                        count64[5]<=1;
                    end
                    else begin
                        count64[5] <= 0;
                    end
                    if (xt[111:106]==xt_1[111:106]) begin
                        count64[6]<=1;
                    end
                    else begin
                        count64[6] <= 0;
                    end
                    if (xt[127:122]==xt_1[127:122]) begin
                        count64[7]<=1;
                    end
                    else begin
                        count64[7] <= 0;
                    end
                    if (xt[143:138]==xt_1[143:138]) begin
                        count64[8]<=1;
                    end
                    else begin
                        count64[8] <= 0;
                    end
                    if (xt[159:154]==xt_1[159:154]) begin
                        count64[9]<=1;
                    end
                    else begin
                        count64[9] <= 0;
                    end
                    if (xt[175:170]==xt_1[175:170]) begin
                        count64[10]<=1;
                    end
                    else begin
                        count64[10] <= 0;
                    end
                    if (xt[191:186]==xt_1[191:186]) begin
                        count64[11]<=1;
                    end
                    else begin
                        count64[11] <= 0;
                    end
                    if (xt[207:202]==xt_1[207:202]) begin
                        count64[12]<=1;
                    end
                    else begin
                        count64[12] <= 0;
                    end
                    if (xt[223:218]==xt_1[223:218]) begin
                        count64[13]<=1;
                    end
                    else begin
                        count64[13] <= 0;
                    end
                    if (xt[239:234]==xt_1[239:234]) begin
                        count64[14]<=1;
                    end
                    else begin
                        count64[14] <= 0;
                    end
                    if (xt[255:250]==xt_1[255:250]) begin
                        count64[15]<=1;
                    end
                    else begin
                        count64[15] <= 0;
                    end
                    if (xt[271:266]==xt_1[271:266]) begin
                        count64[16]<=1;
                    end
                    else begin
                        count64[16] <= 0;
                    end
                    if (xt[287:282]==xt_1[287:282]) begin
                        count64[17]<=1;
                    end
                    else begin
                        count64[17] <= 0;
                    end
                    if (xt[303:298]==xt_1[303:298]) begin
                        count64[18]<=1;
                    end
                    else begin
                        count64[18] <= 0;
                    end
                    if (xt[319:314]==xt_1[319:314]) begin
                        count64[19]<=1;
                    end
                    else begin
                        count64[19] <= 0;
                    end
                    if (xt[335:330]==xt_1[335:330]) begin
                        count64[20]<=1;
                    end
                    else begin
                        count64[20] <= 0;
                    end
                    if (xt[351:346]==xt_1[351:346]) begin
                        count64[21]<=1;
                    end
                    else begin
                        count64[21] <= 0;
                    end
                    if (xt[367:362]==xt_1[367:362]) begin
                        count64[22]<=1;
                    end
                    else begin
                        count64[22] <= 0;
                    end
                    if (xt[383:378]==xt_1[383:378]) begin
                        count64[23]<=1;
                    end
                    else begin
                        count64[23] <= 0;
                    end
                    if (xt[399:394]==xt_1[399:394]) begin
                        count64[24]<=1;
                    end
                    else begin
                        count64[24] <= 0;
                    end
                    if (xt[415:410]==xt_1[415:410]) begin
                        count64[25]<=1;
                    end
                    else begin
                        count64[25] <= 0;
                    end
                    if (xt[431:426]==xt_1[431:426]) begin
                        count64[26]<=1;
                    end
                    else begin
                        count64[26] <= 0;
                    end
                    if (xt[447:442]==xt_1[447:442]) begin
                        count64[27]<=1;
                    end
                    else begin
                        count64[27] <= 0;
                    end
                    if (xt[463:458]==xt_1[463:458]) begin
                        count64[28]<=1;
                    end
                    else begin
                        count64[28] <= 0;
                    end
                    if (xt[479:474]==xt_1[479:474]) begin
                        count64[29]<=1;
                    end
                    else begin
                        count64[29] <= 0;
                    end
                    if (xt[495:490]==xt_1[495:490]) begin
                        count64[30]<=1;
                    end
                    else begin
                        count64[30] <= 0;
                    end
                    if (xt[511:506]==xt_1[511:506]) begin
                        count64[31]<=1;
                    end
                    else begin
                        count64[31] <= 0;
                    end
                    if (xt[527:522]==xt_1[527:522]) begin
                        count64[32]<=1;
                    end
                    else begin
                        count64[32] <= 0;
                    end
                    if (xt[543:538]==xt_1[543:538]) begin
                        count64[33]<=1;
                    end
                    else begin
                        count64[33] <= 0;
                    end
                    if (xt[559:554]==xt_1[559:554]) begin
                        count64[34]<=1;
                    end
                    else begin
                        count64[34] <= 0;
                    end
                    if (xt[575:570]==xt_1[575:570]) begin
                        count64[35]<=1;
                    end
                    else begin
                        count64[35] <= 0;
                    end
                    if (xt[591:586]==xt_1[591:586]) begin
                        count64[36]<=1;
                    end
                    else begin
                        count64[36] <= 0;
                    end
                    if (xt[607:602]==xt_1[607:602]) begin
                        count64[37]<=1;
                    end
                    else begin
                        count64[37] <= 0;
                    end
                    if (xt[623:618]==xt_1[623:618]) begin
                        count64[38]<=1;
                    end
                    else begin
                        count64[38] <= 0;
                    end
                    if (xt[639:634]==xt_1[639:634]) begin
                        count64[39]<=1;
                    end
                    else begin
                        count64[39] <= 0;
                    end
                    if (xt[655:650]==xt_1[655:650]) begin
                        count64[40]<=1;
                    end
                    else begin
                        count64[40] <= 0;
                    end
                    if (xt[671:666]==xt_1[671:666]) begin
                        count64[41]<=1;
                    end
                    else begin
                        count64[41] <= 0;
                    end
                    if (xt[687:682]==xt_1[687:682]) begin
                        count64[42]<=1;
                    end
                    else begin
                        count64[42] <= 0;
                    end
                    if (xt[703:698]==xt_1[703:698]) begin
                        count64[43]<=1;
                    end
                    else begin
                        count64[43] <= 0;
                    end
                    if (xt[719:714]==xt_1[719:714]) begin
                        count64[44]<=1;
                    end
                    else begin
                        count64[44] <= 0;
                    end
                    if (xt[735:730]==xt_1[735:730]) begin
                        count64[45]<=1;
                    end
                    else begin
                        count64[45] <= 0;
                    end
                    if (xt[751:746]==xt_1[751:746]) begin
                        count64[46]<=1;
                    end
                    else begin
                        count64[46] <= 0;
                    end
                    if (xt[767:762]==xt_1[767:762]) begin
                        count64[47]<=1;
                    end
                    else begin
                        count64[47] <= 0;
                    end
                    if (xt[783:778]==xt_1[783:778]) begin
                        count64[48]<=1;
                    end
                    else begin
                        count64[48] <= 0;
                    end
                    if (xt[799:794]==xt_1[799:794]) begin
                        count64[49]<=1;
                    end
                    else begin
                        count64[49] <= 0;
                    end
                    if (xt[815:810]==xt_1[815:810]) begin
                        count64[50]<=1;
                    end
                    else begin
                        count64[50] <= 0;
                    end
                    if (xt[831:826]==xt_1[831:826]) begin
                        count64[51]<=1;
                    end
                    else begin
                        count64[51] <= 0;
                    end
                    if (xt[847:842]==xt_1[847:842]) begin
                        count64[52]<=1;
                    end
                    else begin
                        count64[52] <= 0;
                    end
                    if (xt[863:858]==xt_1[863:858]) begin
                        count64[53]<=1;
                    end
                    else begin
                        count64[53] <= 0;
                    end
                    if (xt[879:874]==xt_1[879:874]) begin
                        count64[54]<=1;
                    end
                    else begin
                        count64[54] <= 0;
                    end
                    if (xt[895:890]==xt_1[895:890]) begin
                        count64[55]<=1;
                    end
                    else begin
                        count64[55] <= 0;
                    end
                    if (xt[911:906]==xt_1[911:906]) begin
                        count64[56]<=1;
                    end
                    else begin
                        count64[56] <= 0;
                    end
                    if (xt[927:922]==xt_1[927:922]) begin
                        count64[57]<=1;
                    end
                    else begin
                        count64[57] <= 0;
                    end
                    if (xt[943:938]==xt_1[943:938]) begin
                        count64[58]<=1;
                    end
                    else begin
                        count64[58] <= 0;
                    end
                    if (xt[959:954]==xt_1[959:954]) begin
                        count64[59]<=1;
                    end
                    else begin
                        count64[59] <= 0;
                    end
                    if (xt[975:970]==xt_1[975:970]) begin
                        count64[60]<=1;
                    end
                    else begin
                        count64[60] <= 0;
                    end
                    if (xt[991:986]==xt_1[991:986]) begin
                        count64[61]<=1;
                    end
                    else begin
                        count64[61] <= 0;
                    end
                    if (xt[1007:1002]==xt_1[1007:1002]) begin
                        count64[62]<=1;
                    end
                    else begin
                        count64[62] <= 0;
                    end
                    if (xt[1023:1018]==xt_1[1023:1018]) begin
                        count64[63]<=1;
                    end
                    else begin
                        count64[63] <= 0;
                    end
                end
                Sub_Add64to32:begin
                    if (xt[15:10]==xt_1[15:10]) begin
                        count64[0]<=1;
                    end
                    else begin
                        count64[0] <= 0;
                    end
                    if (xt[31:26]==xt_1[31:26]) begin
                        count64[1]<=1;
                    end
                    else begin
                        count64[1] <= 0;
                    end
                    if (xt[47:42]==xt_1[47:42]) begin
                        count64[2]<=1;
                    end
                    else begin
                        count64[2] <= 0;
                    end
                    if (xt[63:58]==xt_1[63:58]) begin
                        count64[3]<=1;
                    end
                    else begin
                        count64[3] <= 0;
                    end
                    if (xt[79:74]==xt_1[79:74]) begin
                        count64[4]<=1;
                    end
                    else begin
                        count64[4] <= 0;
                    end
                    if (xt[95:90]==xt_1[95:90]) begin
                        count64[5]<=1;
                    end
                    else begin
                        count64[5] <= 0;
                    end
                    if (xt[111:106]==xt_1[111:106]) begin
                        count64[6]<=1;
                    end
                    else begin
                        count64[6] <= 0;
                    end
                    if (xt[127:122]==xt_1[127:122]) begin
                        count64[7]<=1;
                    end
                    else begin
                        count64[7] <= 0;
                    end
                    if (xt[143:138]==xt_1[143:138]) begin
                        count64[8]<=1;
                    end
                    else begin
                        count64[8] <= 0;
                    end
                    if (xt[159:154]==xt_1[159:154]) begin
                        count64[9]<=1;
                    end
                    else begin
                        count64[9] <= 0;
                    end
                    if (xt[175:170]==xt_1[175:170]) begin
                        count64[10]<=1;
                    end
                    else begin
                        count64[10] <= 0;
                    end
                    if (xt[191:186]==xt_1[191:186]) begin
                        count64[11]<=1;
                    end
                    else begin
                        count64[11] <= 0;
                    end
                    if (xt[207:202]==xt_1[207:202]) begin
                        count64[12]<=1;
                    end
                    else begin
                        count64[12] <= 0;
                    end
                    if (xt[223:218]==xt_1[223:218]) begin
                        count64[13]<=1;
                    end
                    else begin
                        count64[13] <= 0;
                    end
                    if (xt[239:234]==xt_1[239:234]) begin
                        count64[14]<=1;
                    end
                    else begin
                        count64[14] <= 0;
                    end
                    if (xt[255:250]==xt_1[255:250]) begin
                        count64[15]<=1;
                    end
                    else begin
                        count64[15] <= 0;
                    end
                    if (xt[271:266]==xt_1[271:266]) begin
                        count64[16]<=1;
                    end
                    else begin
                        count64[16] <= 0;
                    end
                    if (xt[287:282]==xt_1[287:282]) begin
                        count64[17]<=1;
                    end
                    else begin
                        count64[17] <= 0;
                    end
                    if (xt[303:298]==xt_1[303:298]) begin
                        count64[18]<=1;
                    end
                    else begin
                        count64[18] <= 0;
                    end
                    if (xt[319:314]==xt_1[319:314]) begin
                        count64[19]<=1;
                    end
                    else begin
                        count64[19] <= 0;
                    end
                    if (xt[335:330]==xt_1[335:330]) begin
                        count64[20]<=1;
                    end
                    else begin
                        count64[20] <= 0;
                    end
                    if (xt[351:346]==xt_1[351:346]) begin
                        count64[21]<=1;
                    end
                    else begin
                        count64[21] <= 0;
                    end
                    if (xt[367:362]==xt_1[367:362]) begin
                        count64[22]<=1;
                    end
                    else begin
                        count64[22] <= 0;
                    end
                    if (xt[383:378]==xt_1[383:378]) begin
                        count64[23]<=1;
                    end
                    else begin
                        count64[23] <= 0;
                    end
                    if (xt[399:394]==xt_1[399:394]) begin
                        count64[24]<=1;
                    end
                    else begin
                        count64[24] <= 0;
                    end
                    if (xt[415:410]==xt_1[415:410]) begin
                        count64[25]<=1;
                    end
                    else begin
                        count64[25] <= 0;
                    end
                    if (xt[431:426]==xt_1[431:426]) begin
                        count64[26]<=1;
                    end
                    else begin
                        count64[26] <= 0;
                    end
                    if (xt[447:442]==xt_1[447:442]) begin
                        count64[27]<=1;
                    end
                    else begin
                        count64[27] <= 0;
                    end
                    if (xt[463:458]==xt_1[463:458]) begin
                        count64[28]<=1;
                    end
                    else begin
                        count64[28] <= 0;
                    end
                    if (xt[479:474]==xt_1[479:474]) begin
                        count64[29]<=1;
                    end
                    else begin
                        count64[29] <= 0;
                    end
                    if (xt[495:490]==xt_1[495:490]) begin
                        count64[30]<=1;
                    end
                    else begin
                        count64[30] <= 0;
                    end
                    if (xt[511:506]==xt_1[511:506]) begin
                        count64[31]<=1;
                    end
                    else begin
                        count64[31] <= 0;
                    end
                    if (xt[527:522]==xt_1[527:522]) begin
                        count64[32]<=1;
                    end
                    else begin
                        count64[32] <= 0;
                    end
                    if (xt[543:538]==xt_1[543:538]) begin
                        count64[33]<=1;
                    end
                    else begin
                        count64[33] <= 0;
                    end
                    if (xt[559:554]==xt_1[559:554]) begin
                        count64[34]<=1;
                    end
                    else begin
                        count64[34] <= 0;
                    end
                    if (xt[575:570]==xt_1[575:570]) begin
                        count64[35]<=1;
                    end
                    else begin
                        count64[35] <= 0;
                    end
                    if (xt[591:586]==xt_1[591:586]) begin
                        count64[36]<=1;
                    end
                    else begin
                        count64[36] <= 0;
                    end
                    if (xt[607:602]==xt_1[607:602]) begin
                        count64[37]<=1;
                    end
                    else begin
                        count64[37] <= 0;
                    end
                    if (xt[623:618]==xt_1[623:618]) begin
                        count64[38]<=1;
                    end
                    else begin
                        count64[38] <= 0;
                    end
                    if (xt[639:634]==xt_1[639:634]) begin
                        count64[39]<=1;
                    end
                    else begin
                        count64[39] <= 0;
                    end
                    if (xt[655:650]==xt_1[655:650]) begin
                        count64[40]<=1;
                    end
                    else begin
                        count64[40] <= 0;
                    end
                    if (xt[671:666]==xt_1[671:666]) begin
                        count64[41]<=1;
                    end
                    else begin
                        count64[41] <= 0;
                    end
                    if (xt[687:682]==xt_1[687:682]) begin
                        count64[42]<=1;
                    end
                    else begin
                        count64[42] <= 0;
                    end
                    if (xt[703:698]==xt_1[703:698]) begin
                        count64[43]<=1;
                    end
                    else begin
                        count64[43] <= 0;
                    end
                    if (xt[719:714]==xt_1[719:714]) begin
                        count64[44]<=1;
                    end
                    else begin
                        count64[44] <= 0;
                    end
                    if (xt[735:730]==xt_1[735:730]) begin
                        count64[45]<=1;
                    end
                    else begin
                        count64[45] <= 0;
                    end
                    if (xt[751:746]==xt_1[751:746]) begin
                        count64[46]<=1;
                    end
                    else begin
                        count64[46] <= 0;
                    end
                    if (xt[767:762]==xt_1[767:762]) begin
                        count64[47]<=1;
                    end
                    else begin
                        count64[47] <= 0;
                    end
                    if (xt[783:778]==xt_1[783:778]) begin
                        count64[48]<=1;
                    end
                    else begin
                        count64[48] <= 0;
                    end
                    if (xt[799:794]==xt_1[799:794]) begin
                        count64[49]<=1;
                    end
                    else begin
                        count64[49] <= 0;
                    end
                    if (xt[815:810]==xt_1[815:810]) begin
                        count64[50]<=1;
                    end
                    else begin
                        count64[50] <= 0;
                    end
                    if (xt[831:826]==xt_1[831:826]) begin
                        count64[51]<=1;
                    end
                    else begin
                        count64[51] <= 0;
                    end
                    if (xt[847:842]==xt_1[847:842]) begin
                        count64[52]<=1;
                    end
                    else begin
                        count64[52] <= 0;
                    end
                    if (xt[863:858]==xt_1[863:858]) begin
                        count64[53]<=1;
                    end
                    else begin
                        count64[53] <= 0;
                    end
                    if (xt[879:874]==xt_1[879:874]) begin
                        count64[54]<=1;
                    end
                    else begin
                        count64[54] <= 0;
                    end
                    if (xt[895:890]==xt_1[895:890]) begin
                        count64[55]<=1;
                    end
                    else begin
                        count64[55] <= 0;
                    end
                    if (xt[911:906]==xt_1[911:906]) begin
                        count64[56]<=1;
                    end
                    else begin
                        count64[56] <= 0;
                    end
                    if (xt[927:922]==xt_1[927:922]) begin
                        count64[57]<=1;
                    end
                    else begin
                        count64[57] <= 0;
                    end
                    if (xt[943:938]==xt_1[943:938]) begin
                        count64[58]<=1;
                    end
                    else begin
                        count64[58] <= 0;
                    end
                    if (xt[959:954]==xt_1[959:954]) begin
                        count64[59]<=1;
                    end
                    else begin
                        count64[59] <= 0;
                    end
                    if (xt[975:970]==xt_1[975:970]) begin
                        count64[60]<=1;
                    end
                    else begin
                        count64[60] <= 0;
                    end
                    if (xt[991:986]==xt_1[991:986]) begin
                        count64[61]<=1;
                    end
                    else begin
                        count64[61] <= 0;
                    end
                    if (xt[1007:1002]==xt_1[1007:1002]) begin
                        count64[62]<=1;
                    end
                    else begin
                        count64[62] <= 0;
                    end
                    if (xt[1023:1018]==xt_1[1023:1018]) begin
                        count64[63]<=1;
                    end
                    else begin
                        count64[63] <= 0;
                    end
                end
                Sub_Add64to32_32to16:begin
                    if (xt[15:10]==xt_1[15:10]) begin
                        count64[0]<=1;
                    end
                    else begin
                        count64[0] <= 0;
                    end
                    if (xt[31:26]==xt_1[31:26]) begin
                        count64[1]<=1;
                    end
                    else begin
                        count64[1] <= 0;
                    end
                    if (xt[47:42]==xt_1[47:42]) begin
                        count64[2]<=1;
                    end
                    else begin
                        count64[2] <= 0;
                    end
                    if (xt[63:58]==xt_1[63:58]) begin
                        count64[3]<=1;
                    end
                    else begin
                        count64[3] <= 0;
                    end
                    if (xt[79:74]==xt_1[79:74]) begin
                        count64[4]<=1;
                    end
                    else begin
                        count64[4] <= 0;
                    end
                    if (xt[95:90]==xt_1[95:90]) begin
                        count64[5]<=1;
                    end
                    else begin
                        count64[5] <= 0;
                    end
                    if (xt[111:106]==xt_1[111:106]) begin
                        count64[6]<=1;
                    end
                    else begin
                        count64[6] <= 0;
                    end
                    if (xt[127:122]==xt_1[127:122]) begin
                        count64[7]<=1;
                    end
                    else begin
                        count64[7] <= 0;
                    end
                    if (xt[143:138]==xt_1[143:138]) begin
                        count64[8]<=1;
                    end
                    else begin
                        count64[8] <= 0;
                    end
                    if (xt[159:154]==xt_1[159:154]) begin
                        count64[9]<=1;
                    end
                    else begin
                        count64[9] <= 0;
                    end
                    if (xt[175:170]==xt_1[175:170]) begin
                        count64[10]<=1;
                    end
                    else begin
                        count64[10] <= 0;
                    end
                    if (xt[191:186]==xt_1[191:186]) begin
                        count64[11]<=1;
                    end
                    else begin
                        count64[11] <= 0;
                    end
                    if (xt[207:202]==xt_1[207:202]) begin
                        count64[12]<=1;
                    end
                    else begin
                        count64[12] <= 0;
                    end
                    if (xt[223:218]==xt_1[223:218]) begin
                        count64[13]<=1;
                    end
                    else begin
                        count64[13] <= 0;
                    end
                    if (xt[239:234]==xt_1[239:234]) begin
                        count64[14]<=1;
                    end
                    else begin
                        count64[14] <= 0;
                    end
                    if (xt[255:250]==xt_1[255:250]) begin
                        count64[15]<=1;
                    end
                    else begin
                        count64[15] <= 0;
                    end
                    if (xt[271:266]==xt_1[271:266]) begin
                        count64[16]<=1;
                    end
                    else begin
                        count64[16] <= 0;
                    end
                    if (xt[287:282]==xt_1[287:282]) begin
                        count64[17]<=1;
                    end
                    else begin
                        count64[17] <= 0;
                    end
                    if (xt[303:298]==xt_1[303:298]) begin
                        count64[18]<=1;
                    end
                    else begin
                        count64[18] <= 0;
                    end
                    if (xt[319:314]==xt_1[319:314]) begin
                        count64[19]<=1;
                    end
                    else begin
                        count64[19] <= 0;
                    end
                    if (xt[335:330]==xt_1[335:330]) begin
                        count64[20]<=1;
                    end
                    else begin
                        count64[20] <= 0;
                    end
                    if (xt[351:346]==xt_1[351:346]) begin
                        count64[21]<=1;
                    end
                    else begin
                        count64[21] <= 0;
                    end
                    if (xt[367:362]==xt_1[367:362]) begin
                        count64[22]<=1;
                    end
                    else begin
                        count64[22] <= 0;
                    end
                    if (xt[383:378]==xt_1[383:378]) begin
                        count64[23]<=1;
                    end
                    else begin
                        count64[23] <= 0;
                    end
                    if (xt[399:394]==xt_1[399:394]) begin
                        count64[24]<=1;
                    end
                    else begin
                        count64[24] <= 0;
                    end
                    if (xt[415:410]==xt_1[415:410]) begin
                        count64[25]<=1;
                    end
                    else begin
                        count64[25] <= 0;
                    end
                    if (xt[431:426]==xt_1[431:426]) begin
                        count64[26]<=1;
                    end
                    else begin
                        count64[26] <= 0;
                    end
                    if (xt[447:442]==xt_1[447:442]) begin
                        count64[27]<=1;
                    end
                    else begin
                        count64[27] <= 0;
                    end
                    if (xt[463:458]==xt_1[463:458]) begin
                        count64[28]<=1;
                    end
                    else begin
                        count64[28] <= 0;
                    end
                    if (xt[479:474]==xt_1[479:474]) begin
                        count64[29]<=1;
                    end
                    else begin
                        count64[29] <= 0;
                    end
                    if (xt[495:490]==xt_1[495:490]) begin
                        count64[30]<=1;
                    end
                    else begin
                        count64[30] <= 0;
                    end
                    if (xt[511:506]==xt_1[511:506]) begin
                        count64[31]<=1;
                    end
                    else begin
                        count64[31] <= 0;
                    end
                    if (xt[527:522]==xt_1[527:522]) begin
                        count64[32]<=1;
                    end
                    else begin
                        count64[32] <= 0;
                    end
                    if (xt[543:538]==xt_1[543:538]) begin
                        count64[33]<=1;
                    end
                    else begin
                        count64[33] <= 0;
                    end
                    if (xt[559:554]==xt_1[559:554]) begin
                        count64[34]<=1;
                    end
                    else begin
                        count64[34] <= 0;
                    end
                    if (xt[575:570]==xt_1[575:570]) begin
                        count64[35]<=1;
                    end
                    else begin
                        count64[35] <= 0;
                    end
                    if (xt[591:586]==xt_1[591:586]) begin
                        count64[36]<=1;
                    end
                    else begin
                        count64[36] <= 0;
                    end
                    if (xt[607:602]==xt_1[607:602]) begin
                        count64[37]<=1;
                    end
                    else begin
                        count64[37] <= 0;
                    end
                    if (xt[623:618]==xt_1[623:618]) begin
                        count64[38]<=1;
                    end
                    else begin
                        count64[38] <= 0;
                    end
                    if (xt[639:634]==xt_1[639:634]) begin
                        count64[39]<=1;
                    end
                    else begin
                        count64[39] <= 0;
                    end
                    if (xt[655:650]==xt_1[655:650]) begin
                        count64[40]<=1;
                    end
                    else begin
                        count64[40] <= 0;
                    end
                    if (xt[671:666]==xt_1[671:666]) begin
                        count64[41]<=1;
                    end
                    else begin
                        count64[41] <= 0;
                    end
                    if (xt[687:682]==xt_1[687:682]) begin
                        count64[42]<=1;
                    end
                    else begin
                        count64[42] <= 0;
                    end
                    if (xt[703:698]==xt_1[703:698]) begin
                        count64[43]<=1;
                    end
                    else begin
                        count64[43] <= 0;
                    end
                    if (xt[719:714]==xt_1[719:714]) begin
                        count64[44]<=1;
                    end
                    else begin
                        count64[44] <= 0;
                    end
                    if (xt[735:730]==xt_1[735:730]) begin
                        count64[45]<=1;
                    end
                    else begin
                        count64[45] <= 0;
                    end
                    if (xt[751:746]==xt_1[751:746]) begin
                        count64[46]<=1;
                    end
                    else begin
                        count64[46] <= 0;
                    end
                    if (xt[767:762]==xt_1[767:762]) begin
                        count64[47]<=1;
                    end
                    else begin
                        count64[47] <= 0;
                    end
                    if (xt[783:778]==xt_1[783:778]) begin
                        count64[48]<=1;
                    end
                    else begin
                        count64[48] <= 0;
                    end
                    if (xt[799:794]==xt_1[799:794]) begin
                        count64[49]<=1;
                    end
                    else begin
                        count64[49] <= 0;
                    end
                    if (xt[815:810]==xt_1[815:810]) begin
                        count64[50]<=1;
                    end
                    else begin
                        count64[50] <= 0;
                    end
                    if (xt[831:826]==xt_1[831:826]) begin
                        count64[51]<=1;
                    end
                    else begin
                        count64[51] <= 0;
                    end
                    if (xt[847:842]==xt_1[847:842]) begin
                        count64[52]<=1;
                    end
                    else begin
                        count64[52] <= 0;
                    end
                    if (xt[863:858]==xt_1[863:858]) begin
                        count64[53]<=1;
                    end
                    else begin
                        count64[53] <= 0;
                    end
                    if (xt[879:874]==xt_1[879:874]) begin
                        count64[54]<=1;
                    end
                    else begin
                        count64[54] <= 0;
                    end
                    if (xt[895:890]==xt_1[895:890]) begin
                        count64[55]<=1;
                    end
                    else begin
                        count64[55] <= 0;
                    end
                    if (xt[911:906]==xt_1[911:906]) begin
                        count64[56]<=1;
                    end
                    else begin
                        count64[56] <= 0;
                    end
                    if (xt[927:922]==xt_1[927:922]) begin
                        count64[57]<=1;
                    end
                    else begin
                        count64[57] <= 0;
                    end
                    if (xt[943:938]==xt_1[943:938]) begin
                        count64[58]<=1;
                    end
                    else begin
                        count64[58] <= 0;
                    end
                    if (xt[959:954]==xt_1[959:954]) begin
                        count64[59]<=1;
                    end
                    else begin
                        count64[59] <= 0;
                    end
                    if (xt[975:970]==xt_1[975:970]) begin
                        count64[60]<=1;
                    end
                    else begin
                        count64[60] <= 0;
                    end
                    if (xt[991:986]==xt_1[991:986]) begin
                        count64[61]<=1;
                    end
                    else begin
                        count64[61] <= 0;
                    end
                    if (xt[1007:1002]==xt_1[1007:1002]) begin
                        count64[62]<=1;
                    end
                    else begin
                        count64[62] <= 0;
                    end
                    if (xt[1023:1018]==xt_1[1023:1018]) begin
                        count64[63]<=1;
                    end
                    else begin
                        count64[63] <= 0;
                    end
                end
                Sub_Add64to32_32to16_16to8:begin
                    if (xt[15:10]==xt_1[15:10]) begin
                        count64[0]<=1;
                    end
                    else begin
                        count64[0] <= 0;
                    end
                    if (xt[31:26]==xt_1[31:26]) begin
                        count64[1]<=1;
                    end
                    else begin
                        count64[1] <= 0;
                    end
                    if (xt[47:42]==xt_1[47:42]) begin
                        count64[2]<=1;
                    end
                    else begin
                        count64[2] <= 0;
                    end
                    if (xt[63:58]==xt_1[63:58]) begin
                        count64[3]<=1;
                    end
                    else begin
                        count64[3] <= 0;
                    end
                    if (xt[79:74]==xt_1[79:74]) begin
                        count64[4]<=1;
                    end
                    else begin
                        count64[4] <= 0;
                    end
                    if (xt[95:90]==xt_1[95:90]) begin
                        count64[5]<=1;
                    end
                    else begin
                        count64[5] <= 0;
                    end
                    if (xt[111:106]==xt_1[111:106]) begin
                        count64[6]<=1;
                    end
                    else begin
                        count64[6] <= 0;
                    end
                    if (xt[127:122]==xt_1[127:122]) begin
                        count64[7]<=1;
                    end
                    else begin
                        count64[7] <= 0;
                    end
                    if (xt[143:138]==xt_1[143:138]) begin
                        count64[8]<=1;
                    end
                    else begin
                        count64[8] <= 0;
                    end
                    if (xt[159:154]==xt_1[159:154]) begin
                        count64[9]<=1;
                    end
                    else begin
                        count64[9] <= 0;
                    end
                    if (xt[175:170]==xt_1[175:170]) begin
                        count64[10]<=1;
                    end
                    else begin
                        count64[10] <= 0;
                    end
                    if (xt[191:186]==xt_1[191:186]) begin
                        count64[11]<=1;
                    end
                    else begin
                        count64[11] <= 0;
                    end
                    if (xt[207:202]==xt_1[207:202]) begin
                        count64[12]<=1;
                    end
                    else begin
                        count64[12] <= 0;
                    end
                    if (xt[223:218]==xt_1[223:218]) begin
                        count64[13]<=1;
                    end
                    else begin
                        count64[13] <= 0;
                    end
                    if (xt[239:234]==xt_1[239:234]) begin
                        count64[14]<=1;
                    end
                    else begin
                        count64[14] <= 0;
                    end
                    if (xt[255:250]==xt_1[255:250]) begin
                        count64[15]<=1;
                    end
                    else begin
                        count64[15] <= 0;
                    end
                    if (xt[271:266]==xt_1[271:266]) begin
                        count64[16]<=1;
                    end
                    else begin
                        count64[16] <= 0;
                    end
                    if (xt[287:282]==xt_1[287:282]) begin
                        count64[17]<=1;
                    end
                    else begin
                        count64[17] <= 0;
                    end
                    if (xt[303:298]==xt_1[303:298]) begin
                        count64[18]<=1;
                    end
                    else begin
                        count64[18] <= 0;
                    end
                    if (xt[319:314]==xt_1[319:314]) begin
                        count64[19]<=1;
                    end
                    else begin
                        count64[19] <= 0;
                    end
                    if (xt[335:330]==xt_1[335:330]) begin
                        count64[20]<=1;
                    end
                    else begin
                        count64[20] <= 0;
                    end
                    if (xt[351:346]==xt_1[351:346]) begin
                        count64[21]<=1;
                    end
                    else begin
                        count64[21] <= 0;
                    end
                    if (xt[367:362]==xt_1[367:362]) begin
                        count64[22]<=1;
                    end
                    else begin
                        count64[22] <= 0;
                    end
                    if (xt[383:378]==xt_1[383:378]) begin
                        count64[23]<=1;
                    end
                    else begin
                        count64[23] <= 0;
                    end
                    if (xt[399:394]==xt_1[399:394]) begin
                        count64[24]<=1;
                    end
                    else begin
                        count64[24] <= 0;
                    end
                    if (xt[415:410]==xt_1[415:410]) begin
                        count64[25]<=1;
                    end
                    else begin
                        count64[25] <= 0;
                    end
                    if (xt[431:426]==xt_1[431:426]) begin
                        count64[26]<=1;
                    end
                    else begin
                        count64[26] <= 0;
                    end
                    if (xt[447:442]==xt_1[447:442]) begin
                        count64[27]<=1;
                    end
                    else begin
                        count64[27] <= 0;
                    end
                    if (xt[463:458]==xt_1[463:458]) begin
                        count64[28]<=1;
                    end
                    else begin
                        count64[28] <= 0;
                    end
                    if (xt[479:474]==xt_1[479:474]) begin
                        count64[29]<=1;
                    end
                    else begin
                        count64[29] <= 0;
                    end
                    if (xt[495:490]==xt_1[495:490]) begin
                        count64[30]<=1;
                    end
                    else begin
                        count64[30] <= 0;
                    end
                    if (xt[511:506]==xt_1[511:506]) begin
                        count64[31]<=1;
                    end
                    else begin
                        count64[31] <= 0;
                    end
                    if (xt[527:522]==xt_1[527:522]) begin
                        count64[32]<=1;
                    end
                    else begin
                        count64[32] <= 0;
                    end
                    if (xt[543:538]==xt_1[543:538]) begin
                        count64[33]<=1;
                    end
                    else begin
                        count64[33] <= 0;
                    end
                    if (xt[559:554]==xt_1[559:554]) begin
                        count64[34]<=1;
                    end
                    else begin
                        count64[34] <= 0;
                    end
                    if (xt[575:570]==xt_1[575:570]) begin
                        count64[35]<=1;
                    end
                    else begin
                        count64[35] <= 0;
                    end
                    if (xt[591:586]==xt_1[591:586]) begin
                        count64[36]<=1;
                    end
                    else begin
                        count64[36] <= 0;
                    end
                    if (xt[607:602]==xt_1[607:602]) begin
                        count64[37]<=1;
                    end
                    else begin
                        count64[37] <= 0;
                    end
                    if (xt[623:618]==xt_1[623:618]) begin
                        count64[38]<=1;
                    end
                    else begin
                        count64[38] <= 0;
                    end
                    if (xt[639:634]==xt_1[639:634]) begin
                        count64[39]<=1;
                    end
                    else begin
                        count64[39] <= 0;
                    end
                    if (xt[655:650]==xt_1[655:650]) begin
                        count64[40]<=1;
                    end
                    else begin
                        count64[40] <= 0;
                    end
                    if (xt[671:666]==xt_1[671:666]) begin
                        count64[41]<=1;
                    end
                    else begin
                        count64[41] <= 0;
                    end
                    if (xt[687:682]==xt_1[687:682]) begin
                        count64[42]<=1;
                    end
                    else begin
                        count64[42] <= 0;
                    end
                    if (xt[703:698]==xt_1[703:698]) begin
                        count64[43]<=1;
                    end
                    else begin
                        count64[43] <= 0;
                    end
                    if (xt[719:714]==xt_1[719:714]) begin
                        count64[44]<=1;
                    end
                    else begin
                        count64[44] <= 0;
                    end
                    if (xt[735:730]==xt_1[735:730]) begin
                        count64[45]<=1;
                    end
                    else begin
                        count64[45] <= 0;
                    end
                    if (xt[751:746]==xt_1[751:746]) begin
                        count64[46]<=1;
                    end
                    else begin
                        count64[46] <= 0;
                    end
                    if (xt[767:762]==xt_1[767:762]) begin
                        count64[47]<=1;
                    end
                    else begin
                        count64[47] <= 0;
                    end
                    if (xt[783:778]==xt_1[783:778]) begin
                        count64[48]<=1;
                    end
                    else begin
                        count64[48] <= 0;
                    end
                    if (xt[799:794]==xt_1[799:794]) begin
                        count64[49]<=1;
                    end
                    else begin
                        count64[49] <= 0;
                    end
                    if (xt[815:810]==xt_1[815:810]) begin
                        count64[50]<=1;
                    end
                    else begin
                        count64[50] <= 0;
                    end
                    if (xt[831:826]==xt_1[831:826]) begin
                        count64[51]<=1;
                    end
                    else begin
                        count64[51] <= 0;
                    end
                    if (xt[847:842]==xt_1[847:842]) begin
                        count64[52]<=1;
                    end
                    else begin
                        count64[52] <= 0;
                    end
                    if (xt[863:858]==xt_1[863:858]) begin
                        count64[53]<=1;
                    end
                    else begin
                        count64[53] <= 0;
                    end
                    if (xt[879:874]==xt_1[879:874]) begin
                        count64[54]<=1;
                    end
                    else begin
                        count64[54] <= 0;
                    end
                    if (xt[895:890]==xt_1[895:890]) begin
                        count64[55]<=1;
                    end
                    else begin
                        count64[55] <= 0;
                    end
                    if (xt[911:906]==xt_1[911:906]) begin
                        count64[56]<=1;
                    end
                    else begin
                        count64[56] <= 0;
                    end
                    if (xt[927:922]==xt_1[927:922]) begin
                        count64[57]<=1;
                    end
                    else begin
                        count64[57] <= 0;
                    end
                    if (xt[943:938]==xt_1[943:938]) begin
                        count64[58]<=1;
                    end
                    else begin
                        count64[58] <= 0;
                    end
                    if (xt[959:954]==xt_1[959:954]) begin
                        count64[59]<=1;
                    end
                    else begin
                        count64[59] <= 0;
                    end
                    if (xt[975:970]==xt_1[975:970]) begin
                        count64[60]<=1;
                    end
                    else begin
                        count64[60] <= 0;
                    end
                    if (xt[991:986]==xt_1[991:986]) begin
                        count64[61]<=1;
                    end
                    else begin
                        count64[61] <= 0;
                    end
                    if (xt[1007:1002]==xt_1[1007:1002]) begin
                        count64[62]<=1;
                    end
                    else begin
                        count64[62] <= 0;
                    end
                    if (xt[1023:1018]==xt_1[1023:1018]) begin
                        count64[63]<=1;
                    end
                    else begin
                        count64[63] <= 0;
                    end
                end
                Sub_Add64to32_32to16_16to8_8to4:begin
                    if (xt[15:10]==xt_1[15:10]) begin
                        count64[0]<=1;
                    end
                    else begin
                        count64[0] <= 0;
                    end
                    if (xt[31:26]==xt_1[31:26]) begin
                        count64[1]<=1;
                    end
                    else begin
                        count64[1] <= 0;
                    end
                    if (xt[47:42]==xt_1[47:42]) begin
                        count64[2]<=1;
                    end
                    else begin
                        count64[2] <= 0;
                    end
                    if (xt[63:58]==xt_1[63:58]) begin
                        count64[3]<=1;
                    end
                    else begin
                        count64[3] <= 0;
                    end
                    if (xt[79:74]==xt_1[79:74]) begin
                        count64[4]<=1;
                    end
                    else begin
                        count64[4] <= 0;
                    end
                    if (xt[95:90]==xt_1[95:90]) begin
                        count64[5]<=1;
                    end
                    else begin
                        count64[5] <= 0;
                    end
                    if (xt[111:106]==xt_1[111:106]) begin
                        count64[6]<=1;
                    end
                    else begin
                        count64[6] <= 0;
                    end
                    if (xt[127:122]==xt_1[127:122]) begin
                        count64[7]<=1;
                    end
                    else begin
                        count64[7] <= 0;
                    end
                    if (xt[143:138]==xt_1[143:138]) begin
                        count64[8]<=1;
                    end
                    else begin
                        count64[8] <= 0;
                    end
                    if (xt[159:154]==xt_1[159:154]) begin
                        count64[9]<=1;
                    end
                    else begin
                        count64[9] <= 0;
                    end
                    if (xt[175:170]==xt_1[175:170]) begin
                        count64[10]<=1;
                    end
                    else begin
                        count64[10] <= 0;
                    end
                    if (xt[191:186]==xt_1[191:186]) begin
                        count64[11]<=1;
                    end
                    else begin
                        count64[11] <= 0;
                    end
                    if (xt[207:202]==xt_1[207:202]) begin
                        count64[12]<=1;
                    end
                    else begin
                        count64[12] <= 0;
                    end
                    if (xt[223:218]==xt_1[223:218]) begin
                        count64[13]<=1;
                    end
                    else begin
                        count64[13] <= 0;
                    end
                    if (xt[239:234]==xt_1[239:234]) begin
                        count64[14]<=1;
                    end
                    else begin
                        count64[14] <= 0;
                    end
                    if (xt[255:250]==xt_1[255:250]) begin
                        count64[15]<=1;
                    end
                    else begin
                        count64[15] <= 0;
                    end
                    if (xt[271:266]==xt_1[271:266]) begin
                        count64[16]<=1;
                    end
                    else begin
                        count64[16] <= 0;
                    end
                    if (xt[287:282]==xt_1[287:282]) begin
                        count64[17]<=1;
                    end
                    else begin
                        count64[17] <= 0;
                    end
                    if (xt[303:298]==xt_1[303:298]) begin
                        count64[18]<=1;
                    end
                    else begin
                        count64[18] <= 0;
                    end
                    if (xt[319:314]==xt_1[319:314]) begin
                        count64[19]<=1;
                    end
                    else begin
                        count64[19] <= 0;
                    end
                    if (xt[335:330]==xt_1[335:330]) begin
                        count64[20]<=1;
                    end
                    else begin
                        count64[20] <= 0;
                    end
                    if (xt[351:346]==xt_1[351:346]) begin
                        count64[21]<=1;
                    end
                    else begin
                        count64[21] <= 0;
                    end
                    if (xt[367:362]==xt_1[367:362]) begin
                        count64[22]<=1;
                    end
                    else begin
                        count64[22] <= 0;
                    end
                    if (xt[383:378]==xt_1[383:378]) begin
                        count64[23]<=1;
                    end
                    else begin
                        count64[23] <= 0;
                    end
                    if (xt[399:394]==xt_1[399:394]) begin
                        count64[24]<=1;
                    end
                    else begin
                        count64[24] <= 0;
                    end
                    if (xt[415:410]==xt_1[415:410]) begin
                        count64[25]<=1;
                    end
                    else begin
                        count64[25] <= 0;
                    end
                    if (xt[431:426]==xt_1[431:426]) begin
                        count64[26]<=1;
                    end
                    else begin
                        count64[26] <= 0;
                    end
                    if (xt[447:442]==xt_1[447:442]) begin
                        count64[27]<=1;
                    end
                    else begin
                        count64[27] <= 0;
                    end
                    if (xt[463:458]==xt_1[463:458]) begin
                        count64[28]<=1;
                    end
                    else begin
                        count64[28] <= 0;
                    end
                    if (xt[479:474]==xt_1[479:474]) begin
                        count64[29]<=1;
                    end
                    else begin
                        count64[29] <= 0;
                    end
                    if (xt[495:490]==xt_1[495:490]) begin
                        count64[30]<=1;
                    end
                    else begin
                        count64[30] <= 0;
                    end
                    if (xt[511:506]==xt_1[511:506]) begin
                        count64[31]<=1;
                    end
                    else begin
                        count64[31] <= 0;
                    end
                    if (xt[527:522]==xt_1[527:522]) begin
                        count64[32]<=1;
                    end
                    else begin
                        count64[32] <= 0;
                    end
                    if (xt[543:538]==xt_1[543:538]) begin
                        count64[33]<=1;
                    end
                    else begin
                        count64[33] <= 0;
                    end
                    if (xt[559:554]==xt_1[559:554]) begin
                        count64[34]<=1;
                    end
                    else begin
                        count64[34] <= 0;
                    end
                    if (xt[575:570]==xt_1[575:570]) begin
                        count64[35]<=1;
                    end
                    else begin
                        count64[35] <= 0;
                    end
                    if (xt[591:586]==xt_1[591:586]) begin
                        count64[36]<=1;
                    end
                    else begin
                        count64[36] <= 0;
                    end
                    if (xt[607:602]==xt_1[607:602]) begin
                        count64[37]<=1;
                    end
                    else begin
                        count64[37] <= 0;
                    end
                    if (xt[623:618]==xt_1[623:618]) begin
                        count64[38]<=1;
                    end
                    else begin
                        count64[38] <= 0;
                    end
                    if (xt[639:634]==xt_1[639:634]) begin
                        count64[39]<=1;
                    end
                    else begin
                        count64[39] <= 0;
                    end
                    if (xt[655:650]==xt_1[655:650]) begin
                        count64[40]<=1;
                    end
                    else begin
                        count64[40] <= 0;
                    end
                    if (xt[671:666]==xt_1[671:666]) begin
                        count64[41]<=1;
                    end
                    else begin
                        count64[41] <= 0;
                    end
                    if (xt[687:682]==xt_1[687:682]) begin
                        count64[42]<=1;
                    end
                    else begin
                        count64[42] <= 0;
                    end
                    if (xt[703:698]==xt_1[703:698]) begin
                        count64[43]<=1;
                    end
                    else begin
                        count64[43] <= 0;
                    end
                    if (xt[719:714]==xt_1[719:714]) begin
                        count64[44]<=1;
                    end
                    else begin
                        count64[44] <= 0;
                    end
                    if (xt[735:730]==xt_1[735:730]) begin
                        count64[45]<=1;
                    end
                    else begin
                        count64[45] <= 0;
                    end
                    if (xt[751:746]==xt_1[751:746]) begin
                        count64[46]<=1;
                    end
                    else begin
                        count64[46] <= 0;
                    end
                    if (xt[767:762]==xt_1[767:762]) begin
                        count64[47]<=1;
                    end
                    else begin
                        count64[47] <= 0;
                    end
                    if (xt[783:778]==xt_1[783:778]) begin
                        count64[48]<=1;
                    end
                    else begin
                        count64[48] <= 0;
                    end
                    if (xt[799:794]==xt_1[799:794]) begin
                        count64[49]<=1;
                    end
                    else begin
                        count64[49] <= 0;
                    end
                    if (xt[815:810]==xt_1[815:810]) begin
                        count64[50]<=1;
                    end
                    else begin
                        count64[50] <= 0;
                    end
                    if (xt[831:826]==xt_1[831:826]) begin
                        count64[51]<=1;
                    end
                    else begin
                        count64[51] <= 0;
                    end
                    if (xt[847:842]==xt_1[847:842]) begin
                        count64[52]<=1;
                    end
                    else begin
                        count64[52] <= 0;
                    end
                    if (xt[863:858]==xt_1[863:858]) begin
                        count64[53]<=1;
                    end
                    else begin
                        count64[53] <= 0;
                    end
                    if (xt[879:874]==xt_1[879:874]) begin
                        count64[54]<=1;
                    end
                    else begin
                        count64[54] <= 0;
                    end
                    if (xt[895:890]==xt_1[895:890]) begin
                        count64[55]<=1;
                    end
                    else begin
                        count64[55] <= 0;
                    end
                    if (xt[911:906]==xt_1[911:906]) begin
                        count64[56]<=1;
                    end
                    else begin
                        count64[56] <= 0;
                    end
                    if (xt[927:922]==xt_1[927:922]) begin
                        count64[57]<=1;
                    end
                    else begin
                        count64[57] <= 0;
                    end
                    if (xt[943:938]==xt_1[943:938]) begin
                        count64[58]<=1;
                    end
                    else begin
                        count64[58] <= 0;
                    end
                    if (xt[959:954]==xt_1[959:954]) begin
                        count64[59]<=1;
                    end
                    else begin
                        count64[59] <= 0;
                    end
                    if (xt[975:970]==xt_1[975:970]) begin
                        count64[60]<=1;
                    end
                    else begin
                        count64[60] <= 0;
                    end
                    if (xt[991:986]==xt_1[991:986]) begin
                        count64[61]<=1;
                    end
                    else begin
                        count64[61] <= 0;
                    end
                    if (xt[1007:1002]==xt_1[1007:1002]) begin
                        count64[62]<=1;
                    end
                    else begin
                        count64[62] <= 0;
                    end
                    if (xt[1023:1018]==xt_1[1023:1018]) begin
                        count64[63]<=1;
                    end
                    else begin
                        count64[63] <= 0;
                    end
                end
                Sub_Add64to32_32to16_16to8_8to4_4to2:begin
                    if (xt[15:10]==xt_1[15:10]) begin
                        count64[0]<=1;
                    end
                    else begin
                        count64[0] <= 0;
                    end
                    if (xt[31:26]==xt_1[31:26]) begin
                        count64[1]<=1;
                    end
                    else begin
                        count64[1] <= 0;
                    end
                    if (xt[47:42]==xt_1[47:42]) begin
                        count64[2]<=1;
                    end
                    else begin
                        count64[2] <= 0;
                    end
                    if (xt[63:58]==xt_1[63:58]) begin
                        count64[3]<=1;
                    end
                    else begin
                        count64[3] <= 0;
                    end
                    if (xt[79:74]==xt_1[79:74]) begin
                        count64[4]<=1;
                    end
                    else begin
                        count64[4] <= 0;
                    end
                    if (xt[95:90]==xt_1[95:90]) begin
                        count64[5]<=1;
                    end
                    else begin
                        count64[5] <= 0;
                    end
                    if (xt[111:106]==xt_1[111:106]) begin
                        count64[6]<=1;
                    end
                    else begin
                        count64[6] <= 0;
                    end
                    if (xt[127:122]==xt_1[127:122]) begin
                        count64[7]<=1;
                    end
                    else begin
                        count64[7] <= 0;
                    end
                    if (xt[143:138]==xt_1[143:138]) begin
                        count64[8]<=1;
                    end
                    else begin
                        count64[8] <= 0;
                    end
                    if (xt[159:154]==xt_1[159:154]) begin
                        count64[9]<=1;
                    end
                    else begin
                        count64[9] <= 0;
                    end
                    if (xt[175:170]==xt_1[175:170]) begin
                        count64[10]<=1;
                    end
                    else begin
                        count64[10] <= 0;
                    end
                    if (xt[191:186]==xt_1[191:186]) begin
                        count64[11]<=1;
                    end
                    else begin
                        count64[11] <= 0;
                    end
                    if (xt[207:202]==xt_1[207:202]) begin
                        count64[12]<=1;
                    end
                    else begin
                        count64[12] <= 0;
                    end
                    if (xt[223:218]==xt_1[223:218]) begin
                        count64[13]<=1;
                    end
                    else begin
                        count64[13] <= 0;
                    end
                    if (xt[239:234]==xt_1[239:234]) begin
                        count64[14]<=1;
                    end
                    else begin
                        count64[14] <= 0;
                    end
                    if (xt[255:250]==xt_1[255:250]) begin
                        count64[15]<=1;
                    end
                    else begin
                        count64[15] <= 0;
                    end
                    if (xt[271:266]==xt_1[271:266]) begin
                        count64[16]<=1;
                    end
                    else begin
                        count64[16] <= 0;
                    end
                    if (xt[287:282]==xt_1[287:282]) begin
                        count64[17]<=1;
                    end
                    else begin
                        count64[17] <= 0;
                    end
                    if (xt[303:298]==xt_1[303:298]) begin
                        count64[18]<=1;
                    end
                    else begin
                        count64[18] <= 0;
                    end
                    if (xt[319:314]==xt_1[319:314]) begin
                        count64[19]<=1;
                    end
                    else begin
                        count64[19] <= 0;
                    end
                    if (xt[335:330]==xt_1[335:330]) begin
                        count64[20]<=1;
                    end
                    else begin
                        count64[20] <= 0;
                    end
                    if (xt[351:346]==xt_1[351:346]) begin
                        count64[21]<=1;
                    end
                    else begin
                        count64[21] <= 0;
                    end
                    if (xt[367:362]==xt_1[367:362]) begin
                        count64[22]<=1;
                    end
                    else begin
                        count64[22] <= 0;
                    end
                    if (xt[383:378]==xt_1[383:378]) begin
                        count64[23]<=1;
                    end
                    else begin
                        count64[23] <= 0;
                    end
                    if (xt[399:394]==xt_1[399:394]) begin
                        count64[24]<=1;
                    end
                    else begin
                        count64[24] <= 0;
                    end
                    if (xt[415:410]==xt_1[415:410]) begin
                        count64[25]<=1;
                    end
                    else begin
                        count64[25] <= 0;
                    end
                    if (xt[431:426]==xt_1[431:426]) begin
                        count64[26]<=1;
                    end
                    else begin
                        count64[26] <= 0;
                    end
                    if (xt[447:442]==xt_1[447:442]) begin
                        count64[27]<=1;
                    end
                    else begin
                        count64[27] <= 0;
                    end
                    if (xt[463:458]==xt_1[463:458]) begin
                        count64[28]<=1;
                    end
                    else begin
                        count64[28] <= 0;
                    end
                    if (xt[479:474]==xt_1[479:474]) begin
                        count64[29]<=1;
                    end
                    else begin
                        count64[29] <= 0;
                    end
                    if (xt[495:490]==xt_1[495:490]) begin
                        count64[30]<=1;
                    end
                    else begin
                        count64[30] <= 0;
                    end
                    if (xt[511:506]==xt_1[511:506]) begin
                        count64[31]<=1;
                    end
                    else begin
                        count64[31] <= 0;
                    end
                    if (xt[527:522]==xt_1[527:522]) begin
                        count64[32]<=1;
                    end
                    else begin
                        count64[32] <= 0;
                    end
                    if (xt[543:538]==xt_1[543:538]) begin
                        count64[33]<=1;
                    end
                    else begin
                        count64[33] <= 0;
                    end
                    if (xt[559:554]==xt_1[559:554]) begin
                        count64[34]<=1;
                    end
                    else begin
                        count64[34] <= 0;
                    end
                    if (xt[575:570]==xt_1[575:570]) begin
                        count64[35]<=1;
                    end
                    else begin
                        count64[35] <= 0;
                    end
                    if (xt[591:586]==xt_1[591:586]) begin
                        count64[36]<=1;
                    end
                    else begin
                        count64[36] <= 0;
                    end
                    if (xt[607:602]==xt_1[607:602]) begin
                        count64[37]<=1;
                    end
                    else begin
                        count64[37] <= 0;
                    end
                    if (xt[623:618]==xt_1[623:618]) begin
                        count64[38]<=1;
                    end
                    else begin
                        count64[38] <= 0;
                    end
                    if (xt[639:634]==xt_1[639:634]) begin
                        count64[39]<=1;
                    end
                    else begin
                        count64[39] <= 0;
                    end
                    if (xt[655:650]==xt_1[655:650]) begin
                        count64[40]<=1;
                    end
                    else begin
                        count64[40] <= 0;
                    end
                    if (xt[671:666]==xt_1[671:666]) begin
                        count64[41]<=1;
                    end
                    else begin
                        count64[41] <= 0;
                    end
                    if (xt[687:682]==xt_1[687:682]) begin
                        count64[42]<=1;
                    end
                    else begin
                        count64[42] <= 0;
                    end
                    if (xt[703:698]==xt_1[703:698]) begin
                        count64[43]<=1;
                    end
                    else begin
                        count64[43] <= 0;
                    end
                    if (xt[719:714]==xt_1[719:714]) begin
                        count64[44]<=1;
                    end
                    else begin
                        count64[44] <= 0;
                    end
                    if (xt[735:730]==xt_1[735:730]) begin
                        count64[45]<=1;
                    end
                    else begin
                        count64[45] <= 0;
                    end
                    if (xt[751:746]==xt_1[751:746]) begin
                        count64[46]<=1;
                    end
                    else begin
                        count64[46] <= 0;
                    end
                    if (xt[767:762]==xt_1[767:762]) begin
                        count64[47]<=1;
                    end
                    else begin
                        count64[47] <= 0;
                    end
                    if (xt[783:778]==xt_1[783:778]) begin
                        count64[48]<=1;
                    end
                    else begin
                        count64[48] <= 0;
                    end
                    if (xt[799:794]==xt_1[799:794]) begin
                        count64[49]<=1;
                    end
                    else begin
                        count64[49] <= 0;
                    end
                    if (xt[815:810]==xt_1[815:810]) begin
                        count64[50]<=1;
                    end
                    else begin
                        count64[50] <= 0;
                    end
                    if (xt[831:826]==xt_1[831:826]) begin
                        count64[51]<=1;
                    end
                    else begin
                        count64[51] <= 0;
                    end
                    if (xt[847:842]==xt_1[847:842]) begin
                        count64[52]<=1;
                    end
                    else begin
                        count64[52] <= 0;
                    end
                    if (xt[863:858]==xt_1[863:858]) begin
                        count64[53]<=1;
                    end
                    else begin
                        count64[53] <= 0;
                    end
                    if (xt[879:874]==xt_1[879:874]) begin
                        count64[54]<=1;
                    end
                    else begin
                        count64[54] <= 0;
                    end
                    if (xt[895:890]==xt_1[895:890]) begin
                        count64[55]<=1;
                    end
                    else begin
                        count64[55] <= 0;
                    end
                    if (xt[911:906]==xt_1[911:906]) begin
                        count64[56]<=1;
                    end
                    else begin
                        count64[56] <= 0;
                    end
                    if (xt[927:922]==xt_1[927:922]) begin
                        count64[57]<=1;
                    end
                    else begin
                        count64[57] <= 0;
                    end
                    if (xt[943:938]==xt_1[943:938]) begin
                        count64[58]<=1;
                    end
                    else begin
                        count64[58] <= 0;
                    end
                    if (xt[959:954]==xt_1[959:954]) begin
                        count64[59]<=1;
                    end
                    else begin
                        count64[59] <= 0;
                    end
                    if (xt[975:970]==xt_1[975:970]) begin
                        count64[60]<=1;
                    end
                    else begin
                        count64[60] <= 0;
                    end
                    if (xt[991:986]==xt_1[991:986]) begin
                        count64[61]<=1;
                    end
                    else begin
                        count64[61] <= 0;
                    end
                    if (xt[1007:1002]==xt_1[1007:1002]) begin
                        count64[62]<=1;
                    end
                    else begin
                        count64[62] <= 0;
                    end
                    if (xt[1023:1018]==xt_1[1023:1018]) begin
                        count64[63]<=1;
                    end
                    else begin
                        count64[63] <= 0;
                    end
                end
                Sub_Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                    if (xt[15:10]==xt_1[15:10]) begin
                        count64[0]<=1;
                    end
                    else begin
                        count64[0] <= 0;
                    end
                    if (xt[31:26]==xt_1[31:26]) begin
                        count64[1]<=1;
                    end
                    else begin
                        count64[1] <= 0;
                    end
                    if (xt[47:42]==xt_1[47:42]) begin
                        count64[2]<=1;
                    end
                    else begin
                        count64[2] <= 0;
                    end
                    if (xt[63:58]==xt_1[63:58]) begin
                        count64[3]<=1;
                    end
                    else begin
                        count64[3] <= 0;
                    end
                    if (xt[79:74]==xt_1[79:74]) begin
                        count64[4]<=1;
                    end
                    else begin
                        count64[4] <= 0;
                    end
                    if (xt[95:90]==xt_1[95:90]) begin
                        count64[5]<=1;
                    end
                    else begin
                        count64[5] <= 0;
                    end
                    if (xt[111:106]==xt_1[111:106]) begin
                        count64[6]<=1;
                    end
                    else begin
                        count64[6] <= 0;
                    end
                    if (xt[127:122]==xt_1[127:122]) begin
                        count64[7]<=1;
                    end
                    else begin
                        count64[7] <= 0;
                    end
                    if (xt[143:138]==xt_1[143:138]) begin
                        count64[8]<=1;
                    end
                    else begin
                        count64[8] <= 0;
                    end
                    if (xt[159:154]==xt_1[159:154]) begin
                        count64[9]<=1;
                    end
                    else begin
                        count64[9] <= 0;
                    end
                    if (xt[175:170]==xt_1[175:170]) begin
                        count64[10]<=1;
                    end
                    else begin
                        count64[10] <= 0;
                    end
                    if (xt[191:186]==xt_1[191:186]) begin
                        count64[11]<=1;
                    end
                    else begin
                        count64[11] <= 0;
                    end
                    if (xt[207:202]==xt_1[207:202]) begin
                        count64[12]<=1;
                    end
                    else begin
                        count64[12] <= 0;
                    end
                    if (xt[223:218]==xt_1[223:218]) begin
                        count64[13]<=1;
                    end
                    else begin
                        count64[13] <= 0;
                    end
                    if (xt[239:234]==xt_1[239:234]) begin
                        count64[14]<=1;
                    end
                    else begin
                        count64[14] <= 0;
                    end
                    if (xt[255:250]==xt_1[255:250]) begin
                        count64[15]<=1;
                    end
                    else begin
                        count64[15] <= 0;
                    end
                    if (xt[271:266]==xt_1[271:266]) begin
                        count64[16]<=1;
                    end
                    else begin
                        count64[16] <= 0;
                    end
                    if (xt[287:282]==xt_1[287:282]) begin
                        count64[17]<=1;
                    end
                    else begin
                        count64[17] <= 0;
                    end
                    if (xt[303:298]==xt_1[303:298]) begin
                        count64[18]<=1;
                    end
                    else begin
                        count64[18] <= 0;
                    end
                    if (xt[319:314]==xt_1[319:314]) begin
                        count64[19]<=1;
                    end
                    else begin
                        count64[19] <= 0;
                    end
                    if (xt[335:330]==xt_1[335:330]) begin
                        count64[20]<=1;
                    end
                    else begin
                        count64[20] <= 0;
                    end
                    if (xt[351:346]==xt_1[351:346]) begin
                        count64[21]<=1;
                    end
                    else begin
                        count64[21] <= 0;
                    end
                    if (xt[367:362]==xt_1[367:362]) begin
                        count64[22]<=1;
                    end
                    else begin
                        count64[22] <= 0;
                    end
                    if (xt[383:378]==xt_1[383:378]) begin
                        count64[23]<=1;
                    end
                    else begin
                        count64[23] <= 0;
                    end
                    if (xt[399:394]==xt_1[399:394]) begin
                        count64[24]<=1;
                    end
                    else begin
                        count64[24] <= 0;
                    end
                    if (xt[415:410]==xt_1[415:410]) begin
                        count64[25]<=1;
                    end
                    else begin
                        count64[25] <= 0;
                    end
                    if (xt[431:426]==xt_1[431:426]) begin
                        count64[26]<=1;
                    end
                    else begin
                        count64[26] <= 0;
                    end
                    if (xt[447:442]==xt_1[447:442]) begin
                        count64[27]<=1;
                    end
                    else begin
                        count64[27] <= 0;
                    end
                    if (xt[463:458]==xt_1[463:458]) begin
                        count64[28]<=1;
                    end
                    else begin
                        count64[28] <= 0;
                    end
                    if (xt[479:474]==xt_1[479:474]) begin
                        count64[29]<=1;
                    end
                    else begin
                        count64[29] <= 0;
                    end
                    if (xt[495:490]==xt_1[495:490]) begin
                        count64[30]<=1;
                    end
                    else begin
                        count64[30] <= 0;
                    end
                    if (xt[511:506]==xt_1[511:506]) begin
                        count64[31]<=1;
                    end
                    else begin
                        count64[31] <= 0;
                    end
                    if (xt[527:522]==xt_1[527:522]) begin
                        count64[32]<=1;
                    end
                    else begin
                        count64[32] <= 0;
                    end
                    if (xt[543:538]==xt_1[543:538]) begin
                        count64[33]<=1;
                    end
                    else begin
                        count64[33] <= 0;
                    end
                    if (xt[559:554]==xt_1[559:554]) begin
                        count64[34]<=1;
                    end
                    else begin
                        count64[34] <= 0;
                    end
                    if (xt[575:570]==xt_1[575:570]) begin
                        count64[35]<=1;
                    end
                    else begin
                        count64[35] <= 0;
                    end
                    if (xt[591:586]==xt_1[591:586]) begin
                        count64[36]<=1;
                    end
                    else begin
                        count64[36] <= 0;
                    end
                    if (xt[607:602]==xt_1[607:602]) begin
                        count64[37]<=1;
                    end
                    else begin
                        count64[37] <= 0;
                    end
                    if (xt[623:618]==xt_1[623:618]) begin
                        count64[38]<=1;
                    end
                    else begin
                        count64[38] <= 0;
                    end
                    if (xt[639:634]==xt_1[639:634]) begin
                        count64[39]<=1;
                    end
                    else begin
                        count64[39] <= 0;
                    end
                    if (xt[655:650]==xt_1[655:650]) begin
                        count64[40]<=1;
                    end
                    else begin
                        count64[40] <= 0;
                    end
                    if (xt[671:666]==xt_1[671:666]) begin
                        count64[41]<=1;
                    end
                    else begin
                        count64[41] <= 0;
                    end
                    if (xt[687:682]==xt_1[687:682]) begin
                        count64[42]<=1;
                    end
                    else begin
                        count64[42] <= 0;
                    end
                    if (xt[703:698]==xt_1[703:698]) begin
                        count64[43]<=1;
                    end
                    else begin
                        count64[43] <= 0;
                    end
                    if (xt[719:714]==xt_1[719:714]) begin
                        count64[44]<=1;
                    end
                    else begin
                        count64[44] <= 0;
                    end
                    if (xt[735:730]==xt_1[735:730]) begin
                        count64[45]<=1;
                    end
                    else begin
                        count64[45] <= 0;
                    end
                    if (xt[751:746]==xt_1[751:746]) begin
                        count64[46]<=1;
                    end
                    else begin
                        count64[46] <= 0;
                    end
                    if (xt[767:762]==xt_1[767:762]) begin
                        count64[47]<=1;
                    end
                    else begin
                        count64[47] <= 0;
                    end
                    if (xt[783:778]==xt_1[783:778]) begin
                        count64[48]<=1;
                    end
                    else begin
                        count64[48] <= 0;
                    end
                    if (xt[799:794]==xt_1[799:794]) begin
                        count64[49]<=1;
                    end
                    else begin
                        count64[49] <= 0;
                    end
                    if (xt[815:810]==xt_1[815:810]) begin
                        count64[50]<=1;
                    end
                    else begin
                        count64[50] <= 0;
                    end
                    if (xt[831:826]==xt_1[831:826]) begin
                        count64[51]<=1;
                    end
                    else begin
                        count64[51] <= 0;
                    end
                    if (xt[847:842]==xt_1[847:842]) begin
                        count64[52]<=1;
                    end
                    else begin
                        count64[52] <= 0;
                    end
                    if (xt[863:858]==xt_1[863:858]) begin
                        count64[53]<=1;
                    end
                    else begin
                        count64[53] <= 0;
                    end
                    if (xt[879:874]==xt_1[879:874]) begin
                        count64[54]<=1;
                    end
                    else begin
                        count64[54] <= 0;
                    end
                    if (xt[895:890]==xt_1[895:890]) begin
                        count64[55]<=1;
                    end
                    else begin
                        count64[55] <= 0;
                    end
                    if (xt[911:906]==xt_1[911:906]) begin
                        count64[56]<=1;
                    end
                    else begin
                        count64[56] <= 0;
                    end
                    if (xt[927:922]==xt_1[927:922]) begin
                        count64[57]<=1;
                    end
                    else begin
                        count64[57] <= 0;
                    end
                    if (xt[943:938]==xt_1[943:938]) begin
                        count64[58]<=1;
                    end
                    else begin
                        count64[58] <= 0;
                    end
                    if (xt[959:954]==xt_1[959:954]) begin
                        count64[59]<=1;
                    end
                    else begin
                        count64[59] <= 0;
                    end
                    if (xt[975:970]==xt_1[975:970]) begin
                        count64[60]<=1;
                    end
                    else begin
                        count64[60] <= 0;
                    end
                    if (xt[991:986]==xt_1[991:986]) begin
                        count64[61]<=1;
                    end
                    else begin
                        count64[61] <= 0;
                    end
                    if (xt[1007:1002]==xt_1[1007:1002]) begin
                        count64[62]<=1;
                    end
                    else begin
                        count64[62] <= 0;
                    end
                    if (xt[1023:1018]==xt_1[1023:1018]) begin
                        count64[63]<=1;
                    end
                    else begin
                        count64[63] <= 0;
                    end
                end
                default:begin
                    count64 <= count64;
                end
        endcase
        end
    end
    always @ (posedge clk) begin  // the control of count32
        if(!rst) begin
            count32[0] <= 'd0;
            count32[1] <= 'd0;
            count32[2] <= 'd0;
            count32[3] <= 'd0;
            count32[4] <= 'd0;
            count32[5] <= 'd0;
            count32[6] <= 'd0;
            count32[7] <= 'd0;
            count32[8] <= 'd0;
            count32[9] <= 'd0;
            count32[10] <= 'd0;
            count32[11] <= 'd0;
            count32[12] <= 'd0;
            count32[13] <= 'd0;
            count32[14] <= 'd0;
            count32[15] <= 'd0;
            count32[16] <= 'd0;
            count32[17] <= 'd0;
            count32[18] <= 'd0;
            count32[19] <= 'd0;
            count32[20] <= 'd0;
            count32[21] <= 'd0;
            count32[22] <= 'd0;
            count32[23] <= 'd0;
            count32[24] <= 'd0;
            count32[25] <= 'd0;
            count32[26] <= 'd0;
            count32[27] <= 'd0;
            count32[28] <= 'd0;
            count32[29] <= 'd0;
            count32[30] <= 'd0;
            count32[31] <= 'd0;
        end
        else if (idle) begin
            count32[0] <= 'd0;
            count32[1] <= 'd0;
            count32[2] <= 'd0;
            count32[3] <= 'd0;
            count32[4] <= 'd0;
            count32[5] <= 'd0;
            count32[6] <= 'd0;
            count32[7] <= 'd0;
            count32[8] <= 'd0;
            count32[9] <= 'd0;
            count32[10] <= 'd0;
            count32[11] <= 'd0;
            count32[12] <= 'd0;
            count32[13] <= 'd0;
            count32[14] <= 'd0;
            count32[15] <= 'd0;
            count32[16] <= 'd0;
            count32[17] <= 'd0;
            count32[18] <= 'd0;
            count32[19] <= 'd0;
            count32[20] <= 'd0;
            count32[21] <= 'd0;
            count32[22] <= 'd0;
            count32[23] <= 'd0;
            count32[24] <= 'd0;
            count32[25] <= 'd0;
            count32[26] <= 'd0;
            count32[27] <= 'd0;
            count32[28] <= 'd0;
            count32[29] <= 'd0;
            count32[30] <= 'd0;
            count32[31] <= 'd0;
        end
        else begin
            case(state)
            Sub_Add64to32:begin
                count32[0] <= count64[0]+count64[1];
                count32[1] <= count64[2]+count64[3];
                count32[2] <= count64[4]+count64[5];
                count32[3] <= count64[6]+count64[7];
                count32[4] <= count64[8]+count64[9];
                count32[5] <= count64[10]+count64[11];
                count32[6] <= count64[12]+count64[13];
                count32[7] <= count64[14]+count64[15];
                count32[8] <= count64[16]+count64[17];
                count32[9] <= count64[18]+count64[19];
                count32[10] <= count64[20]+count64[21];
                count32[11] <= count64[22]+count64[23];
                count32[12] <= count64[24]+count64[25];
                count32[13] <= count64[26]+count64[27];
                count32[14] <= count64[28]+count64[29];
                count32[15] <= count64[30]+count64[31];
                count32[16] <= count64[32]+count64[33];
                count32[17] <= count64[34]+count64[35];
                count32[18] <= count64[36]+count64[37];
                count32[19] <= count64[38]+count64[39];
                count32[20] <= count64[40]+count64[41];
                count32[21] <= count64[42]+count64[43];
                count32[22] <= count64[44]+count64[45];
                count32[23] <= count64[46]+count64[47];
                count32[24] <= count64[48]+count64[49];
                count32[25] <= count64[50]+count64[51];
                count32[26] <= count64[52]+count64[53];
                count32[27] <= count64[54]+count64[55];
                count32[28] <= count64[56]+count64[57];
                count32[29] <= count64[58]+count64[59];
                count32[30] <= count64[60]+count64[61];
                count32[31] <= count64[62]+count64[63];
            end
            Sub_Add64to32_32to16:begin
                count32[0] <= count64[0]+count64[1];
                count32[1] <= count64[2]+count64[3];
                count32[2] <= count64[4]+count64[5];
                count32[3] <= count64[6]+count64[7];
                count32[4] <= count64[8]+count64[9];
                count32[5] <= count64[10]+count64[11];
                count32[6] <= count64[12]+count64[13];
                count32[7] <= count64[14]+count64[15];
                count32[8] <= count64[16]+count64[17];
                count32[9] <= count64[18]+count64[19];
                count32[10] <= count64[20]+count64[21];
                count32[11] <= count64[22]+count64[23];
                count32[12] <= count64[24]+count64[25];
                count32[13] <= count64[26]+count64[27];
                count32[14] <= count64[28]+count64[29];
                count32[15] <= count64[30]+count64[31];
                count32[16] <= count64[32]+count64[33];
                count32[17] <= count64[34]+count64[35];
                count32[18] <= count64[36]+count64[37];
                count32[19] <= count64[38]+count64[39];
                count32[20] <= count64[40]+count64[41];
                count32[21] <= count64[42]+count64[43];
                count32[22] <= count64[44]+count64[45];
                count32[23] <= count64[46]+count64[47];
                count32[24] <= count64[48]+count64[49];
                count32[25] <= count64[50]+count64[51];
                count32[26] <= count64[52]+count64[53];
                count32[27] <= count64[54]+count64[55];
                count32[28] <= count64[56]+count64[57];
                count32[29] <= count64[58]+count64[59];
                count32[30] <= count64[60]+count64[61];
                count32[31] <= count64[62]+count64[63];
            end
            Sub_Add64to32_32to16_16to8:begin
                count32[0] <= count64[0]+count64[1];
                count32[1] <= count64[2]+count64[3];
                count32[2] <= count64[4]+count64[5];
                count32[3] <= count64[6]+count64[7];
                count32[4] <= count64[8]+count64[9];
                count32[5] <= count64[10]+count64[11];
                count32[6] <= count64[12]+count64[13];
                count32[7] <= count64[14]+count64[15];
                count32[8] <= count64[16]+count64[17];
                count32[9] <= count64[18]+count64[19];
                count32[10] <= count64[20]+count64[21];
                count32[11] <= count64[22]+count64[23];
                count32[12] <= count64[24]+count64[25];
                count32[13] <= count64[26]+count64[27];
                count32[14] <= count64[28]+count64[29];
                count32[15] <= count64[30]+count64[31];
                count32[16] <= count64[32]+count64[33];
                count32[17] <= count64[34]+count64[35];
                count32[18] <= count64[36]+count64[37];
                count32[19] <= count64[38]+count64[39];
                count32[20] <= count64[40]+count64[41];
                count32[21] <= count64[42]+count64[43];
                count32[22] <= count64[44]+count64[45];
                count32[23] <= count64[46]+count64[47];
                count32[24] <= count64[48]+count64[49];
                count32[25] <= count64[50]+count64[51];
                count32[26] <= count64[52]+count64[53];
                count32[27] <= count64[54]+count64[55];
                count32[28] <= count64[56]+count64[57];
                count32[29] <= count64[58]+count64[59];
                count32[30] <= count64[60]+count64[61];
                count32[31] <= count64[62]+count64[63];
            end
            Sub_Add64to32_32to16_16to8_8to4:begin
                count32[0] <= count64[0]+count64[1];
                count32[1] <= count64[2]+count64[3];
                count32[2] <= count64[4]+count64[5];
                count32[3] <= count64[6]+count64[7];
                count32[4] <= count64[8]+count64[9];
                count32[5] <= count64[10]+count64[11];
                count32[6] <= count64[12]+count64[13];
                count32[7] <= count64[14]+count64[15];
                count32[8] <= count64[16]+count64[17];
                count32[9] <= count64[18]+count64[19];
                count32[10] <= count64[20]+count64[21];
                count32[11] <= count64[22]+count64[23];
                count32[12] <= count64[24]+count64[25];
                count32[13] <= count64[26]+count64[27];
                count32[14] <= count64[28]+count64[29];
                count32[15] <= count64[30]+count64[31];
                count32[16] <= count64[32]+count64[33];
                count32[17] <= count64[34]+count64[35];
                count32[18] <= count64[36]+count64[37];
                count32[19] <= count64[38]+count64[39];
                count32[20] <= count64[40]+count64[41];
                count32[21] <= count64[42]+count64[43];
                count32[22] <= count64[44]+count64[45];
                count32[23] <= count64[46]+count64[47];
                count32[24] <= count64[48]+count64[49];
                count32[25] <= count64[50]+count64[51];
                count32[26] <= count64[52]+count64[53];
                count32[27] <= count64[54]+count64[55];
                count32[28] <= count64[56]+count64[57];
                count32[29] <= count64[58]+count64[59];
                count32[30] <= count64[60]+count64[61];
                count32[31] <= count64[62]+count64[63];
            end
            Sub_Add64to32_32to16_16to8_8to4_4to2:begin
                count32[0] <= count64[0]+count64[1];
                count32[1] <= count64[2]+count64[3];
                count32[2] <= count64[4]+count64[5];
                count32[3] <= count64[6]+count64[7];
                count32[4] <= count64[8]+count64[9];
                count32[5] <= count64[10]+count64[11];
                count32[6] <= count64[12]+count64[13];
                count32[7] <= count64[14]+count64[15];
                count32[8] <= count64[16]+count64[17];
                count32[9] <= count64[18]+count64[19];
                count32[10] <= count64[20]+count64[21];
                count32[11] <= count64[22]+count64[23];
                count32[12] <= count64[24]+count64[25];
                count32[13] <= count64[26]+count64[27];
                count32[14] <= count64[28]+count64[29];
                count32[15] <= count64[30]+count64[31];
                count32[16] <= count64[32]+count64[33];
                count32[17] <= count64[34]+count64[35];
                count32[18] <= count64[36]+count64[37];
                count32[19] <= count64[38]+count64[39];
                count32[20] <= count64[40]+count64[41];
                count32[21] <= count64[42]+count64[43];
                count32[22] <= count64[44]+count64[45];
                count32[23] <= count64[46]+count64[47];
                count32[24] <= count64[48]+count64[49];
                count32[25] <= count64[50]+count64[51];
                count32[26] <= count64[52]+count64[53];
                count32[27] <= count64[54]+count64[55];
                count32[28] <= count64[56]+count64[57];
                count32[29] <= count64[58]+count64[59];
                count32[30] <= count64[60]+count64[61];
                count32[31] <= count64[62]+count64[63];
            end
            Sub_Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count32[0] <= count64[0]+count64[1];
                count32[1] <= count64[2]+count64[3];
                count32[2] <= count64[4]+count64[5];
                count32[3] <= count64[6]+count64[7];
                count32[4] <= count64[8]+count64[9];
                count32[5] <= count64[10]+count64[11];
                count32[6] <= count64[12]+count64[13];
                count32[7] <= count64[14]+count64[15];
                count32[8] <= count64[16]+count64[17];
                count32[9] <= count64[18]+count64[19];
                count32[10] <= count64[20]+count64[21];
                count32[11] <= count64[22]+count64[23];
                count32[12] <= count64[24]+count64[25];
                count32[13] <= count64[26]+count64[27];
                count32[14] <= count64[28]+count64[29];
                count32[15] <= count64[30]+count64[31];
                count32[16] <= count64[32]+count64[33];
                count32[17] <= count64[34]+count64[35];
                count32[18] <= count64[36]+count64[37];
                count32[19] <= count64[38]+count64[39];
                count32[20] <= count64[40]+count64[41];
                count32[21] <= count64[42]+count64[43];
                count32[22] <= count64[44]+count64[45];
                count32[23] <= count64[46]+count64[47];
                count32[24] <= count64[48]+count64[49];
                count32[25] <= count64[50]+count64[51];
                count32[26] <= count64[52]+count64[53];
                count32[27] <= count64[54]+count64[55];
                count32[28] <= count64[56]+count64[57];
                count32[29] <= count64[58]+count64[59];
                count32[30] <= count64[60]+count64[61];
                count32[31] <= count64[62]+count64[63];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count32[0] <= count64[0]+count64[1];
                count32[1] <= count64[2]+count64[3];
                count32[2] <= count64[4]+count64[5];
                count32[3] <= count64[6]+count64[7];
                count32[4] <= count64[8]+count64[9];
                count32[5] <= count64[10]+count64[11];
                count32[6] <= count64[12]+count64[13];
                count32[7] <= count64[14]+count64[15];
                count32[8] <= count64[16]+count64[17];
                count32[9] <= count64[18]+count64[19];
                count32[10] <= count64[20]+count64[21];
                count32[11] <= count64[22]+count64[23];
                count32[12] <= count64[24]+count64[25];
                count32[13] <= count64[26]+count64[27];
                count32[14] <= count64[28]+count64[29];
                count32[15] <= count64[30]+count64[31];
                count32[16] <= count64[32]+count64[33];
                count32[17] <= count64[34]+count64[35];
                count32[18] <= count64[36]+count64[37];
                count32[19] <= count64[38]+count64[39];
                count32[20] <= count64[40]+count64[41];
                count32[21] <= count64[42]+count64[43];
                count32[22] <= count64[44]+count64[45];
                count32[23] <= count64[46]+count64[47];
                count32[24] <= count64[48]+count64[49];
                count32[25] <= count64[50]+count64[51];
                count32[26] <= count64[52]+count64[53];
                count32[27] <= count64[54]+count64[55];
                count32[28] <= count64[56]+count64[57];
                count32[29] <= count64[58]+count64[59];
                count32[30] <= count64[60]+count64[61];
                count32[31] <= count64[62]+count64[63];
            end
            default:begin
                count32[0] <= count32[0];
                count32[1] <= count32[1];
                count32[2] <= count32[2];
                count32[3] <= count32[3];
                count32[4] <= count32[4];
                count32[5] <= count32[5];
                count32[6] <= count32[6];
                count32[7] <= count32[7];
                count32[8] <= count32[8];
                count32[9] <= count32[9];
                count32[10] <= count32[10];
                count32[11] <= count32[11];
                count32[12] <= count32[12];
                count32[13] <= count32[13];
                count32[14] <= count32[14];
                count32[15] <= count32[15];
                count32[16] <= count32[16];
                count32[17] <= count32[17];
                count32[18] <= count32[18];
                count32[19] <= count32[19];
                count32[20] <= count32[20];
                count32[21] <= count32[21];
                count32[22] <= count32[22];
                count32[23] <= count32[23];
                count32[24] <= count32[24];
                count32[25] <= count32[25];
                count32[26] <= count32[26];
                count32[27] <= count32[27];
                count32[28] <= count32[28];
                count32[29] <= count32[29];
                count32[30] <= count32[30];
                count32[31] <= count32[31];
            end
            endcase
        end
    end

    always @ (posedge clk) begin  // the control of count16
        if(!rst) begin
            count16[0] <= 'd0;
            count16[1] <= 'd0;
            count16[2] <= 'd0;
            count16[3] <= 'd0;
            count16[4] <= 'd0;
            count16[5] <= 'd0;
            count16[6] <= 'd0;
            count16[7] <= 'd0;
            count16[8] <= 'd0;
            count16[9] <= 'd0;
            count16[10] <= 'd0;
            count16[11] <= 'd0;
            count16[12] <= 'd0;
            count16[13] <= 'd0;
            count16[14] <= 'd0;
            count16[15] <= 'd0;
        end
        else if (idle) begin
            count16[0] <= 'd0;
            count16[1] <= 'd0;
            count16[2] <= 'd0;
            count16[3] <= 'd0;
            count16[4] <= 'd0;
            count16[5] <= 'd0;
            count16[6] <= 'd0;
            count16[7] <= 'd0;
            count16[8] <= 'd0;
            count16[9] <= 'd0;
            count16[10] <= 'd0;
            count16[11] <= 'd0;
            count16[12] <= 'd0;
            count16[13] <= 'd0;
            count16[14] <= 'd0;
            count16[15] <= 'd0;
        end
        else begin
            case(state)
            Sub_Add64to32_32to16:begin
                count16[0] <= count32[0]+count32[1];
                count16[1] <= count32[2]+count32[3];
                count16[2] <= count32[4]+count32[5];
                count16[3] <= count32[6]+count32[7];
                count16[4] <= count32[8]+count32[9];
                count16[5] <= count32[10]+count32[11];
                count16[6] <= count32[12]+count32[13];
                count16[7] <= count32[14]+count32[15];
                count16[8] <= count32[16]+count32[17];
                count16[9] <= count32[18]+count32[19];
                count16[10] <= count32[20]+count32[21];
                count16[11] <= count32[22]+count32[23];
                count16[12] <= count32[24]+count32[25];
                count16[13] <= count32[26]+count32[27];
                count16[14] <= count32[28]+count32[29];
                count16[15] <= count32[30]+count32[31];
            end
            Sub_Add64to32_32to16_16to8:begin
                count16[0] <= count32[0]+count32[1];
                count16[1] <= count32[2]+count32[3];
                count16[2] <= count32[4]+count32[5];
                count16[3] <= count32[6]+count32[7];
                count16[4] <= count32[8]+count32[9];
                count16[5] <= count32[10]+count32[11];
                count16[6] <= count32[12]+count32[13];
                count16[7] <= count32[14]+count32[15];
                count16[8] <= count32[16]+count32[17];
                count16[9] <= count32[18]+count32[19];
                count16[10] <= count32[20]+count32[21];
                count16[11] <= count32[22]+count32[23];
                count16[12] <= count32[24]+count32[25];
                count16[13] <= count32[26]+count32[27];
                count16[14] <= count32[28]+count32[29];
                count16[15] <= count32[30]+count32[31];
            end
            Sub_Add64to32_32to16_16to8_8to4:begin
                count16[0] <= count32[0]+count32[1];
                count16[1] <= count32[2]+count32[3];
                count16[2] <= count32[4]+count32[5];
                count16[3] <= count32[6]+count32[7];
                count16[4] <= count32[8]+count32[9];
                count16[5] <= count32[10]+count32[11];
                count16[6] <= count32[12]+count32[13];
                count16[7] <= count32[14]+count32[15];
                count16[8] <= count32[16]+count32[17];
                count16[9] <= count32[18]+count32[19];
                count16[10] <= count32[20]+count32[21];
                count16[11] <= count32[22]+count32[23];
                count16[12] <= count32[24]+count32[25];
                count16[13] <= count32[26]+count32[27];
                count16[14] <= count32[28]+count32[29];
                count16[15] <= count32[30]+count32[31];
            end
            Sub_Add64to32_32to16_16to8_8to4_4to2:begin
                count16[0] <= count32[0]+count32[1];
                count16[1] <= count32[2]+count32[3];
                count16[2] <= count32[4]+count32[5];
                count16[3] <= count32[6]+count32[7];
                count16[4] <= count32[8]+count32[9];
                count16[5] <= count32[10]+count32[11];
                count16[6] <= count32[12]+count32[13];
                count16[7] <= count32[14]+count32[15];
                count16[8] <= count32[16]+count32[17];
                count16[9] <= count32[18]+count32[19];
                count16[10] <= count32[20]+count32[21];
                count16[11] <= count32[22]+count32[23];
                count16[12] <= count32[24]+count32[25];
                count16[13] <= count32[26]+count32[27];
                count16[14] <= count32[28]+count32[29];
                count16[15] <= count32[30]+count32[31];
            end
            Sub_Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count16[0] <= count32[0]+count32[1];
                count16[1] <= count32[2]+count32[3];
                count16[2] <= count32[4]+count32[5];
                count16[3] <= count32[6]+count32[7];
                count16[4] <= count32[8]+count32[9];
                count16[5] <= count32[10]+count32[11];
                count16[6] <= count32[12]+count32[13];
                count16[7] <= count32[14]+count32[15];
                count16[8] <= count32[16]+count32[17];
                count16[9] <= count32[18]+count32[19];
                count16[10] <= count32[20]+count32[21];
                count16[11] <= count32[22]+count32[23];
                count16[12] <= count32[24]+count32[25];
                count16[13] <= count32[26]+count32[27];
                count16[14] <= count32[28]+count32[29];
                count16[15] <= count32[30]+count32[31];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count16[0] <= count32[0]+count32[1];
                count16[1] <= count32[2]+count32[3];
                count16[2] <= count32[4]+count32[5];
                count16[3] <= count32[6]+count32[7];
                count16[4] <= count32[8]+count32[9];
                count16[5] <= count32[10]+count32[11];
                count16[6] <= count32[12]+count32[13];
                count16[7] <= count32[14]+count32[15];
                count16[8] <= count32[16]+count32[17];
                count16[9] <= count32[18]+count32[19];
                count16[10] <= count32[20]+count32[21];
                count16[11] <= count32[22]+count32[23];
                count16[12] <= count32[24]+count32[25];
                count16[13] <= count32[26]+count32[27];
                count16[14] <= count32[28]+count32[29];
                count16[15] <= count32[30]+count32[31];
            end
            Add32to16_16to8_8to4_4to2_2to1:begin
                count16[0] <= count32[0]+count32[1];
                count16[1] <= count32[2]+count32[3];
                count16[2] <= count32[4]+count32[5];
                count16[3] <= count32[6]+count32[7];
                count16[4] <= count32[8]+count32[9];
                count16[5] <= count32[10]+count32[11];
                count16[6] <= count32[12]+count32[13];
                count16[7] <= count32[14]+count32[15];
                count16[8] <= count32[16]+count32[17];
                count16[9] <= count32[18]+count32[19];
                count16[10] <= count32[20]+count32[21];
                count16[11] <= count32[22]+count32[23];
                count16[12] <= count32[24]+count32[25];
                count16[13] <= count32[26]+count32[27];
                count16[14] <= count32[28]+count32[29];
                count16[15] <= count32[30]+count32[31];
            end
            default:begin
                count16[0] <= count16[0];
                count16[1] <= count16[1];
                count16[2] <= count16[2];
                count16[3] <= count16[3];
                count16[4] <= count16[4];
                count16[5] <= count16[5];
                count16[6] <= count16[6];
                count16[7] <= count16[7];
                count16[8] <= count16[8];
                count16[9] <= count16[9];
                count16[10] <= count16[10];
                count16[11] <= count16[11];
                count16[12] <= count16[12];
                count16[13] <= count16[13];
                count16[14] <= count16[14];
                count16[15] <= count16[15];
            end
            endcase
        end
    end

    always @ (posedge clk) begin  // the control of count8
        if(!rst) begin
            count8[0] <= 'd0;
            count8[1] <= 'd0;
            count8[2] <= 'd0;
            count8[3] <= 'd0;
            count8[4] <= 'd0;
            count8[5] <= 'd0;
            count8[6] <= 'd0;
            count8[7] <= 'd0;
        end
        else if (idle) begin
            count8[0] <= 'd0;
            count8[1] <= 'd0;
            count8[2] <= 'd0;
            count8[3] <= 'd0;
            count8[4] <= 'd0;
            count8[5] <= 'd0;
            count8[6] <= 'd0;
            count8[7] <= 'd0;
        end
        else begin
            case(state)
            Sub_Add64to32_32to16_16to8:begin
                count8[0] <= count16[0]+count16[1];
                count8[1] <= count16[2]+count16[3];
                count8[2] <= count16[4]+count16[5];
                count8[3] <= count16[6]+count16[7];
                count8[4] <= count16[8]+count16[9];
                count8[5] <= count16[10]+count16[11];
                count8[6] <= count16[12]+count16[13];
                count8[7] <= count16[14]+count16[15];
            end
            Sub_Add64to32_32to16_16to8_8to4:begin
                count8[0] <= count16[0]+count16[1];
                count8[1] <= count16[2]+count16[3];
                count8[2] <= count16[4]+count16[5];
                count8[3] <= count16[6]+count16[7];
                count8[4] <= count16[8]+count16[9];
                count8[5] <= count16[10]+count16[11];
                count8[6] <= count16[12]+count16[13];
                count8[7] <= count16[14]+count16[15];
            end
            Sub_Add64to32_32to16_16to8_8to4_4to2:begin
                count8[0] <= count16[0]+count16[1];
                count8[1] <= count16[2]+count16[3];
                count8[2] <= count16[4]+count16[5];
                count8[3] <= count16[6]+count16[7];
                count8[4] <= count16[8]+count16[9];
                count8[5] <= count16[10]+count16[11];
                count8[6] <= count16[12]+count16[13];
                count8[7] <= count16[14]+count16[15];
            end
            Sub_Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count8[0] <= count16[0]+count16[1];
                count8[1] <= count16[2]+count16[3];
                count8[2] <= count16[4]+count16[5];
                count8[3] <= count16[6]+count16[7];
                count8[4] <= count16[8]+count16[9];
                count8[5] <= count16[10]+count16[11];
                count8[6] <= count16[12]+count16[13];
                count8[7] <= count16[14]+count16[15];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count8[0] <= count16[0]+count16[1];
                count8[1] <= count16[2]+count16[3];
                count8[2] <= count16[4]+count16[5];
                count8[3] <= count16[6]+count16[7];
                count8[4] <= count16[8]+count16[9];
                count8[5] <= count16[10]+count16[11];
                count8[6] <= count16[12]+count16[13];
                count8[7] <= count16[14]+count16[15];
            end
            Add32to16_16to8_8to4_4to2_2to1:begin
                count8[0] <= count16[0]+count16[1];
                count8[1] <= count16[2]+count16[3];
                count8[2] <= count16[4]+count16[5];
                count8[3] <= count16[6]+count16[7];
                count8[4] <= count16[8]+count16[9];
                count8[5] <= count16[10]+count16[11];
                count8[6] <= count16[12]+count16[13];
                count8[7] <= count16[14]+count16[15];
            end
            Add16to8_8to4_4to2_2to1:begin
                count8[0] <= count16[0]+count16[1];
                count8[1] <= count16[2]+count16[3];
                count8[2] <= count16[4]+count16[5];
                count8[3] <= count16[6]+count16[7];
                count8[4] <= count16[8]+count16[9];
                count8[5] <= count16[10]+count16[11];
                count8[6] <= count16[12]+count16[13];
                count8[7] <= count16[14]+count16[15];
            end
            default:begin
                count8[0] <= count8[0];
                count8[1] <= count8[1];
                count8[2] <= count8[2];
                count8[3] <= count8[3];
                count8[4] <= count8[4];
                count8[5] <= count8[5];
                count8[6] <= count8[6];
                count8[7] <= count8[7];
            end
        endcase
        end
    end

    always @ (posedge clk) begin  // the control of count4
        if(!rst) begin
            count4[0] <= 'd0;
            count4[1] <= 'd0;
            count4[2] <= 'd0;
            count4[3] <= 'd0;
        end
        else if (idle) begin
            count4[0] <= 'd0;
            count4[1] <= 'd0;
            count4[2] <= 'd0;
            count4[3] <= 'd0;
        end
        else begin
            case(state)
            Sub_Add64to32_32to16_16to8_8to4:begin
                count4[0] <= count8[0]+count8[1];
                count4[1] <= count8[2]+count8[3];
                count4[2] <= count8[4]+count8[5];
                count4[3] <= count8[6]+count8[7];
            end
            Sub_Add64to32_32to16_16to8_8to4_4to2:begin
                count4[0] <= count8[0]+count8[1];
                count4[1] <= count8[2]+count8[3];
                count4[2] <= count8[4]+count8[5];
                count4[3] <= count8[6]+count8[7];
            end
            Sub_Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count4[0] <= count8[0]+count8[1];
                count4[1] <= count8[2]+count8[3];
                count4[2] <= count8[4]+count8[5];
                count4[3] <= count8[6]+count8[7];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count4[0] <= count8[0]+count8[1];
                count4[1] <= count8[2]+count8[3];
                count4[2] <= count8[4]+count8[5];
                count4[3] <= count8[6]+count8[7];
            end
            Add32to16_16to8_8to4_4to2_2to1:begin
                count4[0] <= count8[0]+count8[1];
                count4[1] <= count8[2]+count8[3];
                count4[2] <= count8[4]+count8[5];
                count4[3] <= count8[6]+count8[7];
            end
            Add16to8_8to4_4to2_2to1:begin
                count4[0] <= count8[0]+count8[1];
                count4[1] <= count8[2]+count8[3];
                count4[2] <= count8[4]+count8[5];
                count4[3] <= count8[6]+count8[7];
            end
            Add8to4_4to2_2to1:begin
                count4[0] <= count8[0]+count8[1];
                count4[1] <= count8[2]+count8[3];
                count4[2] <= count8[4]+count8[5];
                count4[3] <= count8[6]+count8[7];
            end
            default:begin
                count4[0] <= count4[0];
                count4[1] <= count4[1];
                count4[2] <= count4[2];
                count4[3] <= count4[3];
            end
            endcase
        end
    end

    always @ (posedge clk) begin  // the control of count2
        if(!rst) begin
            count2[0] <=  'd0 ;
            count2[1] <=  'd0 ;
        end
        else if (idle) begin
            count2[0] <=  'd0 ;
            count2[1] <=  'd0 ;
        end
        else begin
            case(state)
            Sub_Add64to32_32to16_16to8_8to4_4to2:begin
                count2[0] <= count4[0]+count4[1];
                count2[1] <= count4[2]+count4[3];
            end
            Sub_Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count2[0] <= count4[0]+count4[1];
                count2[1] <= count4[2]+count4[3];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                count2[0] <= count4[0]+count4[1];
                count2[1] <= count4[2]+count4[3];
            end
            Add32to16_16to8_8to4_4to2_2to1:begin
                count2[0] <= count4[0]+count4[1];
                count2[1] <= count4[2]+count4[3];
            end
            Add16to8_8to4_4to2_2to1:begin
                count2[0] <= count4[0]+count4[1];
                count2[1] <= count4[2]+count4[3];
            end
            Add8to4_4to2_2to1:begin
                count2[0] <= count4[0]+count4[1];
                count2[1] <= count4[2]+count4[3];
            end
            Add4to2_2to1:begin
                count2[0] <= count4[0]+count4[1];
                count2[1] <= count4[2]+count4[3];
            end
            default:begin
                count2[0] <= count2[0];
                count2[1] <= count2[1];
            end
            endcase
        end
    end
    always @ (posedge clk) begin  // the control of nozero_num
        if(!rst) begin
            nozero_num <=  'd0 ;
        end
        else if (idle) begin
            nozero_num <=  'd0 ;
        end
        else begin
            case(state)
            Sub_Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                nozero_num <= count2[0]+count2[1];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                nozero_num <= count2[0]+count2[1];
            end
            Add32to16_16to8_8to4_4to2_2to1:begin
                nozero_num <= count2[0]+count2[1];
            end
            Add16to8_8to4_4to2_2to1:begin
                nozero_num <= count2[0]+count2[1];
            end
            Add8to4_4to2_2to1:begin
                nozero_num <= count2[0]+count2[1];
            end
            Add4to2_2to1:begin
                nozero_num <= count2[0]+count2[1];
            end
            Add2to1:begin
                nozero_num <= count2[0]+count2[1];
            end
            default:begin
                nozero_num <= nozero_num ;
            end
            endcase
        end
    end
   
endmodule
