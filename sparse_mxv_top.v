`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/18 21:58:31
// Design Name: 
// Module Name: sparse_mxv_top
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

`define counter 2048
`define newcounter 2055
module sparse_mxv_top(
    input clk,
    input rst,
    input idle,
    input [1023:0] inputx_output,
    input [4095:0] inputw0,
  //  input [4095:0] inputw1,
    input [639:0] inputw0_index,
   // input [1279:0] inputw1_index,
    output reg [15:0] one_elements
    );
// the module of sparse matrix X  dence vector 
// latency is 30
    // reg to store temp result
    reg  [511:0]   active_xt       [127:0] ;
    wire [15:0]    temp_result_128 [127:0];
    reg  [15:0]    temp_result_64  [63:0];
    reg  [15:0]    temp_result_32  [31:0];
    reg  [15:0]    temp_result_16  [15:0];
    reg  [15:0]    temp_result_8   [7:0];
    reg  [15:0]    temp_result_4   [3:0];
    reg  [15:0]    temp_result_2   [1:0]; 

    //control signal 
    
    reg    spmvidle;
    reg    [4:0] state ;
    reg    [31:0] statecount ;


    // state parameter
    parameter  Start                                                       =    0;
    parameter  Load0                                                       =    27;
    parameter  Load1                                                       =    1;
    parameter  Load2                                                       =    2;
    parameter  Load3                                                       =    3;
    parameter  Load4                                                       =    25;
    parameter  Wait1                                                       =    4;
    parameter  Wait2                                                       =    5;
    parameter  Wait3                                                       =    6;
    parameter  Wait4                                                       =    7;
    parameter  Wait5                                                       =    8;
    parameter  Wait6                                                       =    9;
    parameter  Wait7                                                       =    26;
    parameter  Wait_Add128to64                                             =    10;
    parameter  Wait_Add128to64_64to32                                      =    11;
    parameter  Wait_Add128to64_64to32_32to16                               =    12;
    parameter  Wait_Add128to64_64to32_32to16_16to8                         =    13;
    parameter  Wait_Add128to64_64to32_32to16_16to8_8to4                    =    14;
    parameter  Wait_Add128to64_64to32_32to16_16to8_8to4_4to2               =    15;
    parameter  Wait_Add128to64_64to32_32to16_16to8_8to4_4to2_2to1          =    16;
    parameter  Add128to64_64to32_32to16_16to8_8to4_4to2_2to1               =    17;
    parameter  Add64to32_32to16_16to8_8to4_4to2_2to1                       =    18;
    parameter  Add32to16_16to8_8to4_4to2_2to1                              =    19;
    parameter  Add16to8_8to4_4to2_2to1                                     =    20;
    parameter  Add8to4_4to2_2to1                                           =    21;
    parameter  Add4to2_2to1                                                =    22;
    parameter  Add2to1                                                     =    23;
    parameter  Stop                                                        =    24;


    

   

   sparse_mxv sparse_mxv0(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[0]),.inputw(inputw0[31:0]),.inputw_index(inputw0_index[19:0]),.counter(`counter),.output_onebank(temp_result_128[0]));
sparse_mxv sparse_mxv1(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[1]),.inputw(inputw0[63:32]),.inputw_index(inputw0_index[19:0]),.counter(`counter),.output_onebank(temp_result_128[1]));
sparse_mxv sparse_mxv2(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[2]),.inputw(inputw0[95:64]),.inputw_index(inputw0_index[19:0]),.counter(`counter),.output_onebank(temp_result_128[2]));
sparse_mxv sparse_mxv3(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[3]),.inputw(inputw0[127:96]),.inputw_index(inputw0_index[19:0]),.counter(`counter),.output_onebank(temp_result_128[3]));
sparse_mxv sparse_mxv4(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[4]),.inputw(inputw0[159:128]),.inputw_index(inputw0_index[39:20]),.counter(`counter),.output_onebank(temp_result_128[4]));
sparse_mxv sparse_mxv5(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[5]),.inputw(inputw0[191:160]),.inputw_index(inputw0_index[39:20]),.counter(`counter),.output_onebank(temp_result_128[5]));
sparse_mxv sparse_mxv6(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[6]),.inputw(inputw0[223:192]),.inputw_index(inputw0_index[39:20]),.counter(`counter),.output_onebank(temp_result_128[6]));
sparse_mxv sparse_mxv7(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[7]),.inputw(inputw0[255:224]),.inputw_index(inputw0_index[39:20]),.counter(`counter),.output_onebank(temp_result_128[7]));
sparse_mxv sparse_mxv8(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[8]),.inputw(inputw0[287:256]),.inputw_index(inputw0_index[59:40]),.counter(`counter),.output_onebank(temp_result_128[8]));
sparse_mxv sparse_mxv9(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[9]),.inputw(inputw0[319:288]),.inputw_index(inputw0_index[59:40]),.counter(`counter),.output_onebank(temp_result_128[9]));
sparse_mxv sparse_mxv10(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[10]),.inputw(inputw0[351:320]),.inputw_index(inputw0_index[59:40]),.counter(`counter),.output_onebank(temp_result_128[10]));
sparse_mxv sparse_mxv11(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[11]),.inputw(inputw0[383:352]),.inputw_index(inputw0_index[59:40]),.counter(`counter),.output_onebank(temp_result_128[11]));
sparse_mxv sparse_mxv12(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[12]),.inputw(inputw0[415:384]),.inputw_index(inputw0_index[79:60]),.counter(`counter),.output_onebank(temp_result_128[12]));
sparse_mxv sparse_mxv13(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[13]),.inputw(inputw0[447:416]),.inputw_index(inputw0_index[79:60]),.counter(`counter),.output_onebank(temp_result_128[13]));
sparse_mxv sparse_mxv14(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[14]),.inputw(inputw0[479:448]),.inputw_index(inputw0_index[79:60]),.counter(`counter),.output_onebank(temp_result_128[14]));
sparse_mxv sparse_mxv15(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[15]),.inputw(inputw0[511:480]),.inputw_index(inputw0_index[79:60]),.counter(`counter),.output_onebank(temp_result_128[15]));
sparse_mxv sparse_mxv16(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[16]),.inputw(inputw0[543:512]),.inputw_index(inputw0_index[99:80]),.counter(`counter),.output_onebank(temp_result_128[16]));
sparse_mxv sparse_mxv17(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[17]),.inputw(inputw0[575:544]),.inputw_index(inputw0_index[99:80]),.counter(`counter),.output_onebank(temp_result_128[17]));
sparse_mxv sparse_mxv18(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[18]),.inputw(inputw0[607:576]),.inputw_index(inputw0_index[99:80]),.counter(`counter),.output_onebank(temp_result_128[18]));
sparse_mxv sparse_mxv19(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[19]),.inputw(inputw0[639:608]),.inputw_index(inputw0_index[99:80]),.counter(`counter),.output_onebank(temp_result_128[19]));
sparse_mxv sparse_mxv20(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[20]),.inputw(inputw0[671:640]),.inputw_index(inputw0_index[119:100]),.counter(`counter),.output_onebank(temp_result_128[20]));
sparse_mxv sparse_mxv21(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[21]),.inputw(inputw0[703:672]),.inputw_index(inputw0_index[119:100]),.counter(`counter),.output_onebank(temp_result_128[21]));
sparse_mxv sparse_mxv22(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[22]),.inputw(inputw0[735:704]),.inputw_index(inputw0_index[119:100]),.counter(`counter),.output_onebank(temp_result_128[22]));
sparse_mxv sparse_mxv23(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[23]),.inputw(inputw0[767:736]),.inputw_index(inputw0_index[119:100]),.counter(`counter),.output_onebank(temp_result_128[23]));
sparse_mxv sparse_mxv24(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[24]),.inputw(inputw0[799:768]),.inputw_index(inputw0_index[139:120]),.counter(`counter),.output_onebank(temp_result_128[24]));
sparse_mxv sparse_mxv25(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[25]),.inputw(inputw0[831:800]),.inputw_index(inputw0_index[139:120]),.counter(`counter),.output_onebank(temp_result_128[25]));
sparse_mxv sparse_mxv26(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[26]),.inputw(inputw0[863:832]),.inputw_index(inputw0_index[139:120]),.counter(`counter),.output_onebank(temp_result_128[26]));
sparse_mxv sparse_mxv27(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[27]),.inputw(inputw0[895:864]),.inputw_index(inputw0_index[139:120]),.counter(`counter),.output_onebank(temp_result_128[27]));
sparse_mxv sparse_mxv28(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[28]),.inputw(inputw0[927:896]),.inputw_index(inputw0_index[159:140]),.counter(`counter),.output_onebank(temp_result_128[28]));
sparse_mxv sparse_mxv29(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[29]),.inputw(inputw0[959:928]),.inputw_index(inputw0_index[159:140]),.counter(`counter),.output_onebank(temp_result_128[29]));
sparse_mxv sparse_mxv30(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[30]),.inputw(inputw0[991:960]),.inputw_index(inputw0_index[159:140]),.counter(`counter),.output_onebank(temp_result_128[30]));
sparse_mxv sparse_mxv31(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[31]),.inputw(inputw0[1023:992]),.inputw_index(inputw0_index[159:140]),.counter(`counter),.output_onebank(temp_result_128[31]));
sparse_mxv sparse_mxv32(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[32]),.inputw(inputw0[1055:1024]),.inputw_index(inputw0_index[179:160]),.counter(`counter),.output_onebank(temp_result_128[32]));
sparse_mxv sparse_mxv33(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[33]),.inputw(inputw0[1087:1056]),.inputw_index(inputw0_index[179:160]),.counter(`counter),.output_onebank(temp_result_128[33]));
sparse_mxv sparse_mxv34(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[34]),.inputw(inputw0[1119:1088]),.inputw_index(inputw0_index[179:160]),.counter(`counter),.output_onebank(temp_result_128[34]));
sparse_mxv sparse_mxv35(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[35]),.inputw(inputw0[1151:1120]),.inputw_index(inputw0_index[179:160]),.counter(`counter),.output_onebank(temp_result_128[35]));
sparse_mxv sparse_mxv36(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[36]),.inputw(inputw0[1183:1152]),.inputw_index(inputw0_index[199:180]),.counter(`counter),.output_onebank(temp_result_128[36]));
sparse_mxv sparse_mxv37(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[37]),.inputw(inputw0[1215:1184]),.inputw_index(inputw0_index[199:180]),.counter(`counter),.output_onebank(temp_result_128[37]));
sparse_mxv sparse_mxv38(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[38]),.inputw(inputw0[1247:1216]),.inputw_index(inputw0_index[199:180]),.counter(`counter),.output_onebank(temp_result_128[38]));
sparse_mxv sparse_mxv39(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[39]),.inputw(inputw0[1279:1248]),.inputw_index(inputw0_index[199:180]),.counter(`counter),.output_onebank(temp_result_128[39]));
sparse_mxv sparse_mxv40(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[40]),.inputw(inputw0[1311:1280]),.inputw_index(inputw0_index[219:200]),.counter(`counter),.output_onebank(temp_result_128[40]));
sparse_mxv sparse_mxv41(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[41]),.inputw(inputw0[1343:1312]),.inputw_index(inputw0_index[219:200]),.counter(`counter),.output_onebank(temp_result_128[41]));
sparse_mxv sparse_mxv42(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[42]),.inputw(inputw0[1375:1344]),.inputw_index(inputw0_index[219:200]),.counter(`counter),.output_onebank(temp_result_128[42]));
sparse_mxv sparse_mxv43(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[43]),.inputw(inputw0[1407:1376]),.inputw_index(inputw0_index[219:200]),.counter(`counter),.output_onebank(temp_result_128[43]));
sparse_mxv sparse_mxv44(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[44]),.inputw(inputw0[1439:1408]),.inputw_index(inputw0_index[239:220]),.counter(`counter),.output_onebank(temp_result_128[44]));
sparse_mxv sparse_mxv45(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[45]),.inputw(inputw0[1471:1440]),.inputw_index(inputw0_index[239:220]),.counter(`counter),.output_onebank(temp_result_128[45]));
sparse_mxv sparse_mxv46(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[46]),.inputw(inputw0[1503:1472]),.inputw_index(inputw0_index[239:220]),.counter(`counter),.output_onebank(temp_result_128[46]));
sparse_mxv sparse_mxv47(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[47]),.inputw(inputw0[1535:1504]),.inputw_index(inputw0_index[239:220]),.counter(`counter),.output_onebank(temp_result_128[47]));
sparse_mxv sparse_mxv48(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[48]),.inputw(inputw0[1567:1536]),.inputw_index(inputw0_index[259:240]),.counter(`counter),.output_onebank(temp_result_128[48]));
sparse_mxv sparse_mxv49(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[49]),.inputw(inputw0[1599:1568]),.inputw_index(inputw0_index[259:240]),.counter(`counter),.output_onebank(temp_result_128[49]));
sparse_mxv sparse_mxv50(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[50]),.inputw(inputw0[1631:1600]),.inputw_index(inputw0_index[259:240]),.counter(`counter),.output_onebank(temp_result_128[50]));
sparse_mxv sparse_mxv51(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[51]),.inputw(inputw0[1663:1632]),.inputw_index(inputw0_index[259:240]),.counter(`counter),.output_onebank(temp_result_128[51]));
sparse_mxv sparse_mxv52(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[52]),.inputw(inputw0[1695:1664]),.inputw_index(inputw0_index[279:260]),.counter(`counter),.output_onebank(temp_result_128[52]));
sparse_mxv sparse_mxv53(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[53]),.inputw(inputw0[1727:1696]),.inputw_index(inputw0_index[279:260]),.counter(`counter),.output_onebank(temp_result_128[53]));
sparse_mxv sparse_mxv54(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[54]),.inputw(inputw0[1759:1728]),.inputw_index(inputw0_index[279:260]),.counter(`counter),.output_onebank(temp_result_128[54]));
sparse_mxv sparse_mxv55(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[55]),.inputw(inputw0[1791:1760]),.inputw_index(inputw0_index[279:260]),.counter(`counter),.output_onebank(temp_result_128[55]));
sparse_mxv sparse_mxv56(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[56]),.inputw(inputw0[1823:1792]),.inputw_index(inputw0_index[299:280]),.counter(`counter),.output_onebank(temp_result_128[56]));
sparse_mxv sparse_mxv57(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[57]),.inputw(inputw0[1855:1824]),.inputw_index(inputw0_index[299:280]),.counter(`counter),.output_onebank(temp_result_128[57]));
sparse_mxv sparse_mxv58(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[58]),.inputw(inputw0[1887:1856]),.inputw_index(inputw0_index[299:280]),.counter(`counter),.output_onebank(temp_result_128[58]));
sparse_mxv sparse_mxv59(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[59]),.inputw(inputw0[1919:1888]),.inputw_index(inputw0_index[299:280]),.counter(`counter),.output_onebank(temp_result_128[59]));
sparse_mxv sparse_mxv60(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[60]),.inputw(inputw0[1951:1920]),.inputw_index(inputw0_index[319:300]),.counter(`counter),.output_onebank(temp_result_128[60]));
sparse_mxv sparse_mxv61(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[61]),.inputw(inputw0[1983:1952]),.inputw_index(inputw0_index[319:300]),.counter(`counter),.output_onebank(temp_result_128[61]));
sparse_mxv sparse_mxv62(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[62]),.inputw(inputw0[2015:1984]),.inputw_index(inputw0_index[319:300]),.counter(`counter),.output_onebank(temp_result_128[62]));
sparse_mxv sparse_mxv63(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[63]),.inputw(inputw0[2047:2016]),.inputw_index(inputw0_index[319:300]),.counter(`counter),.output_onebank(temp_result_128[63]));
sparse_mxv sparse_mxv64(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[64]),.inputw(inputw0[2079:2048]),.inputw_index(inputw0_index[339:320]),.counter(`counter),.output_onebank(temp_result_128[64]));
sparse_mxv sparse_mxv65(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[65]),.inputw(inputw0[2111:2080]),.inputw_index(inputw0_index[339:320]),.counter(`counter),.output_onebank(temp_result_128[65]));
sparse_mxv sparse_mxv66(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[66]),.inputw(inputw0[2143:2112]),.inputw_index(inputw0_index[339:320]),.counter(`counter),.output_onebank(temp_result_128[66]));
sparse_mxv sparse_mxv67(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[67]),.inputw(inputw0[2175:2144]),.inputw_index(inputw0_index[339:320]),.counter(`counter),.output_onebank(temp_result_128[67]));
sparse_mxv sparse_mxv68(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[68]),.inputw(inputw0[2207:2176]),.inputw_index(inputw0_index[359:340]),.counter(`counter),.output_onebank(temp_result_128[68]));
sparse_mxv sparse_mxv69(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[69]),.inputw(inputw0[2239:2208]),.inputw_index(inputw0_index[359:340]),.counter(`counter),.output_onebank(temp_result_128[69]));
sparse_mxv sparse_mxv70(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[70]),.inputw(inputw0[2271:2240]),.inputw_index(inputw0_index[359:340]),.counter(`counter),.output_onebank(temp_result_128[70]));
sparse_mxv sparse_mxv71(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[71]),.inputw(inputw0[2303:2272]),.inputw_index(inputw0_index[359:340]),.counter(`counter),.output_onebank(temp_result_128[71]));
sparse_mxv sparse_mxv72(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[72]),.inputw(inputw0[2335:2304]),.inputw_index(inputw0_index[379:360]),.counter(`counter),.output_onebank(temp_result_128[72]));
sparse_mxv sparse_mxv73(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[73]),.inputw(inputw0[2367:2336]),.inputw_index(inputw0_index[379:360]),.counter(`counter),.output_onebank(temp_result_128[73]));
sparse_mxv sparse_mxv74(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[74]),.inputw(inputw0[2399:2368]),.inputw_index(inputw0_index[379:360]),.counter(`counter),.output_onebank(temp_result_128[74]));
sparse_mxv sparse_mxv75(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[75]),.inputw(inputw0[2431:2400]),.inputw_index(inputw0_index[379:360]),.counter(`counter),.output_onebank(temp_result_128[75]));
sparse_mxv sparse_mxv76(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[76]),.inputw(inputw0[2463:2432]),.inputw_index(inputw0_index[399:380]),.counter(`counter),.output_onebank(temp_result_128[76]));
sparse_mxv sparse_mxv77(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[77]),.inputw(inputw0[2495:2464]),.inputw_index(inputw0_index[399:380]),.counter(`counter),.output_onebank(temp_result_128[77]));
sparse_mxv sparse_mxv78(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[78]),.inputw(inputw0[2527:2496]),.inputw_index(inputw0_index[399:380]),.counter(`counter),.output_onebank(temp_result_128[78]));
sparse_mxv sparse_mxv79(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[79]),.inputw(inputw0[2559:2528]),.inputw_index(inputw0_index[399:380]),.counter(`counter),.output_onebank(temp_result_128[79]));
sparse_mxv sparse_mxv80(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[80]),.inputw(inputw0[2591:2560]),.inputw_index(inputw0_index[419:400]),.counter(`counter),.output_onebank(temp_result_128[80]));
sparse_mxv sparse_mxv81(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[81]),.inputw(inputw0[2623:2592]),.inputw_index(inputw0_index[419:400]),.counter(`counter),.output_onebank(temp_result_128[81]));
sparse_mxv sparse_mxv82(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[82]),.inputw(inputw0[2655:2624]),.inputw_index(inputw0_index[419:400]),.counter(`counter),.output_onebank(temp_result_128[82]));
sparse_mxv sparse_mxv83(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[83]),.inputw(inputw0[2687:2656]),.inputw_index(inputw0_index[419:400]),.counter(`counter),.output_onebank(temp_result_128[83]));
sparse_mxv sparse_mxv84(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[84]),.inputw(inputw0[2719:2688]),.inputw_index(inputw0_index[439:420]),.counter(`counter),.output_onebank(temp_result_128[84]));
sparse_mxv sparse_mxv85(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[85]),.inputw(inputw0[2751:2720]),.inputw_index(inputw0_index[439:420]),.counter(`counter),.output_onebank(temp_result_128[85]));
sparse_mxv sparse_mxv86(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[86]),.inputw(inputw0[2783:2752]),.inputw_index(inputw0_index[439:420]),.counter(`counter),.output_onebank(temp_result_128[86]));
sparse_mxv sparse_mxv87(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[87]),.inputw(inputw0[2815:2784]),.inputw_index(inputw0_index[439:420]),.counter(`counter),.output_onebank(temp_result_128[87]));
sparse_mxv sparse_mxv88(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[88]),.inputw(inputw0[2847:2816]),.inputw_index(inputw0_index[459:440]),.counter(`counter),.output_onebank(temp_result_128[88]));
sparse_mxv sparse_mxv89(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[89]),.inputw(inputw0[2879:2848]),.inputw_index(inputw0_index[459:440]),.counter(`counter),.output_onebank(temp_result_128[89]));
sparse_mxv sparse_mxv90(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[90]),.inputw(inputw0[2911:2880]),.inputw_index(inputw0_index[459:440]),.counter(`counter),.output_onebank(temp_result_128[90]));
sparse_mxv sparse_mxv91(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[91]),.inputw(inputw0[2943:2912]),.inputw_index(inputw0_index[459:440]),.counter(`counter),.output_onebank(temp_result_128[91]));
sparse_mxv sparse_mxv92(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[92]),.inputw(inputw0[2975:2944]),.inputw_index(inputw0_index[479:460]),.counter(`counter),.output_onebank(temp_result_128[92]));
sparse_mxv sparse_mxv93(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[93]),.inputw(inputw0[3007:2976]),.inputw_index(inputw0_index[479:460]),.counter(`counter),.output_onebank(temp_result_128[93]));
sparse_mxv sparse_mxv94(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[94]),.inputw(inputw0[3039:3008]),.inputw_index(inputw0_index[479:460]),.counter(`counter),.output_onebank(temp_result_128[94]));
sparse_mxv sparse_mxv95(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[95]),.inputw(inputw0[3071:3040]),.inputw_index(inputw0_index[479:460]),.counter(`counter),.output_onebank(temp_result_128[95]));
sparse_mxv sparse_mxv96(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[96]),.inputw(inputw0[3103:3072]),.inputw_index(inputw0_index[499:480]),.counter(`counter),.output_onebank(temp_result_128[96]));
sparse_mxv sparse_mxv97(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[97]),.inputw(inputw0[3135:3104]),.inputw_index(inputw0_index[499:480]),.counter(`counter),.output_onebank(temp_result_128[97]));
sparse_mxv sparse_mxv98(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[98]),.inputw(inputw0[3167:3136]),.inputw_index(inputw0_index[499:480]),.counter(`counter),.output_onebank(temp_result_128[98]));
sparse_mxv sparse_mxv99(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[99]),.inputw(inputw0[3199:3168]),.inputw_index(inputw0_index[499:480]),.counter(`counter),.output_onebank(temp_result_128[99]));
sparse_mxv sparse_mxv100(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[100]),.inputw(inputw0[3231:3200]),.inputw_index(inputw0_index[519:500]),.counter(`counter),.output_onebank(temp_result_128[100]));
sparse_mxv sparse_mxv101(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[101]),.inputw(inputw0[3263:3232]),.inputw_index(inputw0_index[519:500]),.counter(`counter),.output_onebank(temp_result_128[101]));
sparse_mxv sparse_mxv102(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[102]),.inputw(inputw0[3295:3264]),.inputw_index(inputw0_index[519:500]),.counter(`counter),.output_onebank(temp_result_128[102]));
sparse_mxv sparse_mxv103(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[103]),.inputw(inputw0[3327:3296]),.inputw_index(inputw0_index[519:500]),.counter(`counter),.output_onebank(temp_result_128[103]));
sparse_mxv sparse_mxv104(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[104]),.inputw(inputw0[3359:3328]),.inputw_index(inputw0_index[539:520]),.counter(`counter),.output_onebank(temp_result_128[104]));
sparse_mxv sparse_mxv105(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[105]),.inputw(inputw0[3391:3360]),.inputw_index(inputw0_index[539:520]),.counter(`counter),.output_onebank(temp_result_128[105]));
sparse_mxv sparse_mxv106(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[106]),.inputw(inputw0[3423:3392]),.inputw_index(inputw0_index[539:520]),.counter(`counter),.output_onebank(temp_result_128[106]));
sparse_mxv sparse_mxv107(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[107]),.inputw(inputw0[3455:3424]),.inputw_index(inputw0_index[539:520]),.counter(`counter),.output_onebank(temp_result_128[107]));
sparse_mxv sparse_mxv108(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[108]),.inputw(inputw0[3487:3456]),.inputw_index(inputw0_index[559:540]),.counter(`counter),.output_onebank(temp_result_128[108]));
sparse_mxv sparse_mxv109(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[109]),.inputw(inputw0[3519:3488]),.inputw_index(inputw0_index[559:540]),.counter(`counter),.output_onebank(temp_result_128[109]));
sparse_mxv sparse_mxv110(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[110]),.inputw(inputw0[3551:3520]),.inputw_index(inputw0_index[559:540]),.counter(`counter),.output_onebank(temp_result_128[110]));
sparse_mxv sparse_mxv111(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[111]),.inputw(inputw0[3583:3552]),.inputw_index(inputw0_index[559:540]),.counter(`counter),.output_onebank(temp_result_128[111]));
sparse_mxv sparse_mxv112(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[112]),.inputw(inputw0[3615:3584]),.inputw_index(inputw0_index[579:560]),.counter(`counter),.output_onebank(temp_result_128[112]));
sparse_mxv sparse_mxv113(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[113]),.inputw(inputw0[3647:3616]),.inputw_index(inputw0_index[579:560]),.counter(`counter),.output_onebank(temp_result_128[113]));
sparse_mxv sparse_mxv114(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[114]),.inputw(inputw0[3679:3648]),.inputw_index(inputw0_index[579:560]),.counter(`counter),.output_onebank(temp_result_128[114]));
sparse_mxv sparse_mxv115(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[115]),.inputw(inputw0[3711:3680]),.inputw_index(inputw0_index[579:560]),.counter(`counter),.output_onebank(temp_result_128[115]));
sparse_mxv sparse_mxv116(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[116]),.inputw(inputw0[3743:3712]),.inputw_index(inputw0_index[599:580]),.counter(`counter),.output_onebank(temp_result_128[116]));
sparse_mxv sparse_mxv117(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[117]),.inputw(inputw0[3775:3744]),.inputw_index(inputw0_index[599:580]),.counter(`counter),.output_onebank(temp_result_128[117]));
sparse_mxv sparse_mxv118(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[118]),.inputw(inputw0[3807:3776]),.inputw_index(inputw0_index[599:580]),.counter(`counter),.output_onebank(temp_result_128[118]));
sparse_mxv sparse_mxv119(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[119]),.inputw(inputw0[3839:3808]),.inputw_index(inputw0_index[599:580]),.counter(`counter),.output_onebank(temp_result_128[119]));
sparse_mxv sparse_mxv120(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[120]),.inputw(inputw0[3871:3840]),.inputw_index(inputw0_index[619:600]),.counter(`counter),.output_onebank(temp_result_128[120]));
sparse_mxv sparse_mxv121(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[121]),.inputw(inputw0[3903:3872]),.inputw_index(inputw0_index[619:600]),.counter(`counter),.output_onebank(temp_result_128[121]));
sparse_mxv sparse_mxv122(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[122]),.inputw(inputw0[3935:3904]),.inputw_index(inputw0_index[619:600]),.counter(`counter),.output_onebank(temp_result_128[122]));
sparse_mxv sparse_mxv123(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[123]),.inputw(inputw0[3967:3936]),.inputw_index(inputw0_index[619:600]),.counter(`counter),.output_onebank(temp_result_128[123]));
sparse_mxv sparse_mxv124(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[124]),.inputw(inputw0[3999:3968]),.inputw_index(inputw0_index[639:620]),.counter(`counter),.output_onebank(temp_result_128[124]));
sparse_mxv sparse_mxv125(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[125]),.inputw(inputw0[4031:4000]),.inputw_index(inputw0_index[639:620]),.counter(`counter),.output_onebank(temp_result_128[125]));
sparse_mxv sparse_mxv126(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[126]),.inputw(inputw0[4063:4032]),.inputw_index(inputw0_index[639:620]),.counter(`counter),.output_onebank(temp_result_128[126]));
sparse_mxv sparse_mxv127(.clk(clk),.idle(spmvidle),.rst(rst),.inputx(active_xt[127]),.inputw(inputw0[4095:4064]),.inputw_index(inputw0_index[639:620]),.counter(`counter),.output_onebank(temp_result_128[127]));
always @ (posedge clk) begin // state change 
        if(!rst) begin
            state <= Start ;
            statecount <= 'd0 ;
            spmvidle <= 1;
        end
        else if (idle) begin
            state <= Start ;
            statecount <= 'd0;
            spmvidle <= 1;
        end
        else begin
            case(state)
            Start:begin
                state <= Load0;
                statecount <= 'd0;
                spmvidle <= spmvidle;
            end
            Load0:begin
                state <= Load1;
                statecount <= 'd0;
                spmvidle <= spmvidle;
            end

            Load1:begin   // latency of Load
                if (statecount <1) begin
                    state <= state;
                    statecount <= statecount + 1;
                    spmvidle <= spmvidle;
                end 
                else begin
                    state <= Load2;
                    statecount <= statecount + 1;
                    spmvidle <= spmvidle;
                end
                
            end

            Load2:begin   
                if (statecount <63) begin  //  is Load 16 elements  of active_xt
                    state <= state;
                    statecount <= statecount + 1;
                    spmvidle <= spmvidle ;
                end 
                else begin
                    state <= Load3;
                    statecount <= 'd0;
                    spmvidle <= spmvidle ;
                end
                
            end

            Load3:begin
                state <= Load4;
                statecount <= statecount + 1;
                spmvidle <= spmvidle ;
            end

            Load4:begin
                state <= Wait1;
                statecount <= statecount + 1;
                spmvidle <= 1;
            end
            

            Wait1:begin   // the latency time of  sparse_mx
                state <= Wait2;
                statecount <= statecount + 1;
                spmvidle <= 0;
            end

            Wait2:begin // the latency time of  sparse_mx
                state <= Wait3;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait3:begin  // the latency time of  sparse_mx
                state <= Wait4;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait4:begin  // the latency time of  sparse_mx
                state <= Wait5;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait5:begin  // the latency time of  sparse_mx
                state <= Wait6;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait6:begin  // the latency time of  sparse_mx
                state <= Wait7;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end
            
            Wait7:begin  // the latency time of  sparse_mx
                state <= Wait_Add128to64;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait_Add128to64:begin
                state <= Wait_Add128to64_64to32;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait_Add128to64_64to32:begin
                state <= Wait_Add128to64_64to32_32to16;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait_Add128to64_64to32_32to16:begin
                state <= Wait_Add128to64_64to32_32to16_16to8;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait_Add128to64_64to32_32to16_16to8:begin
                state <= Wait_Add128to64_64to32_32to16_16to8_8to4;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4:begin
                state <= Wait_Add128to64_64to32_32to16_16to8_8to4_4to2;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2:begin
                state <= Wait_Add128to64_64to32_32to16_16to8_8to4_4to2_2to1;
                statecount <= statecount + 1;
                spmvidle <= spmvidle;
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                spmvidle <= spmvidle;
                if (statecount < `newcounter) begin // is add 2048 elements 
                    state <= state ;
                    statecount <= statecount + 1;
                end
                else begin
                     state <=Add128to64_64to32_32to16_16to8_8to4_4to2_2to1;
                     statecount <= statecount ;
                end
            end

            Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                state <= Add64to32_32to16_16to8_8to4_4to2_2to1;
                statecount <= statecount;
                spmvidle <= spmvidle;
            end

            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                state <= Add32to16_16to8_8to4_4to2_2to1;
                statecount <= statecount;
                spmvidle <= spmvidle;
            end

            Add32to16_16to8_8to4_4to2_2to1:begin
                state <= Add16to8_8to4_4to2_2to1;
                statecount <= statecount;
                spmvidle <= spmvidle;
            end

            Add16to8_8to4_4to2_2to1:begin
                state <= Add8to4_4to2_2to1;
                statecount <= statecount;
                spmvidle <= spmvidle;
            end

            Add8to4_4to2_2to1:begin
                state <= Add4to2_2to1;
                statecount <= statecount;
                spmvidle <= spmvidle;
            end

            Add4to2_2to1:begin
                state <= Add2to1;
                statecount <= statecount;
                spmvidle <= spmvidle;
            end
            Add2to1:begin
                state <= Stop;
                statecount <= statecount;
                spmvidle <= spmvidle;
            end

            Stop:begin
                state <= state;
                statecount <= statecount;
                spmvidle <= spmvidle;
            end

            default:begin
                state <= state;
                statecount <= statecount;
                spmvidle <= spmvidle;
            end

            endcase
        end

end

always @ (posedge clk) begin    // the state machine to assign active_xt reg 
        if(!rst) begin
            active_xt[0] <= active_xt[0];
                active_xt[1] <= active_xt[1];
                active_xt[2] <= active_xt[2];
                active_xt[3] <= active_xt[3];
                active_xt[4] <= active_xt[4];
                active_xt[5] <= active_xt[5];
                active_xt[6] <= active_xt[6];
                active_xt[7] <= active_xt[7];
                active_xt[8] <= active_xt[8];
                active_xt[9] <= active_xt[9];
                active_xt[10] <= active_xt[10];
                active_xt[11] <= active_xt[11];
                active_xt[12] <= active_xt[12];
                active_xt[13] <= active_xt[13];
                active_xt[14] <= active_xt[14];
                active_xt[15] <= active_xt[15];
                active_xt[16] <= active_xt[16];
                active_xt[17] <= active_xt[17];
                active_xt[18] <= active_xt[18];
                active_xt[19] <= active_xt[19];
                active_xt[20] <= active_xt[20];
                active_xt[21] <= active_xt[21];
                active_xt[22] <= active_xt[22];
                active_xt[23] <= active_xt[23];
                active_xt[24] <= active_xt[24];
                active_xt[25] <= active_xt[25];
                active_xt[26] <= active_xt[26];
                active_xt[27] <= active_xt[27];
                active_xt[28] <= active_xt[28];
                active_xt[29] <= active_xt[29];
                active_xt[30] <= active_xt[30];
                active_xt[31] <= active_xt[31];
                active_xt[32] <= active_xt[32];
                active_xt[33] <= active_xt[33];
                active_xt[34] <= active_xt[34];
                active_xt[35] <= active_xt[35];
                active_xt[36] <= active_xt[36];
                active_xt[37] <= active_xt[37];
                active_xt[38] <= active_xt[38];
                active_xt[39] <= active_xt[39];
                active_xt[40] <= active_xt[40];
                active_xt[41] <= active_xt[41];
                active_xt[42] <= active_xt[42];
                active_xt[43] <= active_xt[43];
                active_xt[44] <= active_xt[44];
                active_xt[45] <= active_xt[45];
                active_xt[46] <= active_xt[46];
                active_xt[47] <= active_xt[47];
                active_xt[48] <= active_xt[48];
                active_xt[49] <= active_xt[49];
                active_xt[50] <= active_xt[50];
                active_xt[51] <= active_xt[51];
                active_xt[52] <= active_xt[52];
                active_xt[53] <= active_xt[53];
                active_xt[54] <= active_xt[54];
                active_xt[55] <= active_xt[55];
                active_xt[56] <= active_xt[56];
                active_xt[57] <= active_xt[57];
                active_xt[58] <= active_xt[58];
                active_xt[59] <= active_xt[59];
                active_xt[60] <= active_xt[60];
                active_xt[61] <= active_xt[61];
                active_xt[62] <= active_xt[62];
                active_xt[63] <= active_xt[63];
                active_xt[64] <= active_xt[64];
                active_xt[65] <= active_xt[65];
                active_xt[66] <= active_xt[66];
                active_xt[67] <= active_xt[67];
                active_xt[68] <= active_xt[68];
                active_xt[69] <= active_xt[69];
                active_xt[70] <= active_xt[70];
                active_xt[71] <= active_xt[71];
                active_xt[72] <= active_xt[72];
                active_xt[73] <= active_xt[73];
                active_xt[74] <= active_xt[74];
                active_xt[75] <= active_xt[75];
                active_xt[76] <= active_xt[76];
                active_xt[77] <= active_xt[77];
                active_xt[78] <= active_xt[78];
                active_xt[79] <= active_xt[79];
                active_xt[80] <= active_xt[80];
                active_xt[81] <= active_xt[81];
                active_xt[82] <= active_xt[82];
                active_xt[83] <= active_xt[83];
                active_xt[84] <= active_xt[84];
                active_xt[85] <= active_xt[85];
                active_xt[86] <= active_xt[86];
                active_xt[87] <= active_xt[87];
                active_xt[88] <= active_xt[88];
                active_xt[89] <= active_xt[89];
                active_xt[90] <= active_xt[90];
                active_xt[91] <= active_xt[91];
                active_xt[92] <= active_xt[92];
                active_xt[93] <= active_xt[93];
                active_xt[94] <= active_xt[94];
                active_xt[95] <= active_xt[95];
                active_xt[96] <= active_xt[96];
                active_xt[97] <= active_xt[97];
                active_xt[98] <= active_xt[98];
                active_xt[99] <= active_xt[99];
                active_xt[100] <= active_xt[100];
                active_xt[101] <= active_xt[101];
                active_xt[102] <= active_xt[102];
                active_xt[103] <= active_xt[103];
                active_xt[104] <= active_xt[104];
                active_xt[105] <= active_xt[105];
                active_xt[106] <= active_xt[106];
                active_xt[107] <= active_xt[107];
                active_xt[108] <= active_xt[108];
                active_xt[109] <= active_xt[109];
                active_xt[110] <= active_xt[110];
                active_xt[111] <= active_xt[111];
                active_xt[112] <= active_xt[112];
                active_xt[113] <= active_xt[113];
                active_xt[114] <= active_xt[114];
                active_xt[115] <= active_xt[115];
                active_xt[116] <= active_xt[116];
                active_xt[117] <= active_xt[117];
                active_xt[118] <= active_xt[118];
                active_xt[119] <= active_xt[119];
                active_xt[120] <= active_xt[120];
                active_xt[121] <= active_xt[121];
                active_xt[122] <= active_xt[122];
                active_xt[123] <= active_xt[123];
                active_xt[124] <= active_xt[124];
                active_xt[125] <= active_xt[125];
                active_xt[126] <= active_xt[126];
                active_xt[127] <= active_xt[127];
        end
        else if (idle) begin
            active_xt[0] <= active_xt[0];
                active_xt[1] <= active_xt[1];
                active_xt[2] <= active_xt[2];
                active_xt[3] <= active_xt[3];
                active_xt[4] <= active_xt[4];
                active_xt[5] <= active_xt[5];
                active_xt[6] <= active_xt[6];
                active_xt[7] <= active_xt[7];
                active_xt[8] <= active_xt[8];
                active_xt[9] <= active_xt[9];
                active_xt[10] <= active_xt[10];
                active_xt[11] <= active_xt[11];
                active_xt[12] <= active_xt[12];
                active_xt[13] <= active_xt[13];
                active_xt[14] <= active_xt[14];
                active_xt[15] <= active_xt[15];
                active_xt[16] <= active_xt[16];
                active_xt[17] <= active_xt[17];
                active_xt[18] <= active_xt[18];
                active_xt[19] <= active_xt[19];
                active_xt[20] <= active_xt[20];
                active_xt[21] <= active_xt[21];
                active_xt[22] <= active_xt[22];
                active_xt[23] <= active_xt[23];
                active_xt[24] <= active_xt[24];
                active_xt[25] <= active_xt[25];
                active_xt[26] <= active_xt[26];
                active_xt[27] <= active_xt[27];
                active_xt[28] <= active_xt[28];
                active_xt[29] <= active_xt[29];
                active_xt[30] <= active_xt[30];
                active_xt[31] <= active_xt[31];
                active_xt[32] <= active_xt[32];
                active_xt[33] <= active_xt[33];
                active_xt[34] <= active_xt[34];
                active_xt[35] <= active_xt[35];
                active_xt[36] <= active_xt[36];
                active_xt[37] <= active_xt[37];
                active_xt[38] <= active_xt[38];
                active_xt[39] <= active_xt[39];
                active_xt[40] <= active_xt[40];
                active_xt[41] <= active_xt[41];
                active_xt[42] <= active_xt[42];
                active_xt[43] <= active_xt[43];
                active_xt[44] <= active_xt[44];
                active_xt[45] <= active_xt[45];
                active_xt[46] <= active_xt[46];
                active_xt[47] <= active_xt[47];
                active_xt[48] <= active_xt[48];
                active_xt[49] <= active_xt[49];
                active_xt[50] <= active_xt[50];
                active_xt[51] <= active_xt[51];
                active_xt[52] <= active_xt[52];
                active_xt[53] <= active_xt[53];
                active_xt[54] <= active_xt[54];
                active_xt[55] <= active_xt[55];
                active_xt[56] <= active_xt[56];
                active_xt[57] <= active_xt[57];
                active_xt[58] <= active_xt[58];
                active_xt[59] <= active_xt[59];
                active_xt[60] <= active_xt[60];
                active_xt[61] <= active_xt[61];
                active_xt[62] <= active_xt[62];
                active_xt[63] <= active_xt[63];
                active_xt[64] <= active_xt[64];
                active_xt[65] <= active_xt[65];
                active_xt[66] <= active_xt[66];
                active_xt[67] <= active_xt[67];
                active_xt[68] <= active_xt[68];
                active_xt[69] <= active_xt[69];
                active_xt[70] <= active_xt[70];
                active_xt[71] <= active_xt[71];
                active_xt[72] <= active_xt[72];
                active_xt[73] <= active_xt[73];
                active_xt[74] <= active_xt[74];
                active_xt[75] <= active_xt[75];
                active_xt[76] <= active_xt[76];
                active_xt[77] <= active_xt[77];
                active_xt[78] <= active_xt[78];
                active_xt[79] <= active_xt[79];
                active_xt[80] <= active_xt[80];
                active_xt[81] <= active_xt[81];
                active_xt[82] <= active_xt[82];
                active_xt[83] <= active_xt[83];
                active_xt[84] <= active_xt[84];
                active_xt[85] <= active_xt[85];
                active_xt[86] <= active_xt[86];
                active_xt[87] <= active_xt[87];
                active_xt[88] <= active_xt[88];
                active_xt[89] <= active_xt[89];
                active_xt[90] <= active_xt[90];
                active_xt[91] <= active_xt[91];
                active_xt[92] <= active_xt[92];
                active_xt[93] <= active_xt[93];
                active_xt[94] <= active_xt[94];
                active_xt[95] <= active_xt[95];
                active_xt[96] <= active_xt[96];
                active_xt[97] <= active_xt[97];
                active_xt[98] <= active_xt[98];
                active_xt[99] <= active_xt[99];
                active_xt[100] <= active_xt[100];
                active_xt[101] <= active_xt[101];
                active_xt[102] <= active_xt[102];
                active_xt[103] <= active_xt[103];
                active_xt[104] <= active_xt[104];
                active_xt[105] <= active_xt[105];
                active_xt[106] <= active_xt[106];
                active_xt[107] <= active_xt[107];
                active_xt[108] <= active_xt[108];
                active_xt[109] <= active_xt[109];
                active_xt[110] <= active_xt[110];
                active_xt[111] <= active_xt[111];
                active_xt[112] <= active_xt[112];
                active_xt[113] <= active_xt[113];
                active_xt[114] <= active_xt[114];
                active_xt[115] <= active_xt[115];
                active_xt[116] <= active_xt[116];
                active_xt[117] <= active_xt[117];
                active_xt[118] <= active_xt[118];
                active_xt[119] <= active_xt[119];
                active_xt[120] <= active_xt[120];
                active_xt[121] <= active_xt[121];
                active_xt[122] <= active_xt[122];
                active_xt[123] <= active_xt[123];
                active_xt[124] <= active_xt[124];
                active_xt[125] <= active_xt[125];
                active_xt[126] <= active_xt[126];
                active_xt[127] <= active_xt[127];
        end
        else begin
            case(state)
            Load2:begin
                if (statecount == 2) begin
                    active_xt[0] <= inputx_output[511:0];
                    active_xt[1] <= inputx_output[1023:512];
                end
                else if (statecount == 3) begin
                    active_xt[2] <= inputx_output[511:0];
                    active_xt[3] <= inputx_output[1023:512];
                end
                else if (statecount == 4) begin
                    active_xt[4] <= inputx_output[511:0];
                    active_xt[5] <= inputx_output[1023:512];
                end
                else if (statecount == 5) begin
                    active_xt[6] <= inputx_output[511:0];
                    active_xt[7] <= inputx_output[1023:512];
                end
                else if (statecount == 6) begin
                    active_xt[8] <= inputx_output[511:0];
                    active_xt[9] <= inputx_output[1023:512];
                end
                else if (statecount == 7) begin
                    active_xt[10] <= inputx_output[511:0];
                    active_xt[11] <= inputx_output[1023:512];
                end
                else if (statecount == 8) begin
                    active_xt[12] <= inputx_output[511:0];
                    active_xt[13] <= inputx_output[1023:512];
                end
                else if (statecount == 9) begin
                    active_xt[14] <= inputx_output[511:0];
                    active_xt[15] <= inputx_output[1023:512];
                end
                else if (statecount == 10) begin
                    active_xt[16] <= inputx_output[511:0];
                    active_xt[17] <= inputx_output[1023:512];
                end
                else if (statecount == 11) begin
                    active_xt[18] <= inputx_output[511:0];
                    active_xt[19] <= inputx_output[1023:512];
                end
                else if (statecount == 12) begin
                    active_xt[20] <= inputx_output[511:0];
                    active_xt[21] <= inputx_output[1023:512];
                end
                else if (statecount == 13) begin
                    active_xt[22] <= inputx_output[511:0];
                    active_xt[23] <= inputx_output[1023:512];
                end
                else if (statecount == 14) begin
                    active_xt[24] <= inputx_output[511:0];
                    active_xt[25] <= inputx_output[1023:512];
                end
                else if (statecount == 15) begin
                    active_xt[26] <= inputx_output[511:0];
                    active_xt[27] <= inputx_output[1023:512];
                end
                else if (statecount == 16) begin
                    active_xt[28] <= inputx_output[511:0];
                    active_xt[29] <= inputx_output[1023:512];
                end
                else if (statecount == 17) begin
                    active_xt[30] <= inputx_output[511:0];
                    active_xt[31] <= inputx_output[1023:512];
                end
                else if (statecount == 18) begin
                    active_xt[32] <= inputx_output[511:0];
                    active_xt[33] <= inputx_output[1023:512];
                end
                else if (statecount == 19) begin
                    active_xt[34] <= inputx_output[511:0];
                    active_xt[35] <= inputx_output[1023:512];
                end
                else if (statecount == 20) begin
                    active_xt[36] <= inputx_output[511:0];
                    active_xt[37] <= inputx_output[1023:512];
                end
                else if (statecount == 21) begin
                    active_xt[38] <= inputx_output[511:0];
                    active_xt[39] <= inputx_output[1023:512];
                end
                else if (statecount == 22) begin
                    active_xt[40] <= inputx_output[511:0];
                    active_xt[41] <= inputx_output[1023:512];
                end
                else if (statecount == 23) begin
                    active_xt[42] <= inputx_output[511:0];
                    active_xt[43] <= inputx_output[1023:512];
                end
                else if (statecount == 24) begin
                    active_xt[44] <= inputx_output[511:0];
                    active_xt[45] <= inputx_output[1023:512];
                end
                else if (statecount == 25) begin
                    active_xt[46] <= inputx_output[511:0];
                    active_xt[47] <= inputx_output[1023:512];
                end
                else if (statecount == 26) begin
                    active_xt[48] <= inputx_output[511:0];
                    active_xt[49] <= inputx_output[1023:512];
                end
                else if (statecount == 27) begin
                    active_xt[50] <= inputx_output[511:0];
                    active_xt[51] <= inputx_output[1023:512];
                end
                else if (statecount == 28) begin
                    active_xt[52] <= inputx_output[511:0];
                    active_xt[53] <= inputx_output[1023:512];
                end
                else if (statecount == 29) begin
                    active_xt[54] <= inputx_output[511:0];
                    active_xt[55] <= inputx_output[1023:512];
                end
                else if (statecount == 30) begin
                    active_xt[56] <= inputx_output[511:0];
                    active_xt[57] <= inputx_output[1023:512];
                end
                else if (statecount == 31) begin
                    active_xt[58] <= inputx_output[511:0];
                    active_xt[59] <= inputx_output[1023:512];
                end
                else if (statecount == 32) begin
                    active_xt[60] <= inputx_output[511:0];
                    active_xt[61] <= inputx_output[1023:512];
                end
                else if (statecount == 33) begin
                    active_xt[62] <= inputx_output[511:0];
                    active_xt[63] <= inputx_output[1023:512];
                end
                else if (statecount == 34) begin
                    active_xt[64] <= inputx_output[511:0];
                    active_xt[65] <= inputx_output[1023:512];
                end
                else if (statecount == 35) begin
                    active_xt[66] <= inputx_output[511:0];
                    active_xt[67] <= inputx_output[1023:512];
                end
                else if (statecount == 36) begin
                    active_xt[68] <= inputx_output[511:0];
                    active_xt[69] <= inputx_output[1023:512];
                end
                else if (statecount == 37) begin
                    active_xt[70] <= inputx_output[511:0];
                    active_xt[71] <= inputx_output[1023:512];
                end
                else if (statecount == 38) begin
                    active_xt[72] <= inputx_output[511:0];
                    active_xt[73] <= inputx_output[1023:512];
                end
                else if (statecount == 39) begin
                    active_xt[74] <= inputx_output[511:0];
                    active_xt[75] <= inputx_output[1023:512];
                end
                else if (statecount == 40) begin
                    active_xt[76] <= inputx_output[511:0];
                    active_xt[77] <= inputx_output[1023:512];
                end
                else if (statecount == 41) begin
                    active_xt[78] <= inputx_output[511:0];
                    active_xt[79] <= inputx_output[1023:512];
                end
                else if (statecount == 42) begin
                    active_xt[80] <= inputx_output[511:0];
                    active_xt[81] <= inputx_output[1023:512];
                end
                else if (statecount == 43) begin
                    active_xt[82] <= inputx_output[511:0];
                    active_xt[83] <= inputx_output[1023:512];
                end
                else if (statecount == 44) begin
                    active_xt[84] <= inputx_output[511:0];
                    active_xt[85] <= inputx_output[1023:512];
                end
                else if (statecount == 45) begin
                    active_xt[86] <= inputx_output[511:0];
                    active_xt[87] <= inputx_output[1023:512];
                end
                else if (statecount == 46) begin
                    active_xt[88] <= inputx_output[511:0];
                    active_xt[89] <= inputx_output[1023:512];
                end
                else if (statecount == 47) begin
                    active_xt[90] <= inputx_output[511:0];
                    active_xt[91] <= inputx_output[1023:512];
                end
                else if (statecount == 48) begin
                    active_xt[92] <= inputx_output[511:0];
                    active_xt[93] <= inputx_output[1023:512];
                end
                else if (statecount == 49) begin
                    active_xt[94] <= inputx_output[511:0];
                    active_xt[95] <= inputx_output[1023:512];
                end
                else if (statecount == 50) begin
                    active_xt[96] <= inputx_output[511:0];
                    active_xt[97] <= inputx_output[1023:512];
                end
                else if (statecount == 51) begin
                    active_xt[98] <= inputx_output[511:0];
                    active_xt[99] <= inputx_output[1023:512];
                end
                else if (statecount == 52) begin
                    active_xt[100] <= inputx_output[511:0];
                    active_xt[101] <= inputx_output[1023:512];
                end
                else if (statecount == 53) begin
                    active_xt[102] <= inputx_output[511:0];
                    active_xt[103] <= inputx_output[1023:512];
                end
                else if (statecount == 54) begin
                    active_xt[104] <= inputx_output[511:0];
                    active_xt[105] <= inputx_output[1023:512];
                end
                else if (statecount == 55) begin
                    active_xt[106] <= inputx_output[511:0];
                    active_xt[107] <= inputx_output[1023:512];
                end
                else if (statecount == 56) begin
                    active_xt[108] <= inputx_output[511:0];
                    active_xt[109] <= inputx_output[1023:512];
                end
                else if (statecount == 57) begin
                    active_xt[110] <= inputx_output[511:0];
                    active_xt[111] <= inputx_output[1023:512];
                end
                else if (statecount == 58) begin
                    active_xt[112] <= inputx_output[511:0];
                    active_xt[113] <= inputx_output[1023:512];
                end
                else if (statecount == 59) begin
                    active_xt[114] <= inputx_output[511:0];
                    active_xt[115] <= inputx_output[1023:512];
                end
                else if (statecount == 60) begin
                    active_xt[116] <= inputx_output[511:0];
                    active_xt[117] <= inputx_output[1023:512];
                end
                else if (statecount == 61) begin
                    active_xt[118] <= inputx_output[511:0];
                    active_xt[119] <= inputx_output[1023:512];
                end
                else if (statecount == 62) begin
                    active_xt[120] <= inputx_output[511:0];
                    active_xt[121] <= inputx_output[1023:512];
                end
                else begin
                    active_xt[0] <= active_xt[0];
                    active_xt[1] <= active_xt[1];
                    active_xt[2] <= active_xt[2];
                    active_xt[3] <= active_xt[3];
                    active_xt[4] <= active_xt[4];
                    active_xt[5] <= active_xt[5];
                    active_xt[6] <= active_xt[6];
                    active_xt[7] <= active_xt[7];
                    active_xt[8] <= active_xt[8];
                    active_xt[9] <= active_xt[9];
                    active_xt[10] <= active_xt[10];
                    active_xt[11] <= active_xt[11];
                    active_xt[12] <= active_xt[12];
                    active_xt[13] <= active_xt[13];
                    active_xt[14] <= active_xt[14];
                    active_xt[15] <= active_xt[15];
                    active_xt[16] <= active_xt[16];
                    active_xt[17] <= active_xt[17];
                    active_xt[18] <= active_xt[18];
                    active_xt[19] <= active_xt[19];
                    active_xt[20] <= active_xt[20];
                    active_xt[21] <= active_xt[21];
                    active_xt[22] <= active_xt[22];
                    active_xt[23] <= active_xt[23];
                    active_xt[24] <= active_xt[24];
                    active_xt[25] <= active_xt[25];
                    active_xt[26] <= active_xt[26];
                    active_xt[27] <= active_xt[27];
                    active_xt[28] <= active_xt[28];
                    active_xt[29] <= active_xt[29];
                    active_xt[30] <= active_xt[30];
                    active_xt[31] <= active_xt[31];
                    active_xt[32] <= active_xt[32];
                    active_xt[33] <= active_xt[33];
                    active_xt[34] <= active_xt[34];
                    active_xt[35] <= active_xt[35];
                    active_xt[36] <= active_xt[36];
                    active_xt[37] <= active_xt[37];
                    active_xt[38] <= active_xt[38];
                    active_xt[39] <= active_xt[39];
                    active_xt[40] <= active_xt[40];
                    active_xt[41] <= active_xt[41];
                    active_xt[42] <= active_xt[42];
                    active_xt[43] <= active_xt[43];
                    active_xt[44] <= active_xt[44];
                    active_xt[45] <= active_xt[45];
                    active_xt[46] <= active_xt[46];
                    active_xt[47] <= active_xt[47];
                    active_xt[48] <= active_xt[48];
                    active_xt[49] <= active_xt[49];
                    active_xt[50] <= active_xt[50];
                    active_xt[51] <= active_xt[51];
                    active_xt[52] <= active_xt[52];
                    active_xt[53] <= active_xt[53];
                    active_xt[54] <= active_xt[54];
                    active_xt[55] <= active_xt[55];
                    active_xt[56] <= active_xt[56];
                    active_xt[57] <= active_xt[57];
                    active_xt[58] <= active_xt[58];
                    active_xt[59] <= active_xt[59];
                    active_xt[60] <= active_xt[60];
                    active_xt[61] <= active_xt[61];
                    active_xt[62] <= active_xt[62];
                    active_xt[63] <= active_xt[63];
                    active_xt[64] <= active_xt[64];
                    active_xt[65] <= active_xt[65];
                    active_xt[66] <= active_xt[66];
                    active_xt[67] <= active_xt[67];
                    active_xt[68] <= active_xt[68];
                    active_xt[69] <= active_xt[69];
                    active_xt[70] <= active_xt[70];
                    active_xt[71] <= active_xt[71];
                    active_xt[72] <= active_xt[72];
                    active_xt[73] <= active_xt[73];
                    active_xt[74] <= active_xt[74];
                    active_xt[75] <= active_xt[75];
                    active_xt[76] <= active_xt[76];
                    active_xt[77] <= active_xt[77];
                    active_xt[78] <= active_xt[78];
                    active_xt[79] <= active_xt[79];
                    active_xt[80] <= active_xt[80];
                    active_xt[81] <= active_xt[81];
                    active_xt[82] <= active_xt[82];
                    active_xt[83] <= active_xt[83];
                    active_xt[84] <= active_xt[84];
                    active_xt[85] <= active_xt[85];
                    active_xt[86] <= active_xt[86];
                    active_xt[87] <= active_xt[87];
                    active_xt[88] <= active_xt[88];
                    active_xt[89] <= active_xt[89];
                    active_xt[90] <= active_xt[90];
                    active_xt[91] <= active_xt[91];
                    active_xt[92] <= active_xt[92];
                    active_xt[93] <= active_xt[93];
                    active_xt[94] <= active_xt[94];
                    active_xt[95] <= active_xt[95];
                    active_xt[96] <= active_xt[96];
                    active_xt[97] <= active_xt[97];
                    active_xt[98] <= active_xt[98];
                    active_xt[99] <= active_xt[99];
                    active_xt[100] <= active_xt[100];
                    active_xt[101] <= active_xt[101];
                    active_xt[102] <= active_xt[102];
                    active_xt[103] <= active_xt[103];
                    active_xt[104] <= active_xt[104];
                    active_xt[105] <= active_xt[105];
                    active_xt[106] <= active_xt[106];
                    active_xt[107] <= active_xt[107];
                    active_xt[108] <= active_xt[108];
                    active_xt[109] <= active_xt[109];
                    active_xt[110] <= active_xt[110];
                    active_xt[111] <= active_xt[111];
                    active_xt[112] <= active_xt[112];
                    active_xt[113] <= active_xt[113];
                    active_xt[114] <= active_xt[114];
                    active_xt[115] <= active_xt[115];
                    active_xt[116] <= active_xt[116];
                    active_xt[117] <= active_xt[117];
                    active_xt[118] <= active_xt[118];
                    active_xt[119] <= active_xt[119];
                    active_xt[120] <= active_xt[120];
                    active_xt[121] <= active_xt[121];
                end
            end
            Load3:begin
                active_xt[122] <= inputx_output[511:0];
                active_xt[123] <= inputx_output[1023:512];
            end
            Load4:begin
                active_xt[124] <= inputx_output[511:0];
                active_xt[125] <= inputx_output[1023:512];
            end
            Wait1:begin
                active_xt[126] <= inputx_output[511:0];
                active_xt[127] <= inputx_output[1023:512];
            end
            default:begin
                active_xt[0] <= active_xt[0];
                active_xt[1] <= active_xt[1];
                active_xt[2] <= active_xt[2];
                active_xt[3] <= active_xt[3];
                active_xt[4] <= active_xt[4];
                active_xt[5] <= active_xt[5];
                active_xt[6] <= active_xt[6];
                active_xt[7] <= active_xt[7];
                active_xt[8] <= active_xt[8];
                active_xt[9] <= active_xt[9];
                active_xt[10] <= active_xt[10];
                active_xt[11] <= active_xt[11];
                active_xt[12] <= active_xt[12];
                active_xt[13] <= active_xt[13];
                active_xt[14] <= active_xt[14];
                active_xt[15] <= active_xt[15];
                active_xt[16] <= active_xt[16];
                active_xt[17] <= active_xt[17];
                active_xt[18] <= active_xt[18];
                active_xt[19] <= active_xt[19];
                active_xt[20] <= active_xt[20];
                active_xt[21] <= active_xt[21];
                active_xt[22] <= active_xt[22];
                active_xt[23] <= active_xt[23];
                active_xt[24] <= active_xt[24];
                active_xt[25] <= active_xt[25];
                active_xt[26] <= active_xt[26];
                active_xt[27] <= active_xt[27];
                active_xt[28] <= active_xt[28];
                active_xt[29] <= active_xt[29];
                active_xt[30] <= active_xt[30];
                active_xt[31] <= active_xt[31];
                active_xt[32] <= active_xt[32];
                active_xt[33] <= active_xt[33];
                active_xt[34] <= active_xt[34];
                active_xt[35] <= active_xt[35];
                active_xt[36] <= active_xt[36];
                active_xt[37] <= active_xt[37];
                active_xt[38] <= active_xt[38];
                active_xt[39] <= active_xt[39];
                active_xt[40] <= active_xt[40];
                active_xt[41] <= active_xt[41];
                active_xt[42] <= active_xt[42];
                active_xt[43] <= active_xt[43];
                active_xt[44] <= active_xt[44];
                active_xt[45] <= active_xt[45];
                active_xt[46] <= active_xt[46];
                active_xt[47] <= active_xt[47];
                active_xt[48] <= active_xt[48];
                active_xt[49] <= active_xt[49];
                active_xt[50] <= active_xt[50];
                active_xt[51] <= active_xt[51];
                active_xt[52] <= active_xt[52];
                active_xt[53] <= active_xt[53];
                active_xt[54] <= active_xt[54];
                active_xt[55] <= active_xt[55];
                active_xt[56] <= active_xt[56];
                active_xt[57] <= active_xt[57];
                active_xt[58] <= active_xt[58];
                active_xt[59] <= active_xt[59];
                active_xt[60] <= active_xt[60];
                active_xt[61] <= active_xt[61];
                active_xt[62] <= active_xt[62];
                active_xt[63] <= active_xt[63];
                active_xt[64] <= active_xt[64];
                active_xt[65] <= active_xt[65];
                active_xt[66] <= active_xt[66];
                active_xt[67] <= active_xt[67];
                active_xt[68] <= active_xt[68];
                active_xt[69] <= active_xt[69];
                active_xt[70] <= active_xt[70];
                active_xt[71] <= active_xt[71];
                active_xt[72] <= active_xt[72];
                active_xt[73] <= active_xt[73];
                active_xt[74] <= active_xt[74];
                active_xt[75] <= active_xt[75];
                active_xt[76] <= active_xt[76];
                active_xt[77] <= active_xt[77];
                active_xt[78] <= active_xt[78];
                active_xt[79] <= active_xt[79];
                active_xt[80] <= active_xt[80];
                active_xt[81] <= active_xt[81];
                active_xt[82] <= active_xt[82];
                active_xt[83] <= active_xt[83];
                active_xt[84] <= active_xt[84];
                active_xt[85] <= active_xt[85];
                active_xt[86] <= active_xt[86];
                active_xt[87] <= active_xt[87];
                active_xt[88] <= active_xt[88];
                active_xt[89] <= active_xt[89];
                active_xt[90] <= active_xt[90];
                active_xt[91] <= active_xt[91];
                active_xt[92] <= active_xt[92];
                active_xt[93] <= active_xt[93];
                active_xt[94] <= active_xt[94];
                active_xt[95] <= active_xt[95];
                active_xt[96] <= active_xt[96];
                active_xt[97] <= active_xt[97];
                active_xt[98] <= active_xt[98];
                active_xt[99] <= active_xt[99];
                active_xt[100] <= active_xt[100];
                active_xt[101] <= active_xt[101];
                active_xt[102] <= active_xt[102];
                active_xt[103] <= active_xt[103];
                active_xt[104] <= active_xt[104];
                active_xt[105] <= active_xt[105];
                active_xt[106] <= active_xt[106];
                active_xt[107] <= active_xt[107];
                active_xt[108] <= active_xt[108];
                active_xt[109] <= active_xt[109];
                active_xt[110] <= active_xt[110];
                active_xt[111] <= active_xt[111];
                active_xt[112] <= active_xt[112];
                active_xt[113] <= active_xt[113];
                active_xt[114] <= active_xt[114];
                active_xt[115] <= active_xt[115];
                active_xt[116] <= active_xt[116];
                active_xt[117] <= active_xt[117];
                active_xt[118] <= active_xt[118];
                active_xt[119] <= active_xt[119];
                active_xt[120] <= active_xt[120];
                active_xt[121] <= active_xt[121];
                active_xt[122] <= active_xt[122];
                active_xt[123] <= active_xt[123];
                active_xt[124] <= active_xt[124];
                active_xt[125] <= active_xt[125];
                active_xt[126] <= active_xt[126];
                active_xt[127] <= active_xt[127];
            end
            endcase
        end
end


always @ (posedge clk) begin    // the state machine to add temp_result_64
        if(!rst) begin
            temp_result_64[0] <= 'd0;
            temp_result_64[1] <= 'd0;
            temp_result_64[2] <= 'd0;
            temp_result_64[3] <= 'd0;
            temp_result_64[4] <= 'd0;
            temp_result_64[5] <= 'd0;
            temp_result_64[6] <= 'd0;
            temp_result_64[7] <= 'd0;
            temp_result_64[8] <= 'd0;
            temp_result_64[9] <= 'd0;
            temp_result_64[10] <= 'd0;
            temp_result_64[11] <= 'd0;
            temp_result_64[12] <= 'd0;
            temp_result_64[13] <= 'd0;
            temp_result_64[14] <= 'd0;
            temp_result_64[15] <= 'd0;
            temp_result_64[16] <= 'd0;
            temp_result_64[17] <= 'd0;
            temp_result_64[18] <= 'd0;
            temp_result_64[19] <= 'd0;
            temp_result_64[20] <= 'd0;
            temp_result_64[21] <= 'd0;
            temp_result_64[22] <= 'd0;
            temp_result_64[23] <= 'd0;
            temp_result_64[24] <= 'd0;
            temp_result_64[25] <= 'd0;
            temp_result_64[26] <= 'd0;
            temp_result_64[27] <= 'd0;
            temp_result_64[28] <= 'd0;
            temp_result_64[29] <= 'd0;
            temp_result_64[30] <= 'd0;
            temp_result_64[31] <= 'd0;
            temp_result_64[32] <= 'd0;
            temp_result_64[33] <= 'd0;
            temp_result_64[34] <= 'd0;
            temp_result_64[35] <= 'd0;
            temp_result_64[36] <= 'd0;
            temp_result_64[37] <= 'd0;
            temp_result_64[38] <= 'd0;
            temp_result_64[39] <= 'd0;
            temp_result_64[40] <= 'd0;
            temp_result_64[41] <= 'd0;
            temp_result_64[42] <= 'd0;
            temp_result_64[43] <= 'd0;
            temp_result_64[44] <= 'd0;
            temp_result_64[45] <= 'd0;
            temp_result_64[46] <= 'd0;
            temp_result_64[47] <= 'd0;
            temp_result_64[48] <= 'd0;
            temp_result_64[49] <= 'd0;
            temp_result_64[50] <= 'd0;
            temp_result_64[51] <= 'd0;
            temp_result_64[52] <= 'd0;
            temp_result_64[53] <= 'd0;
            temp_result_64[54] <= 'd0;
            temp_result_64[55] <= 'd0;
            temp_result_64[56] <= 'd0;
            temp_result_64[57] <= 'd0;
            temp_result_64[58] <= 'd0;
            temp_result_64[59] <= 'd0;
            temp_result_64[60] <= 'd0;
            temp_result_64[61] <= 'd0;
            temp_result_64[62] <= 'd0;
            temp_result_64[63] <= 'd0;
        end
        else if (idle) begin
            temp_result_64[0] <= 'd0;
            temp_result_64[1] <= 'd0;
            temp_result_64[2] <= 'd0;
            temp_result_64[3] <= 'd0;
            temp_result_64[4] <= 'd0;
            temp_result_64[5] <= 'd0;
            temp_result_64[6] <= 'd0;
            temp_result_64[7] <= 'd0;
            temp_result_64[8] <= 'd0;
            temp_result_64[9] <= 'd0;
            temp_result_64[10] <= 'd0;
            temp_result_64[11] <= 'd0;
            temp_result_64[12] <= 'd0;
            temp_result_64[13] <= 'd0;
            temp_result_64[14] <= 'd0;
            temp_result_64[15] <= 'd0;
            temp_result_64[16] <= 'd0;
            temp_result_64[17] <= 'd0;
            temp_result_64[18] <= 'd0;
            temp_result_64[19] <= 'd0;
            temp_result_64[20] <= 'd0;
            temp_result_64[21] <= 'd0;
            temp_result_64[22] <= 'd0;
            temp_result_64[23] <= 'd0;
            temp_result_64[24] <= 'd0;
            temp_result_64[25] <= 'd0;
            temp_result_64[26] <= 'd0;
            temp_result_64[27] <= 'd0;
            temp_result_64[28] <= 'd0;
            temp_result_64[29] <= 'd0;
            temp_result_64[30] <= 'd0;
            temp_result_64[31] <= 'd0;
            temp_result_64[32] <= 'd0;
            temp_result_64[33] <= 'd0;
            temp_result_64[34] <= 'd0;
            temp_result_64[35] <= 'd0;
            temp_result_64[36] <= 'd0;
            temp_result_64[37] <= 'd0;
            temp_result_64[38] <= 'd0;
            temp_result_64[39] <= 'd0;
            temp_result_64[40] <= 'd0;
            temp_result_64[41] <= 'd0;
            temp_result_64[42] <= 'd0;
            temp_result_64[43] <= 'd0;
            temp_result_64[44] <= 'd0;
            temp_result_64[45] <= 'd0;
            temp_result_64[46] <= 'd0;
            temp_result_64[47] <= 'd0;
            temp_result_64[48] <= 'd0;
            temp_result_64[49] <= 'd0;
            temp_result_64[50] <= 'd0;
            temp_result_64[51] <= 'd0;
            temp_result_64[52] <= 'd0;
            temp_result_64[53] <= 'd0;
            temp_result_64[54] <= 'd0;
            temp_result_64[55] <= 'd0;
            temp_result_64[56] <= 'd0;
            temp_result_64[57] <= 'd0;
            temp_result_64[58] <= 'd0;
            temp_result_64[59] <= 'd0;
            temp_result_64[60] <= 'd0;
            temp_result_64[61] <= 'd0;
            temp_result_64[62] <= 'd0;
            temp_result_64[63] <= 'd0;
        end
        else begin
            case(state)
            Wait_Add128to64:begin
                temp_result_64[0] <= temp_result_128[0] + temp_result_128[1];
                temp_result_64[1] <= temp_result_128[2] + temp_result_128[3];
                temp_result_64[2] <= temp_result_128[4] + temp_result_128[5];
                temp_result_64[3] <= temp_result_128[6] + temp_result_128[7];
                temp_result_64[4] <= temp_result_128[8] + temp_result_128[9];
                temp_result_64[5] <= temp_result_128[10] + temp_result_128[11];
                temp_result_64[6] <= temp_result_128[12] + temp_result_128[13];
                temp_result_64[7] <= temp_result_128[14] + temp_result_128[15];
                temp_result_64[8] <= temp_result_128[16] + temp_result_128[17];
                temp_result_64[9] <= temp_result_128[18] + temp_result_128[19];
                temp_result_64[10] <= temp_result_128[20] + temp_result_128[21];
                temp_result_64[11] <= temp_result_128[22] + temp_result_128[23];
                temp_result_64[12] <= temp_result_128[24] + temp_result_128[25];
                temp_result_64[13] <= temp_result_128[26] + temp_result_128[27];
                temp_result_64[14] <= temp_result_128[28] + temp_result_128[29];
                temp_result_64[15] <= temp_result_128[30] + temp_result_128[31];
                temp_result_64[16] <= temp_result_128[32] + temp_result_128[33];
                temp_result_64[17] <= temp_result_128[34] + temp_result_128[35];
                temp_result_64[18] <= temp_result_128[36] + temp_result_128[37];
                temp_result_64[19] <= temp_result_128[38] + temp_result_128[39];
                temp_result_64[20] <= temp_result_128[40] + temp_result_128[41];
                temp_result_64[21] <= temp_result_128[42] + temp_result_128[43];
                temp_result_64[22] <= temp_result_128[44] + temp_result_128[45];
                temp_result_64[23] <= temp_result_128[46] + temp_result_128[47];
                temp_result_64[24] <= temp_result_128[48] + temp_result_128[49];
                temp_result_64[25] <= temp_result_128[50] + temp_result_128[51];
                temp_result_64[26] <= temp_result_128[52] + temp_result_128[53];
                temp_result_64[27] <= temp_result_128[54] + temp_result_128[55];
                temp_result_64[28] <= temp_result_128[56] + temp_result_128[57];
                temp_result_64[29] <= temp_result_128[58] + temp_result_128[59];
                temp_result_64[30] <= temp_result_128[60] + temp_result_128[61];
                temp_result_64[31] <= temp_result_128[62] + temp_result_128[63];
                temp_result_64[32] <= temp_result_128[64] + temp_result_128[65];
                temp_result_64[33] <= temp_result_128[66] + temp_result_128[67];
                temp_result_64[34] <= temp_result_128[68] + temp_result_128[69];
                temp_result_64[35] <= temp_result_128[70] + temp_result_128[71];
                temp_result_64[36] <= temp_result_128[72] + temp_result_128[73];
                temp_result_64[37] <= temp_result_128[74] + temp_result_128[75];
                temp_result_64[38] <= temp_result_128[76] + temp_result_128[77];
                temp_result_64[39] <= temp_result_128[78] + temp_result_128[79];
                temp_result_64[40] <= temp_result_128[80] + temp_result_128[81];
                temp_result_64[41] <= temp_result_128[82] + temp_result_128[83];
                temp_result_64[42] <= temp_result_128[84] + temp_result_128[85];
                temp_result_64[43] <= temp_result_128[86] + temp_result_128[87];
                temp_result_64[44] <= temp_result_128[88] + temp_result_128[89];
                temp_result_64[45] <= temp_result_128[90] + temp_result_128[91];
                temp_result_64[46] <= temp_result_128[92] + temp_result_128[93];
                temp_result_64[47] <= temp_result_128[94] + temp_result_128[95];
                temp_result_64[48] <= temp_result_128[96] + temp_result_128[97];
                temp_result_64[49] <= temp_result_128[98] + temp_result_128[99];
                temp_result_64[50] <= temp_result_128[100] + temp_result_128[101];
                temp_result_64[51] <= temp_result_128[102] + temp_result_128[103];
                temp_result_64[52] <= temp_result_128[104] + temp_result_128[105];
                temp_result_64[53] <= temp_result_128[106] + temp_result_128[107];
                temp_result_64[54] <= temp_result_128[108] + temp_result_128[109];
                temp_result_64[55] <= temp_result_128[110] + temp_result_128[111];
                temp_result_64[56] <= temp_result_128[112] + temp_result_128[113];
                temp_result_64[57] <= temp_result_128[114] + temp_result_128[115];
                temp_result_64[58] <= temp_result_128[116] + temp_result_128[117];
                temp_result_64[59] <= temp_result_128[118] + temp_result_128[119];
                temp_result_64[60] <= temp_result_128[120] + temp_result_128[121];
                temp_result_64[61] <= temp_result_128[122] + temp_result_128[123];
                temp_result_64[62] <= temp_result_128[124] + temp_result_128[125];
                temp_result_64[63] <= temp_result_128[126] + temp_result_128[127];
            end

            Wait_Add128to64_64to32:begin
                temp_result_64[0] <= temp_result_128[0] + temp_result_128[1];
                temp_result_64[1] <= temp_result_128[2] + temp_result_128[3];
                temp_result_64[2] <= temp_result_128[4] + temp_result_128[5];
                temp_result_64[3] <= temp_result_128[6] + temp_result_128[7];
                temp_result_64[4] <= temp_result_128[8] + temp_result_128[9];
                temp_result_64[5] <= temp_result_128[10] + temp_result_128[11];
                temp_result_64[6] <= temp_result_128[12] + temp_result_128[13];
                temp_result_64[7] <= temp_result_128[14] + temp_result_128[15];
                temp_result_64[8] <= temp_result_128[16] + temp_result_128[17];
                temp_result_64[9] <= temp_result_128[18] + temp_result_128[19];
                temp_result_64[10] <= temp_result_128[20] + temp_result_128[21];
                temp_result_64[11] <= temp_result_128[22] + temp_result_128[23];
                temp_result_64[12] <= temp_result_128[24] + temp_result_128[25];
                temp_result_64[13] <= temp_result_128[26] + temp_result_128[27];
                temp_result_64[14] <= temp_result_128[28] + temp_result_128[29];
                temp_result_64[15] <= temp_result_128[30] + temp_result_128[31];
                temp_result_64[16] <= temp_result_128[32] + temp_result_128[33];
                temp_result_64[17] <= temp_result_128[34] + temp_result_128[35];
                temp_result_64[18] <= temp_result_128[36] + temp_result_128[37];
                temp_result_64[19] <= temp_result_128[38] + temp_result_128[39];
                temp_result_64[20] <= temp_result_128[40] + temp_result_128[41];
                temp_result_64[21] <= temp_result_128[42] + temp_result_128[43];
                temp_result_64[22] <= temp_result_128[44] + temp_result_128[45];
                temp_result_64[23] <= temp_result_128[46] + temp_result_128[47];
                temp_result_64[24] <= temp_result_128[48] + temp_result_128[49];
                temp_result_64[25] <= temp_result_128[50] + temp_result_128[51];
                temp_result_64[26] <= temp_result_128[52] + temp_result_128[53];
                temp_result_64[27] <= temp_result_128[54] + temp_result_128[55];
                temp_result_64[28] <= temp_result_128[56] + temp_result_128[57];
                temp_result_64[29] <= temp_result_128[58] + temp_result_128[59];
                temp_result_64[30] <= temp_result_128[60] + temp_result_128[61];
                temp_result_64[31] <= temp_result_128[62] + temp_result_128[63];
                temp_result_64[32] <= temp_result_128[64] + temp_result_128[65];
                temp_result_64[33] <= temp_result_128[66] + temp_result_128[67];
                temp_result_64[34] <= temp_result_128[68] + temp_result_128[69];
                temp_result_64[35] <= temp_result_128[70] + temp_result_128[71];
                temp_result_64[36] <= temp_result_128[72] + temp_result_128[73];
                temp_result_64[37] <= temp_result_128[74] + temp_result_128[75];
                temp_result_64[38] <= temp_result_128[76] + temp_result_128[77];
                temp_result_64[39] <= temp_result_128[78] + temp_result_128[79];
                temp_result_64[40] <= temp_result_128[80] + temp_result_128[81];
                temp_result_64[41] <= temp_result_128[82] + temp_result_128[83];
                temp_result_64[42] <= temp_result_128[84] + temp_result_128[85];
                temp_result_64[43] <= temp_result_128[86] + temp_result_128[87];
                temp_result_64[44] <= temp_result_128[88] + temp_result_128[89];
                temp_result_64[45] <= temp_result_128[90] + temp_result_128[91];
                temp_result_64[46] <= temp_result_128[92] + temp_result_128[93];
                temp_result_64[47] <= temp_result_128[94] + temp_result_128[95];
                temp_result_64[48] <= temp_result_128[96] + temp_result_128[97];
                temp_result_64[49] <= temp_result_128[98] + temp_result_128[99];
                temp_result_64[50] <= temp_result_128[100] + temp_result_128[101];
                temp_result_64[51] <= temp_result_128[102] + temp_result_128[103];
                temp_result_64[52] <= temp_result_128[104] + temp_result_128[105];
                temp_result_64[53] <= temp_result_128[106] + temp_result_128[107];
                temp_result_64[54] <= temp_result_128[108] + temp_result_128[109];
                temp_result_64[55] <= temp_result_128[110] + temp_result_128[111];
                temp_result_64[56] <= temp_result_128[112] + temp_result_128[113];
                temp_result_64[57] <= temp_result_128[114] + temp_result_128[115];
                temp_result_64[58] <= temp_result_128[116] + temp_result_128[117];
                temp_result_64[59] <= temp_result_128[118] + temp_result_128[119];
                temp_result_64[60] <= temp_result_128[120] + temp_result_128[121];
                temp_result_64[61] <= temp_result_128[122] + temp_result_128[123];
                temp_result_64[62] <= temp_result_128[124] + temp_result_128[125];
                temp_result_64[63] <= temp_result_128[126] + temp_result_128[127];
            end

            Wait_Add128to64_64to32_32to16:begin
                temp_result_64[0] <= temp_result_128[0] + temp_result_128[1];
                temp_result_64[1] <= temp_result_128[2] + temp_result_128[3];
                temp_result_64[2] <= temp_result_128[4] + temp_result_128[5];
                temp_result_64[3] <= temp_result_128[6] + temp_result_128[7];
                temp_result_64[4] <= temp_result_128[8] + temp_result_128[9];
                temp_result_64[5] <= temp_result_128[10] + temp_result_128[11];
                temp_result_64[6] <= temp_result_128[12] + temp_result_128[13];
                temp_result_64[7] <= temp_result_128[14] + temp_result_128[15];
                temp_result_64[8] <= temp_result_128[16] + temp_result_128[17];
                temp_result_64[9] <= temp_result_128[18] + temp_result_128[19];
                temp_result_64[10] <= temp_result_128[20] + temp_result_128[21];
                temp_result_64[11] <= temp_result_128[22] + temp_result_128[23];
                temp_result_64[12] <= temp_result_128[24] + temp_result_128[25];
                temp_result_64[13] <= temp_result_128[26] + temp_result_128[27];
                temp_result_64[14] <= temp_result_128[28] + temp_result_128[29];
                temp_result_64[15] <= temp_result_128[30] + temp_result_128[31];
                temp_result_64[16] <= temp_result_128[32] + temp_result_128[33];
                temp_result_64[17] <= temp_result_128[34] + temp_result_128[35];
                temp_result_64[18] <= temp_result_128[36] + temp_result_128[37];
                temp_result_64[19] <= temp_result_128[38] + temp_result_128[39];
                temp_result_64[20] <= temp_result_128[40] + temp_result_128[41];
                temp_result_64[21] <= temp_result_128[42] + temp_result_128[43];
                temp_result_64[22] <= temp_result_128[44] + temp_result_128[45];
                temp_result_64[23] <= temp_result_128[46] + temp_result_128[47];
                temp_result_64[24] <= temp_result_128[48] + temp_result_128[49];
                temp_result_64[25] <= temp_result_128[50] + temp_result_128[51];
                temp_result_64[26] <= temp_result_128[52] + temp_result_128[53];
                temp_result_64[27] <= temp_result_128[54] + temp_result_128[55];
                temp_result_64[28] <= temp_result_128[56] + temp_result_128[57];
                temp_result_64[29] <= temp_result_128[58] + temp_result_128[59];
                temp_result_64[30] <= temp_result_128[60] + temp_result_128[61];
                temp_result_64[31] <= temp_result_128[62] + temp_result_128[63];
                temp_result_64[32] <= temp_result_128[64] + temp_result_128[65];
                temp_result_64[33] <= temp_result_128[66] + temp_result_128[67];
                temp_result_64[34] <= temp_result_128[68] + temp_result_128[69];
                temp_result_64[35] <= temp_result_128[70] + temp_result_128[71];
                temp_result_64[36] <= temp_result_128[72] + temp_result_128[73];
                temp_result_64[37] <= temp_result_128[74] + temp_result_128[75];
                temp_result_64[38] <= temp_result_128[76] + temp_result_128[77];
                temp_result_64[39] <= temp_result_128[78] + temp_result_128[79];
                temp_result_64[40] <= temp_result_128[80] + temp_result_128[81];
                temp_result_64[41] <= temp_result_128[82] + temp_result_128[83];
                temp_result_64[42] <= temp_result_128[84] + temp_result_128[85];
                temp_result_64[43] <= temp_result_128[86] + temp_result_128[87];
                temp_result_64[44] <= temp_result_128[88] + temp_result_128[89];
                temp_result_64[45] <= temp_result_128[90] + temp_result_128[91];
                temp_result_64[46] <= temp_result_128[92] + temp_result_128[93];
                temp_result_64[47] <= temp_result_128[94] + temp_result_128[95];
                temp_result_64[48] <= temp_result_128[96] + temp_result_128[97];
                temp_result_64[49] <= temp_result_128[98] + temp_result_128[99];
                temp_result_64[50] <= temp_result_128[100] + temp_result_128[101];
                temp_result_64[51] <= temp_result_128[102] + temp_result_128[103];
                temp_result_64[52] <= temp_result_128[104] + temp_result_128[105];
                temp_result_64[53] <= temp_result_128[106] + temp_result_128[107];
                temp_result_64[54] <= temp_result_128[108] + temp_result_128[109];
                temp_result_64[55] <= temp_result_128[110] + temp_result_128[111];
                temp_result_64[56] <= temp_result_128[112] + temp_result_128[113];
                temp_result_64[57] <= temp_result_128[114] + temp_result_128[115];
                temp_result_64[58] <= temp_result_128[116] + temp_result_128[117];
                temp_result_64[59] <= temp_result_128[118] + temp_result_128[119];
                temp_result_64[60] <= temp_result_128[120] + temp_result_128[121];
                temp_result_64[61] <= temp_result_128[122] + temp_result_128[123];
                temp_result_64[62] <= temp_result_128[124] + temp_result_128[125];
                temp_result_64[63] <= temp_result_128[126] + temp_result_128[127];
            end

            Wait_Add128to64_64to32_32to16_16to8:begin
                temp_result_64[0] <= temp_result_128[0] + temp_result_128[1];
                temp_result_64[1] <= temp_result_128[2] + temp_result_128[3];
                temp_result_64[2] <= temp_result_128[4] + temp_result_128[5];
                temp_result_64[3] <= temp_result_128[6] + temp_result_128[7];
                temp_result_64[4] <= temp_result_128[8] + temp_result_128[9];
                temp_result_64[5] <= temp_result_128[10] + temp_result_128[11];
                temp_result_64[6] <= temp_result_128[12] + temp_result_128[13];
                temp_result_64[7] <= temp_result_128[14] + temp_result_128[15];
                temp_result_64[8] <= temp_result_128[16] + temp_result_128[17];
                temp_result_64[9] <= temp_result_128[18] + temp_result_128[19];
                temp_result_64[10] <= temp_result_128[20] + temp_result_128[21];
                temp_result_64[11] <= temp_result_128[22] + temp_result_128[23];
                temp_result_64[12] <= temp_result_128[24] + temp_result_128[25];
                temp_result_64[13] <= temp_result_128[26] + temp_result_128[27];
                temp_result_64[14] <= temp_result_128[28] + temp_result_128[29];
                temp_result_64[15] <= temp_result_128[30] + temp_result_128[31];
                temp_result_64[16] <= temp_result_128[32] + temp_result_128[33];
                temp_result_64[17] <= temp_result_128[34] + temp_result_128[35];
                temp_result_64[18] <= temp_result_128[36] + temp_result_128[37];
                temp_result_64[19] <= temp_result_128[38] + temp_result_128[39];
                temp_result_64[20] <= temp_result_128[40] + temp_result_128[41];
                temp_result_64[21] <= temp_result_128[42] + temp_result_128[43];
                temp_result_64[22] <= temp_result_128[44] + temp_result_128[45];
                temp_result_64[23] <= temp_result_128[46] + temp_result_128[47];
                temp_result_64[24] <= temp_result_128[48] + temp_result_128[49];
                temp_result_64[25] <= temp_result_128[50] + temp_result_128[51];
                temp_result_64[26] <= temp_result_128[52] + temp_result_128[53];
                temp_result_64[27] <= temp_result_128[54] + temp_result_128[55];
                temp_result_64[28] <= temp_result_128[56] + temp_result_128[57];
                temp_result_64[29] <= temp_result_128[58] + temp_result_128[59];
                temp_result_64[30] <= temp_result_128[60] + temp_result_128[61];
                temp_result_64[31] <= temp_result_128[62] + temp_result_128[63];
                temp_result_64[32] <= temp_result_128[64] + temp_result_128[65];
                temp_result_64[33] <= temp_result_128[66] + temp_result_128[67];
                temp_result_64[34] <= temp_result_128[68] + temp_result_128[69];
                temp_result_64[35] <= temp_result_128[70] + temp_result_128[71];
                temp_result_64[36] <= temp_result_128[72] + temp_result_128[73];
                temp_result_64[37] <= temp_result_128[74] + temp_result_128[75];
                temp_result_64[38] <= temp_result_128[76] + temp_result_128[77];
                temp_result_64[39] <= temp_result_128[78] + temp_result_128[79];
                temp_result_64[40] <= temp_result_128[80] + temp_result_128[81];
                temp_result_64[41] <= temp_result_128[82] + temp_result_128[83];
                temp_result_64[42] <= temp_result_128[84] + temp_result_128[85];
                temp_result_64[43] <= temp_result_128[86] + temp_result_128[87];
                temp_result_64[44] <= temp_result_128[88] + temp_result_128[89];
                temp_result_64[45] <= temp_result_128[90] + temp_result_128[91];
                temp_result_64[46] <= temp_result_128[92] + temp_result_128[93];
                temp_result_64[47] <= temp_result_128[94] + temp_result_128[95];
                temp_result_64[48] <= temp_result_128[96] + temp_result_128[97];
                temp_result_64[49] <= temp_result_128[98] + temp_result_128[99];
                temp_result_64[50] <= temp_result_128[100] + temp_result_128[101];
                temp_result_64[51] <= temp_result_128[102] + temp_result_128[103];
                temp_result_64[52] <= temp_result_128[104] + temp_result_128[105];
                temp_result_64[53] <= temp_result_128[106] + temp_result_128[107];
                temp_result_64[54] <= temp_result_128[108] + temp_result_128[109];
                temp_result_64[55] <= temp_result_128[110] + temp_result_128[111];
                temp_result_64[56] <= temp_result_128[112] + temp_result_128[113];
                temp_result_64[57] <= temp_result_128[114] + temp_result_128[115];
                temp_result_64[58] <= temp_result_128[116] + temp_result_128[117];
                temp_result_64[59] <= temp_result_128[118] + temp_result_128[119];
                temp_result_64[60] <= temp_result_128[120] + temp_result_128[121];
                temp_result_64[61] <= temp_result_128[122] + temp_result_128[123];
                temp_result_64[62] <= temp_result_128[124] + temp_result_128[125];
                temp_result_64[63] <= temp_result_128[126] + temp_result_128[127];
            end
            
            Wait_Add128to64_64to32_32to16_16to8_8to4:begin
                temp_result_64[0] <= temp_result_128[0] + temp_result_128[1];
                temp_result_64[1] <= temp_result_128[2] + temp_result_128[3];
                temp_result_64[2] <= temp_result_128[4] + temp_result_128[5];
                temp_result_64[3] <= temp_result_128[6] + temp_result_128[7];
                temp_result_64[4] <= temp_result_128[8] + temp_result_128[9];
                temp_result_64[5] <= temp_result_128[10] + temp_result_128[11];
                temp_result_64[6] <= temp_result_128[12] + temp_result_128[13];
                temp_result_64[7] <= temp_result_128[14] + temp_result_128[15];
                temp_result_64[8] <= temp_result_128[16] + temp_result_128[17];
                temp_result_64[9] <= temp_result_128[18] + temp_result_128[19];
                temp_result_64[10] <= temp_result_128[20] + temp_result_128[21];
                temp_result_64[11] <= temp_result_128[22] + temp_result_128[23];
                temp_result_64[12] <= temp_result_128[24] + temp_result_128[25];
                temp_result_64[13] <= temp_result_128[26] + temp_result_128[27];
                temp_result_64[14] <= temp_result_128[28] + temp_result_128[29];
                temp_result_64[15] <= temp_result_128[30] + temp_result_128[31];
                temp_result_64[16] <= temp_result_128[32] + temp_result_128[33];
                temp_result_64[17] <= temp_result_128[34] + temp_result_128[35];
                temp_result_64[18] <= temp_result_128[36] + temp_result_128[37];
                temp_result_64[19] <= temp_result_128[38] + temp_result_128[39];
                temp_result_64[20] <= temp_result_128[40] + temp_result_128[41];
                temp_result_64[21] <= temp_result_128[42] + temp_result_128[43];
                temp_result_64[22] <= temp_result_128[44] + temp_result_128[45];
                temp_result_64[23] <= temp_result_128[46] + temp_result_128[47];
                temp_result_64[24] <= temp_result_128[48] + temp_result_128[49];
                temp_result_64[25] <= temp_result_128[50] + temp_result_128[51];
                temp_result_64[26] <= temp_result_128[52] + temp_result_128[53];
                temp_result_64[27] <= temp_result_128[54] + temp_result_128[55];
                temp_result_64[28] <= temp_result_128[56] + temp_result_128[57];
                temp_result_64[29] <= temp_result_128[58] + temp_result_128[59];
                temp_result_64[30] <= temp_result_128[60] + temp_result_128[61];
                temp_result_64[31] <= temp_result_128[62] + temp_result_128[63];
                temp_result_64[32] <= temp_result_128[64] + temp_result_128[65];
                temp_result_64[33] <= temp_result_128[66] + temp_result_128[67];
                temp_result_64[34] <= temp_result_128[68] + temp_result_128[69];
                temp_result_64[35] <= temp_result_128[70] + temp_result_128[71];
                temp_result_64[36] <= temp_result_128[72] + temp_result_128[73];
                temp_result_64[37] <= temp_result_128[74] + temp_result_128[75];
                temp_result_64[38] <= temp_result_128[76] + temp_result_128[77];
                temp_result_64[39] <= temp_result_128[78] + temp_result_128[79];
                temp_result_64[40] <= temp_result_128[80] + temp_result_128[81];
                temp_result_64[41] <= temp_result_128[82] + temp_result_128[83];
                temp_result_64[42] <= temp_result_128[84] + temp_result_128[85];
                temp_result_64[43] <= temp_result_128[86] + temp_result_128[87];
                temp_result_64[44] <= temp_result_128[88] + temp_result_128[89];
                temp_result_64[45] <= temp_result_128[90] + temp_result_128[91];
                temp_result_64[46] <= temp_result_128[92] + temp_result_128[93];
                temp_result_64[47] <= temp_result_128[94] + temp_result_128[95];
                temp_result_64[48] <= temp_result_128[96] + temp_result_128[97];
                temp_result_64[49] <= temp_result_128[98] + temp_result_128[99];
                temp_result_64[50] <= temp_result_128[100] + temp_result_128[101];
                temp_result_64[51] <= temp_result_128[102] + temp_result_128[103];
                temp_result_64[52] <= temp_result_128[104] + temp_result_128[105];
                temp_result_64[53] <= temp_result_128[106] + temp_result_128[107];
                temp_result_64[54] <= temp_result_128[108] + temp_result_128[109];
                temp_result_64[55] <= temp_result_128[110] + temp_result_128[111];
                temp_result_64[56] <= temp_result_128[112] + temp_result_128[113];
                temp_result_64[57] <= temp_result_128[114] + temp_result_128[115];
                temp_result_64[58] <= temp_result_128[116] + temp_result_128[117];
                temp_result_64[59] <= temp_result_128[118] + temp_result_128[119];
                temp_result_64[60] <= temp_result_128[120] + temp_result_128[121];
                temp_result_64[61] <= temp_result_128[122] + temp_result_128[123];
                temp_result_64[62] <= temp_result_128[124] + temp_result_128[125];
                temp_result_64[63] <= temp_result_128[126] + temp_result_128[127];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2:begin
                temp_result_64[0] <= temp_result_128[0] + temp_result_128[1];
                temp_result_64[1] <= temp_result_128[2] + temp_result_128[3];
                temp_result_64[2] <= temp_result_128[4] + temp_result_128[5];
                temp_result_64[3] <= temp_result_128[6] + temp_result_128[7];
                temp_result_64[4] <= temp_result_128[8] + temp_result_128[9];
                temp_result_64[5] <= temp_result_128[10] + temp_result_128[11];
                temp_result_64[6] <= temp_result_128[12] + temp_result_128[13];
                temp_result_64[7] <= temp_result_128[14] + temp_result_128[15];
                temp_result_64[8] <= temp_result_128[16] + temp_result_128[17];
                temp_result_64[9] <= temp_result_128[18] + temp_result_128[19];
                temp_result_64[10] <= temp_result_128[20] + temp_result_128[21];
                temp_result_64[11] <= temp_result_128[22] + temp_result_128[23];
                temp_result_64[12] <= temp_result_128[24] + temp_result_128[25];
                temp_result_64[13] <= temp_result_128[26] + temp_result_128[27];
                temp_result_64[14] <= temp_result_128[28] + temp_result_128[29];
                temp_result_64[15] <= temp_result_128[30] + temp_result_128[31];
                temp_result_64[16] <= temp_result_128[32] + temp_result_128[33];
                temp_result_64[17] <= temp_result_128[34] + temp_result_128[35];
                temp_result_64[18] <= temp_result_128[36] + temp_result_128[37];
                temp_result_64[19] <= temp_result_128[38] + temp_result_128[39];
                temp_result_64[20] <= temp_result_128[40] + temp_result_128[41];
                temp_result_64[21] <= temp_result_128[42] + temp_result_128[43];
                temp_result_64[22] <= temp_result_128[44] + temp_result_128[45];
                temp_result_64[23] <= temp_result_128[46] + temp_result_128[47];
                temp_result_64[24] <= temp_result_128[48] + temp_result_128[49];
                temp_result_64[25] <= temp_result_128[50] + temp_result_128[51];
                temp_result_64[26] <= temp_result_128[52] + temp_result_128[53];
                temp_result_64[27] <= temp_result_128[54] + temp_result_128[55];
                temp_result_64[28] <= temp_result_128[56] + temp_result_128[57];
                temp_result_64[29] <= temp_result_128[58] + temp_result_128[59];
                temp_result_64[30] <= temp_result_128[60] + temp_result_128[61];
                temp_result_64[31] <= temp_result_128[62] + temp_result_128[63];
                temp_result_64[32] <= temp_result_128[64] + temp_result_128[65];
                temp_result_64[33] <= temp_result_128[66] + temp_result_128[67];
                temp_result_64[34] <= temp_result_128[68] + temp_result_128[69];
                temp_result_64[35] <= temp_result_128[70] + temp_result_128[71];
                temp_result_64[36] <= temp_result_128[72] + temp_result_128[73];
                temp_result_64[37] <= temp_result_128[74] + temp_result_128[75];
                temp_result_64[38] <= temp_result_128[76] + temp_result_128[77];
                temp_result_64[39] <= temp_result_128[78] + temp_result_128[79];
                temp_result_64[40] <= temp_result_128[80] + temp_result_128[81];
                temp_result_64[41] <= temp_result_128[82] + temp_result_128[83];
                temp_result_64[42] <= temp_result_128[84] + temp_result_128[85];
                temp_result_64[43] <= temp_result_128[86] + temp_result_128[87];
                temp_result_64[44] <= temp_result_128[88] + temp_result_128[89];
                temp_result_64[45] <= temp_result_128[90] + temp_result_128[91];
                temp_result_64[46] <= temp_result_128[92] + temp_result_128[93];
                temp_result_64[47] <= temp_result_128[94] + temp_result_128[95];
                temp_result_64[48] <= temp_result_128[96] + temp_result_128[97];
                temp_result_64[49] <= temp_result_128[98] + temp_result_128[99];
                temp_result_64[50] <= temp_result_128[100] + temp_result_128[101];
                temp_result_64[51] <= temp_result_128[102] + temp_result_128[103];
                temp_result_64[52] <= temp_result_128[104] + temp_result_128[105];
                temp_result_64[53] <= temp_result_128[106] + temp_result_128[107];
                temp_result_64[54] <= temp_result_128[108] + temp_result_128[109];
                temp_result_64[55] <= temp_result_128[110] + temp_result_128[111];
                temp_result_64[56] <= temp_result_128[112] + temp_result_128[113];
                temp_result_64[57] <= temp_result_128[114] + temp_result_128[115];
                temp_result_64[58] <= temp_result_128[116] + temp_result_128[117];
                temp_result_64[59] <= temp_result_128[118] + temp_result_128[119];
                temp_result_64[60] <= temp_result_128[120] + temp_result_128[121];
                temp_result_64[61] <= temp_result_128[122] + temp_result_128[123];
                temp_result_64[62] <= temp_result_128[124] + temp_result_128[125];
                temp_result_64[63] <= temp_result_128[126] + temp_result_128[127];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_64[0] <= temp_result_128[0] + temp_result_128[1];
                temp_result_64[1] <= temp_result_128[2] + temp_result_128[3];
                temp_result_64[2] <= temp_result_128[4] + temp_result_128[5];
                temp_result_64[3] <= temp_result_128[6] + temp_result_128[7];
                temp_result_64[4] <= temp_result_128[8] + temp_result_128[9];
                temp_result_64[5] <= temp_result_128[10] + temp_result_128[11];
                temp_result_64[6] <= temp_result_128[12] + temp_result_128[13];
                temp_result_64[7] <= temp_result_128[14] + temp_result_128[15];
                temp_result_64[8] <= temp_result_128[16] + temp_result_128[17];
                temp_result_64[9] <= temp_result_128[18] + temp_result_128[19];
                temp_result_64[10] <= temp_result_128[20] + temp_result_128[21];
                temp_result_64[11] <= temp_result_128[22] + temp_result_128[23];
                temp_result_64[12] <= temp_result_128[24] + temp_result_128[25];
                temp_result_64[13] <= temp_result_128[26] + temp_result_128[27];
                temp_result_64[14] <= temp_result_128[28] + temp_result_128[29];
                temp_result_64[15] <= temp_result_128[30] + temp_result_128[31];
                temp_result_64[16] <= temp_result_128[32] + temp_result_128[33];
                temp_result_64[17] <= temp_result_128[34] + temp_result_128[35];
                temp_result_64[18] <= temp_result_128[36] + temp_result_128[37];
                temp_result_64[19] <= temp_result_128[38] + temp_result_128[39];
                temp_result_64[20] <= temp_result_128[40] + temp_result_128[41];
                temp_result_64[21] <= temp_result_128[42] + temp_result_128[43];
                temp_result_64[22] <= temp_result_128[44] + temp_result_128[45];
                temp_result_64[23] <= temp_result_128[46] + temp_result_128[47];
                temp_result_64[24] <= temp_result_128[48] + temp_result_128[49];
                temp_result_64[25] <= temp_result_128[50] + temp_result_128[51];
                temp_result_64[26] <= temp_result_128[52] + temp_result_128[53];
                temp_result_64[27] <= temp_result_128[54] + temp_result_128[55];
                temp_result_64[28] <= temp_result_128[56] + temp_result_128[57];
                temp_result_64[29] <= temp_result_128[58] + temp_result_128[59];
                temp_result_64[30] <= temp_result_128[60] + temp_result_128[61];
                temp_result_64[31] <= temp_result_128[62] + temp_result_128[63];
                temp_result_64[32] <= temp_result_128[64] + temp_result_128[65];
                temp_result_64[33] <= temp_result_128[66] + temp_result_128[67];
                temp_result_64[34] <= temp_result_128[68] + temp_result_128[69];
                temp_result_64[35] <= temp_result_128[70] + temp_result_128[71];
                temp_result_64[36] <= temp_result_128[72] + temp_result_128[73];
                temp_result_64[37] <= temp_result_128[74] + temp_result_128[75];
                temp_result_64[38] <= temp_result_128[76] + temp_result_128[77];
                temp_result_64[39] <= temp_result_128[78] + temp_result_128[79];
                temp_result_64[40] <= temp_result_128[80] + temp_result_128[81];
                temp_result_64[41] <= temp_result_128[82] + temp_result_128[83];
                temp_result_64[42] <= temp_result_128[84] + temp_result_128[85];
                temp_result_64[43] <= temp_result_128[86] + temp_result_128[87];
                temp_result_64[44] <= temp_result_128[88] + temp_result_128[89];
                temp_result_64[45] <= temp_result_128[90] + temp_result_128[91];
                temp_result_64[46] <= temp_result_128[92] + temp_result_128[93];
                temp_result_64[47] <= temp_result_128[94] + temp_result_128[95];
                temp_result_64[48] <= temp_result_128[96] + temp_result_128[97];
                temp_result_64[49] <= temp_result_128[98] + temp_result_128[99];
                temp_result_64[50] <= temp_result_128[100] + temp_result_128[101];
                temp_result_64[51] <= temp_result_128[102] + temp_result_128[103];
                temp_result_64[52] <= temp_result_128[104] + temp_result_128[105];
                temp_result_64[53] <= temp_result_128[106] + temp_result_128[107];
                temp_result_64[54] <= temp_result_128[108] + temp_result_128[109];
                temp_result_64[55] <= temp_result_128[110] + temp_result_128[111];
                temp_result_64[56] <= temp_result_128[112] + temp_result_128[113];
                temp_result_64[57] <= temp_result_128[114] + temp_result_128[115];
                temp_result_64[58] <= temp_result_128[116] + temp_result_128[117];
                temp_result_64[59] <= temp_result_128[118] + temp_result_128[119];
                temp_result_64[60] <= temp_result_128[120] + temp_result_128[121];
                temp_result_64[61] <= temp_result_128[122] + temp_result_128[123];
                temp_result_64[62] <= temp_result_128[124] + temp_result_128[125];
                temp_result_64[63] <= temp_result_128[126] + temp_result_128[127];
            end
            Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_64[0] <= temp_result_128[0] + temp_result_128[1];
                temp_result_64[1] <= temp_result_128[2] + temp_result_128[3];
                temp_result_64[2] <= temp_result_128[4] + temp_result_128[5];
                temp_result_64[3] <= temp_result_128[6] + temp_result_128[7];
                temp_result_64[4] <= temp_result_128[8] + temp_result_128[9];
                temp_result_64[5] <= temp_result_128[10] + temp_result_128[11];
                temp_result_64[6] <= temp_result_128[12] + temp_result_128[13];
                temp_result_64[7] <= temp_result_128[14] + temp_result_128[15];
                temp_result_64[8] <= temp_result_128[16] + temp_result_128[17];
                temp_result_64[9] <= temp_result_128[18] + temp_result_128[19];
                temp_result_64[10] <= temp_result_128[20] + temp_result_128[21];
                temp_result_64[11] <= temp_result_128[22] + temp_result_128[23];
                temp_result_64[12] <= temp_result_128[24] + temp_result_128[25];
                temp_result_64[13] <= temp_result_128[26] + temp_result_128[27];
                temp_result_64[14] <= temp_result_128[28] + temp_result_128[29];
                temp_result_64[15] <= temp_result_128[30] + temp_result_128[31];
                temp_result_64[16] <= temp_result_128[32] + temp_result_128[33];
                temp_result_64[17] <= temp_result_128[34] + temp_result_128[35];
                temp_result_64[18] <= temp_result_128[36] + temp_result_128[37];
                temp_result_64[19] <= temp_result_128[38] + temp_result_128[39];
                temp_result_64[20] <= temp_result_128[40] + temp_result_128[41];
                temp_result_64[21] <= temp_result_128[42] + temp_result_128[43];
                temp_result_64[22] <= temp_result_128[44] + temp_result_128[45];
                temp_result_64[23] <= temp_result_128[46] + temp_result_128[47];
                temp_result_64[24] <= temp_result_128[48] + temp_result_128[49];
                temp_result_64[25] <= temp_result_128[50] + temp_result_128[51];
                temp_result_64[26] <= temp_result_128[52] + temp_result_128[53];
                temp_result_64[27] <= temp_result_128[54] + temp_result_128[55];
                temp_result_64[28] <= temp_result_128[56] + temp_result_128[57];
                temp_result_64[29] <= temp_result_128[58] + temp_result_128[59];
                temp_result_64[30] <= temp_result_128[60] + temp_result_128[61];
                temp_result_64[31] <= temp_result_128[62] + temp_result_128[63];
                temp_result_64[32] <= temp_result_128[64] + temp_result_128[65];
                temp_result_64[33] <= temp_result_128[66] + temp_result_128[67];
                temp_result_64[34] <= temp_result_128[68] + temp_result_128[69];
                temp_result_64[35] <= temp_result_128[70] + temp_result_128[71];
                temp_result_64[36] <= temp_result_128[72] + temp_result_128[73];
                temp_result_64[37] <= temp_result_128[74] + temp_result_128[75];
                temp_result_64[38] <= temp_result_128[76] + temp_result_128[77];
                temp_result_64[39] <= temp_result_128[78] + temp_result_128[79];
                temp_result_64[40] <= temp_result_128[80] + temp_result_128[81];
                temp_result_64[41] <= temp_result_128[82] + temp_result_128[83];
                temp_result_64[42] <= temp_result_128[84] + temp_result_128[85];
                temp_result_64[43] <= temp_result_128[86] + temp_result_128[87];
                temp_result_64[44] <= temp_result_128[88] + temp_result_128[89];
                temp_result_64[45] <= temp_result_128[90] + temp_result_128[91];
                temp_result_64[46] <= temp_result_128[92] + temp_result_128[93];
                temp_result_64[47] <= temp_result_128[94] + temp_result_128[95];
                temp_result_64[48] <= temp_result_128[96] + temp_result_128[97];
                temp_result_64[49] <= temp_result_128[98] + temp_result_128[99];
                temp_result_64[50] <= temp_result_128[100] + temp_result_128[101];
                temp_result_64[51] <= temp_result_128[102] + temp_result_128[103];
                temp_result_64[52] <= temp_result_128[104] + temp_result_128[105];
                temp_result_64[53] <= temp_result_128[106] + temp_result_128[107];
                temp_result_64[54] <= temp_result_128[108] + temp_result_128[109];
                temp_result_64[55] <= temp_result_128[110] + temp_result_128[111];
                temp_result_64[56] <= temp_result_128[112] + temp_result_128[113];
                temp_result_64[57] <= temp_result_128[114] + temp_result_128[115];
                temp_result_64[58] <= temp_result_128[116] + temp_result_128[117];
                temp_result_64[59] <= temp_result_128[118] + temp_result_128[119];
                temp_result_64[60] <= temp_result_128[120] + temp_result_128[121];
                temp_result_64[61] <= temp_result_128[122] + temp_result_128[123];
                temp_result_64[62] <= temp_result_128[124] + temp_result_128[125];
                temp_result_64[63] <= temp_result_128[126] + temp_result_128[127];
            end
            default:begin
                temp_result_64[0] <= temp_result_64[0];
                temp_result_64[1] <= temp_result_64[1];
                temp_result_64[2] <= temp_result_64[2];
                temp_result_64[3] <= temp_result_64[3];
                temp_result_64[4] <= temp_result_64[4];
                temp_result_64[5] <= temp_result_64[5];
                temp_result_64[6] <= temp_result_64[6];
                temp_result_64[7] <= temp_result_64[7];
                temp_result_64[8] <= temp_result_64[8];
                temp_result_64[9] <= temp_result_64[9];
                temp_result_64[10] <= temp_result_64[10];
                temp_result_64[11] <= temp_result_64[11];
                temp_result_64[12] <= temp_result_64[12];
                temp_result_64[13] <= temp_result_64[13];
                temp_result_64[14] <= temp_result_64[14];
                temp_result_64[15] <= temp_result_64[15];
                temp_result_64[16] <= temp_result_64[16];
                temp_result_64[17] <= temp_result_64[17];
                temp_result_64[18] <= temp_result_64[18];
                temp_result_64[19] <= temp_result_64[19];
                temp_result_64[20] <= temp_result_64[20];
                temp_result_64[21] <= temp_result_64[21];
                temp_result_64[22] <= temp_result_64[22];
                temp_result_64[23] <= temp_result_64[23];
                temp_result_64[24] <= temp_result_64[24];
                temp_result_64[25] <= temp_result_64[25];
                temp_result_64[26] <= temp_result_64[26];
                temp_result_64[27] <= temp_result_64[27];
                temp_result_64[28] <= temp_result_64[28];
                temp_result_64[29] <= temp_result_64[29];
                temp_result_64[30] <= temp_result_64[30];
                temp_result_64[31] <= temp_result_64[31];
                temp_result_64[32] <= temp_result_64[32];
                temp_result_64[33] <= temp_result_64[33];
                temp_result_64[34] <= temp_result_64[34];
                temp_result_64[35] <= temp_result_64[35];
                temp_result_64[36] <= temp_result_64[36];
                temp_result_64[37] <= temp_result_64[37];
                temp_result_64[38] <= temp_result_64[38];
                temp_result_64[39] <= temp_result_64[39];
                temp_result_64[40] <= temp_result_64[40];
                temp_result_64[41] <= temp_result_64[41];
                temp_result_64[42] <= temp_result_64[42];
                temp_result_64[43] <= temp_result_64[43];
                temp_result_64[44] <= temp_result_64[44];
                temp_result_64[45] <= temp_result_64[45];
                temp_result_64[46] <= temp_result_64[46];
                temp_result_64[47] <= temp_result_64[47];
                temp_result_64[48] <= temp_result_64[48];
                temp_result_64[49] <= temp_result_64[49];
                temp_result_64[50] <= temp_result_64[50];
                temp_result_64[51] <= temp_result_64[51];
                temp_result_64[52] <= temp_result_64[52];
                temp_result_64[53] <= temp_result_64[53];
                temp_result_64[54] <= temp_result_64[54];
                temp_result_64[55] <= temp_result_64[55];
                temp_result_64[56] <= temp_result_64[56];
                temp_result_64[57] <= temp_result_64[57];
                temp_result_64[58] <= temp_result_64[58];
                temp_result_64[59] <= temp_result_64[59];
                temp_result_64[60] <= temp_result_64[60];
                temp_result_64[61] <= temp_result_64[61];
                temp_result_64[62] <= temp_result_64[62];
                temp_result_64[63] <= temp_result_64[63];
            end
            endcase
        end
end

always @ (posedge clk) begin    // the state machine to add temp_result_32
        if(!rst) begin
            temp_result_32[0] <= 'd0;
            temp_result_32[1] <= 'd0;
            temp_result_32[2] <= 'd0;
            temp_result_32[3] <= 'd0;
            temp_result_32[4] <= 'd0;
            temp_result_32[5] <= 'd0;
            temp_result_32[6] <= 'd0;
            temp_result_32[7] <= 'd0;
            temp_result_32[8] <= 'd0;
            temp_result_32[9] <= 'd0;
            temp_result_32[10] <= 'd0;
            temp_result_32[11] <= 'd0;
            temp_result_32[12] <= 'd0;
            temp_result_32[13] <= 'd0;
            temp_result_32[14] <= 'd0;
            temp_result_32[15] <= 'd0;
            temp_result_32[16] <= 'd0;
            temp_result_32[17] <= 'd0;
            temp_result_32[18] <= 'd0;
            temp_result_32[19] <= 'd0;
            temp_result_32[20] <= 'd0;
            temp_result_32[21] <= 'd0;
            temp_result_32[22] <= 'd0;
            temp_result_32[23] <= 'd0;
            temp_result_32[24] <= 'd0;
            temp_result_32[25] <= 'd0;
            temp_result_32[26] <= 'd0;
            temp_result_32[27] <= 'd0;
            temp_result_32[28] <= 'd0;
            temp_result_32[29] <= 'd0;
            temp_result_32[30] <= 'd0;
            temp_result_32[31] <= 'd0;
        end
        else if (idle) begin
            temp_result_32[0] <= 'd0;
            temp_result_32[1] <= 'd0;
            temp_result_32[2] <= 'd0;
            temp_result_32[3] <= 'd0;
            temp_result_32[4] <= 'd0;
            temp_result_32[5] <= 'd0;
            temp_result_32[6] <= 'd0;
            temp_result_32[7] <= 'd0;
            temp_result_32[8] <= 'd0;
            temp_result_32[9] <= 'd0;
            temp_result_32[10] <= 'd0;
            temp_result_32[11] <= 'd0;
            temp_result_32[12] <= 'd0;
            temp_result_32[13] <= 'd0;
            temp_result_32[14] <= 'd0;
            temp_result_32[15] <= 'd0;
            temp_result_32[16] <= 'd0;
            temp_result_32[17] <= 'd0;
            temp_result_32[18] <= 'd0;
            temp_result_32[19] <= 'd0;
            temp_result_32[20] <= 'd0;
            temp_result_32[21] <= 'd0;
            temp_result_32[22] <= 'd0;
            temp_result_32[23] <= 'd0;
            temp_result_32[24] <= 'd0;
            temp_result_32[25] <= 'd0;
            temp_result_32[26] <= 'd0;
            temp_result_32[27] <= 'd0;
            temp_result_32[28] <= 'd0;
            temp_result_32[29] <= 'd0;
            temp_result_32[30] <= 'd0;
            temp_result_32[31] <= 'd0;
        end
        else begin
            case(state)
            Wait_Add128to64_64to32:begin
                temp_result_32[0] <= temp_result_64[0] + temp_result_64[1];
                temp_result_32[1] <= temp_result_64[2] + temp_result_64[3];
                temp_result_32[2] <= temp_result_64[4] + temp_result_64[5];
                temp_result_32[3] <= temp_result_64[6] + temp_result_64[7];
                temp_result_32[4] <= temp_result_64[8] + temp_result_64[9];
                temp_result_32[5] <= temp_result_64[10] + temp_result_64[11];
                temp_result_32[6] <= temp_result_64[12] + temp_result_64[13];
                temp_result_32[7] <= temp_result_64[14] + temp_result_64[15];
                temp_result_32[8] <= temp_result_64[16] + temp_result_64[17];
                temp_result_32[9] <= temp_result_64[18] + temp_result_64[19];
                temp_result_32[10] <= temp_result_64[20] + temp_result_64[21];
                temp_result_32[11] <= temp_result_64[22] + temp_result_64[23];
                temp_result_32[12] <= temp_result_64[24] + temp_result_64[25];
                temp_result_32[13] <= temp_result_64[26] + temp_result_64[27];
                temp_result_32[14] <= temp_result_64[28] + temp_result_64[29];
                temp_result_32[15] <= temp_result_64[30] + temp_result_64[31];
                temp_result_32[16] <= temp_result_64[32] + temp_result_64[33];
                temp_result_32[17] <= temp_result_64[34] + temp_result_64[35];
                temp_result_32[18] <= temp_result_64[36] + temp_result_64[37];
                temp_result_32[19] <= temp_result_64[38] + temp_result_64[39];
                temp_result_32[20] <= temp_result_64[40] + temp_result_64[41];
                temp_result_32[21] <= temp_result_64[42] + temp_result_64[43];
                temp_result_32[22] <= temp_result_64[44] + temp_result_64[45];
                temp_result_32[23] <= temp_result_64[46] + temp_result_64[47];
                temp_result_32[24] <= temp_result_64[48] + temp_result_64[49];
                temp_result_32[25] <= temp_result_64[50] + temp_result_64[51];
                temp_result_32[26] <= temp_result_64[52] + temp_result_64[53];
                temp_result_32[27] <= temp_result_64[54] + temp_result_64[55];
                temp_result_32[28] <= temp_result_64[56] + temp_result_64[57];
                temp_result_32[29] <= temp_result_64[58] + temp_result_64[59];
                temp_result_32[30] <= temp_result_64[60] + temp_result_64[61];
                temp_result_32[31] <= temp_result_64[62] + temp_result_64[63];
            end

            Wait_Add128to64_64to32_32to16:begin
                temp_result_32[0] <= temp_result_64[0] + temp_result_64[1];
                temp_result_32[1] <= temp_result_64[2] + temp_result_64[3];
                temp_result_32[2] <= temp_result_64[4] + temp_result_64[5];
                temp_result_32[3] <= temp_result_64[6] + temp_result_64[7];
                temp_result_32[4] <= temp_result_64[8] + temp_result_64[9];
                temp_result_32[5] <= temp_result_64[10] + temp_result_64[11];
                temp_result_32[6] <= temp_result_64[12] + temp_result_64[13];
                temp_result_32[7] <= temp_result_64[14] + temp_result_64[15];
                temp_result_32[8] <= temp_result_64[16] + temp_result_64[17];
                temp_result_32[9] <= temp_result_64[18] + temp_result_64[19];
                temp_result_32[10] <= temp_result_64[20] + temp_result_64[21];
                temp_result_32[11] <= temp_result_64[22] + temp_result_64[23];
                temp_result_32[12] <= temp_result_64[24] + temp_result_64[25];
                temp_result_32[13] <= temp_result_64[26] + temp_result_64[27];
                temp_result_32[14] <= temp_result_64[28] + temp_result_64[29];
                temp_result_32[15] <= temp_result_64[30] + temp_result_64[31];
                temp_result_32[16] <= temp_result_64[32] + temp_result_64[33];
                temp_result_32[17] <= temp_result_64[34] + temp_result_64[35];
                temp_result_32[18] <= temp_result_64[36] + temp_result_64[37];
                temp_result_32[19] <= temp_result_64[38] + temp_result_64[39];
                temp_result_32[20] <= temp_result_64[40] + temp_result_64[41];
                temp_result_32[21] <= temp_result_64[42] + temp_result_64[43];
                temp_result_32[22] <= temp_result_64[44] + temp_result_64[45];
                temp_result_32[23] <= temp_result_64[46] + temp_result_64[47];
                temp_result_32[24] <= temp_result_64[48] + temp_result_64[49];
                temp_result_32[25] <= temp_result_64[50] + temp_result_64[51];
                temp_result_32[26] <= temp_result_64[52] + temp_result_64[53];
                temp_result_32[27] <= temp_result_64[54] + temp_result_64[55];
                temp_result_32[28] <= temp_result_64[56] + temp_result_64[57];
                temp_result_32[29] <= temp_result_64[58] + temp_result_64[59];
                temp_result_32[30] <= temp_result_64[60] + temp_result_64[61];
                temp_result_32[31] <= temp_result_64[62] + temp_result_64[63];
            end

            Wait_Add128to64_64to32_32to16_16to8:begin
                temp_result_32[0] <= temp_result_64[0] + temp_result_64[1];
                temp_result_32[1] <= temp_result_64[2] + temp_result_64[3];
                temp_result_32[2] <= temp_result_64[4] + temp_result_64[5];
                temp_result_32[3] <= temp_result_64[6] + temp_result_64[7];
                temp_result_32[4] <= temp_result_64[8] + temp_result_64[9];
                temp_result_32[5] <= temp_result_64[10] + temp_result_64[11];
                temp_result_32[6] <= temp_result_64[12] + temp_result_64[13];
                temp_result_32[7] <= temp_result_64[14] + temp_result_64[15];
                temp_result_32[8] <= temp_result_64[16] + temp_result_64[17];
                temp_result_32[9] <= temp_result_64[18] + temp_result_64[19];
                temp_result_32[10] <= temp_result_64[20] + temp_result_64[21];
                temp_result_32[11] <= temp_result_64[22] + temp_result_64[23];
                temp_result_32[12] <= temp_result_64[24] + temp_result_64[25];
                temp_result_32[13] <= temp_result_64[26] + temp_result_64[27];
                temp_result_32[14] <= temp_result_64[28] + temp_result_64[29];
                temp_result_32[15] <= temp_result_64[30] + temp_result_64[31];
                temp_result_32[16] <= temp_result_64[32] + temp_result_64[33];
                temp_result_32[17] <= temp_result_64[34] + temp_result_64[35];
                temp_result_32[18] <= temp_result_64[36] + temp_result_64[37];
                temp_result_32[19] <= temp_result_64[38] + temp_result_64[39];
                temp_result_32[20] <= temp_result_64[40] + temp_result_64[41];
                temp_result_32[21] <= temp_result_64[42] + temp_result_64[43];
                temp_result_32[22] <= temp_result_64[44] + temp_result_64[45];
                temp_result_32[23] <= temp_result_64[46] + temp_result_64[47];
                temp_result_32[24] <= temp_result_64[48] + temp_result_64[49];
                temp_result_32[25] <= temp_result_64[50] + temp_result_64[51];
                temp_result_32[26] <= temp_result_64[52] + temp_result_64[53];
                temp_result_32[27] <= temp_result_64[54] + temp_result_64[55];
                temp_result_32[28] <= temp_result_64[56] + temp_result_64[57];
                temp_result_32[29] <= temp_result_64[58] + temp_result_64[59];
                temp_result_32[30] <= temp_result_64[60] + temp_result_64[61];
                temp_result_32[31] <= temp_result_64[62] + temp_result_64[63];
            end
            
            Wait_Add128to64_64to32_32to16_16to8_8to4:begin
               temp_result_32[0] <= temp_result_64[0] + temp_result_64[1];
                temp_result_32[1] <= temp_result_64[2] + temp_result_64[3];
                temp_result_32[2] <= temp_result_64[4] + temp_result_64[5];
                temp_result_32[3] <= temp_result_64[6] + temp_result_64[7];
                temp_result_32[4] <= temp_result_64[8] + temp_result_64[9];
                temp_result_32[5] <= temp_result_64[10] + temp_result_64[11];
                temp_result_32[6] <= temp_result_64[12] + temp_result_64[13];
                temp_result_32[7] <= temp_result_64[14] + temp_result_64[15];
                temp_result_32[8] <= temp_result_64[16] + temp_result_64[17];
                temp_result_32[9] <= temp_result_64[18] + temp_result_64[19];
                temp_result_32[10] <= temp_result_64[20] + temp_result_64[21];
                temp_result_32[11] <= temp_result_64[22] + temp_result_64[23];
                temp_result_32[12] <= temp_result_64[24] + temp_result_64[25];
                temp_result_32[13] <= temp_result_64[26] + temp_result_64[27];
                temp_result_32[14] <= temp_result_64[28] + temp_result_64[29];
                temp_result_32[15] <= temp_result_64[30] + temp_result_64[31];
                temp_result_32[16] <= temp_result_64[32] + temp_result_64[33];
                temp_result_32[17] <= temp_result_64[34] + temp_result_64[35];
                temp_result_32[18] <= temp_result_64[36] + temp_result_64[37];
                temp_result_32[19] <= temp_result_64[38] + temp_result_64[39];
                temp_result_32[20] <= temp_result_64[40] + temp_result_64[41];
                temp_result_32[21] <= temp_result_64[42] + temp_result_64[43];
                temp_result_32[22] <= temp_result_64[44] + temp_result_64[45];
                temp_result_32[23] <= temp_result_64[46] + temp_result_64[47];
                temp_result_32[24] <= temp_result_64[48] + temp_result_64[49];
                temp_result_32[25] <= temp_result_64[50] + temp_result_64[51];
                temp_result_32[26] <= temp_result_64[52] + temp_result_64[53];
                temp_result_32[27] <= temp_result_64[54] + temp_result_64[55];
                temp_result_32[28] <= temp_result_64[56] + temp_result_64[57];
                temp_result_32[29] <= temp_result_64[58] + temp_result_64[59];
                temp_result_32[30] <= temp_result_64[60] + temp_result_64[61];
                temp_result_32[31] <= temp_result_64[62] + temp_result_64[63];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2:begin
                temp_result_32[0] <= temp_result_64[0] + temp_result_64[1];
                temp_result_32[1] <= temp_result_64[2] + temp_result_64[3];
                temp_result_32[2] <= temp_result_64[4] + temp_result_64[5];
                temp_result_32[3] <= temp_result_64[6] + temp_result_64[7];
                temp_result_32[4] <= temp_result_64[8] + temp_result_64[9];
                temp_result_32[5] <= temp_result_64[10] + temp_result_64[11];
                temp_result_32[6] <= temp_result_64[12] + temp_result_64[13];
                temp_result_32[7] <= temp_result_64[14] + temp_result_64[15];
                temp_result_32[8] <= temp_result_64[16] + temp_result_64[17];
                temp_result_32[9] <= temp_result_64[18] + temp_result_64[19];
                temp_result_32[10] <= temp_result_64[20] + temp_result_64[21];
                temp_result_32[11] <= temp_result_64[22] + temp_result_64[23];
                temp_result_32[12] <= temp_result_64[24] + temp_result_64[25];
                temp_result_32[13] <= temp_result_64[26] + temp_result_64[27];
                temp_result_32[14] <= temp_result_64[28] + temp_result_64[29];
                temp_result_32[15] <= temp_result_64[30] + temp_result_64[31];
                temp_result_32[16] <= temp_result_64[32] + temp_result_64[33];
                temp_result_32[17] <= temp_result_64[34] + temp_result_64[35];
                temp_result_32[18] <= temp_result_64[36] + temp_result_64[37];
                temp_result_32[19] <= temp_result_64[38] + temp_result_64[39];
                temp_result_32[20] <= temp_result_64[40] + temp_result_64[41];
                temp_result_32[21] <= temp_result_64[42] + temp_result_64[43];
                temp_result_32[22] <= temp_result_64[44] + temp_result_64[45];
                temp_result_32[23] <= temp_result_64[46] + temp_result_64[47];
                temp_result_32[24] <= temp_result_64[48] + temp_result_64[49];
                temp_result_32[25] <= temp_result_64[50] + temp_result_64[51];
                temp_result_32[26] <= temp_result_64[52] + temp_result_64[53];
                temp_result_32[27] <= temp_result_64[54] + temp_result_64[55];
                temp_result_32[28] <= temp_result_64[56] + temp_result_64[57];
                temp_result_32[29] <= temp_result_64[58] + temp_result_64[59];
                temp_result_32[30] <= temp_result_64[60] + temp_result_64[61];
                temp_result_32[31] <= temp_result_64[62] + temp_result_64[63];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_32[0] <= temp_result_64[0] + temp_result_64[1];
                temp_result_32[1] <= temp_result_64[2] + temp_result_64[3];
                temp_result_32[2] <= temp_result_64[4] + temp_result_64[5];
                temp_result_32[3] <= temp_result_64[6] + temp_result_64[7];
                temp_result_32[4] <= temp_result_64[8] + temp_result_64[9];
                temp_result_32[5] <= temp_result_64[10] + temp_result_64[11];
                temp_result_32[6] <= temp_result_64[12] + temp_result_64[13];
                temp_result_32[7] <= temp_result_64[14] + temp_result_64[15];
                temp_result_32[8] <= temp_result_64[16] + temp_result_64[17];
                temp_result_32[9] <= temp_result_64[18] + temp_result_64[19];
                temp_result_32[10] <= temp_result_64[20] + temp_result_64[21];
                temp_result_32[11] <= temp_result_64[22] + temp_result_64[23];
                temp_result_32[12] <= temp_result_64[24] + temp_result_64[25];
                temp_result_32[13] <= temp_result_64[26] + temp_result_64[27];
                temp_result_32[14] <= temp_result_64[28] + temp_result_64[29];
                temp_result_32[15] <= temp_result_64[30] + temp_result_64[31];
                temp_result_32[16] <= temp_result_64[32] + temp_result_64[33];
                temp_result_32[17] <= temp_result_64[34] + temp_result_64[35];
                temp_result_32[18] <= temp_result_64[36] + temp_result_64[37];
                temp_result_32[19] <= temp_result_64[38] + temp_result_64[39];
                temp_result_32[20] <= temp_result_64[40] + temp_result_64[41];
                temp_result_32[21] <= temp_result_64[42] + temp_result_64[43];
                temp_result_32[22] <= temp_result_64[44] + temp_result_64[45];
                temp_result_32[23] <= temp_result_64[46] + temp_result_64[47];
                temp_result_32[24] <= temp_result_64[48] + temp_result_64[49];
                temp_result_32[25] <= temp_result_64[50] + temp_result_64[51];
                temp_result_32[26] <= temp_result_64[52] + temp_result_64[53];
                temp_result_32[27] <= temp_result_64[54] + temp_result_64[55];
                temp_result_32[28] <= temp_result_64[56] + temp_result_64[57];
                temp_result_32[29] <= temp_result_64[58] + temp_result_64[59];
                temp_result_32[30] <= temp_result_64[60] + temp_result_64[61];
                temp_result_32[31] <= temp_result_64[62] + temp_result_64[63];
            end
            Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_32[0] <= temp_result_64[0] + temp_result_64[1];
                temp_result_32[1] <= temp_result_64[2] + temp_result_64[3];
                temp_result_32[2] <= temp_result_64[4] + temp_result_64[5];
                temp_result_32[3] <= temp_result_64[6] + temp_result_64[7];
                temp_result_32[4] <= temp_result_64[8] + temp_result_64[9];
                temp_result_32[5] <= temp_result_64[10] + temp_result_64[11];
                temp_result_32[6] <= temp_result_64[12] + temp_result_64[13];
                temp_result_32[7] <= temp_result_64[14] + temp_result_64[15];
                temp_result_32[8] <= temp_result_64[16] + temp_result_64[17];
                temp_result_32[9] <= temp_result_64[18] + temp_result_64[19];
                temp_result_32[10] <= temp_result_64[20] + temp_result_64[21];
                temp_result_32[11] <= temp_result_64[22] + temp_result_64[23];
                temp_result_32[12] <= temp_result_64[24] + temp_result_64[25];
                temp_result_32[13] <= temp_result_64[26] + temp_result_64[27];
                temp_result_32[14] <= temp_result_64[28] + temp_result_64[29];
                temp_result_32[15] <= temp_result_64[30] + temp_result_64[31];
                temp_result_32[16] <= temp_result_64[32] + temp_result_64[33];
                temp_result_32[17] <= temp_result_64[34] + temp_result_64[35];
                temp_result_32[18] <= temp_result_64[36] + temp_result_64[37];
                temp_result_32[19] <= temp_result_64[38] + temp_result_64[39];
                temp_result_32[20] <= temp_result_64[40] + temp_result_64[41];
                temp_result_32[21] <= temp_result_64[42] + temp_result_64[43];
                temp_result_32[22] <= temp_result_64[44] + temp_result_64[45];
                temp_result_32[23] <= temp_result_64[46] + temp_result_64[47];
                temp_result_32[24] <= temp_result_64[48] + temp_result_64[49];
                temp_result_32[25] <= temp_result_64[50] + temp_result_64[51];
                temp_result_32[26] <= temp_result_64[52] + temp_result_64[53];
                temp_result_32[27] <= temp_result_64[54] + temp_result_64[55];
                temp_result_32[28] <= temp_result_64[56] + temp_result_64[57];
                temp_result_32[29] <= temp_result_64[58] + temp_result_64[59];
                temp_result_32[30] <= temp_result_64[60] + temp_result_64[61];
                temp_result_32[31] <= temp_result_64[62] + temp_result_64[63];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_32[0] <= temp_result_64[0] + temp_result_64[1];
                temp_result_32[1] <= temp_result_64[2] + temp_result_64[3];
                temp_result_32[2] <= temp_result_64[4] + temp_result_64[5];
                temp_result_32[3] <= temp_result_64[6] + temp_result_64[7];
                temp_result_32[4] <= temp_result_64[8] + temp_result_64[9];
                temp_result_32[5] <= temp_result_64[10] + temp_result_64[11];
                temp_result_32[6] <= temp_result_64[12] + temp_result_64[13];
                temp_result_32[7] <= temp_result_64[14] + temp_result_64[15];
                temp_result_32[8] <= temp_result_64[16] + temp_result_64[17];
                temp_result_32[9] <= temp_result_64[18] + temp_result_64[19];
                temp_result_32[10] <= temp_result_64[20] + temp_result_64[21];
                temp_result_32[11] <= temp_result_64[22] + temp_result_64[23];
                temp_result_32[12] <= temp_result_64[24] + temp_result_64[25];
                temp_result_32[13] <= temp_result_64[26] + temp_result_64[27];
                temp_result_32[14] <= temp_result_64[28] + temp_result_64[29];
                temp_result_32[15] <= temp_result_64[30] + temp_result_64[31];
                temp_result_32[16] <= temp_result_64[32] + temp_result_64[33];
                temp_result_32[17] <= temp_result_64[34] + temp_result_64[35];
                temp_result_32[18] <= temp_result_64[36] + temp_result_64[37];
                temp_result_32[19] <= temp_result_64[38] + temp_result_64[39];
                temp_result_32[20] <= temp_result_64[40] + temp_result_64[41];
                temp_result_32[21] <= temp_result_64[42] + temp_result_64[43];
                temp_result_32[22] <= temp_result_64[44] + temp_result_64[45];
                temp_result_32[23] <= temp_result_64[46] + temp_result_64[47];
                temp_result_32[24] <= temp_result_64[48] + temp_result_64[49];
                temp_result_32[25] <= temp_result_64[50] + temp_result_64[51];
                temp_result_32[26] <= temp_result_64[52] + temp_result_64[53];
                temp_result_32[27] <= temp_result_64[54] + temp_result_64[55];
                temp_result_32[28] <= temp_result_64[56] + temp_result_64[57];
                temp_result_32[29] <= temp_result_64[58] + temp_result_64[59];
                temp_result_32[30] <= temp_result_64[60] + temp_result_64[61];
                temp_result_32[31] <= temp_result_64[62] + temp_result_64[63];
            end
            default:begin
                temp_result_32[0] <= temp_result_32[0];
                temp_result_32[1] <= temp_result_32[1];
                temp_result_32[2] <= temp_result_32[2];
                temp_result_32[3] <= temp_result_32[3];
                temp_result_32[4] <= temp_result_32[4];
                temp_result_32[5] <= temp_result_32[5];
                temp_result_32[6] <= temp_result_32[6];
                temp_result_32[7] <= temp_result_32[7];
                temp_result_32[8] <= temp_result_32[8];
                temp_result_32[9] <= temp_result_32[9];
                temp_result_32[10] <= temp_result_32[10];
                temp_result_32[11] <= temp_result_32[11];
                temp_result_32[12] <= temp_result_32[12];
                temp_result_32[13] <= temp_result_32[13];
                temp_result_32[14] <= temp_result_32[14];
                temp_result_32[15] <= temp_result_32[15];
                temp_result_32[16] <= temp_result_32[16];
                temp_result_32[17] <= temp_result_32[17];
                temp_result_32[18] <= temp_result_32[18];
                temp_result_32[19] <= temp_result_32[19];
                temp_result_32[20] <= temp_result_32[20];
                temp_result_32[21] <= temp_result_32[21];
                temp_result_32[22] <= temp_result_32[22];
                temp_result_32[23] <= temp_result_32[23];
                temp_result_32[24] <= temp_result_32[24];
                temp_result_32[25] <= temp_result_32[25];
                temp_result_32[26] <= temp_result_32[26];
                temp_result_32[27] <= temp_result_32[27];
                temp_result_32[28] <= temp_result_32[28];
                temp_result_32[29] <= temp_result_32[29];
                temp_result_32[30] <= temp_result_32[30];
                temp_result_32[31] <= temp_result_32[31];
            end
            endcase
        end
end

always @ (posedge clk) begin    // the state machine to add temp_result_16
        if(!rst) begin
            temp_result_16[0] <= 'd0;
            temp_result_16[1] <= 'd0;
            temp_result_16[2] <= 'd0;
            temp_result_16[3] <= 'd0;
            temp_result_16[4] <= 'd0;
            temp_result_16[5] <= 'd0;
            temp_result_16[6] <= 'd0;
            temp_result_16[7] <= 'd0;
            temp_result_16[8] <= 'd0;
            temp_result_16[9] <= 'd0;
            temp_result_16[10] <= 'd0;
            temp_result_16[11] <= 'd0;
            temp_result_16[12] <= 'd0;
            temp_result_16[13] <= 'd0;
            temp_result_16[14] <= 'd0;
            temp_result_16[15] <= 'd0;
        end
        else if (idle) begin
            temp_result_16[0] <= 'd0;
            temp_result_16[1] <= 'd0;
            temp_result_16[2] <= 'd0;
            temp_result_16[3] <= 'd0;
            temp_result_16[4] <= 'd0;
            temp_result_16[5] <= 'd0;
            temp_result_16[6] <= 'd0;
            temp_result_16[7] <= 'd0;
            temp_result_16[8] <= 'd0;
            temp_result_16[9] <= 'd0;
            temp_result_16[10] <= 'd0;
            temp_result_16[11] <= 'd0;
            temp_result_16[12] <= 'd0;
            temp_result_16[13] <= 'd0;
            temp_result_16[14] <= 'd0;
            temp_result_16[15] <= 'd0;
        end
        else begin
            case(state)
            Wait_Add128to64_64to32_32to16:begin
               temp_result_16[0] <= temp_result_32[0] + temp_result_32[1];
                temp_result_16[1] <= temp_result_32[2] + temp_result_32[3];
                temp_result_16[2] <= temp_result_32[4] + temp_result_32[5];
                temp_result_16[3] <= temp_result_32[6] + temp_result_32[7];
                temp_result_16[4] <= temp_result_32[8] + temp_result_32[9];
                temp_result_16[5] <= temp_result_32[10] + temp_result_32[11];
                temp_result_16[6] <= temp_result_32[12] + temp_result_32[13];
                temp_result_16[7] <= temp_result_32[14] + temp_result_32[15];
                temp_result_16[8] <= temp_result_32[16] + temp_result_32[17];
                temp_result_16[9] <= temp_result_32[18] + temp_result_32[19];
                temp_result_16[10] <= temp_result_32[20] + temp_result_32[21];
                temp_result_16[11] <= temp_result_32[22] + temp_result_32[23];
                temp_result_16[12] <= temp_result_32[24] + temp_result_32[25];
                temp_result_16[13] <= temp_result_32[26] + temp_result_32[27];
                temp_result_16[14] <= temp_result_32[28] + temp_result_32[29];
                temp_result_16[15] <= temp_result_32[30] + temp_result_32[31];
            end


            Wait_Add128to64_64to32_32to16_16to8:begin
                temp_result_16[0] <= temp_result_32[0] + temp_result_32[1];
                temp_result_16[1] <= temp_result_32[2] + temp_result_32[3];
                temp_result_16[2] <= temp_result_32[4] + temp_result_32[5];
                temp_result_16[3] <= temp_result_32[6] + temp_result_32[7];
                temp_result_16[4] <= temp_result_32[8] + temp_result_32[9];
                temp_result_16[5] <= temp_result_32[10] + temp_result_32[11];
                temp_result_16[6] <= temp_result_32[12] + temp_result_32[13];
                temp_result_16[7] <= temp_result_32[14] + temp_result_32[15];
                temp_result_16[8] <= temp_result_32[16] + temp_result_32[17];
                temp_result_16[9] <= temp_result_32[18] + temp_result_32[19];
                temp_result_16[10] <= temp_result_32[20] + temp_result_32[21];
                temp_result_16[11] <= temp_result_32[22] + temp_result_32[23];
                temp_result_16[12] <= temp_result_32[24] + temp_result_32[25];
                temp_result_16[13] <= temp_result_32[26] + temp_result_32[27];
                temp_result_16[14] <= temp_result_32[28] + temp_result_32[29];
                temp_result_16[15] <= temp_result_32[30] + temp_result_32[31];
            end
            
            Wait_Add128to64_64to32_32to16_16to8_8to4:begin
               temp_result_16[0] <= temp_result_32[0] + temp_result_32[1];
                temp_result_16[1] <= temp_result_32[2] + temp_result_32[3];
                temp_result_16[2] <= temp_result_32[4] + temp_result_32[5];
                temp_result_16[3] <= temp_result_32[6] + temp_result_32[7];
                temp_result_16[4] <= temp_result_32[8] + temp_result_32[9];
                temp_result_16[5] <= temp_result_32[10] + temp_result_32[11];
                temp_result_16[6] <= temp_result_32[12] + temp_result_32[13];
                temp_result_16[7] <= temp_result_32[14] + temp_result_32[15];
                temp_result_16[8] <= temp_result_32[16] + temp_result_32[17];
                temp_result_16[9] <= temp_result_32[18] + temp_result_32[19];
                temp_result_16[10] <= temp_result_32[20] + temp_result_32[21];
                temp_result_16[11] <= temp_result_32[22] + temp_result_32[23];
                temp_result_16[12] <= temp_result_32[24] + temp_result_32[25];
                temp_result_16[13] <= temp_result_32[26] + temp_result_32[27];
                temp_result_16[14] <= temp_result_32[28] + temp_result_32[29];
                temp_result_16[15] <= temp_result_32[30] + temp_result_32[31];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2:begin
                temp_result_16[0] <= temp_result_32[0] + temp_result_32[1];
                temp_result_16[1] <= temp_result_32[2] + temp_result_32[3];
                temp_result_16[2] <= temp_result_32[4] + temp_result_32[5];
                temp_result_16[3] <= temp_result_32[6] + temp_result_32[7];
                temp_result_16[4] <= temp_result_32[8] + temp_result_32[9];
                temp_result_16[5] <= temp_result_32[10] + temp_result_32[11];
                temp_result_16[6] <= temp_result_32[12] + temp_result_32[13];
                temp_result_16[7] <= temp_result_32[14] + temp_result_32[15];
                temp_result_16[8] <= temp_result_32[16] + temp_result_32[17];
                temp_result_16[9] <= temp_result_32[18] + temp_result_32[19];
                temp_result_16[10] <= temp_result_32[20] + temp_result_32[21];
                temp_result_16[11] <= temp_result_32[22] + temp_result_32[23];
                temp_result_16[12] <= temp_result_32[24] + temp_result_32[25];
                temp_result_16[13] <= temp_result_32[26] + temp_result_32[27];
                temp_result_16[14] <= temp_result_32[28] + temp_result_32[29];
                temp_result_16[15] <= temp_result_32[30] + temp_result_32[31];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_16[0] <= temp_result_32[0] + temp_result_32[1];
                temp_result_16[1] <= temp_result_32[2] + temp_result_32[3];
                temp_result_16[2] <= temp_result_32[4] + temp_result_32[5];
                temp_result_16[3] <= temp_result_32[6] + temp_result_32[7];
                temp_result_16[4] <= temp_result_32[8] + temp_result_32[9];
                temp_result_16[5] <= temp_result_32[10] + temp_result_32[11];
                temp_result_16[6] <= temp_result_32[12] + temp_result_32[13];
                temp_result_16[7] <= temp_result_32[14] + temp_result_32[15];
                temp_result_16[8] <= temp_result_32[16] + temp_result_32[17];
                temp_result_16[9] <= temp_result_32[18] + temp_result_32[19];
                temp_result_16[10] <= temp_result_32[20] + temp_result_32[21];
                temp_result_16[11] <= temp_result_32[22] + temp_result_32[23];
                temp_result_16[12] <= temp_result_32[24] + temp_result_32[25];
                temp_result_16[13] <= temp_result_32[26] + temp_result_32[27];
                temp_result_16[14] <= temp_result_32[28] + temp_result_32[29];
                temp_result_16[15] <= temp_result_32[30] + temp_result_32[31];
            end
            Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_16[0] <= temp_result_32[0] + temp_result_32[1];
                temp_result_16[1] <= temp_result_32[2] + temp_result_32[3];
                temp_result_16[2] <= temp_result_32[4] + temp_result_32[5];
                temp_result_16[3] <= temp_result_32[6] + temp_result_32[7];
                temp_result_16[4] <= temp_result_32[8] + temp_result_32[9];
                temp_result_16[5] <= temp_result_32[10] + temp_result_32[11];
                temp_result_16[6] <= temp_result_32[12] + temp_result_32[13];
                temp_result_16[7] <= temp_result_32[14] + temp_result_32[15];
                temp_result_16[8] <= temp_result_32[16] + temp_result_32[17];
                temp_result_16[9] <= temp_result_32[18] + temp_result_32[19];
                temp_result_16[10] <= temp_result_32[20] + temp_result_32[21];
                temp_result_16[11] <= temp_result_32[22] + temp_result_32[23];
                temp_result_16[12] <= temp_result_32[24] + temp_result_32[25];
                temp_result_16[13] <= temp_result_32[26] + temp_result_32[27];
                temp_result_16[14] <= temp_result_32[28] + temp_result_32[29];
                temp_result_16[15] <= temp_result_32[30] + temp_result_32[31];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_16[0] <= temp_result_32[0] + temp_result_32[1];
                temp_result_16[1] <= temp_result_32[2] + temp_result_32[3];
                temp_result_16[2] <= temp_result_32[4] + temp_result_32[5];
                temp_result_16[3] <= temp_result_32[6] + temp_result_32[7];
                temp_result_16[4] <= temp_result_32[8] + temp_result_32[9];
                temp_result_16[5] <= temp_result_32[10] + temp_result_32[11];
                temp_result_16[6] <= temp_result_32[12] + temp_result_32[13];
                temp_result_16[7] <= temp_result_32[14] + temp_result_32[15];
                temp_result_16[8] <= temp_result_32[16] + temp_result_32[17];
                temp_result_16[9] <= temp_result_32[18] + temp_result_32[19];
                temp_result_16[10] <= temp_result_32[20] + temp_result_32[21];
                temp_result_16[11] <= temp_result_32[22] + temp_result_32[23];
                temp_result_16[12] <= temp_result_32[24] + temp_result_32[25];
                temp_result_16[13] <= temp_result_32[26] + temp_result_32[27];
                temp_result_16[14] <= temp_result_32[28] + temp_result_32[29];
                temp_result_16[15] <= temp_result_32[30] + temp_result_32[31];
            end
            Add32to16_16to8_8to4_4to2_2to1:begin
                temp_result_16[0] <= temp_result_32[0] + temp_result_32[1];
                temp_result_16[1] <= temp_result_32[2] + temp_result_32[3];
                temp_result_16[2] <= temp_result_32[4] + temp_result_32[5];
                temp_result_16[3] <= temp_result_32[6] + temp_result_32[7];
                temp_result_16[4] <= temp_result_32[8] + temp_result_32[9];
                temp_result_16[5] <= temp_result_32[10] + temp_result_32[11];
                temp_result_16[6] <= temp_result_32[12] + temp_result_32[13];
                temp_result_16[7] <= temp_result_32[14] + temp_result_32[15];
                temp_result_16[8] <= temp_result_32[16] + temp_result_32[17];
                temp_result_16[9] <= temp_result_32[18] + temp_result_32[19];
                temp_result_16[10] <= temp_result_32[20] + temp_result_32[21];
                temp_result_16[11] <= temp_result_32[22] + temp_result_32[23];
                temp_result_16[12] <= temp_result_32[24] + temp_result_32[25];
                temp_result_16[13] <= temp_result_32[26] + temp_result_32[27];
                temp_result_16[14] <= temp_result_32[28] + temp_result_32[29];
                temp_result_16[15] <= temp_result_32[30] + temp_result_32[31];
            end
            default:begin
                temp_result_16[0] <= temp_result_16[0];
                temp_result_16[1] <= temp_result_16[1];
                temp_result_16[2] <= temp_result_16[2];
                temp_result_16[3] <= temp_result_16[3];
                temp_result_16[4] <= temp_result_16[4];
                temp_result_16[5] <= temp_result_16[5];
                temp_result_16[6] <= temp_result_16[6];
                temp_result_16[7] <= temp_result_16[7];
                temp_result_16[8] <= temp_result_16[8];
                temp_result_16[9] <= temp_result_16[9];
                temp_result_16[10] <= temp_result_16[10];
                temp_result_16[11] <= temp_result_16[11];
                temp_result_16[12] <= temp_result_16[12];
                temp_result_16[13] <= temp_result_16[13];
                temp_result_16[14] <= temp_result_16[14];
                temp_result_16[15] <= temp_result_16[15];
            end
            endcase
        end
end

always @ (posedge clk) begin    // the state machine to add temp_result_8
        if(!rst) begin
            temp_result_8[0] <= 'd0;
            temp_result_8[1] <= 'd0;
            temp_result_8[2] <= 'd0;
            temp_result_8[3] <= 'd0;
            temp_result_8[4] <= 'd0;
            temp_result_8[5] <= 'd0;
            temp_result_8[6] <= 'd0;
            temp_result_8[7] <= 'd0;
        end
        else if (idle) begin
            temp_result_8[0] <= 'd0;
            temp_result_8[1] <= 'd0;
            temp_result_8[2] <= 'd0;
            temp_result_8[3] <= 'd0;
            temp_result_8[4] <= 'd0;
            temp_result_8[5] <= 'd0;
            temp_result_8[6] <= 'd0;
            temp_result_8[7] <= 'd0;
        end
        else begin
            case(state)
            Wait_Add128to64_64to32_32to16_16to8:begin
                temp_result_8[0] <= temp_result_16[0] + temp_result_16[1];
                temp_result_8[1] <= temp_result_16[2] + temp_result_16[3];
                temp_result_8[2] <= temp_result_16[4] + temp_result_16[5];
                temp_result_8[3] <= temp_result_16[6] + temp_result_16[7];
                temp_result_8[4] <= temp_result_16[8] + temp_result_16[9];
                temp_result_8[5] <= temp_result_16[10] + temp_result_16[11];
                temp_result_8[6] <= temp_result_16[12] + temp_result_16[13];
                temp_result_8[7] <= temp_result_16[14] + temp_result_16[15];
            end
            
            Wait_Add128to64_64to32_32to16_16to8_8to4:begin
                temp_result_8[0] <= temp_result_16[0] + temp_result_16[1];
                temp_result_8[1] <= temp_result_16[2] + temp_result_16[3];
                temp_result_8[2] <= temp_result_16[4] + temp_result_16[5];
                temp_result_8[3] <= temp_result_16[6] + temp_result_16[7];
                temp_result_8[4] <= temp_result_16[8] + temp_result_16[9];
                temp_result_8[5] <= temp_result_16[10] + temp_result_16[11];
                temp_result_8[6] <= temp_result_16[12] + temp_result_16[13];
                temp_result_8[7] <= temp_result_16[14] + temp_result_16[15];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2:begin
                temp_result_8[0] <= temp_result_16[0] + temp_result_16[1];
                temp_result_8[1] <= temp_result_16[2] + temp_result_16[3];
                temp_result_8[2] <= temp_result_16[4] + temp_result_16[5];
                temp_result_8[3] <= temp_result_16[6] + temp_result_16[7];
                temp_result_8[4] <= temp_result_16[8] + temp_result_16[9];
                temp_result_8[5] <= temp_result_16[10] + temp_result_16[11];
                temp_result_8[6] <= temp_result_16[12] + temp_result_16[13];
                temp_result_8[7] <= temp_result_16[14] + temp_result_16[15];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_8[0] <= temp_result_16[0] + temp_result_16[1];
                temp_result_8[1] <= temp_result_16[2] + temp_result_16[3];
                temp_result_8[2] <= temp_result_16[4] + temp_result_16[5];
                temp_result_8[3] <= temp_result_16[6] + temp_result_16[7];
                temp_result_8[4] <= temp_result_16[8] + temp_result_16[9];
                temp_result_8[5] <= temp_result_16[10] + temp_result_16[11];
                temp_result_8[6] <= temp_result_16[12] + temp_result_16[13];
                temp_result_8[7] <= temp_result_16[14] + temp_result_16[15];
            end
            Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_8[0] <= temp_result_16[0] + temp_result_16[1];
                temp_result_8[1] <= temp_result_16[2] + temp_result_16[3];
                temp_result_8[2] <= temp_result_16[4] + temp_result_16[5];
                temp_result_8[3] <= temp_result_16[6] + temp_result_16[7];
                temp_result_8[4] <= temp_result_16[8] + temp_result_16[9];
                temp_result_8[5] <= temp_result_16[10] + temp_result_16[11];
                temp_result_8[6] <= temp_result_16[12] + temp_result_16[13];
                temp_result_8[7] <= temp_result_16[14] + temp_result_16[15];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_8[0] <= temp_result_16[0] + temp_result_16[1];
                temp_result_8[1] <= temp_result_16[2] + temp_result_16[3];
                temp_result_8[2] <= temp_result_16[4] + temp_result_16[5];
                temp_result_8[3] <= temp_result_16[6] + temp_result_16[7];
                temp_result_8[4] <= temp_result_16[8] + temp_result_16[9];
                temp_result_8[5] <= temp_result_16[10] + temp_result_16[11];
                temp_result_8[6] <= temp_result_16[12] + temp_result_16[13];
                temp_result_8[7] <= temp_result_16[14] + temp_result_16[15];
            end
            Add32to16_16to8_8to4_4to2_2to1:begin
                temp_result_8[0] <= temp_result_16[0] + temp_result_16[1];
                temp_result_8[1] <= temp_result_16[2] + temp_result_16[3];
                temp_result_8[2] <= temp_result_16[4] + temp_result_16[5];
                temp_result_8[3] <= temp_result_16[6] + temp_result_16[7];
                temp_result_8[4] <= temp_result_16[8] + temp_result_16[9];
                temp_result_8[5] <= temp_result_16[10] + temp_result_16[11];
                temp_result_8[6] <= temp_result_16[12] + temp_result_16[13];
                temp_result_8[7] <= temp_result_16[14] + temp_result_16[15];
            end
            Add16to8_8to4_4to2_2to1:begin
                temp_result_8[0] <= temp_result_16[0] + temp_result_16[1];
                temp_result_8[1] <= temp_result_16[2] + temp_result_16[3];
                temp_result_8[2] <= temp_result_16[4] + temp_result_16[5];
                temp_result_8[3] <= temp_result_16[6] + temp_result_16[7];
                temp_result_8[4] <= temp_result_16[8] + temp_result_16[9];
                temp_result_8[5] <= temp_result_16[10] + temp_result_16[11];
                temp_result_8[6] <= temp_result_16[12] + temp_result_16[13];
                temp_result_8[7] <= temp_result_16[14] + temp_result_16[15];
            end
            default:begin
                temp_result_8[0] <= temp_result_8[0];
                temp_result_8[1] <= temp_result_8[1];
                temp_result_8[2] <= temp_result_8[2];
                temp_result_8[3] <= temp_result_8[3];
                temp_result_8[4] <= temp_result_8[4];
                temp_result_8[5] <= temp_result_8[5];
                temp_result_8[6] <= temp_result_8[6];
                temp_result_8[7] <= temp_result_8[7];
            end
            endcase
        end
end

always @ (posedge clk) begin    // the state machine to add temp_result_4
        if(!rst) begin
            temp_result_4[0] <= 'd0;
            temp_result_4[1] <= 'd0;
            temp_result_4[2] <= 'd0;
            temp_result_4[3] <= 'd0;
        end
        else if (idle) begin
            temp_result_4[0] <= 'd0;
            temp_result_4[1] <= 'd0;
            temp_result_4[2] <= 'd0;
            temp_result_4[3] <= 'd0;
        end
        else begin
            case(state)
            Wait_Add128to64_64to32_32to16_16to8_8to4:begin
                temp_result_4[0] <= temp_result_8[0] + temp_result_8[1];
                temp_result_4[1] <= temp_result_8[2] + temp_result_8[3];
                temp_result_4[2] <= temp_result_8[4] + temp_result_8[5];
                temp_result_4[3] <= temp_result_8[6] + temp_result_8[7];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2:begin
                temp_result_4[0] <= temp_result_8[0] + temp_result_8[1];
                temp_result_4[1] <= temp_result_8[2] + temp_result_8[3];
                temp_result_4[2] <= temp_result_8[4] + temp_result_8[5];
                temp_result_4[3] <= temp_result_8[6] + temp_result_8[7];
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_4[0] <= temp_result_8[0] + temp_result_8[1];
                temp_result_4[1] <= temp_result_8[2] + temp_result_8[3];
                temp_result_4[2] <= temp_result_8[4] + temp_result_8[5];
                temp_result_4[3] <= temp_result_8[6] + temp_result_8[7];
            end
            Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_4[0] <= temp_result_8[0] + temp_result_8[1];
                temp_result_4[1] <= temp_result_8[2] + temp_result_8[3];
                temp_result_4[2] <= temp_result_8[4] + temp_result_8[5];
                temp_result_4[3] <= temp_result_8[6] + temp_result_8[7];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_4[0] <= temp_result_8[0] + temp_result_8[1];
                temp_result_4[1] <= temp_result_8[2] + temp_result_8[3];
                temp_result_4[2] <= temp_result_8[4] + temp_result_8[5];
                temp_result_4[3] <= temp_result_8[6] + temp_result_8[7];
            end
            Add32to16_16to8_8to4_4to2_2to1:begin
                temp_result_4[0] <= temp_result_8[0] + temp_result_8[1];
                temp_result_4[1] <= temp_result_8[2] + temp_result_8[3];
                temp_result_4[2] <= temp_result_8[4] + temp_result_8[5];
                temp_result_4[3] <= temp_result_8[6] + temp_result_8[7];
            end
            Add16to8_8to4_4to2_2to1:begin
                temp_result_4[0] <= temp_result_8[0] + temp_result_8[1];
                temp_result_4[1] <= temp_result_8[2] + temp_result_8[3];
                temp_result_4[2] <= temp_result_8[4] + temp_result_8[5];
                temp_result_4[3] <= temp_result_8[6] + temp_result_8[7];
            end
            Add8to4_4to2_2to1:begin
                temp_result_4[0] <= temp_result_8[0] + temp_result_8[1];
                temp_result_4[1] <= temp_result_8[2] + temp_result_8[3];
                temp_result_4[2] <= temp_result_8[4] + temp_result_8[5];
                temp_result_4[3] <= temp_result_8[6] + temp_result_8[7];
            end
            default:begin
                temp_result_4[0] <= temp_result_4[0];
                temp_result_4[1] <= temp_result_4[1];
                temp_result_4[2] <= temp_result_4[2];
                temp_result_4[3] <= temp_result_4[3];
            end
            endcase
        end
end


always @ (posedge clk) begin    // the state machine to add temp_result_2 and one_elements
        if(!rst) begin
            temp_result_2[0] <= 'd0;
            temp_result_2[1] <= 'd0;
            one_elements <= 'd0;
        end
        else if (idle) begin
            temp_result_2[0] <= 'd0;
            temp_result_2[1] <= 'd0;
            one_elements <= 'd0;
        end
        else begin
            case(state)
            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2:begin
                temp_result_2[0] <= temp_result_4[0] + temp_result_4[1];
                temp_result_2[1] <= temp_result_4[2] + temp_result_4[3];
                one_elements <= one_elements ;
            end

            Wait_Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_2[0] <= temp_result_4[0] + temp_result_4[1];
                temp_result_2[1] <= temp_result_4[2] + temp_result_4[3];
                one_elements <= temp_result_2[0] + temp_result_2[1];
            end
            Add128to64_64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_2[0] <= temp_result_4[0] + temp_result_4[1];
                temp_result_2[1] <= temp_result_4[2] + temp_result_4[3];
                one_elements <= temp_result_2[0] + temp_result_2[1];
            end
            Add64to32_32to16_16to8_8to4_4to2_2to1:begin
                temp_result_2[0] <= temp_result_4[0] + temp_result_4[1];
                temp_result_2[1] <= temp_result_4[2] + temp_result_4[3];
                one_elements <= temp_result_2[0] + temp_result_2[1];
            end
            Add32to16_16to8_8to4_4to2_2to1:begin
                temp_result_2[0] <= temp_result_4[0] + temp_result_4[1];
                temp_result_2[1] <= temp_result_4[2] + temp_result_4[3];
                one_elements <= temp_result_2[0] + temp_result_2[1];
            end
            Add16to8_8to4_4to2_2to1:begin
                temp_result_2[0] <= temp_result_4[0] + temp_result_4[1];
                temp_result_2[1] <= temp_result_4[2] + temp_result_4[3];
                one_elements <= temp_result_2[0] + temp_result_2[1];
            end
            Add8to4_4to2_2to1:begin
                temp_result_2[0] <= temp_result_4[0] + temp_result_4[1];
                temp_result_2[1] <= temp_result_4[2] + temp_result_4[3];
                one_elements <= temp_result_2[0] + temp_result_2[1];
            end

            Add4to2_2to1:begin
                temp_result_2[0] <= temp_result_4[0] + temp_result_4[1];
                temp_result_2[1] <= temp_result_4[2] + temp_result_4[3];
                one_elements <= temp_result_2[0] + temp_result_2[1];
            end
            Add2to1:begin
                temp_result_2[0] <= temp_result_2[0];
                temp_result_2[1] <= temp_result_2[1];
                one_elements <= temp_result_2[0] + temp_result_2[1];
            end
            default:begin
                temp_result_2[0] <= temp_result_2[0];
                temp_result_2[1] <= temp_result_2[1];
                one_elements <= 'd0 ;
            end
            endcase
        end
end
endmodule
