//-----------------------------------------
//           Instruction Fetch Stage
//-----------------------------------------
module IF(	CLK, 
		RESET, 
		fetchNull1,
		fetchNull2,
		PCA_PR,
		CIA_PR,
                no_new_fetch,
		single_fetch,
		taken_branch1,
		taken_branch2, 
		nextInstruction_address, 
		PC_init, 
		Instr1_fIM, 
		Instr2_fIM, 
		Instr1_PR, 
		Instr2_PR, 
		Instr_address_2IM
		);

  output reg     [31: 0] Instr_address_2IM;
  output reg     [31: 0] Instr1_PR;
  output reg     [31: 0] Instr2_PR;
  output reg     [31: 0] PCA_PR;
  output reg     [31: 0] CIA_PR;

  input          [31: 0] nextInstruction_address;
  input          [31: 0] PC_init;
  input          [31: 0] Instr1_fIM;
  input          [31: 0] Instr2_fIM;
  input                  single_fetch;
  input                  CLK;
  input                  RESET;
  input                  taken_branch1;
  input                  taken_branch2; 
  input                  no_new_fetch;
  input			 fetchNull1;
  input			 fetchNull2;

  wire           [31: 0] Instr1;
  wire           [31: 0] Instr2;
  wire           [31: 0] PCA;
  wire           [31: 0] CIA;

  reg            [31: 0] PC;
  reg            [31: 0] FPC;
  reg                    comment;

  initial comment = 0; // shows IF displays

  assign Instr_address_2IM   = (taken_branch1|taken_branch2)? nextInstruction_address: PC;
  assign PCA                 = (single_fetch)?PC:Instr_address_2IM+32'h00000008;
  assign CIA                 = (single_fetch)?FPC:Instr_address_2IM;
  assign Instr1              = (fetchNull1)? 32'h00000000: ((single_fetch)? Instr2_PR : Instr1_fIM);
  assign Instr2              = (fetchNull2)? 32'h00000000: ((single_fetch)? Instr1_fIM: Instr2_fIM);
  

  // Pipeline Register (IF/ID)
  always @ (posedge CLK or negedge RESET)
  begin
    if(!RESET)
      begin
        Instr1_PR            <= 32'b0;
        Instr2_PR            <= 32'b0;
	PCA_PR               <= 32'b0;
	CIA_PR               <= 32'b0;
	FPC                  <= 32'b0;
	PC                   <= PC_init;
      end
    else if(!no_new_fetch)
      begin
        Instr1_PR            <= Instr1;
        Instr2_PR            <= Instr2;
	PCA_PR               <= PCA;
	CIA_PR               <= CIA;
	FPC                  <= Instr_address_2IM;
	PC                   <= Instr_address_2IM + ((single_fetch)?32'h00000004:32'h00000008);        
      end
  end

  always  @ (posedge CLK) begin
     if (comment) begin
	$display("=============================================================");
	$display("[IF]:Instr1_fIM:%x\t|Instr2_fIM:%x",Instr1_fIM,Instr2_fIM);
	/*$display("[IF]:\tsingle_fetch:%x",single_fetch);
	$display("[IF]:\tPCA:%x",PCA);
	$display("[IF]:\tCIA:%x",CIA);
	$display("[IF]:\tPC:%x",PC);
	$display("[IF]:\tFPC:%x",FPC);
	$display("[IF]:\tInstr_address_2IM:%x",Instr_address_2IM);
	$display("[IF]:\tnextInstruction_address:%x",nextInstruction_address);
	$display("[IF]:taken_branch1:%x\t\t|taken_branch2:%x",taken_branch1,taken_branch2);
	$display("[IF]:Instr1:%x\t\t|Instr2:%x",Instr1,Instr2);
	$display("[IF]:Instr1_PR:%x\t\t|Instr2_PR:%x",Instr1_PR,Instr2_PR);
	$display("[IF]:Instr1_fIM:%x\t|Instr2_fIM:%x",Instr1_fIM,Instr2_fIM);
	/**/
     end
  end

endmodule
