`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/01 15:35:15
// Design Name: 
// Module Name: lstm_top
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

`define sigmoid_counter 1024 
`define tanh_counter 1024 
module lstm_top(
    input clk_in,
    input rst,
    input idle,
    output reg done,
    output reg   [63:0]  output_element

    );

wire clk;


reg  [3:0] state;
reg  spv_idle;
reg  spv_idle2;
reg  spv_idle1;
reg  spv_idle3;
reg  sigmoid_idle;
create_clk my_clk
   (
    // Clock out ports
    .clk_out1(clk)     // output clk_out1
   // Clock in ports
    ,.clk_in1(clk_in)
    );      // input clk_in1

// the  paramenter of sparse MxV input and output 
wire [15:0] one_elements0;
wire [15:0] one_elements1;

wire [15:0] one_elements2;
wire [15:0] one_elements3;

wire [15:0] one_elements4;
wire [15:0] one_elements5;

wire [15:0] one_elements6;
wire [15:0] one_elements7;

wire [15:0] one_elements10;
wire [15:0] one_elements11;

wire [15:0] one_elements12;
wire [15:0] one_elements13;

wire [15:0] one_elements14;
wire [15:0] one_elements15;

wire [15:0] one_elements16;
wire [15:0] one_elements17;

wire [15:0] one_elements20;
wire [15:0] one_elements21;

wire [15:0] one_elements22;
wire [15:0] one_elements23;

wire [15:0] one_elements24;
wire [15:0] one_elements25;

wire [15:0] one_elements26;
wire [15:0] one_elements27;

wire [15:0] one_elements30;
wire [15:0] one_elements31;

wire [15:0] one_elements32;
wire [15:0] one_elements33;

wire [15:0] one_elements34;
wire [15:0] one_elements35;

wire [15:0] one_elements36;
wire [15:0] one_elements37;


// the signal of sigmoid temp result
reg  [15:0] sigmoid_input1;
reg  [15:0] sigmoid_input2;
reg  [15:0] sigmoid_input3;
reg  [15:0] sigmoid_input4;
reg  [15:0] sigmoid_input5;
reg  [15:0] sigmoid_input6;
reg  [15:0] sigmoid_input7;
reg  [15:0] sigmoid_input8;
reg  [15:0] sigmoid_input9;
reg  [15:0] sigmoid_input10;
reg  [15:0] sigmoid_input11;
reg  [15:0] sigmoid_input12;
reg  [15:0] sigmoid_input13;
reg  [15:0] sigmoid_input14;
reg  [15:0] sigmoid_input15;
reg  [15:0] sigmoid_input16;


wire [15:0] sigmoid_output1;
wire [15:0] sigmoid_output2;
wire [15:0] sigmoid_output3;
wire [15:0] sigmoid_output4;
wire [15:0] sigmoid_output5;
wire [15:0] sigmoid_output6;
wire [15:0] sigmoid_output7;
wire [15:0] sigmoid_output8;
wire [15:0] sigmoid_output9;
wire [15:0] sigmoid_output10;
wire [15:0] sigmoid_output11;
wire [15:0] sigmoid_output12;
wire [15:0] sigmoid_output13;
wire [15:0] sigmoid_output14;
wire [15:0] sigmoid_output15;
wire [15:0] sigmoid_output16;


wire        sigmoid_dateout1;
wire        sigmoid_dateout2;
wire        sigmoid_dateout3;
wire        sigmoid_dateout4;
wire        sigmoid_dateout5;
wire        sigmoid_dateout6;
wire        sigmoid_dateout7;
wire        sigmoid_dateout8;
wire        sigmoid_dateout9;
wire        sigmoid_dateout10;
wire        sigmoid_dateout11;
wire        sigmoid_dateout12;
wire        sigmoid_dateout13;
wire        sigmoid_dateout14;
wire        sigmoid_dateout15;
wire        sigmoid_dateout16;



wire        start_C_bram1;  // the signal to driver C_bram_in
wire        start_C_bram2;
wire        start_C_bram3;  // the signal to driver C_bram_in
wire        start_C_bram4;
wire        start_C_bram5;  // the signal to driver C_bram_in
wire        start_C_bram6;
wire        start_C_bram7;  // the signal to driver C_bram_in
wire        start_C_bram8;
wire        start_C_bram9;  // the signal to driver C_bram_in
wire        start_C_bram10;
wire        start_C_bram11;  // the signal to driver C_bram_in
wire        start_C_bram12;
wire        start_C_bram13;  // the signal to driver C_bram_in
wire        start_C_bram14;
wire        start_C_bram15;  // the signal to driver C_bram_in
wire        start_C_bram16;

//the signal of ram 
wire   [10:0]     addra      ;  // the addr of W
wire   [10:0]     addra1      ;  // the addr of U
wire   [10:0]     addra2      ;  // the addr of W
wire   [10:0]     addra3      ;  // the addr of U
wire   ena ;
wire   wea ;
wire   ena1 ;
wire   wea1 ;
wire   ena2;
wire   ena3;
wire   wea2;
wire   wea3;
wire   spvdateout;
wire   spvdateout1;

wire   spvdateout2;
wire   spvdateout3;


wire   spv_driver_C_bram1 ;        // is a signal for output stage
wire   spv_driver_C_bram2 ;        // is a signal for output stage
wire   spv_driver_C_bram3 ;        // is a signal for output stage
wire   spv_driver_C_bram4 ;        // is a signal for output stage


// the control signal of forget gate  control mudle
wire   F_start_C_bram_En;
wire   F_start_C_bram_Wea;
wire   F_start_multer_CE;
wire   F_done;
wire   F_start_sigmoid;
reg    F_control_idle ;


// the stage of forget gate 
F_control my_F_control(.clk(clk),.rst(rst),.idle(F_control_idle),.spv_dateout(spvdateout),.sigmoid_dateout(sigmoid_dateout1),.sigmoid_idle(F_start_sigmoid)
,.multer_CE(F_start_multer_CE),.C_bram_En(F_start_C_bram_En),.C_bram_Wea(F_start_C_bram_Wea),.F_done(F_done),.driver_C_bram(start_C_bram1));


// the control signal of C_bram 

reg                  en_C_bram;
reg                  wea_C_bram;
reg   [10:0]         write_C_bram_addr;
reg   [10:0]         read_C_bram_addr;
reg   [255:0]         input_C_bram;
wire  [255:0]         output_C_bram; 

// the bram to store Cell C
C_bram my_C_bram (
  .clka(clk),    // input wire clka
  .wea(wea_C_bram),      // input wire [0 : 0] wea
  .addra(write_C_bram_addr),  // input wire [10 : 0] addra
  .dina(input_C_bram),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(en_C_bram),      // input wire enb
  .addrb(read_C_bram_addr),  // input wire [10 : 0] addrb
  .doutb(output_C_bram)  // output wire [31 : 0] doutb
);

// the ram of xt and xt-1
wire [1023:0]  inputx_output;
wire [1023:0]  inputxt_1_output;
reg    eninputxt ;
reg    weainputxt ;
reg    eninputxt_1 ;
reg    weainputxt_1 ;
reg    [5:0]      inputxt_addr ;
reg    [5:0]      inputxt_1_addr ;
wire   [5:0]      spv_top0_output_addr;
wire   [5:0]      spv_top1_output_addr;
wire   [5:0]      spv_top2_output_addr;
wire   [5:0]      spv_top3_output_addr;


initial_x_new myinitialx (.clka(clk),.ena(eninputxt),.wea(weainputxt),.addra(inputxt_addr),.dina(inputx_output),.douta(inputx_output));
initial_x_new myinitialxt_1 (.clka(clk),.ena(eninputxt_1),.wea(weainputxt_1),.addra(inputxt_1_addr),.dina(inputxt_1_output),.douta(inputxt_1_output));
// the module of sM check
wire   is_Sm;
wire   Sm_is_done ;
reg    SM_idle;
reg    SM_control_idle ;
wire   Start_X_bram_En;
wire   Start_X_bram_Wea;
wire   Start_SM  ;
similarity_check_top my_SM_check(
    .clk(clk),. rst(rst),.idle(SM_idle),.xt(inputx_output),.xt_1(inputxt_1_output),.count(63),.similarity_flag(is_Sm),.SM_done(Sm_is_done)
    );

SM_control  mySM_control(.clk(clk),.rst(rst),.idle(SM_control_idle),.SM_out(Sm_is_done),.Start_SM(Start_SM),.X_bram_En(Start_X_bram_En),.X_bram_Wea(Start_X_bram_Wea));
// the signal of C and forget gate 
reg       [15:0]     Cxf1_input1 ;
reg       [15:0]     Cxf1_input2 ;
wire      [31:0]     Cxf1_result ;
reg       [15:0]     Cxf2_input1 ;
reg       [15:0]     Cxf2_input2 ;
wire      [31:0]     Cxf2_result ;

reg       [15:0]     Cxf3_input1 ;
reg       [15:0]     Cxf3_input2 ;
wire      [31:0]     Cxf3_result ;
reg       [15:0]     Cxf4_input1 ;
reg       [15:0]     Cxf4_input2 ;
wire      [31:0]     Cxf4_result ;


reg       [15:0]     Cxf5_input1 ;
reg       [15:0]     Cxf5_input2 ;
wire      [31:0]     Cxf5_result ;
reg       [15:0]     Cxf6_input1 ;
reg       [15:0]     Cxf6_input2 ;
wire      [31:0]     Cxf6_result ;

reg       [15:0]     Cxf7_input1 ;
reg       [15:0]     Cxf7_input2 ;
wire      [31:0]     Cxf7_result ;
reg       [15:0]     Cxf8_input1 ;
reg       [15:0]     Cxf8_input2 ;
wire      [31:0]     Cxf8_result ;


reg       [15:0]     Cxf9_input1 ;
reg       [15:0]     Cxf9_input2 ;
wire      [31:0]     Cxf9_result ;
reg       [15:0]     Cxf10_input1 ;
reg       [15:0]     Cxf10_input2 ;
wire      [31:0]     Cxf10_result ;

reg       [15:0]     Cxf11_input1 ;
reg       [15:0]     Cxf11_input2 ;
wire      [31:0]     Cxf11_result ;
reg       [15:0]     Cxf12_input1 ;
reg       [15:0]     Cxf12_input2 ;
wire      [31:0]     Cxf12_result ;


reg       [15:0]     Cxf13_input1 ;
reg       [15:0]     Cxf13_input2 ;
wire      [31:0]     Cxf13_result ;
reg       [15:0]     Cxf14_input1 ;
reg       [15:0]     Cxf14_input2 ;
wire      [31:0]     Cxf14_result ;

reg       [15:0]     Cxf15_input1 ;
reg       [15:0]     Cxf15_input2 ;
wire      [31:0]     Cxf15_result ;
reg       [15:0]     Cxf16_input1 ;
reg       [15:0]     Cxf16_input2 ;
wire      [31:0]     Cxf16_result ;

reg                  Cxf_CE ;
// the two multer of C and forget gate 
multer_16x16bit Cxf_multer1(
  .CLK(clk),  // input wire CLK
  .A(Cxf1_input1),      // input wire [15 : 0] A
  .B(Cxf1_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf1_result)      // output wire [31 : 0] P
);
multer_16x16bit Cxf_multer2(
  .CLK(clk),  // input wire CLK
  .A(Cxf2_input1),      // input wire [15 : 0] A
  .B(Cxf2_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf2_result)      // output wire [31 : 0] P
);

multer_16x16bit Cxf_multer3(
  .CLK(clk),  // input wire CLK
  .A(Cxf3_input1),      // input wire [15 : 0] A
  .B(Cxf3_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf3_result)      // output wire [31 : 0] P
);
multer_16x16bit Cxf_multer4(
  .CLK(clk),  // input wire CLK
  .A(Cxf4_input1),      // input wire [15 : 0] A
  .B(Cxf4_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf4_result)      // output wire [31 : 0] P
);

multer_16x16bit Cxf_multer5(
  .CLK(clk),  // input wire CLK
  .A(Cxf5_input1),      // input wire [15 : 0] A
  .B(Cxf5_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf5_result)      // output wire [31 : 0] P
);
multer_16x16bit Cxf_multer6(
  .CLK(clk),  // input wire CLK
  .A(Cxf6_input1),      // input wire [15 : 0] A
  .B(Cxf6_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf6_result)      // output wire [31 : 0] P
);

multer_16x16bit Cxf_multer7(
  .CLK(clk),  // input wire CLK
  .A(Cxf7_input1),      // input wire [15 : 0] A
  .B(Cxf7_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf7_result)      // output wire [31 : 0] P
);
multer_16x16bit Cxf_multer8(
  .CLK(clk),  // input wire CLK
  .A(Cxf8_input1),      // input wire [15 : 0] A
  .B(Cxf8_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf8_result)      // output wire [31 : 0] P
);

multer_16x16bit Cxf_multer9(
  .CLK(clk),  // input wire CLK
  .A(Cxf9_input1),      // input wire [15 : 0] A
  .B(Cxf9_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf9_result)      // output wire [31 : 0] P
);
multer_16x16bit Cxf_multer10(
  .CLK(clk),  // input wire CLK
  .A(Cxf10_input1),      // input wire [15 : 0] A
  .B(Cxf10_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf10_result)      // output wire [31 : 0] P
);

multer_16x16bit Cxf_multer11(
  .CLK(clk),  // input wire CLK
  .A(Cxf11_input1),      // input wire [15 : 0] A
  .B(Cxf11_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf11_result)      // output wire [31 : 0] P
);
multer_16x16bit Cxf_multer12(
  .CLK(clk),  // input wire CLK
  .A(Cxf12_input1),      // input wire [15 : 0] A
  .B(Cxf12_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf12_result)      // output wire [31 : 0] P
);

multer_16x16bit Cxf_multer13(
  .CLK(clk),  // input wire CLK
  .A(Cxf13_input1),      // input wire [15 : 0] A
  .B(Cxf13_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf13_result)      // output wire [31 : 0] P
);
multer_16x16bit Cxf_multer14(
  .CLK(clk),  // input wire CLK
  .A(Cxf14_input1),      // input wire [15 : 0] A
  .B(Cxf14_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf14_result)      // output wire [31 : 0] P
);

multer_16x16bit Cxf_multer15(
  .CLK(clk),  // input wire CLK
  .A(Cxf15_input1),      // input wire [15 : 0] A
  .B(Cxf15_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf15_result)      // output wire [31 : 0] P
);
multer_16x16bit Cxf_multer16(
  .CLK(clk),  // input wire CLK
  .A(Cxf16_input1),      // input wire [15 : 0] A
  .B(Cxf16_input2),      // input wire [15 : 0] B
  .CE(Cxf_CE),    // input wire CE
  .P(Cxf16_result)      // output wire [31 : 0] P
);



// signal of input_w0 and index0

wire [1023:0]  inputw00;
wire [159:0]  inputw_index00;

wire [1023:0]  inputw01;
wire [159:0]  inputw_index01;

wire [1023:0]  inputw02;
wire [159:0]  inputw_index02;

wire [1023:0]  inputw03;
wire [159:0]  inputw_index03;

wire [1023:0]  inputw04;
wire [159:0]  inputw_index04;

wire [1023:0]  inputw05;
wire [159:0]  inputw_index05;

wire [1023:0]  inputw06;
wire [159:0]  inputw_index06;

wire [1023:0]  inputw07;
wire [159:0]  inputw_index07;

wire [1023:0]  inputw08;
wire [159:0]  inputw_index08;

wire [1023:0]  inputw09;
wire [159:0]  inputw_index09;

wire [1023:0]  inputw010;
wire [159:0]  inputw_index010;

wire [1023:0]  inputw011;
wire [159:0]  inputw_index011;

wire [1023:0]  inputw012;
wire [159:0]  inputw_index012;

wire [1023:0]  inputw013;
wire [159:0]  inputw_index013;

wire [1023:0]  inputw014;
wire [159:0]  inputw_index014;

wire [1023:0]  inputw015;
wire [159:0]  inputw_index00;




// wire [4095:0]  inputw10;
// wire [639:0]  inputw_index10;


inputw_0_0  my_inputw_0_0(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw00),.douta(inputw00));
inputw_index_0_0  my_inputw_index_0_0(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index00),.douta(inputw_index00));


inputw_0_0  my_inputw_0_1(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw01),.douta(inputw01));
inputw_index_0_0  my_inputw_index_0_1(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index01),.douta(inputw_index01));

inputw_0_0  my_inputw_0_2(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw02),.douta(inputw02));
inputw_index_0_0  my_inputw_index_0_2(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index02),.douta(inputw_index02));

inputw_0_0  my_inputw_0_3(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw03),.douta(inputw03));
inputw_index_0_0  my_inputw_index_0_3(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index03),.douta(inputw_index03));

inputw_0_0  my_inputw_0_4(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw04),.douta(inputw04));
inputw_index_0_0  my_inputw_index_0_4(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index04),.douta(inputw_index04));

inputw_0_0  my_inputw_0_5(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw05),.douta(inputw05));
inputw_index_0_0  my_inputw_index_0_5(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index05),.douta(inputw_index05));

inputw_0_0  my_inputw_0_6(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw06),.douta(inputw06));
inputw_index_0_0  my_inputw_index_0_6(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index06),.douta(inputw_index06));

inputw_0_0  my_inputw_0_7(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw07),.douta(inputw07));
inputw_index_0_0  my_inputw_index_0_7(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index07),.douta(inputw_index07));

inputw_0_0  my_inputw_0_8(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw08),.douta(inputw08));
inputw_index_0_0  my_inputw_index_0_8(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index08),.douta(inputw_index08));

inputw_0_0  my_inputw_0_9(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw09),.douta(inputw09));
inputw_index_0_0  my_inputw_index_0_9(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index09),.douta(inputw_index09));

inputw_0_0  my_inputw_0_10(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw010),.douta(inputw010));
inputw_index_0_0  my_inputw_index_0_10(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index010),.douta(inputw_index010));

inputw_0_0  my_inputw_0_11(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw011),.douta(inputw011));
inputw_index_0_0  my_inputw_index_0_11(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index011),.douta(inputw_index011));


inputw_0_0  my_inputw_0_12(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw012),.douta(inputw012));
inputw_index_0_0  my_inputw_index_0_12(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index012),.douta(inputw_index012));

inputw_0_0  my_inputw_0_13(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw013),.douta(inputw013));
inputw_index_0_0  my_inputw_index_0_13(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index013),.douta(inputw_index013));

inputw_0_0  my_inputw_0_14(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw014),.douta(inputw014));
inputw_index_0_0  my_inputw_index_0_14(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index014),.douta(inputw_index014));

inputw_0_0  my_inputw_0_15(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw015),.douta(inputw015));
inputw_index_0_0  my_inputw_index_0_15(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index015),.douta(inputw_index015));

// inputw_1_0  my_inputw_1_0(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw10),.douta(inputw10));
// inputw_index_1_0  my_inputw_index_1_0(.clka(clk),.ena(ena),.wea(wea),.addra(addra),.dina(inputw_index10),.douta(inputw_index10));

sigmoid_function sigmoid_function1(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input1),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output1),.sigmoid_dateout(sigmoid_dateout1),.start_C_bram(start_C_bram1));
sigmoid_function sigmoid_function2(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input2),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output2),.sigmoid_dateout(sigmoid_dateout2),.start_C_bram(start_C_bram2));

sigmoid_function sigmoid_function3(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input3),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output3),.sigmoid_dateout(sigmoid_dateout3),.start_C_bram(start_C_bram3));
sigmoid_function sigmoid_function4(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input4),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output4),.sigmoid_dateout(sigmoid_dateout4),.start_C_bram(start_C_bram4));

sigmoid_function sigmoid_function5(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input5),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output5),.sigmoid_dateout(sigmoid_dateout5),.start_C_bram(start_C_bram5));
sigmoid_function sigmoid_function6(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input6),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output6),.sigmoid_dateout(sigmoid_dateout6),.start_C_bram(start_C_bram6));

sigmoid_function sigmoid_function7(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input7),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output7),.sigmoid_dateout(sigmoid_dateout7),.start_C_bram(start_C_bram7));
sigmoid_function sigmoid_function8(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input8),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output8),.sigmoid_dateout(sigmoid_dateout8),.start_C_bram(start_C_bram8));

sigmoid_function sigmoid_function9(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input9),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output9),.sigmoid_dateout(sigmoid_dateout9),.start_C_bram(start_C_bram9));
sigmoid_function sigmoid_function10(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input10),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output10),.sigmoid_dateout(sigmoid_dateout10),.start_C_bram(start_C_bram10));

sigmoid_function sigmoid_function11(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input11),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output11),.sigmoid_dateout(sigmoid_dateout11),.start_C_bram(start_C_bram11));
sigmoid_function sigmoid_function12(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input12),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output12),.sigmoid_dateout(sigmoid_dateout12),.start_C_bram(start_C_bram12));

sigmoid_function sigmoid_function13(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input13),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output13),.sigmoid_dateout(sigmoid_dateout13),.start_C_bram(start_C_bram13));
sigmoid_function sigmoid_function14(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input14),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output14),.sigmoid_dateout(sigmoid_dateout14),.start_C_bram(start_C_bram14));

sigmoid_function sigmoid_function15(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input15),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output15),.sigmoid_dateout(sigmoid_dateout15),.start_C_bram(start_C_bram15));
sigmoid_function sigmoid_function16(.clk(clk),.rst(rst),.idle(sigmoid_idle),.one_elements_in(sigmoid_input16),.counter(`sigmoid_counter),.res_sigmoid(sigmoid_output16),.sigmoid_dateout(sigmoid_dateout16),.start_C_bram(start_C_bram16));

// wire  spv0_out_weainputxt;
// wire  spv0_out_eninputxt;


// wire [4095:0]  inputw02;
// wire [4095:0]  inputw12;
// wire [639:0]  inputw_index02;
// wire [639:0]  inputw_index12;


// inputw_0_2  my_inputw_0_2(.clka(clk),.ena(ena2),.wea(wea2),.addra(addra),.dina(inputw02),.douta(inputw02));
// inputw_index_0_2  my_inputw_index_0_2(.clka(clk),.ena(ena2),.wea(wea2),.addra(addra),.dina(inputw_index02),.douta(inputw_index02));
// inputw_1_2  my_inputw_1_2(.clka(clk),.ena(ena2),.wea(wea2),.addra(addra),.dina(inputw12),.douta(inputw12));
// inputw_index_1_2  my_inputw_index_1_2(.clka(clk),.ena(ena2),.wea(wea2),.addra(addra),.dina(inputw_index12),.douta(inputw_index12));



wire  spv0_out_weainputxt2;
wire  spv0_out_eninputxt2;


// sparse_mxv_top_top my_sparse_mxv_top_top(.clk(clk),.rst(rst),.idle(spv_idle),.ena(ena),.wea(wea),.dateout(spvdateout),.eninput(spv0_out_eninputxt),.weainput(spv0_out_weainputxt)
// ,.inputx_output(inputx_output),.inputw0(inputw00),.inputw1(inputw01),.inputw2(inputw02),.inputw3(inputw03)
// ,.inputw4(inputw04),.inputw5(inputw05),.inputw6(inputw06),.inputw7(inputw07)
// ,.inputw8(inputw08),.inputw9(inputw09),.inputw10(inputw010),.inputw11(inputw011)
// ,.inputw12(inputw012),.inputw13(inputw013),.inputw14(inputw014),.inputw15(inputw015)

// ,.inputw_index0(inputw_index00),.inputw_index1(inputw_index01),.inputw_index2(inputw_index02),.inputw_index3(inputw_index03)
// ,.inputw_index4(inputw_index04),.inputw_index5(inputw_index05),.inputw_index6(inputw_index06),.inputw_index7(inputw_index07)
// ,.inputw_index8(inputw_index08),.inputw_index9(inputw_index09),.inputw_index10(inputw_index010),.inputw_index11(inputw_index011)
// ,.inputw_index12(inputw_index012),.inputw_index13(inputw_index013),.inputw_index14(inputw_index014),.inputw_index15(inputw_index015)


// ,.one_elements0(one_elements0),.one_elements1(one_elements1),.one_elements2(one_elements2),.one_elements3(one_elements3)
// ,.one_elements4(one_elements4),.one_elements5(one_elements5),.one_elements6(one_elements6),.one_elements7(one_elements7)
// ,.one_elements8(one_elements10),.one_elements9(one_elements11),.one_elements10(one_elements12),.one_elements11(one_elements13)
// ,.one_elements12(one_elements14),.one_elements13(one_elements15),.one_elements14(one_elements16),.one_elements15(one_elements17)

// ,.input_addr(spv_top0_output_addr),.addra(addra),.spv_driver_C_bram(spv_driver_C_bram1)) ;






sparse_mxv_top_top my_sparse_mxv_top_top(.clk(clk),.rst(rst),.idle(spv_idle),.ena(ena),.wea(wea),.dateout(spvdateout),.eninput(spv0_out_eninputxt),.weainput(spv0_out_weainputxt)
,.inputx_output(inputx_output),.inputw0(inputw00),.inputw1(inputw01),.inputw2(inputw02),.inputw3(inputw03)
,.inputw4(inputw04),.inputw5(inputw05),.inputw6(inputw06),.inputw7(inputw07)


,.inputw_index0(inputw_index00),.inputw_index1(inputw_index01),.inputw_index2(inputw_index02),.inputw_index3(inputw_index03)
,.inputw_index4(inputw_index04),.inputw_index5(inputw_index05),.inputw_index6(inputw_index06),.inputw_index7(inputw_index07)



,.one_elements0(one_elements0),.one_elements1(one_elements1),.one_elements2(one_elements2),.one_elements3(one_elements3)
,.one_elements4(one_elements4),.one_elements5(one_elements5),.one_elements6(one_elements6),.one_elements7(one_elements7)


,.input_addr(spv_top0_output_addr),.addra(addra),.spv_driver_C_bram(spv_driver_C_bram1)) ;




sparse_mxv_top_top my_sparse_mxv_top_top2(.clk(clk),.rst(rst),.idle(spv_idle1),.ena(ena2),.wea(wea2),.dateout(spvdateout2),.eninput(spv0_out_enispv0_out_eninputxt2nputxt),.weainput(spv0_out_weainputxt2)
,.inputx_output(inputx_output),.inputw0(inputw08),.inputw1(inputw09),.inputw2(inputw010),.inputw3(inputw011)
,.inputw4(inputw012),.inputw5(inputw013),.inputw6(inputw014),.inputw7(inputw015)


,.inputw_index0(inputw_index08),.inputw_index1(inputw_index09),.inputw_index2(inputw_index010),.inputw_index3(inputw_index011)
,.inputw_index4(inputw_index012),.inputw_index5(inputw_index013),.inputw_index6(inputw_index014),.inputw_index7(inputw_index015)



,.one_elements0(one_elements10),.one_elements1(one_elements11),.one_elements2(one_elements12),.one_elements3(one_elements13)
,.one_elements4(one_elements14),.one_elements5(one_elements15),.one_elements6(one_elements16),.one_elements7(one_elements17)


,.input_addr(spv_top2_output_addr),.addra(addra2),.spv_driver_C_bram(spv_driver_C_bram3)) ;







//#sparse_mxv_top_top my_sparse_mxv_top_top2(.clk(clk),.rst(rst),.idle(spv_idle),.ena(ena2),.wea(wea2),.dateout(spvdateout2),.eninput(spv0_out_eninputxt2),.weainput(spv0_out_weainputxt2)
//,.inputx_output(inputx_output),.inputw0(inputw02),.inputw1(inputw12)
//,.inputw_index0(inputw_index02),.inputw_index1(inputw_index12)
//,.one_elements0(one_elements2),.one_elements1(one_elements3),.input_addr(spv_top2_output_addr),.addra(addra2),.spv_driver_C_bram(spv_driver_C_bram3)) ;


// signal of input_w1 and index1
wire [1023:0]  inputh_output;
reg  [31:0]    inputh_input;
// wire [4095:0]  inputw01;
// wire [4095:0]  inputw11;
// wire [639:0]  inputw_index01;
// wire [639:0]  inputw_index11;

reg    eninputht ;
reg    weainputht ;
reg    eninputhta;
reg   [10:0]      inputht_addr ;
reg   [10:0]      inputht_addra ;

ht_1_bram myinitialh (
  .clka(clk),    // input wire clka
  .ena(eninputhta),      // input wire ena
  .wea(weainputht),   // input wire [0 : 0] wea
  .addra(inputht_addra),  // input wire [10 : 0] addra
  .dina(inputh_input),    // input wire [31 : 0] dina
  .clkb(clk),    // input wire clkb
  .enb(eninputht),      // input wire enb
  .addrb(inputht_addr),  // input wire [5 : 0] addrb
  .doutb(inputh_output)  // output wire [1023 : 0] doutb
);


wire  spv1_out_eninputht;
wire  spv1_out_weainputht;


wire [1023:0]  inputw10;
wire [1023:0]  inputw11;
wire [1023:0]  inputw12;
wire [1023:0]  inputw13;
wire [1023:0]  inputw14;
wire [1023:0]  inputw15;
wire [1023:0]  inputw16;
wire [1023:0]  inputw17;
wire [1023:0]  inputw18;
wire [1023:0]  inputw19;
wire [1023:0]  inputw110;
wire [1023:0]  inputw111;
wire [1023:0]  inputw112;
wire [1023:0]  inputw113;
wire [1023:0]  inputw114;
wire [1023:0]  inputw115;


wire [159:0]  inputw_index10;
wire [159:0]  inputw_index11;
wire [159:0]  inputw_index12;
wire [159:0]  inputw_index13;
wire [159:0]  inputw_index14;
wire [159:0]  inputw_index15;
wire [159:0]  inputw_index16;
wire [159:0]  inputw_index17;
wire [159:0]  inputw_index18;
wire [159:0]  inputw_index19;
wire [159:0]  inputw_index110;
wire [159:0]  inputw_index111;
wire [159:0]  inputw_index112;
wire [159:0]  inputw_index113;
wire [159:0]  inputw_index114;
wire [159:0]  inputw_index115;

inputw_0_0  my_inputw_1_0(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw10),.douta(inputw10));
inputw_index_0_0  my_inputw_index_1_0(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index10),.douta(inputw_index10));


inputw_0_0  my_inputw_1_1(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw11),.douta(inputw11));
inputw_index_0_0  my_inputw_index_1_1(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index11),.douta(inputw_index11));

inputw_0_0  my_inputw_1_2(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw12),.douta(inputw12));
inputw_index_0_0  my_inputw_index_1_2(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index12),.douta(inputw_index12));

inputw_0_0  my_inputw_1_3(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw13),.douta(inputw13));
inputw_index_0_0  my_inputw_index_1_3(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index13),.douta(inputw_index13));

inputw_0_0  my_inputw_1_4(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw14),.douta(inputw14));
inputw_index_0_0  my_inputw_index_1_4(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index14),.douta(inputw_index14));

inputw_0_0  my_inputw_1_5(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw15),.douta(inputw15));
inputw_index_0_0  my_inputw_index_1_5(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index15),.douta(inputw_index15));

inputw_0_0  my_inputw_1_6(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw16),.douta(inputw16));
inputw_index_0_0  my_inputw_index_1_6(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index16),.douta(inputw_index16));

inputw_0_0  my_inputw_1_7(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw17),.douta(inputw17));
inputw_index_0_0  my_inputw_index_1_7(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index17),.douta(inputw_index17));

inputw_0_0  my_inputw_1_8(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw18),.douta(inputw18));
inputw_index_0_0  my_inputw_index_1_8(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index18),.douta(inputw_index18));

inputw_0_0  my_inputw_1_9(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw19),.douta(inputw19));
inputw_index_0_0  my_inputw_index_1_9(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index19),.douta(inputw_index19));

inputw_0_0  my_inputw_1_10(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw110),.douta(inputw110));
inputw_index_0_0  my_inputw_index_1_10(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index110),.douta(inputw_index110));

inputw_0_0  my_inputw_1_11(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw111),.douta(inputw111));
inputw_index_0_0  my_inputw_index_1_11(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index111),.douta(inputw_index111));


inputw_0_0  my_inputw_1_12(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw112),.douta(inputw112));
inputw_index_0_0  my_inputw_index_1_12(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index112),.douta(inputw_index112));

inputw_0_0  my_inputw_1_13(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw113),.douta(inputw113));
inputw_index_0_0  my_inputw_index_1_13(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index113),.douta(inputw_index113));

inputw_0_0  my_inputw_1_14(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw114),.douta(inputw114));
inputw_index_0_0  my_inputw_index_1_14(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index114),.douta(inputw_index114));

inputw_0_0  my_inputw_1_15(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw115),.douta(inputw115));
inputw_index_0_0  my_inputw_index_1_15(.clka(clk),.ena(ena),.wea(wea),.addra(addra1),.dina(inputw_index115),.douta(inputw_index115));




// inputw_0_1  my_inputw_0_1(.clka(clk),.ena(ena1),.wea(wea1),.addra(addra1),.dina(inputw01),.douta(inputw01));
// inputw_index_0_1  my_inputw_index_0_1(.clka(clk),.ena(ena1),.wea(wea1),.addra(addra1),.dina(inputw_index01),.douta(inputw_index01));
// inputw_1_1  my_inputw_1_1(.clka(clk),.ena(ena1),.wea(wea1),.addra(addra1),.dina(inputw11),.douta(inputw11));
// inputw_index_1_1  my_inputw_index_1_1(.clka(clk),.ena(ena1),.wea(wea1),.addra(addra1),.dina(inputw_index11),.douta(inputw_index11));




// inputw_0_3  my_inputw_0_3(.clka(clk),.ena(ena3),.wea(wea3),.addra(addra1),.dina(inputw03),.douta(inputw03));
// inputw_index_0_3  my_inputw_index_0_3(.clka(clk),.ena(ena3),.wea(wea3),.addra(addra1),.dina(inputw_index03),.douta(inputw_index03));
// inputw_1_3  my_inputw_1_3(.clka(clk),.ena(ena3),.wea(wea3),.addra(addra1),.dina(inputw13),.douta(inputw13));
// inputw_index_1_3  my_inputw_index_1_3(.clka(clk),.ena(ena3),.wea(wea3),.addra(addra1),.dina(inputw_index13),.douta(inputw_index13));


wire  spv1_out_eninputht3;
wire  spv1_out_weainputht3;

sparse_mxv_top_top my_sparse_mxv_top_top1(.clk(clk),.rst(rst),.idle(spv_idle2),.ena(ena1),.wea(wea1),.dateout(spvdateout1),.eninput(spv1_out_eninputht),.weainput(spv1_out_weainputht)
,.inputx_output(inputh_output)
,.inputw0(inputw10),.inputw1(inputw11),.inputw2(inputw12),.inputw3(inputw13)
,.inputw4(inputw14),.inputw5(inputw15),.inputw6(inputw16),.inputw7(inputw17)


,.inputw_index0(inputw_index10),.inputw_index1(inputw_index11),.inputw_index2(inputw_index12),.inputw_index3(inputw_index13)
,.inputw_index4(inputw_index14),.inputw_index5(inputw_index15),.inputw_index6(inputw_index16),.inputw_index7(inputw_index17)



,.one_elements0(one_elements20),.one_elements1(one_elements21),.one_elements2(one_elements22),.one_elements3(one_elements23)
,.one_elements4(one_elements24),.one_elements5(one_elements25),.one_elements6(one_elements26),.one_elements7(one_elements27)

,.input_addr(spv_top1_output_addr),.addra(addra1),.spv_driver_C_bram(spv_driver_C_bram2)) ;



sparse_mxv_top_top my_sparse_mxv_top_top3(.clk(clk),.rst(rst),.idle(spv_idle3),.ena(ena3),.wea(wea3),.dateout(spvdateout3),.eninput(spv1_out_eninputht3),.weainput(spv1_out_weainputht3)
,.inputx_output(inputh_output)
,.inputw0(inputw18),.inputw1(inputw19),.inputw2(inputw110),.inputw3(inputw111)
,.inputw4(inputw112),.inputw5(inputw113),.inputw6(inputw114),.inputw7(inputw115)


,.inputw_index0(inputw_index18),.inputw_index1(inputw_index19),.inputw_index2(inputw_index110),.inputw_index3(inputw_index111)
,.inputw_index4(inputw_index112),.inputw_index5(inputw_index113),.inputw_index6(inputw_index114),.inputw_index7(inputw_index115)



,.one_elements0(one_elements30),.one_elements1(one_elements31),.one_elements2(one_elements32),.one_elements3(one_elements33)
,.one_elements4(one_elements34),.one_elements5(one_elements35),.one_elements6(one_elements36),.one_elements7(one_elements37)

,.input_addr(spv_top3_output_addr),.addra(addra3),.spv_driver_C_bram(spv_driver_C_bram4)) ;



//sparse_mxv_top_top my_sparse_mxv_top_top3(.clk(clk),.rst(rst),.idle(spv_idle),.ena(ena3),.wea(wea3),.dateout(spvdateout3),.eninput(spv1_out_eninputht3),.weainput(spv1_out_weainputht3)
//,.inputx_output(inputh_output),.inputw0(inputw03),.inputw1(inputw13)
//,.inputw_index0(inputw_index03),.inputw_index1(inputw_index13)
//,.one_elements0(one_elements6),.one_elements1(one_elements7),.input_addr(spv_top3_output_addr),.addra(addra3),.spv_driver_C_bram(spv_driver_C_bram4)) ;



    parameter  Start             = 0;
    parameter  SM_check          = 1;
    parameter  Forget_stage      = 2;
    parameter  Input_stage       = 3;
    parameter  A_stage           = 4;
    parameter  Output_stage      = 5;
    parameter  Stop              = 9;
    parameter  RRR               = 10;
    

// the control signal of forget gate  control mudle
wire   I_start_I_bram_Wea;
wire   I_done;
wire   I_start_sigmoid;
reg    I_control_idle ;


// the stage of forget gate 
I_control my_I_control(.clk(clk),.rst(rst),.idle(I_control_idle),.spv_dateout(spvdateout),.sigmoid_dateout(sigmoid_dateout1),.sigmoid_idle(I_start_sigmoid)
,.I_bram_Wea(I_start_I_bram_Wea),.I_done(I_done));


//  the tempresult of Input_Stage 
reg                      En_I_bram;
reg                      Wea_I_bram;
reg       [12:0]          I_bram_addr;
reg       [256:0]         I_bram_input;
wire      [256:0]         I_bram_output;

I_bram my_I_bram (
  .clka(clk),    // input wire clka
  .ena(En_I_bram),      // input wire ena
  .wea(Wea_I_bram),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [10 : 0] addra
  .dina(I_bram_input),    // input wire [31 : 0] dina
  .douta(I_bram_output)  // output wire [31 : 0] douta
);


// the     tanh     signal 
reg          tanh_idle   ;
reg          A_control_idle ;

// the signal of sigmoid temp result
reg  [15:0] tanh_input1;
reg  [15:0] tanh_input2;
reg  [15:0] tanh_input3;
reg  [15:0] tanh_input4;
reg  [15:0] tanh_input5;
reg  [15:0] tanh_input6;
reg  [15:0] tanh_input7;
reg  [15:0] tanh_input8;
reg  [15:0] tanh_input9;
reg  [15:0] tanh_input10;
reg  [15:0] tanh_input11;
reg  [15:0] tanh_input12;
reg  [15:0] tanh_input13;
reg  [15:0] tanh_input14;
reg  [15:0] tanh_input15;
reg  [15:0] tanh_input16;


wire [15:0] tanh_output1;
wire [15:0] tanh_output2;
wire [15:0] tanh_output3;
wire [15:0] tanh_output4;
wire [15:0] tanh_output5;
wire [15:0] tanh_output6;
wire [15:0] tanh_output7;
wire [15:0] tanh_output8;
wire [15:0] tanh_output9;
wire [15:0] tanh_output10;
wire [15:0] tanh_output11;
wire [15:0] tanh_output12;
wire [15:0] tanh_output13;
wire [15:0] tanh_output14;
wire [15:0] tanh_output15;
wire [15:0] tanh_output16;

wire        tanh_dateout1;
wire        tanh_dateout2;
wire        tanh_dateout3;
wire        tanh_dateout4;
wire        tanh_dateout5;
wire        tanh_dateout6;
wire        tanh_dateout7;
wire        tanh_dateout8;
wire        tanh_dateout9;
wire        tanh_dateout10;
wire        tanh_dateout11;
wire        tanh_dateout12;
wire        tanh_dateout13;
wire        tanh_dateout14;
wire        tanh_dateout15;
wire        tanh_dateout16;


wire        start_I_bram1;  // the signal to driver C_bram_in
wire        start_I_bram2;
wire        start_I_bram3;  
wire        start_I_bram4;
wire        start_I_bram5;  // the signal to driver C_bram_in
wire        start_I_bram6;
wire        start_I_bram7;  
wire        start_I_bram8;
wire        start_I_bram9;  // the signal to driver C_bram_in
wire        start_I_bram10;
wire        start_I_bram11;  
wire        start_I_bram12;
wire        start_I_bram13;  // the signal to driver C_bram_in
wire        start_I_bram14;
wire        start_I_bram15;  
wire        start_I_bram16;








wire        A_start_tanh ;
wire        A_start_multer_CE ;
wire        A_start_I_bram_En ;
wire        A_start_C_bram_Wea ;
wire        A_done ;
wire        A_Start_Add;
wire        A_start_C_bram_En ;




tanh_function tanh_function1(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input1),.counter(`tanh_counter),.res_tanh(tanh_output1),.tanh_dateout(tanh_dateout1),.start_I_bram(start_I_bram1));
tanh_function tanh_function2(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input2),.counter(`tanh_counter),.res_tanh(tanh_output2),.tanh_dateout(tanh_dateout2),.start_I_bram(start_I_bram2));
tanh_function tanh_function3(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input3),.counter(`tanh_counter),.res_tanh(tanh_output3),.tanh_dateout(tanh_dateout3),.start_I_bram(start_I_bram3));
tanh_function tanh_function4(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input4),.counter(`tanh_counter),.res_tanh(tanh_output4),.tanh_dateout(tanh_dateout4),.start_I_bram(start_I_bram4));
tanh_function tanh_function5(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input5),.counter(`tanh_counter),.res_tanh(tanh_output5),.tanh_dateout(tanh_dateout5),.start_I_bram(start_I_bram5));
tanh_function tanh_function6(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input6),.counter(`tanh_counter),.res_tanh(tanh_output6),.tanh_dateout(tanh_dateout6),.start_I_bram(start_I_bram6));
tanh_function tanh_function7(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input7),.counter(`tanh_counter),.res_tanh(tanh_output7),.tanh_dateout(tanh_dateout7),.start_I_bram(start_I_bram7));
tanh_function tanh_function8(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input8),.counter(`tanh_counter),.res_tanh(tanh_output8),.tanh_dateout(tanh_dateout8),.start_I_bram(start_I_bram8));
tanh_function tanh_function9(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input9),.counter(`tanh_counter),.res_tanh(tanh_output9),.tanh_dateout(tanh_dateout9),.start_I_bram(start_I_bram9));
tanh_function tanh_function10(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input10),.counter(`tanh_counter),.res_tanh(tanh_output10),.tanh_dateout(tanh_dateout10),.start_I_bram(start_I_bram10));
tanh_function tanh_function11(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input11),.counter(`tanh_counter),.res_tanh(tanh_output11),.tanh_dateout(tanh_dateout11),.start_I_bram(start_I_bram11));
tanh_function tanh_function12(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input12),.counter(`tanh_counter),.res_tanh(tanh_output12),.tanh_dateout(tanh_dateout12),.start_I_bram(start_I_bram12));
tanh_function tanh_function13(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input13),.counter(`tanh_counter),.res_tanh(tanh_output13),.tanh_dateout(tanh_dateout13),.start_I_bram(start_I_bram13));
tanh_function tanh_function14(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input14),.counter(`tanh_counter),.res_tanh(tanh_output14),.tanh_dateout(tanh_dateout14),.start_I_bram(start_I_bram14));
tanh_function tanh_function15(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input15),.counter(`tanh_counter),.res_tanh(tanh_output15),.tanh_dateout(tanh_dateout15),.start_I_bram(start_I_bram15));
tanh_function tanh_function16(.clk(clk),.rst(rst),.idle(tanh_idle),.one_elements_in(tanh_input16),.counter(`tanh_counter),.res_tanh(tanh_output16),.tanh_dateout(tanh_dateout16),.start_I_bram(start_I_bram16));



// the   stage   of   A stage   
A_control my_A_control(.clk(clk),.rst(rst),.idle(A_control_idle),.spv_dateout(spvdateout),.tanh_dateout(tanh_dateout1),.tanh_idle(A_start_tanh)
,.multer_CE(A_start_multer_CE),.I_bram_En(A_start_I_bram_En),.C_bram_Wea(A_start_C_bram_Wea),.C_bram_En(A_start_C_bram_En),.A_done(A_done),.driver_I_bram(start_I_bram1),.A_Start_Add(A_Start_Add));




// the  stage   of  Output 
reg                 Output_control_idle  ;
wire                Out_start_tanh;
wire                Output_start_multer_CE ;
wire                Output_start_C_bram_En ;
wire                Output_start_H_bram_Wea ;
wire                Output_done ;
Output_control my_Output_control(.clk(clk),.rst(rst),.idle(Output_control_idle),.spv_dateout(spvdateout),.tanh_dateout(tanh_dateout1),.tanh_idle(Out_start_tanh)
,.multer_CE(Output_start_multer_CE),.C_bram_En(Output_start_C_bram_En),.H_bram_Wea(Output_start_H_bram_Wea),.Output_done(Output_done),.driver_C_bram(start_C_bram1));





    always @ (posedge clk) begin
        done <= 0;
        if(!rst) begin
            state <= RRR ;              //   to  rst state 
            SM_idle <= 1;               // the SM idle 
            F_control_idle <= 1;        // the forget stage  control idle 
            spv_idle <= 1;              // the  spv module idle 
            spv_idle1 <= 1;              // the  spv module idle 
            spv_idle2 <= 1;              // the  spv module idle 
            spv_idle3 <= 1;              // the  spv module idle 
            sigmoid_idle <= 1;          // the sigmoid idle 
            weainputxt <= 0;            // the signal to start  write xt bram 
            eninputxt  <= 0;            // the signal to start  read xt bram 
            inputxt_addr <= 'b11111 ;   // the xt bram addr    initial -1
            weainputxt_1 <= 0;          // the signal to start  write xt-1 bram 
            eninputxt_1  <= 0;           // the signal to start  read xt-1 bram 
            weainputht <=0 ;            // the signal to start  write ht bram 
            eninputht <=0 ;             // the signal to start  read  ht bram 
            inputxt_1_addr <= 'b11111 ;  // the xt-1 bram addr  initial -1
            read_C_bram_addr <= -1;      // the read C  bram addr  initial -1
            write_C_bram_addr <= -1;     // the wirte C  bram addr  initial -1
            SM_control_idle <= 1;        // the SM  control idle 
            I_control_idle <= 1;         // the Input stage  control idle 
            I_bram_addr <= -1;           // the addr of I bram
            A_control_idle <= 1;         // the A stage  control idle 
            tanh_idle <= 1;              // the tanh function idle 
            Output_control_idle <= 1;    // the control module of Output idle 
            inputht_addra  <= -1 ;       // the bram of h addr
            I_bram_input <= I_bram_input ;
            input_C_bram <= input_C_bram;

            sigmoid_input1 <= sigmoid_input1 ;
            sigmoid_input2 <= sigmoid_input2 ;
            sigmoid_input3 <= sigmoid_input3 ;
            sigmoid_input4 <= sigmoid_input4 ;
            sigmoid_input5 <= sigmoid_input5 ;
            sigmoid_input6 <= sigmoid_input6 ;
            sigmoid_input7 <= sigmoid_input7 ;
            sigmoid_input8 <= sigmoid_input8 ;
            sigmoid_input9 <= sigmoid_input9 ;
            sigmoid_input10 <= sigmoid_input10 ;
            sigmoid_input11 <= sigmoid_input11 ;
            sigmoid_input12 <= sigmoid_input12 ;
            sigmoid_input13 <= sigmoid_input13 ;
            sigmoid_input14 <= sigmoid_input14 ;
            sigmoid_input15 <= sigmoid_input15 ;
            sigmoid_input16 <= sigmoid_input16 ;

            tanh_input1 <= tanh_input1 ;
            tanh_input2 <= tanh_input2 ;
            tanh_input3 <= tanh_input3 ;
            tanh_input4 <= tanh_input4 ;
            tanh_input5 <= tanh_input5 ;
            tanh_input6 <= tanh_input6 ;
            tanh_input7 <= tanh_input7 ;
            tanh_input8 <= tanh_input8 ;
            tanh_input9 <= tanh_input9 ;
            tanh_input10 <= tanh_input10 ;
            tanh_input11 <= tanh_input11 ;
            tanh_input12 <= tanh_input12 ;
            tanh_input13 <= tanh_input13 ;
            tanh_input14 <= tanh_input14 ;
            tanh_input15 <= tanh_input15 ;
            tanh_input16 <= tanh_input16 ;

            Cxf1_input1 <= Cxf1_input1 ;
            Cxf1_input2 <= Cxf1_input2;
            Cxf2_input1 <= Cxf2_input1;
            Cxf2_input2 <= Cxf2_input2 ;
            Cxf3_input1 <= Cxf3_input1 ;
            Cxf3_input2 <= Cxf3_input2;
            Cxf4_input1 <= Cxf4_input1;
            Cxf4_input2 <= Cxf4_input2 ;
            
            Cxf5_input1 <= Cxf5_input1 ;
            Cxf5_input2 <= Cxf5_input2;
            Cxf6_input1 <= Cxf6_input1;
            Cxf6_input2 <= Cxf6_input2 ;
            Cxf7_input1 <= Cxf7_input1 ;
            Cxf7_input2 <= Cxf7_input2;
            Cxf8_input1 <= Cxf8_input1;
            Cxf8_input2 <= Cxf8_input2 ;

            Cxf9_input1 <= Cxf9_input1 ;
            Cxf9_input2 <= Cxf9_input2;
            Cxf10_input1 <= Cxf10_input1;
            Cxf10_input2 <= Cxf10_input2 ;
            Cxf11_input1 <= Cxf11_input1 ;
            Cxf11_input2 <= Cxf11_input2;
            Cxf12_input1 <= Cxf12_input1;
            Cxf12_input2 <= Cxf12_input2 ;

            Cxf13_input1 <= Cxf13_input1 ;
            Cxf13_input2 <= Cxf13_input2;
            Cxf14_input1 <= Cxf14_input1;
            Cxf14_input2 <= Cxf14_input2 ;
            Cxf15_input1 <= Cxf15_input1 ;
            Cxf15_input2 <= Cxf15_input2;
            Cxf16_input1 <= Cxf16_input1;
            Cxf16_input2 <= Cxf16_input2 ;
        end
        else if (idle) begin
            done <= 0;
            state <= Start ;              //   to  idle state 
            SM_idle <= 1;               // the SM idle 
            F_control_idle <= 1;        // the forget stage  control idle 
            spv_idle <= 1;              // the  spv module idle 
            spv_idle1 <= 1;              // the  spv module idle 
            spv_idle2 <= 1;              // the  spv module idle 
            spv_idle3 <= 1;              // the  spv module idle 
            sigmoid_idle <= 1;          // the sigmoid idle 
            weainputxt <= 0;            // the signal to start  write xt bram 
            eninputxt  <= 0;            // the signal to start  read xt bram 
            inputxt_addr <= 'b11111 ;   // the xt bram addr    initial -1
            weainputxt_1 <= 0;          // the signal to start  write xt-1 bram 
            eninputxt_1  <= 0;           // the signal to start  read xt-1 bram 
            weainputht <=0 ;            // the signal to start  write ht bram 
            eninputht <=0 ;             // the signal to start  read  ht bram 
            inputxt_1_addr <= 'b11111 ;  // the xt-1 bram addr  initial -1
            read_C_bram_addr <= -1;      // the read C  bram addr  initial -1
            write_C_bram_addr <= -1;     // the wirte C  bram addr  initial -1
            SM_control_idle <= 1;        // the SM  control idle 
            I_control_idle <= 1;         // the Input stage  control idle 
            I_bram_addr <= -1;           // the addr of I bram
            A_control_idle <= 1;         // the A stage  control idle 
            tanh_idle <= 1;              // the tanh function idle 
            Output_control_idle <= 1;    // the control module of Output idle 
            inputht_addra  <= -1 ;       // the bram of h addr
            I_bram_input <= I_bram_input ;
            input_C_bram <= input_C_bram;

            sigmoid_input1 <= sigmoid_input1 ;
            sigmoid_input2 <= sigmoid_input2 ;
            sigmoid_input3 <= sigmoid_input3 ;
            sigmoid_input4 <= sigmoid_input4 ;
            sigmoid_input5 <= sigmoid_input5 ;
            sigmoid_input6 <= sigmoid_input6 ;
            sigmoid_input7 <= sigmoid_input7 ;
            sigmoid_input8 <= sigmoid_input8 ;
            sigmoid_input9 <= sigmoid_input9 ;
            sigmoid_input10 <= sigmoid_input10 ;
            sigmoid_input11 <= sigmoid_input11 ;
            sigmoid_input12 <= sigmoid_input12 ;
            sigmoid_input13 <= sigmoid_input13 ;
            sigmoid_input14 <= sigmoid_input14 ;
            sigmoid_input15 <= sigmoid_input15 ;
            sigmoid_input16 <= sigmoid_input16 ;

            tanh_input1 <= tanh_input1 ;
            tanh_input2 <= tanh_input2 ;
            tanh_input3 <= tanh_input3 ;
            tanh_input4 <= tanh_input4 ;
            tanh_input5 <= tanh_input5 ;
            tanh_input6 <= tanh_input6 ;
            tanh_input7 <= tanh_input7 ;
            tanh_input8 <= tanh_input8 ;
            tanh_input9 <= tanh_input9 ;
            tanh_input10 <= tanh_input10 ;
            tanh_input11 <= tanh_input11 ;
            tanh_input12 <= tanh_input12 ;
            tanh_input13 <= tanh_input13 ;
            tanh_input14 <= tanh_input14 ;
            tanh_input15 <= tanh_input15 ;
            tanh_input16 <= tanh_input16 ;

            Cxf1_input1 <= Cxf1_input1 ;
            Cxf1_input2 <= Cxf1_input2;
            Cxf2_input1 <= Cxf2_input1;
            Cxf2_input2 <= Cxf2_input2 ;
            Cxf3_input1 <= Cxf3_input1 ;
            Cxf3_input2 <= Cxf3_input2;
            Cxf4_input1 <= Cxf4_input1;
            Cxf4_input2 <= Cxf4_input2 ;
            
            Cxf5_input1 <= Cxf5_input1 ;
            Cxf5_input2 <= Cxf5_input2;
            Cxf6_input1 <= Cxf6_input1;
            Cxf6_input2 <= Cxf6_input2 ;
            Cxf7_input1 <= Cxf7_input1 ;
            Cxf7_input2 <= Cxf7_input2;
            Cxf8_input1 <= Cxf8_input1;
            Cxf8_input2 <= Cxf8_input2 ;

            Cxf9_input1 <= Cxf9_input1 ;
            Cxf9_input2 <= Cxf9_input2;
            Cxf10_input1 <= Cxf10_input1;
            Cxf10_input2 <= Cxf10_input2 ;
            Cxf11_input1 <= Cxf11_input1 ;
            Cxf11_input2 <= Cxf11_input2;
            Cxf12_input1 <= Cxf12_input1;
            Cxf12_input2 <= Cxf12_input2 ;

            Cxf13_input1 <= Cxf13_input1 ;
            Cxf13_input2 <= Cxf13_input2;
            Cxf14_input1 <= Cxf14_input1;
            Cxf14_input2 <= Cxf14_input2 ;
            Cxf15_input1 <= Cxf15_input1 ;
            Cxf15_input2 <= Cxf15_input2;
            Cxf16_input1 <= Cxf16_input1;
            Cxf16_input2 <= Cxf16_input2 ;
        end
        else begin
            case(state)
                Start:begin
                    done <= 0;
                    input_C_bram <= input_C_bram;
                    weainputht <=0 ;
                    eninputht <=0 ;
                    state <= SM_check ;  // the next stage 
                    SM_idle <= 1;
                    F_control_idle <= 1;
                    spv_idle <= 1;              // the  spv module idle 
                    spv_idle1 <= 1;              // the  spv module idle 
                    spv_idle2 <= 1;              // the  spv module idle 
                    spv_idle3 <= 1;              // the  spv module idle 
                    sigmoid_idle <= 1;
                    weainputxt <= 0;
                    inputxt_addr <= 'b11111 ;
                    eninputxt <= 0;
                    weainputxt_1 <= 0;
                    inputxt_1_addr <= 'b11111 ;
                    eninputxt_1 <= 0;
                    read_C_bram_addr <= -1;
                    write_C_bram_addr <= -1;
                    SM_control_idle <= 1;
                    I_control_idle <= I_control_idle ;
                    I_bram_addr <= -1;
                    Output_control_idle <= 1;
                    inputht_addra  <= -1 ;
                    I_bram_input <= I_bram_input ;
                end

                SM_check:begin

                    sigmoid_input1 <= sigmoid_input1 ;
                    sigmoid_input2 <= sigmoid_input2 ;
                    sigmoid_input3 <= sigmoid_input3 ;
                    sigmoid_input4 <= sigmoid_input4 ;
                    sigmoid_input5 <= sigmoid_input5 ;
                    sigmoid_input6 <= sigmoid_input6 ;
                    sigmoid_input7 <= sigmoid_input7 ;
                    sigmoid_input8 <= sigmoid_input8 ;
                    sigmoid_input9 <= sigmoid_input9 ;
                    sigmoid_input10 <= sigmoid_input10 ;
                    sigmoid_input11 <= sigmoid_input11 ;
                    sigmoid_input12 <= sigmoid_input12 ;
                    sigmoid_input13 <= sigmoid_input13 ;
                    sigmoid_input14 <= sigmoid_input14 ;
                    sigmoid_input15 <= sigmoid_input15 ;
                    sigmoid_input16 <= sigmoid_input16 ;

                    tanh_input1 <= tanh_input1 ;
                    tanh_input2 <= tanh_input2 ;
                    tanh_input3 <= tanh_input3 ;
                    tanh_input4 <= tanh_input4 ;
                    tanh_input5 <= tanh_input5 ;
                    tanh_input6 <= tanh_input6 ;
                    tanh_input7 <= tanh_input7 ;
                    tanh_input8 <= tanh_input8 ;
                    tanh_input9 <= tanh_input9 ;
                    tanh_input10 <= tanh_input10 ;
                    tanh_input11 <= tanh_input11 ;
                    tanh_input12 <= tanh_input12 ;
                    tanh_input13 <= tanh_input13 ;
                    tanh_input14 <= tanh_input14 ;
                    tanh_input15 <= tanh_input15 ;
                    tanh_input16 <= tanh_input16 ;

                    Cxf1_input1 <= Cxf1_input1 ;
                    Cxf1_input2 <= Cxf1_input2;
                    Cxf2_input1 <= Cxf2_input1;
                    Cxf2_input2 <= Cxf2_input2 ;
                    Cxf3_input1 <= Cxf3_input1 ;
                    Cxf3_input2 <= Cxf3_input2;
                    Cxf4_input1 <= Cxf4_input1;
                    Cxf4_input2 <= Cxf4_input2 ;
                    
                    Cxf5_input1 <= Cxf5_input1 ;
                    Cxf5_input2 <= Cxf5_input2;
                    Cxf6_input1 <= Cxf6_input1;
                    Cxf6_input2 <= Cxf6_input2 ;
                    Cxf7_input1 <= Cxf7_input1 ;
                    Cxf7_input2 <= Cxf7_input2;
                    Cxf8_input1 <= Cxf8_input1;
                    Cxf8_input2 <= Cxf8_input2 ;

                    Cxf9_input1 <= Cxf9_input1 ;
                    Cxf9_input2 <= Cxf9_input2;
                    Cxf10_input1 <= Cxf10_input1;
                    Cxf10_input2 <= Cxf10_input2 ;
                    Cxf11_input1 <= Cxf11_input1 ;
                    Cxf11_input2 <= Cxf11_input2;
                    Cxf12_input1 <= Cxf12_input1;
                    Cxf12_input2 <= Cxf12_input2 ;

                    Cxf13_input1 <= Cxf13_input1 ;
                    Cxf13_input2 <= Cxf13_input2;
                    Cxf14_input1 <= Cxf14_input1;
                    Cxf14_input2 <= Cxf14_input2 ;
                    Cxf15_input1 <= Cxf15_input1 ;
                    Cxf15_input2 <= Cxf15_input2;
                    Cxf16_input1 <= Cxf16_input1;
                    Cxf16_input2 <= Cxf16_input2 ;

                    done <= 0;
                    input_C_bram <= input_C_bram;
                    weainputht <=weainputht ;
                    eninputht <=eninputht ;
                    weainputxt <= weainputxt ;
                    weainputxt_1 <= weainputxt_1 ;
                    F_control_idle <= F_control_idle ;
                    I_control_idle <= I_control_idle ;
                    SM_control_idle <= 0;
                    read_C_bram_addr <= read_C_bram_addr ;
                    write_C_bram_addr <= write_C_bram_addr;
                    I_bram_addr <= I_bram_addr ;
                    Output_control_idle <= Output_control_idle ;
                    inputht_addra <= inputht_addra ;
                    I_bram_input <= I_bram_input ;
                    if(Sm_is_done) begin   // is Sm  done
                        if (is_Sm) begin   // the result of Sm check
                            state <= Forget_stage;
                            spv_idle <= 1;              // the  spv module idle 
                            spv_idle1 <= 1;              // the  spv module idle 
                            spv_idle2 <= 1;              // the  spv module idle 
                            spv_idle3 <= 1;              // the  spv module idle 
                            sigmoid_idle <= 1;
                        end
                        else begin
                            state <= Forget_stage;
                            spv_idle <= 1;              // the  spv module idle 
                            spv_idle1 <= 1;              // the  spv module idle 
                            spv_idle2 <= 1;              // the  spv module idle 
                            spv_idle3 <= 1;              // the  spv module idle 
                            sigmoid_idle <= 1;
                        end
                        
                    end
                    else begin
                        state <= state;
                        spv_idle <= spv_idle;
                        spv_idle1 <= spv_idle1;
                        spv_idle2 <= spv_idle2;
                        spv_idle3 <= spv_idle3;
                        sigmoid_idle <= sigmoid_idle;
                    end
                    if (Start_X_bram_En) begin   // start  Xt bram  Xt-1 Bram
                        eninputxt <= 1;
                        inputxt_addr <= inputxt_addr + 1;
                        eninputxt_1 <= 1;
                        inputxt_1_addr <= inputxt_1_addr + 1;
                    end
                    else begin
                        eninputxt <= 0;
                        inputxt_addr <= inputxt_addr;
                        eninputxt_1 <= 0;
                        inputxt_1_addr <= inputxt_1_addr;
                    end

                    if (Start_SM) begin
                        SM_idle <= 0;
                        spv_idle <= 1;              // the  spv module idle 
                        spv_idle1 <= 1;              // the  spv module idle 
                        spv_idle2 <= 1;              // the  spv module idle 
                        spv_idle3 <= 1;              // the  spv module idle 
                    end
                    else begin
                        SM_idle <= SM_idle ;
                        spv_idle <= 0;              // the  spv module idle 
                        spv_idle1 <= 0;              // the  spv module idle 
                        spv_idle2 <= 0;              // the  spv module idle 
                        spv_idle3 <= 0;              // the  spv module idle 
                    end
                    
                    
                end

                Forget_stage:begin
                    done <= 0;
                    input_C_bram <= input_C_bram;
                    F_control_idle <= 0 ;
                    inputxt_addr <= spv_top0_output_addr ;
                    inputht_addr <= spv_top1_output_addr ;
                    weainputxt <=  spv0_out_weainputxt ;
                    weainputht <=  spv1_out_weainputht ;
                    eninputxt <=  spv0_out_eninputxt ;
                    eninputht <=  spv1_out_eninputht ;
                    I_control_idle <= I_control_idle ;
                    I_bram_addr <= I_bram_addr ;
                    Output_control_idle <= Output_control_idle ;
                    inputht_addra <= inputht_addra ;
                    SM_control_idle <= SM_control_idle;
                    I_bram_input <= I_bram_input ;

                    tanh_input1 <= tanh_input1 ;
                    tanh_input2 <= tanh_input2 ;
                    tanh_input3 <= tanh_input3 ;
                    tanh_input4 <= tanh_input4 ;
                    tanh_input5 <= tanh_input5 ;
                    tanh_input6 <= tanh_input6 ;
                    tanh_input7 <= tanh_input7 ;
                    tanh_input8 <= tanh_input8 ;
                    tanh_input9 <= tanh_input9 ;
                    tanh_input10 <= tanh_input10 ;
                    tanh_input11 <= tanh_input11 ;
                    tanh_input12 <= tanh_input12 ;
                    tanh_input13 <= tanh_input13 ;
                    tanh_input14 <= tanh_input14 ;
                    tanh_input15 <= tanh_input15 ;
                    tanh_input16 <= tanh_input16 ;

                    // the start of sigmoid 
                    if (F_start_sigmoid) begin
                        sigmoid_idle <= 0 ;
                        sigmoid_input1 <= one_elements0+one_elements20;
                        sigmoid_input2 <= one_elements1+one_elements21;
                        sigmoid_input3 <= one_elements2+one_elements22;
                        sigmoid_input4 <= one_elements3+one_elements23;
                        sigmoid_input5 <= one_elements4+one_elements24;
                        sigmoid_input6 <= one_elements5+one_elements25;
                        sigmoid_input7 <= one_elements6+one_elements26;
                        sigmoid_input8 <= one_elements7+one_elements27;
                        sigmoid_input9 <= one_elements10+one_elements30;
                        sigmoid_input10 <= one_elements11+one_elements31;
                        sigmoid_input11 <= one_elements12+one_elements32;
                        sigmoid_input12 <= one_elements13+one_elements33;
                        sigmoid_input13 <= one_elements14+one_elements34;
                        sigmoid_input14 <= one_elements15+one_elements35;
                        sigmoid_input15 <= one_elements16+one_elements36;
                        sigmoid_input16 <= one_elements17+one_elements37;
                    end
                    else begin
                        sigmoid_idle <= 1 ;
                        sigmoid_input1 <= sigmoid_input1 ;
                        sigmoid_input2 <= sigmoid_input2 ;
                        sigmoid_input3 <= sigmoid_input3 ;
                        sigmoid_input4 <= sigmoid_input4 ;
                        sigmoid_input5 <= sigmoid_input5 ;
                        sigmoid_input6 <= sigmoid_input6 ;
                        sigmoid_input7 <= sigmoid_input7 ;
                        sigmoid_input8 <= sigmoid_input8 ;
                        sigmoid_input9 <= sigmoid_input9 ;
                        sigmoid_input10 <= sigmoid_input10 ;
                        sigmoid_input11 <= sigmoid_input11 ;
                        sigmoid_input12 <= sigmoid_input12 ;
                        sigmoid_input13 <= sigmoid_input13 ;
                        sigmoid_input14 <= sigmoid_input14 ;
                        sigmoid_input15 <= sigmoid_input15 ;
                        sigmoid_input16 <= sigmoid_input16 ;
                        
                    end
                    //the control of read C_bram
                    if (F_start_C_bram_En) begin
                        en_C_bram <= 1;
                        read_C_bram_addr  <= read_C_bram_addr + 1;
                    end
                    else begin
                        en_C_bram <= 0 ;
                        read_C_bram_addr <= read_C_bram_addr ;
                    end

                    // the control of multer
                    if (F_start_multer_CE) begin
                        Cxf_CE <= 1;
                        Cxf1_input1 <= output_C_bram[15:0] ;
                        Cxf1_input2 <= sigmoid_output1;
                        Cxf2_input1 <= output_C_bram[31:16];
                        Cxf2_input2 <= sigmoid_output2 ;
                        Cxf3_input1 <= output_C_bram[47:32] ;
                        Cxf3_input2 <= sigmoid_output3;
                        Cxf4_input1 <= output_C_bram[63:48];
                        Cxf4_input2 <= sigmoid_output4 ;

                        Cxf5_input1 <= output_C_bram[79:64] ;
                        Cxf5_input2 <= sigmoid_output5;
                        Cxf6_input1 <= output_C_bram[95:80];
                        Cxf6_input2 <= sigmoid_output6 ;
                        Cxf7_input1 <= output_C_bram[111:96] ;
                        Cxf7_input2 <= sigmoid_output7;
                        Cxf8_input1 <= output_C_bram[127:112];
                        Cxf8_input2 <= sigmoid_output8 ;

                        Cxf9_input1 <= output_C_bram[143:128] ;
                        Cxf9_input2 <= sigmoid_output9;
                        Cxf10_input1 <= output_C_bram[159:144];
                        Cxf10_input2 <= sigmoid_output10 ;
                        Cxf11_input1 <= output_C_bram[175:160] ;
                        Cxf11_input2 <= sigmoid_output11;
                        Cxf12_input1 <= output_C_bram[191:176];
                        Cxf12_input2 <= sigmoid_output12 ;


                        Cxf13_input1 <= output_C_bram[207:192] ;
                        Cxf13_input2 <= sigmoid_output13;
                        Cxf14_input1 <= output_C_bram[223:208];
                        Cxf14_input2 <= sigmoid_output14 ;
                        Cxf15_input1 <= output_C_bram[239:224] ;
                        Cxf15_input2 <= sigmoid_output15;
                        Cxf16_input1 <= output_C_bram[255:240];
                        Cxf16_input2 <= sigmoid_output16 ;

                    end
                    else begin
                        Cxf_CE <= 0;
                        Cxf1_input1 <= Cxf1_input1 ;
                        Cxf1_input2 <= Cxf1_input2;
                        Cxf2_input1 <= Cxf2_input1;
                        Cxf2_input2 <= Cxf2_input2 ;
                        Cxf3_input1 <= Cxf3_input1 ;
                        Cxf3_input2 <= Cxf3_input2;
                        Cxf4_input1 <= Cxf4_input1;
                        Cxf4_input2 <= Cxf4_input2 ;
                        
                        Cxf5_input1 <= Cxf5_input1 ;
                        Cxf5_input2 <= Cxf5_input2;
                        Cxf6_input1 <= Cxf6_input1;
                        Cxf6_input2 <= Cxf6_input2 ;
                        Cxf7_input1 <= Cxf7_input1 ;
                        Cxf7_input2 <= Cxf7_input2;
                        Cxf8_input1 <= Cxf8_input1;
                        Cxf8_input2 <= Cxf8_input2 ;

                        Cxf9_input1 <= Cxf9_input1 ;
                        Cxf9_input2 <= Cxf9_input2;
                        Cxf10_input1 <= Cxf10_input1;
                        Cxf10_input2 <= Cxf10_input2 ;
                        Cxf11_input1 <= Cxf11_input1 ;
                        Cxf11_input2 <= Cxf11_input2;
                        Cxf12_input1 <= Cxf12_input1;
                        Cxf12_input2 <= Cxf12_input2 ;

                        Cxf13_input1 <= Cxf13_input1 ;
                        Cxf13_input2 <= Cxf13_input2;
                        Cxf14_input1 <= Cxf14_input1;
                        Cxf14_input2 <= Cxf14_input2 ;
                        Cxf15_input1 <= Cxf15_input1 ;
                        Cxf15_input2 <= Cxf15_input2;
                        Cxf16_input1 <= Cxf16_input1;
                        Cxf16_input2 <= Cxf16_input2 ;
                    end 

                    if (F_start_C_bram_Wea) begin
                        wea_C_bram <= 1;
                        write_C_bram_addr <= write_C_bram_addr +1 ;
                        input_C_bram <= {Cxf16_result[31:16],Cxf15_result[31:16],Cxf14_result[31:16],Cxf13_result[31:16],Cxf12_result[31:16],Cxf11_result[31:16],Cxf10_result[31:16],Cxf9_result[31:16],Cxf8_result[31:16],Cxf7_result[31:16],Cxf6_result[31:16],Cxf5_result[31:16],Cxf4_result[31:16],Cxf3_result[31:16],Cxf2_result[31:16],Cxf1_result[31:16]};
                    end
                    else begin
                        wea_C_bram <= 0 ;
                        write_C_bram_addr <= write_C_bram_addr ;
                        input_C_bram <= input_C_bram ;
                    end

                    if (F_done) begin
                        spv_idle <=  1;
                        spv_idle2 <=  1;
                        spv_idle1 <=  1;
                        spv_idle3 <=  1;
                        state <= Input_stage;
                    end
                    else begin
                        state <= state ;
                        spv_idle <=  0;
                        spv_idle2 <=  0;
                        spv_idle1 <=  0;
                        spv_idle3 <=  0;
                    end


                end

                Input_stage:begin
                    done <= 0;
                    input_C_bram <= input_C_bram;
                    inputxt_addr <= spv_top0_output_addr ;
                    inputht_addr <= spv_top1_output_addr ;
                    weainputxt <=  spv0_out_weainputxt ;
                    weainputht <=  spv1_out_weainputht ;
                    eninputxt <=  spv0_out_eninputxt ;
                    eninputht <=  spv1_out_eninputht ;
                    I_control_idle <= 0 ;

                    Cxf1_input1 <= Cxf1_input1 ;
                    Cxf1_input2 <= Cxf1_input2;
                    Cxf2_input1 <= Cxf2_input1;
                    Cxf2_input2 <= Cxf2_input2 ;
                    Cxf3_input1 <= Cxf3_input1 ;
                    Cxf3_input2 <= Cxf3_input2;
                    Cxf4_input1 <= Cxf4_input1;
                    Cxf4_input2 <= Cxf4_input2 ;
                    
                    Cxf5_input1 <= Cxf5_input1 ;
                    Cxf5_input2 <= Cxf5_input2;
                    Cxf6_input1 <= Cxf6_input1;
                    Cxf6_input2 <= Cxf6_input2 ;
                    Cxf7_input1 <= Cxf7_input1 ;
                    Cxf7_input2 <= Cxf7_input2;
                    Cxf8_input1 <= Cxf8_input1;
                    Cxf8_input2 <= Cxf8_input2 ;

                    Cxf9_input1 <= Cxf9_input1 ;
                    Cxf9_input2 <= Cxf9_input2;
                    Cxf10_input1 <= Cxf10_input1;
                    Cxf10_input2 <= Cxf10_input2 ;
                    Cxf11_input1 <= Cxf11_input1 ;
                    Cxf11_input2 <= Cxf11_input2;
                    Cxf12_input1 <= Cxf12_input1;
                    Cxf12_input2 <= Cxf12_input2 ;

                    Cxf13_input1 <= Cxf13_input1 ;
                    Cxf13_input2 <= Cxf13_input2;
                    Cxf14_input1 <= Cxf14_input1;
                    Cxf14_input2 <= Cxf14_input2 ;
                    Cxf15_input1 <= Cxf15_input1 ;
                    Cxf15_input2 <= Cxf15_input2;
                    Cxf16_input1 <= Cxf16_input1;
                    Cxf16_input2 <= Cxf16_input2 ;

                    tanh_input1 <= tanh_input1 ;
                    tanh_input2 <= tanh_input2 ;
                    tanh_input3 <= tanh_input3 ;
                    tanh_input4 <= tanh_input4 ;
                    tanh_input5 <= tanh_input5 ;
                    tanh_input6 <= tanh_input6 ;
                    tanh_input7 <= tanh_input7 ;
                    tanh_input8 <= tanh_input8 ;
                    tanh_input9 <= tanh_input9 ;
                    tanh_input10 <= tanh_input10 ;
                    tanh_input11 <= tanh_input11 ;
                    tanh_input12 <= tanh_input12 ;
                    tanh_input13 <= tanh_input13 ;
                    tanh_input14 <= tanh_input14 ;
                    tanh_input15 <= tanh_input15 ;
                    tanh_input16 <= tanh_input16 ;

                    // the start of sigmoid 
                    if (I_start_sigmoid) begin
                        sigmoid_idle <= 0 ;
                        sigmoid_input1 <= one_elements0+one_elements20;
                        sigmoid_input2 <= one_elements1+one_elements21;
                        sigmoid_input3 <= one_elements2+one_elements22;
                        sigmoid_input4 <= one_elements3+one_elements23;
                        sigmoid_input5 <= one_elements4+one_elements24;
                        sigmoid_input6 <= one_elements5+one_elements25;
                        sigmoid_input7 <= one_elements6+one_elements26;
                        sigmoid_input8 <= one_elements7+one_elements27;
                        sigmoid_input9 <= one_elements10+one_elements30;
                        sigmoid_input10 <= one_elements11+one_elements31;
                        sigmoid_input11 <= one_elements12+one_elements32;
                        sigmoid_input12 <= one_elements13+one_elements33;
                        sigmoid_input13 <= one_elements14+one_elements34;
                        sigmoid_input14 <= one_elements15+one_elements35;
                        sigmoid_input15 <= one_elements16+one_elements36;
                        sigmoid_input16 <= one_elements17+one_elements37;
                    end
                    else begin
                        sigmoid_idle <= 1 ;
                        sigmoid_input1 <= sigmoid_input1 ;
                        sigmoid_input2 <= sigmoid_input2 ;
                        sigmoid_input3 <= sigmoid_input3 ;
                        sigmoid_input4 <= sigmoid_input4 ;
                        sigmoid_input5 <= sigmoid_input5 ;
                        sigmoid_input6 <= sigmoid_input6 ;
                        sigmoid_input7 <= sigmoid_input7 ;
                        sigmoid_input8 <= sigmoid_input8 ;
                        sigmoid_input9 <= sigmoid_input9 ;
                        sigmoid_input10 <= sigmoid_input10 ;
                        sigmoid_input11 <= sigmoid_input11 ;
                        sigmoid_input12 <= sigmoid_input12 ;
                        sigmoid_input13 <= sigmoid_input13 ;
                        sigmoid_input14 <= sigmoid_input14 ;
                        sigmoid_input15 <= sigmoid_input15 ;
                        sigmoid_input16 <= sigmoid_input16 ;
                    end

                    if (I_start_I_bram_Wea) begin
                        Wea_I_bram <= 1;
                        I_bram_addr <= I_bram_addr +1 ;
                        I_bram_input <= {sigmoid_output16,sigmoid_output15,sigmoid_output14,sigmoid_output13,sigmoid_output12,sigmoid_output11,sigmoid_output10,sigmoid_output9,sigmoid_output8,sigmoid_output7,sigmoid_output6,sigmoid_output5,sigmoid_output4,sigmoid_output3,sigmoid_output2,sigmoid_output1};
                    end
                    else begin
                        Wea_I_bram <= 0 ;
                        I_bram_addr <= I_bram_addr ;
                        I_bram_input <= I_bram_input ;
                    end

                    if (I_done) begin
                        state <= A_stage;  
                        spv_idle <= 1; 
                        spv_idle2 <= 1; 
                        spv_idle1 <= 1; 
                        spv_idle3 <= 1; 
                    end
                    else begin
                        state <= state ;  
                        spv_idle <= 0;   
                        spv_idle2 <= 0;  
                        spv_idle1 <= 0;   
                        spv_idle3 <= 0; 
                    end
                end


                A_stage:begin
                    done <= 0;
                    A_control_idle <= 0 ;
                    inputxt_addr <= spv_top0_output_addr ;
                    inputht_addr <= spv_top1_output_addr ;
                    weainputxt <=  spv0_out_weainputxt ;
                    weainputht <=  spv1_out_weainputht ;
                    eninputxt <=  spv0_out_eninputxt ;
                    eninputht <=  spv1_out_eninputht ;
                    I_control_idle <= I_control_idle ;
                    sigmoid_input1 <= sigmoid_input1 ;
                    sigmoid_input2 <= sigmoid_input2 ;
                    sigmoid_input3 <= sigmoid_input3 ;
                    sigmoid_input4 <= sigmoid_input4 ;
                    sigmoid_input5 <= sigmoid_input5 ;
                    sigmoid_input6 <= sigmoid_input6 ;
                    sigmoid_input7 <= sigmoid_input7 ;
                    sigmoid_input8 <= sigmoid_input8 ;
                    sigmoid_input9 <= sigmoid_input9 ;
                    sigmoid_input10 <= sigmoid_input10 ;
                    sigmoid_input11 <= sigmoid_input11 ;
                    sigmoid_input12 <= sigmoid_input12 ;
                    sigmoid_input13 <= sigmoid_input13 ;
                    sigmoid_input14 <= sigmoid_input14 ;
                    sigmoid_input15 <= sigmoid_input15 ;
                    sigmoid_input16 <= sigmoid_input16 ;

                    Cxf1_input1 <= Cxf1_input1 ;
                    Cxf1_input2 <= Cxf1_input2;
                    Cxf2_input1 <= Cxf2_input1;
                    Cxf2_input2 <= Cxf2_input2 ;
                    Cxf3_input1 <= Cxf3_input1 ;
                    Cxf3_input2 <= Cxf3_input2;
                    Cxf4_input1 <= Cxf4_input1;
                    Cxf4_input2 <= Cxf4_input2 ;
                    
                    Cxf5_input1 <= Cxf5_input1 ;
                    Cxf5_input2 <= Cxf5_input2;
                    Cxf6_input1 <= Cxf6_input1;
                    Cxf6_input2 <= Cxf6_input2 ;
                    Cxf7_input1 <= Cxf7_input1 ;
                    Cxf7_input2 <= Cxf7_input2;
                    Cxf8_input1 <= Cxf8_input1;
                    Cxf8_input2 <= Cxf8_input2 ;

                    Cxf9_input1 <= Cxf9_input1 ;
                    Cxf9_input2 <= Cxf9_input2;
                    Cxf10_input1 <= Cxf10_input1;
                    Cxf10_input2 <= Cxf10_input2 ;
                    Cxf11_input1 <= Cxf11_input1 ;
                    Cxf11_input2 <= Cxf11_input2;
                    Cxf12_input1 <= Cxf12_input1;
                    Cxf12_input2 <= Cxf12_input2 ;

                    Cxf13_input1 <= Cxf13_input1 ;
                    Cxf13_input2 <= Cxf13_input2;
                    Cxf14_input1 <= Cxf14_input1;
                    Cxf14_input2 <= Cxf14_input2 ;
                    Cxf15_input1 <= Cxf15_input1 ;
                    Cxf15_input2 <= Cxf15_input2;
                    Cxf16_input1 <= Cxf16_input1;
                    Cxf16_input2 <= Cxf16_input2 ;

                    // the start of tanh 
                    if (A_start_tanh) begin
                        tanh_idle <= 0 ;
                        tanh_input1 <= one_elements0+one_elements20;
                        tanh_input2 <= one_elements1+one_elements21;
                        tanh_input3 <= one_elements2+one_elements22;
                        tanh_input4 <= one_elements3+one_elements23;
                        tanh_input5 <= one_elements4+one_elements24;
                        tanh_input6 <= one_elements5+one_elements25;
                        tanh_input7 <= one_elements6+one_elements26;
                        tanh_input8 <= one_elements7+one_elements27;
                        tanh_input9 <= one_elements10+one_elements30;
                        tanh_input10 <= one_elements11+one_elements31;
                        tanh_input11 <= one_elements12+one_elements32;
                        tanh_input12 <= one_elements13+one_elements33;
                        tanh_input13 <= one_elements14+one_elements34;
                        tanh_input14 <= one_elements15+one_elements35;
                        tanh_input15 <= one_elements16+one_elements36;
                        tanh_input16 <= one_elements17+one_elements37;
                    end
                    else begin
                        tanh_idle <= 1 ;
                        tanh_input1 <= tanh_input1 ;
                        tanh_input2 <= tanh_input2 ;
                        tanh_input3 <= tanh_input3 ;
                        tanh_input4 <= tanh_input4 ;
                        tanh_input5 <= tanh_input5 ;
                        tanh_input6 <= tanh_input6 ;
                        tanh_input7 <= tanh_input7 ;
                        tanh_input8 <= tanh_input8 ;
                        tanh_input9 <= tanh_input9 ;
                        tanh_input10 <= tanh_input10 ;
                        tanh_input11 <= tanh_input11 ;
                        tanh_input12 <= tanh_input12 ;
                        tanh_input13 <= tanh_input13 ;
                        tanh_input14 <= tanh_input14 ;
                        tanh_input15 <= tanh_input15 ;
                        tanh_input16 <= tanh_input16 ;
                    end
                    //the control of read I_bram
                    if (A_start_I_bram_En) begin
                        En_I_bram <= 1;
                        I_bram_addr  <= I_bram_addr + 1;
                    end
                    else begin
                        En_I_bram <= 0;
                        I_bram_addr  <= I_bram_addr ;
                    end

                    // the control of multer
                    if (A_start_multer_CE) begin
                        Cxf_CE <= 1;
                        Cxf1_input1 <= I_bram_output[15:0] ;
                        Cxf1_input2 <= tanh_output1;
                        Cxf2_input1 <= I_bram_output[31:16];
                        Cxf2_input2 <= tanh_output2 ;
                    end
                    else begin
                        Cxf_CE <= 0;
                        Cxf1_input1 <= Cxf1_input1 ;
                        Cxf1_input2 <= Cxf1_input2;
                        Cxf2_input1 <= Cxf2_input1;
                        Cxf2_input2 <= Cxf2_input2 ;
                    end 

                    if (A_Start_Add) begin
                        wea_C_bram <= 1;
                        write_C_bram_addr <= write_C_bram_addr +1 ;
                        input_C_bram <= {Cxf16_result[31:16]+output_C_bram[255:240] ,Cxf15_result[31:16]+output_C_bram[239:224],Cxf14_result[31:16]+output_C_bram[223:208] ,Cxf13_result[31:16]+output_C_bram[207:192],Cxf12_result[31:16]+output_C_bram[191:176] ,Cxf11_result[31:16]+output_C_bram[175:160],Cxf10_result[31:16]+output_C_bram[159:144] ,Cxf9_result[31:16]+output_C_bram[143:128],
                            Cxf8_result[31:16]+output_C_bram[127:112] ,Cxf7_result[31:16]+output_C_bram[111:96],Cxf6_result[31:16]+output_C_bram[95:80] ,Cxf5_result[31:16]+output_C_bram[79:64],Cxf4_result[31:16]+output_C_bram[63:48] ,Cxf3_result[31:16]+output_C_bram[47:32],Cxf2_result[31:16]+output_C_bram[31:16] ,Cxf1_result[31:16]+output_C_bram[15:0]};
                    end
                    else begin
                        wea_C_bram <= 0 ;
                        write_C_bram_addr <= -1 ;
                        input_C_bram <= input_C_bram ;
                    end

                    if (A_start_C_bram_En) begin
                        en_C_bram <= 1;
                        read_C_bram_addr  <= read_C_bram_addr + 1;
                    end
                    else begin
                        en_C_bram <= 0 ;
                        read_C_bram_addr <= -1 ;
                    end
                    if (A_done) begin
                        spv_idle <=  1;
                        spv_idle2 <=  1;
                        spv_idle1 <=  1;
                        spv_idle3 <=  1;
                        state <= Output_stage;
                    end
                    else begin
                        state <= state ;
                        spv_idle <= 0 ;
                        spv_idle2 <= 0 ;
                        spv_idle1 <= 0 ;
                        spv_idle3 <= 0 ;
                    end


                end

                Output_stage:begin
                    done <= 0;
                    input_C_bram <= input_C_bram;
                    Output_control_idle <= 0;
                    spv_idle <= 0;
                    spv_idle2 <= 0;
                    spv_idle1 <= 0;
                    spv_idle3 <= 0;
                    inputxt_addr <= spv_top0_output_addr ;
                    weainputxt <=  spv0_out_weainputxt ;
                    eninputxt <=  spv0_out_eninputxt ;
                    eninputht <=  spv1_out_eninputht ;
                    inputht_addr <= spv_top1_output_addr ;
                    
                    // the start of sigmoid 
                    if (Out_start_tanh) begin
                        sigmoid_idle <= 0 ;
                        tanh_idle <= 0 ;
                        sigmoid_input1 <= one_elements0+one_elements20;
                        sigmoid_input2 <= one_elements1+one_elements21;
                        sigmoid_input3 <= one_elements2+one_elements22;
                        sigmoid_input4 <= one_elements3+one_elements23;
                        sigmoid_input5 <= one_elements4+one_elements24;
                        sigmoid_input6 <= one_elements5+one_elements25;
                        sigmoid_input7 <= one_elements6+one_elements26;
                        sigmoid_input8 <= one_elements7+one_elements27;
                        sigmoid_input9 <= one_elements10+one_elements30;
                        sigmoid_input10 <= one_elements11+one_elements31;
                        sigmoid_input11 <= one_elements12+one_elements32;
                        sigmoid_input12 <= one_elements13+one_elements33;
                        sigmoid_input13 <= one_elements14+one_elements34;
                        sigmoid_input14 <= one_elements15+one_elements35;
                        sigmoid_input15 <= one_elements16+one_elements36;
                        sigmoid_input16 <= one_elements17+one_elements37;

                       
                        
                        tanh_input1 <=  output_C_bram[15:0] ;
                        tanh_input2 <=  output_C_bram[31:16] ;
                        tanh_input3 <=  output_C_bram[47:32] ;
                        tanh_input4 <=  output_C_bram[63:48] ;
                        tanh_input5 <= output_C_bram[79:64];
                        tanh_input6 <= output_C_bram[95:80];
                        tanh_input7 <= output_C_bram[111:96];
                        tanh_input8 <= output_C_bram[127:112];
                        tanh_input9 <= output_C_bram[143:128];
                        tanh_input10 <= output_C_bram[159:144];
                        tanh_input11 <= output_C_bram[175:160];
                        tanh_input12 <= output_C_bram[191:176];
                        tanh_input13 <= output_C_bram[207:192];
                        tanh_input14 <= output_C_bram[223:208];
                        tanh_input15 <= output_C_bram[239:224];
                        tanh_input16 <= output_C_bram[255:240];
                    end
                    else begin
                        sigmoid_idle <= 1 ;
                        tanh_idle <= 1 ;
                        tanh_input1 <= tanh_input1 ;
                        tanh_input2 <= tanh_input2 ;
                        tanh_input3 <= tanh_input3 ;
                        tanh_input4 <= tanh_input4 ;
                        tanh_input5 <= tanh_input5 ;
                        tanh_input6 <= tanh_input6 ;
                        tanh_input7 <= tanh_input7 ;
                        tanh_input8 <= tanh_input8 ;
                        tanh_input9 <= tanh_input9 ;
                        tanh_input10 <= tanh_input10 ;
                        tanh_input11 <= tanh_input11 ;
                        tanh_input12 <= tanh_input12 ;
                        tanh_input13 <= tanh_input13 ;
                        tanh_input14 <= tanh_input14 ;
                        tanh_input15 <= tanh_input15 ;
                        tanh_input16 <= tanh_input16 ;

                        sigmoid_input1 <= sigmoid_input1 ;
                        sigmoid_input2 <= sigmoid_input2 ;
                        sigmoid_input3 <= sigmoid_input3 ;
                        sigmoid_input4 <= sigmoid_input4 ;
                        sigmoid_input5 <= sigmoid_input5 ;
                        sigmoid_input6 <= sigmoid_input6 ;
                        sigmoid_input7 <= sigmoid_input7 ;
                        sigmoid_input8 <= sigmoid_input8 ;
                        sigmoid_input9 <= sigmoid_input9 ;
                        sigmoid_input10 <= sigmoid_input10 ;
                        sigmoid_input11 <= sigmoid_input11 ;
                        sigmoid_input12 <= sigmoid_input12 ;
                        sigmoid_input13 <= sigmoid_input13 ;
                        sigmoid_input14 <= sigmoid_input14 ;
                        sigmoid_input15 <= sigmoid_input15 ;
                        sigmoid_input16 <= sigmoid_input16 ;
                    end
                    //the control of read C_bram
                    if (spv_driver_C_bram1) begin
                        en_C_bram <= 1;
                        read_C_bram_addr  <= read_C_bram_addr + 1;
                    end
                    else begin
                        en_C_bram <= 0 ;
                        read_C_bram_addr <= -1 ;
                    end

                    // the control of multer
                    if (Output_start_multer_CE) begin
                        Cxf_CE <= 1;
                        Cxf1_input1 <= tanh_output1 ;
                        Cxf1_input2 <= sigmoid_output1;
                        Cxf2_input1 <= tanh_output2;
                        Cxf2_input2 <= sigmoid_output2 ;
                        Cxf3_input1 <= tanh_output3 ;
                        Cxf3_input2 <= sigmoid_output3;
                        Cxf4_input1 <= tanh_output4;
                        Cxf4_input2 <= sigmoid_output4 ;

                        Cxf5_input1 <= tanh_output5 ;
                        Cxf5_input2 <= sigmoid_output5;
                        Cxf6_input1 <= tanh_output6;
                        Cxf6_input2 <= sigmoid_output6 ;
                        Cxf7_input1 <= tanh_output7 ;
                        Cxf7_input2 <= sigmoid_output7;
                        Cxf8_input1 <= tanh_output8;
                        Cxf8_input2 <= sigmoid_output8 ;

                        Cxf9_input1 <= tanh_output9 ;
                        Cxf9_input2 <= sigmoid_output9;
                        Cxf10_input1 <= tanh_output10;
                        Cxf10_input2 <= sigmoid_output10 ;
                        Cxf11_input1 <= tanh_output11 ;
                        Cxf11_input2 <= sigmoid_output11;
                        Cxf12_input1 <= tanh_output12;
                        Cxf12_input2 <= sigmoid_output12 ;


                        Cxf13_input1 <= tanh_output13 ;
                        Cxf13_input2 <= sigmoid_output13;
                        Cxf14_input1 <= tanh_output14;
                        Cxf14_input2 <= sigmoid_output14 ;
                        Cxf15_input1 <= tanh_output15 ;
                        Cxf15_input2 <= sigmoid_output15;
                        Cxf16_input1 <= tanh_output16;
                        Cxf16_input2 <= sigmoid_output16 ;
                    end
                    else begin
                        Cxf_CE <= 0;
                        Cxf1_input1 <= Cxf1_input1 ;
                        Cxf1_input2 <= Cxf1_input2;
                        Cxf2_input1 <= Cxf2_input1;
                        Cxf2_input2 <= Cxf2_input2 ;
                        Cxf3_input1 <= Cxf3_input1 ;
                        Cxf3_input2 <= Cxf3_input2;
                        Cxf4_input1 <= Cxf4_input1;
                        Cxf4_input2 <= Cxf4_input2 ;
                        
                        Cxf5_input1 <= Cxf5_input1 ;
                        Cxf5_input2 <= Cxf5_input2;
                        Cxf6_input1 <= Cxf6_input1;
                        Cxf6_input2 <= Cxf6_input2 ;
                        Cxf7_input1 <= Cxf7_input1 ;
                        Cxf7_input2 <= Cxf7_input2;
                        Cxf8_input1 <= Cxf8_input1;
                        Cxf8_input2 <= Cxf8_input2 ;

                        Cxf9_input1 <= Cxf9_input1 ;
                        Cxf9_input2 <= Cxf9_input2;
                        Cxf10_input1 <= Cxf10_input1;
                        Cxf10_input2 <= Cxf10_input2 ;
                        Cxf11_input1 <= Cxf11_input1 ;
                        Cxf11_input2 <= Cxf11_input2;
                        Cxf12_input1 <= Cxf12_input1;
                        Cxf12_input2 <= Cxf12_input2 ;

                        Cxf13_input1 <= Cxf13_input1 ;
                        Cxf13_input2 <= Cxf13_input2;
                        Cxf14_input1 <= Cxf14_input1;
                        Cxf14_input2 <= Cxf14_input2 ;
                        Cxf15_input1 <= Cxf15_input1 ;
                        Cxf15_input2 <= Cxf15_input2;
                        Cxf16_input1 <= Cxf16_input1;
                        Cxf16_input2 <= Cxf16_input2 ;
                    end 

                    if (Output_start_H_bram_Wea) begin
                        weainputht <=  1 ;
                        inputht_addra <= inputht_addra+1 ;
                        inputh_input <= {Cxf16_result[31:16],Cxf15_result[31:16],Cxf14_result[31:16],Cxf13_result[31:16],Cxf12_result[31:16],Cxf11_result[31:16],Cxf10_result[31:16],Cxf9_result[31:16],Cxf8_result[31:16],Cxf7_result[31:16],Cxf6_result[31:16],Cxf5_result[31:16],Cxf4_result[31:16],Cxf3_result[31:16],Cxf2_result[31:16],Cxf1_result[31:16]};
                        output_element <= output_element +{Cxf4_result[31:16],Cxf3_result[31:16],Cxf2_result[31:16],Cxf1_result[31:16]}+{Cxf8_result[31:16],Cxf7_result[31:16],Cxf6_result[31:16],Cxf5_result[31:16]}+{Cxf12_result[31:16],Cxf11_result[31:16],Cxf10_result[31:16],Cxf9_result[31:16]}+{Cxf16_result[31:16],Cxf15_result[31:16],Cxf14_result[31:16],Cxf13_result[31:16]};
                    end
                    else begin
                        weainputht <=  0 ;
                        inputht_addra <= inputht_addra ;
                        inputh_input <= 'd0;
                        output_element <= output_element ;
                    end
                    

                    if (Output_done) begin
                        spv_idle <=  1;
                        spv_idle2 <=  1;
                        spv_idle1 <=  1;
                        spv_idle3 <=  1;
                        state <= Stop;
                    end
                    else begin
                        state <= state ;
                        spv_idle <= 0 ;
                        spv_idle2 <= 0 ;
                        spv_idle1 <= 0 ;
                        spv_idle3 <= 0 ;
                    end


                end
                Stop:begin
                    input_C_bram <= input_C_bram;
                    state <= state ;              //   to  idle state 
                    SM_idle <= SM_idle;               // the SM idle 
                    F_control_idle <= F_control_idle;        // the forget stage  control idle 
                    spv_idle <= spv_idle;  
                    spv_idle2 <= spv_idle2;    
                    spv_idle1 <= spv_idle1;  
                    spv_idle3 <= spv_idle3;         // the  spv module idle 
                    sigmoid_idle <= sigmoid_idle;          // the sigmoid idle 
                    weainputxt <= weainputxt;            // the signal to start  write xt bram 
                    eninputxt  <= eninputxt;            // the signal to start  read xt bram 
                    inputxt_addr <= inputxt_addr ;   // the xt bram addr    initial -1
                    weainputxt_1 <= weainputxt_1;          // the signal to start  write xt-1 bram 
                    eninputxt_1  <= eninputxt_1;           // the signal to start  read xt-1 bram 
                    weainputht <=weainputht ;            // the signal to start  write ht bram 
                    eninputht <=eninputht ;             // the signal to start  read  ht bram 
                    inputxt_1_addr <= inputxt_1_addr ;  // the xt-1 bram addr  initial -1
                    read_C_bram_addr <= read_C_bram_addr;      // the read C  bram addr  initial -1
                    write_C_bram_addr <= write_C_bram_addr;     // the wirte C  bram addr  initial -1
                    SM_control_idle <= SM_control_idle;        // the SM  control idle 
                    I_control_idle <= I_control_idle;         // the Input stage  control idle 
                    I_bram_addr <= I_bram_addr;           // the addr of I bram
                    A_control_idle <= A_control_idle;         // the A stage  control idle 
                    tanh_idle <= tanh_idle;              // the tanh function idle 
                    Output_control_idle <=Output_control_idle;    // the control module of Output idle 
                    inputht_addra  <= inputht_addra ;       // the bram of h addr
                    done <= 1;

                    Cxf1_input1 <= Cxf1_input1 ;
                    Cxf1_input2 <= Cxf1_input2;
                    Cxf2_input1 <= Cxf2_input1;
                    Cxf2_input2 <= Cxf2_input2 ;
                    Cxf3_input1 <= Cxf3_input1 ;
                    Cxf3_input2 <= Cxf3_input2;
                    Cxf4_input1 <= Cxf4_input1;
                    Cxf4_input2 <= Cxf4_input2 ;
                    
                    Cxf5_input1 <= Cxf5_input1 ;
                    Cxf5_input2 <= Cxf5_input2;
                    Cxf6_input1 <= Cxf6_input1;
                    Cxf6_input2 <= Cxf6_input2 ;
                    Cxf7_input1 <= Cxf7_input1 ;
                    Cxf7_input2 <= Cxf7_input2;
                    Cxf8_input1 <= Cxf8_input1;
                    Cxf8_input2 <= Cxf8_input2 ;

                    Cxf9_input1 <= Cxf9_input1 ;
                    Cxf9_input2 <= Cxf9_input2;
                    Cxf10_input1 <= Cxf10_input1;
                    Cxf10_input2 <= Cxf10_input2 ;
                    Cxf11_input1 <= Cxf11_input1 ;
                    Cxf11_input2 <= Cxf11_input2;
                    Cxf12_input1 <= Cxf12_input1;
                    Cxf12_input2 <= Cxf12_input2 ;

                    Cxf13_input1 <= Cxf13_input1 ;
                    Cxf13_input2 <= Cxf13_input2;
                    Cxf14_input1 <= Cxf14_input1;
                    Cxf14_input2 <= Cxf14_input2 ;
                    Cxf15_input1 <= Cxf15_input1 ;
                    Cxf15_input2 <= Cxf15_input2;
                    Cxf16_input1 <= Cxf16_input1;
                    Cxf16_input2 <= Cxf16_input2 ;

                    sigmoid_input1 <= sigmoid_input1 ;
                    sigmoid_input2 <= sigmoid_input2 ;
                    sigmoid_input3 <= sigmoid_input3 ;
                    sigmoid_input4 <= sigmoid_input4 ;
                    sigmoid_input5 <= sigmoid_input5 ;
                    sigmoid_input6 <= sigmoid_input6 ;
                    sigmoid_input7 <= sigmoid_input7 ;
                    sigmoid_input8 <= sigmoid_input8 ;
                    sigmoid_input9 <= sigmoid_input9 ;
                    sigmoid_input10 <= sigmoid_input10 ;
                    sigmoid_input11 <= sigmoid_input11 ;
                    sigmoid_input12 <= sigmoid_input12 ;
                    sigmoid_input13 <= sigmoid_input13 ;
                    sigmoid_input14 <= sigmoid_input14 ;
                    sigmoid_input15 <= sigmoid_input15 ;
                    sigmoid_input16 <= sigmoid_input16 ;

                    tanh_input1 <= tanh_input1 ;
                    tanh_input2 <= tanh_input2 ;
                    tanh_input3 <= tanh_input3 ;
                    tanh_input4 <= tanh_input4 ;
                    tanh_input5 <= tanh_input5 ;
                    tanh_input6 <= tanh_input6 ;
                    tanh_input7 <= tanh_input7 ;
                    tanh_input8 <= tanh_input8 ;
                    tanh_input9 <= tanh_input9 ;
                    tanh_input10 <= tanh_input10 ;
                    tanh_input11 <= tanh_input11 ;
                    tanh_input12 <= tanh_input12 ;
                    tanh_input13 <= tanh_input13 ;
                    tanh_input14 <= tanh_input14 ;
                    tanh_input15 <= tanh_input15 ;
                    tanh_input16 <= tanh_input16 ;
                end

                default:begin
                    state <= state ;              //   to  idle state 
                    SM_idle <= SM_idle;               // the SM idle 
                    F_control_idle <= F_control_idle;        // the forget stage  control idle 
                    spv_idle <= spv_idle;              // the  spv module idle 
                    spv_idle2 <= spv_idle2;
                    spv_idle1 <= spv_idle1;              // the  spv module idle 
                    spv_idle3 <= spv_idle3;
                    sigmoid_idle <= sigmoid_idle;          // the sigmoid idle 
                    weainputxt <= weainputxt;            // the signal to start  write xt bram 
                    eninputxt  <= eninputxt;            // the signal to start  read xt bram 
                    inputxt_addr <= inputxt_addr ;   // the xt bram addr    initial -1
                    weainputxt_1 <= weainputxt_1;          // the signal to start  write xt-1 bram 
                    eninputxt_1  <= eninputxt_1;           // the signal to start  read xt-1 bram 
                    weainputht <=weainputht ;            // the signal to start  write ht bram 
                    eninputht <=eninputht ;             // the signal to start  read  ht bram 
                    inputxt_1_addr <= inputxt_1_addr ;  // the xt-1 bram addr  initial -1
                    read_C_bram_addr <= read_C_bram_addr;      // the read C  bram addr  initial -1
                    write_C_bram_addr <= write_C_bram_addr;     // the wirte C  bram addr  initial -1
                    SM_control_idle <= SM_control_idle;        // the SM  control idle 
                    I_control_idle <= I_control_idle;         // the Input stage  control idle 
                    I_bram_addr <= I_bram_addr;           // the addr of I bram
                    A_control_idle <= A_control_idle;         // the A stage  control idle 
                    tanh_idle <= tanh_idle;              // the tanh function idle 
                    Output_control_idle <=Output_control_idle;    // the control module of Output idle 
                    inputht_addra  <= inputht_addra ;       // the bram of h addr
                    done <= 1;

                    Cxf1_input1 <= Cxf1_input1 ;
                    Cxf1_input2 <= Cxf1_input2;
                    Cxf2_input1 <= Cxf2_input1;
                    Cxf2_input2 <= Cxf2_input2 ;
                    Cxf3_input1 <= Cxf3_input1 ;
                    Cxf3_input2 <= Cxf3_input2;
                    Cxf4_input1 <= Cxf4_input1;
                    Cxf4_input2 <= Cxf4_input2 ;
                    
                    Cxf5_input1 <= Cxf5_input1 ;
                    Cxf5_input2 <= Cxf5_input2;
                    Cxf6_input1 <= Cxf6_input1;
                    Cxf6_input2 <= Cxf6_input2 ;
                    Cxf7_input1 <= Cxf7_input1 ;
                    Cxf7_input2 <= Cxf7_input2;
                    Cxf8_input1 <= Cxf8_input1;
                    Cxf8_input2 <= Cxf8_input2 ;

                    Cxf9_input1 <= Cxf9_input1 ;
                    Cxf9_input2 <= Cxf9_input2;
                    Cxf10_input1 <= Cxf10_input1;
                    Cxf10_input2 <= Cxf10_input2 ;
                    Cxf11_input1 <= Cxf11_input1 ;
                    Cxf11_input2 <= Cxf11_input2;
                    Cxf12_input1 <= Cxf12_input1;
                    Cxf12_input2 <= Cxf12_input2 ;

                    Cxf13_input1 <= Cxf13_input1 ;
                    Cxf13_input2 <= Cxf13_input2;
                    Cxf14_input1 <= Cxf14_input1;
                    Cxf14_input2 <= Cxf14_input2 ;
                    Cxf15_input1 <= Cxf15_input1 ;
                    Cxf15_input2 <= Cxf15_input2;
                    Cxf16_input1 <= Cxf16_input1;
                    Cxf16_input2 <= Cxf16_input2 ;

                    sigmoid_input1 <= sigmoid_input1 ;
                    sigmoid_input2 <= sigmoid_input2 ;
                    sigmoid_input3 <= sigmoid_input3 ;
                    sigmoid_input4 <= sigmoid_input4 ;
                    sigmoid_input5 <= sigmoid_input5 ;
                    sigmoid_input6 <= sigmoid_input6 ;
                    sigmoid_input7 <= sigmoid_input7 ;
                    sigmoid_input8 <= sigmoid_input8 ;
                    sigmoid_input9 <= sigmoid_input9 ;
                    sigmoid_input10 <= sigmoid_input10 ;
                    sigmoid_input11 <= sigmoid_input11 ;
                    sigmoid_input12 <= sigmoid_input12 ;
                    sigmoid_input13 <= sigmoid_input13 ;
                    sigmoid_input14 <= sigmoid_input14 ;
                    sigmoid_input15 <= sigmoid_input15 ;
                    sigmoid_input16 <= sigmoid_input16 ;

                    tanh_input1 <= tanh_input1 ;
                    tanh_input2 <= tanh_input2 ;
                    tanh_input3 <= tanh_input3 ;
                    tanh_input4 <= tanh_input4 ;
                    tanh_input5 <= tanh_input5 ;
                    tanh_input6 <= tanh_input6 ;
                    tanh_input7 <= tanh_input7 ;
                    tanh_input8 <= tanh_input8 ;
                    tanh_input9 <= tanh_input9 ;
                    tanh_input10 <= tanh_input10 ;
                    tanh_input11 <= tanh_input11 ;
                    tanh_input12 <= tanh_input12 ;
                    tanh_input13 <= tanh_input13 ;
                    tanh_input14 <= tanh_input14 ;
                    tanh_input15 <= tanh_input15 ;
                    tanh_input16 <= tanh_input16 ;
                end
            endcase
        end
    end
endmodule
