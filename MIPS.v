//-----------------------------------------
//            Pipelined MIPS
//-----------------------------------------
module MIPS (	R2_output,
             	MemRead,
             	MemWrite,
             	data_write_2DM,
             	data_read_fDM,
             	Instr1_fIM,
		Instr2_fIM,
             	data_address_2DM,
             	CLK,
	     	RESET,
             	R2_input,
             	PC_init
            	);

   output [31: 0] R2_output;
   output [31: 0] data_address_2DM;
   output [31: 0] data_write_2DM;
   output         MemRead;
   output         MemWrite;

   input  [31: 0]  PC_init;
   input  [31: 0]  R2_input;
   input  [31: 0]  data_read_fDM;
   input  [31: 0]  Instr1_fIM;
   input  [31: 0]  Instr2_fIM;
   input 	  CLK;
   input          RESET;

   //connecting wires (signals passing through more than 1 stage)
   wire [31: 0]   R2_output_ID/*verilator public*/;
   wire [31: 0]   Instr_fMEM/*verilator public*/;
   wire [31: 0]   Reg_ID [0:31]/*verilator public*/;  
   wire [31: 0]   Instr_address_2IM/*verilator public*/;
   wire [31: 0]   CIA_IFID/*verilator public*/;
   wire [31: 0]   PCA_IFID/*verilator public*/;
   wire [31: 0]   nextInstruction_address_IDIF/*verilator public*/;
   wire           no_fetch/*verilator public*/;
   wire           SYS/*verilator public*/;
   wire           single_fetch_IDIF/*verilator public*/;

   //connecting wires (bifurcated signals passing through more than 1 stage)
   wire [31: 0]   writeData1_WBID/*verilator public*/;
   wire [31: 0]   writeData2_WBID/*verilator public*/;
   wire [31: 0]   writeData1_WBEXE/*verilator public*/;
   wire [31: 0]   writeData2_WBEXE/*verilator public*/;
   wire [31: 0]   writeData1_MID/*verilator public*/;
   wire [31: 0]   writeData2_MID/*verilator public*/;
   wire [31: 0]   Dest_Value1_IDEXE/*verilator public*/;
   wire [31: 0]   Dest_Value2_IDEXE/*verilator public*/;
   wire [31: 0]   Dest_Value1_EXEM/*verilator public*/;
   wire [31: 0]   Dest_Value2_EXEM/*verilator public*/;
   wire [31: 0]   Instr1_IDEXE/*verilator public*/;
   wire [31: 0]   Instr2_IDEXE/*verilator public*/;
   wire [31: 0]   Instr1_EXEM/*verilator public*/;
   wire [31: 0]   Instr2_EXEM/*verilator public*/;
   wire [31: 0]   Instr1_fIM/*verilator public*/;
   wire [31: 0]   Instr2_fIM/*verilator public*/;
   wire [31: 0]   Instr1_IFID/*verilator public*/;
   wire [31: 0]   Instr2_IFID/*verilator public*/;
   wire [31: 0]   Operand_A1_IDEXE/*verilator public*/;
   wire [31: 0]   Operand_A2_IDEXE/*verilator public*/;
   wire [31: 0]   Operand_B1_IDEXE/*verilator public*/;
   wire [31: 0]   Operand_B2_IDEXE/*verilator public*/;
   wire [31: 0]   aluResult1_EXEM/*verilator public*/;
   wire [31: 0]   aluResult2_EXEM/*verilator public*/;
   wire [31: 0]   aluResult1_EXEID/*verilator public*/;
   wire [31: 0]   aluResult2_EXEID/*verilator public*/;
   wire [31: 0]   aluResult1_MEMW/*verilator public*/;
   wire [31: 0]   aluResult2_MEMW/*verilator public*/;
   wire [31: 0]   aluResult1_WBID/*verilator public*/;
   wire [31: 0]   aluResult2_WBID/*verilator public*/;
   wire [31: 0]   data_read1_MEMW/*verilator public*/;
   wire [31: 0]   data_read2_MEMW/*verilator public*/;
   wire [31: 0]   readDataB1_IDEXE/*verilator public*/;
   wire [31: 0]   readDataB2_IDEXE/*verilator public*/;
   wire [31: 0]   readDataB1_EXEM/*verilator public*/;
   wire [31: 0]   readDataB2_EXEM/*verilator public*/;
   wire [ 5: 0]   ALU_control1_IDEXE/*verilator public*/;
   wire [ 5: 0]   ALU_control2_IDEXE/*verilator public*/;
   wire [ 5: 0]   ALU_control1_EXEM/*verilator public*/;
   wire [ 5: 0]   ALU_control2_EXEM/*verilator public*/;
   wire [ 4: 0]   writeRegister1_IDEXE/*verilator public*/;
   wire [ 4: 0]   writeRegister2_IDEXE/*verilator public*/;
   wire [ 4: 0]   writeRegister1_EXEM/*verilator public*/;
   wire [ 4: 0]   writeRegister2_EXEM/*verilator public*/;
   wire [ 4: 0]   writeRegister1_MEMW/*verilator public*/;
   wire [ 4: 0]   writeRegister2_MEMW/*verilator public*/;
   wire [ 4: 0]   writeRegister1_WBID/*verilator public*/;
   wire [ 4: 0]   writeRegister2_WBID/*verilator public*/;
   wire [ 4: 0]   writeRegister1_WBEXE/*verilator public*/;
   wire [ 4: 0]   writeRegister2_WBEXE/*verilator public*/;
   wire [ 4: 0]   Instr1_10_6_IDEXE/*verilator public*/;
   wire [ 4: 0]   Instr2_10_6_IDEXE/*verilator public*/;
   wire [ 4: 0]   readRegisterA2_IDEXE/*verilator public*/;
   wire [ 4: 0]   readRegisterA1_IDEXE/*verilator public*/;
   wire [ 4: 0]   readRegisterB1_IDEXE/*verilator public*/;
   wire [ 4: 0]   readRegisterB2_IDEXE/*verilator public*/;
   wire           MemtoReg1_IDEXE/*verilator public*/;
   wire           MemtoReg2_IDEXE/*verilator public*/;
   wire 	  MemtoReg1_EXEM/*verilator public*/;
   wire 	  MemtoReg2_EXEM/*verilator public*/;
   wire           MemtoReg1_MEMW/*verilator public*/;
   wire           MemtoReg2_MEMW/*verilator public*/;
   wire 	  MemRead1_IDEXE/*verilator public*/;
   wire           MemRead2_IDEXE/*verilator public*/;
   wire           MemRead1_EXEM/*verilator public*/;
   wire           MemRead2_EXEM/*verilator public*/;
   wire 	  MemWrite1_IDEXE/*verilator public*/;
   wire           MemWrite2_IDEXE/*verilator public*/;
   wire           MemWrite1_EXEM/*verilator public*/;
   wire           MemWrite2_EXEM/*verilator public*/;
   wire           do_writeback1_WBID/*verilator public*/;
   wire           do_writeback2_WBID/*verilator public*/;
   wire           do_writeback1_IDEXE/*verilator public*/;
   wire           do_writeback2_IDEXE/*verilator public*/;
   wire           do_writeback1_MEMW/*verilator public*/;
   wire           do_writeback2_MEMW/*verilator public*/;
   wire           do_writeback1_EXEM/*verilator public*/;
   wire           do_writeback2_EXEM/*verilator public*/;
   wire           do_writeback1_WBEXE/*verilator public*/;
   wire           do_writeback2_WBEXE/*verilator public*/;
   wire           taken_branch1_IDIF/*verilator public*/;
   wire           taken_branch2_IDIF/*verilator public*/;
   wire           fetchNull1_fID/*verilator public*/;
   wire           fetchNull2_fID/*verilator public*/;
   wire           ALUSrc1_IDEXE/*verilator public*/;
   wire           ALUSrc2_IDEXE/*verilator public*/;
   wire           ALUSrc1_EXEM/*verilator public*/;
   wire           ALUSrc2_EXEM/*verilator public*/;

   // Pipeline Stages Instantiation
   IF IF1( CLK, RESET, fetchNull1_fID, fetchNull2_fID, PCA_IFID, CIA_IFID, no_fetch, single_fetch_IDIF, taken_branch1_IDIF, taken_branch2_IDIF, nextInstruction_address_IDIF, PC_init, Instr1_fIM, Instr2_fIM, Instr1_IFID, Instr2_IFID, Instr_address_2IM);

   ID ID1( CLK, RESET, ALUSrc1_IDEXE, ALUSrc2_IDEXE, fetchNull1_fID, 
fetchNull2_fID, single_fetch_IDIF, Instr1_IDEXE, Instr2_IDEXE, 
Dest_Value1_IDEXE, Dest_Value2_IDEXE, no_fetch, SYS, 
readDataB1_IDEXE, readDataB2_IDEXE, Instr1_10_6_IDEXE, 
Instr2_10_6_IDEXE, do_writeback1_EXEM, do_writeback2_EXEM, 
writeRegister1_EXEM, writeRegister2_EXEM, writeData1_MID, 
writeData2_MID, do_writeback1_WBID, do_writeback2_WBID, 
writeRegister1_WBID, writeRegister2_WBID, writeData1_WBID, 
writeData2_WBID, aluResult1_EXEID, aluResult2_EXEID,  
do_writeback1_IDEXE, do_writeback2_IDEXE, readRegisterA1_IDEXE, 
readRegisterB1_IDEXE, readRegisterA2_IDEXE, readRegisterB2_IDEXE,  
taken_branch1_IDIF, taken_branch2_IDIF,  aluResult1_WBID, 
aluResult2_WBID,  
writeRegister1_IDEXE, writeRegister2_IDEXE, 
nextInstruction_address_IDIF, Reg_ID, R2_output_ID, 
Operand_A1_IDEXE, Operand_B1_IDEXE, Operand_A2_IDEXE, 
Operand_B2_IDEXE, ALU_control1_IDEXE, ALU_control2_IDEXE, 
MemRead1_IDEXE, MemRead2_IDEXE, MemWrite1_IDEXE, MemWrite2_IDEXE, 
MemtoReg1_IDEXE, MemtoReg2_IDEXE, Instr1_IFID, Instr2_IFID, 
PCA_IFID, writeData1_WBID, writeData2_WBID, R2_input, CIA_IFID);

   EXE EXE1( CLK, RESET, ALUSrc1_EXEM, ALUSrc2_EXEM, ALUSrc1_IDEXE, ALUSrc2_IDEXE, Instr1_IDEXE, Instr2_IDEXE, Instr1_EXEM, Instr2_EXEM, Dest_Value1_IDEXE, Dest_Value2_IDEXE, Dest_Value1_EXEM, Dest_Value2_EXEM, readDataB1_IDEXE, readDataB2_IDEXE, readDataB1_EXEM, readDataB2_EXEM, aluResult1_EXEID, aluResult2_EXEID, do_writeback1_WBEXE, do_writeback2_WBEXE, writeRegister1_WBEXE, writeRegister2_WBEXE, writeData1_WBEXE, writeData2_WBEXE, ALU_control1_EXEM, ALU_control2_EXEM, ALU_control1_IDEXE, ALU_control2_IDEXE, writeData1_WBID, writeData2_WBID, writeRegister1_MEMW, writeRegister2_MEMW, do_writeback1_MEMW, do_writeback2_MEMW, do_writeback1_EXEM, do_writeback2_EXEM, do_writeback1_IDEXE, do_writeback2_IDEXE, /**/readRegisterA1_IDEXE, readRegisterA2_IDEXE, readRegisterB1_IDEXE, readRegisterB2_IDEXE, /**/writeRegister1_IDEXE, writeRegister2_IDEXE, writeRegister1_EXEM, writeRegister2_EXEM, Instr1_10_6_IDEXE, Instr2_10_6_IDEXE, MemRead1_IDEXE, MemRead2_IDEXE, MemWrite1_IDEXE, MemWrite2_IDEXE, MemRead1_EXEM, MemRead2_EXEM, MemWrite1_EXEM, MemWrite2_EXEM, Operand_A1_IDEXE, Operand_A2_IDEXE, Operand_B1_IDEXE, Operand_B2_IDEXE, MemtoReg1_IDEXE, MemtoReg2_IDEXE, MemtoReg1_EXEM, MemtoReg2_EXEM, aluResult1_EXEM, aluResult2_EXEM);

   MEM MEM1( CLK, RESET, ALUSrc1_EXEM, ALUSrc2_EXEM, Instr1_EXEM, Instr2_EXEM, Instr_fMEM, writeData1_WBID, writeData2_WBID, writeRegister1_WBID, writeRegister2_WBID, do_writeback1_WBID, do_writeback2_WBID, Dest_Value1_EXEM, Dest_Value2_EXEM, readDataB1_EXEM, readDataB2_EXEM, /**/writeData1_MID,writeData2_MID,/**/ do_writeback1_MEMW, do_writeback2_MEMW, do_writeback1_EXEM, do_writeback2_EXEM, writeRegister1_EXEM, writeRegister2_EXEM, writeRegister1_MEMW, writeRegister2_MEMW, /**/data_write_2DM, data_address_2DM, MemRead, MemWrite, data_read_fDM, /**/MemtoReg1_EXEM, MemtoReg2_EXEM, MemtoReg1_MEMW, MemtoReg2_MEMW, MemRead1_EXEM, MemRead2_EXEM, MemWrite1_EXEM, MemWrite2_EXEM, ALU_control1_EXEM, ALU_control2_EXEM, aluResult1_EXEM, aluResult2_EXEM, aluResult1_MEMW, aluResult2_MEMW, data_read1_MEMW, data_read2_MEMW);

   WB WriteBack ( CLK, RESET, do_writeback1_WBEXE, do_writeback2_WBEXE, writeRegister1_WBEXE, writeRegister2_WBEXE, writeData1_WBEXE, writeData2_WBEXE, do_writeback1_MEMW, do_writeback2_MEMW, aluResult1_WBID, aluResult2_WBID, writeRegister1_MEMW, writeRegister2_MEMW, writeRegister1_WBID, writeRegister2_WBID, writeData1_WBID, writeData2_WBID, do_writeback1_WBID, do_writeback2_WBID, aluResult1_MEMW, aluResult2_MEMW, data_read1_MEMW, data_read2_MEMW, MemtoReg1_MEMW, MemtoReg2_MEMW);

endmodule
