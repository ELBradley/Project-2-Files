//-----------------------------------------
//           Data Memory Stage
//-----------------------------------------
module MEM (	CLK, 
		RESET,
		ALUSrc1,
		ALUSrc2,
		Instr1,
		Instr2,
		Instr_OUT,
		writeData1_WB,
		writeData2_WB,
		writeRegister1_WB, 
		writeRegister2_WB, 
		do_writeback1_WB,
		do_writeback2_WB,
		Dest_Value1,
		Dest_Value2,
		readDataB1,
		readDataB2,
		Data1_2ID,
		Data2_2ID,
		do_writeback1_PR, 
		do_writeback2_PR, 
		do_writeback1,
		do_writeback2, 
		writeRegister1, 
		writeRegister2, 
		writeRegister1_PR, 
		writeRegister2_PR, 
		data_write_2DM,
		data_address_2DM,
		MemRead_2DM,
		MemWrite_2DM,
		data_read_fDM,
		MemtoReg1, 
		MemtoReg2, 
		MemtoReg1_PR, 
		MemtoReg2_PR, 
		MemRead1, 
		MemRead2, 
		MemWrite1, 
		MemWrite2,
		ALU_control1, 
		ALU_control2, 
		aluResult1, 
		aluResult2, 
		aluResult1_PR, 
		aluResult2_PR, 
		data_read1_PR,
		data_read2_PR
		);

   output reg    [31: 0] aluResult1_PR;
   output reg    [31: 0] aluResult2_PR;
   output reg    [31: 0] data_read1_PR;
   output reg    [31: 0] data_read2_PR;
   output reg    [31: 0] data_write_2DM;
   output reg    [31: 0] data_address_2DM;
   output reg    [31: 0] Instr_OUT;
   output reg    [31: 0] Data1_2ID;
   output reg    [31: 0] Data2_2ID;
   output reg    [ 4: 0] writeRegister1_PR;
   output reg    [ 4: 0] writeRegister2_PR;
   output reg            MemtoReg1_PR;
   output reg            MemtoReg2_PR;
   output reg            do_writeback1_PR;
   output reg            do_writeback2_PR;
   output reg	         MemRead_2DM;
   output reg            MemWrite_2DM;   

   input         [31: 0] aluResult1;
   input         [31: 0] aluResult2;
   input         [31: 0] data_read_fDM;
   input         [31: 0] Dest_Value1;
   input         [31: 0] Dest_Value2;
   input         [31: 0] readDataB1;
   input         [31: 0] readDataB2;
   input         [31: 0] writeData1_WB;
   input         [31: 0] writeData2_WB;
   input         [31: 0] Instr1;
   input         [31: 0] Instr2;
   input         [ 5: 0] ALU_control1;
   input         [ 5: 0] ALU_control2;
   input         [ 4: 0] writeRegister1_WB;
   input         [ 4: 0] writeRegister2_WB;
   input         [ 4: 0] writeRegister1;
   input         [ 4: 0] writeRegister2;
   input                 ALUSrc1;
   input                 ALUSrc2;
   input                 do_writeback1_WB;
   input                 do_writeback2_WB;
   input                 do_writeback1;
   input                 do_writeback2;
   input                 CLK;
   input                 RESET;
   input                 MemtoReg1;
   input                 MemtoReg2;
   input                 MemRead1;
   input                 MemRead2;
   input                 MemWrite1;
   input                 MemWrite2;

   wire         [31: 0] data_read_aligned;
   wire         [31: 0] Dest_Value;
   wire         [31: 0] aluResult;
   wire         [31: 0] readDataB;
   wire         [31: 0] writeData_WB;
   wire         [31: 0] Instr;
   wire         [ 5: 0] ALU_control;
   wire                 MemRead;
   wire                 MemWrite;
   wire                 select1_WB;
   wire                 select2_WB;

   reg                  comment;

   initial comment = 0;  //show MEM displays

   assign Instr_OUT = (MemWrite2)?Instr2:Instr1;
   assign MemRead_2DM = (MemRead1|MemRead2);
   assign MemWrite_2DM = (MemWrite1|MemWrite2);
   assign select1_WB = (do_writeback1_WB&&(writeRegister1_WB==((MemWrite2)?writeRegister2:writeRegister1)))/*&&(!ALUSrc1)/**/;
   assign select2_WB = (do_writeback2_WB&&(writeRegister2_WB==((MemWrite2)?writeRegister2:writeRegister1)))/*&&(!ALUSrc2)/**/;
   assign data_write_2DM = (select2_WB)?writeData2_WB:((select1_WB)?writeData1_WB:((MemWrite2)?readDataB2:readDataB1));
   assign data_address_2DM = (MemWrite2|MemRead2)?aluResult2:aluResult1;
   
   assign Data1_2ID = (MemRead_2DM)?data_read_aligned:((MemRead2)?aluResult2:aluResult1);

   assign Data2_2ID = (MemRead_2DM)?data_read_aligned:((MemRead1)?aluResult1:aluResult2);

   always
     begin
        data_read_aligned = (select2_WB)?writeData2_WB:((select1_WB)?writeData1_WB:((MemRead2)?Dest_Value2:Dest_Value1));
	ALU_control = (MemRead2)? ALU_control2: ALU_control1;//~DS//ALU_control = (MemRead2)? ALU_control1: ALU_control2;
	aluResult = (MemRead2)? aluResult2: aluResult1;//~DS//aluResult = (MemRead2)? aluResult1: aluResult2;
	
	       case(ALU_control)
        		6'b101101: begin //LWX
                        	case( aluResult[1:0] )
                       	   		0:  data_read_aligned = data_read_fDM;
                      	        	1:  data_read_aligned[31:8] = data_read_fDM[23:0];
                       	        	2:  data_read_aligned[31:16] = data_read_fDM[15:0];
                       	        	3:  data_read_aligned[31:24] = data_read_fDM[7:0];
               		        endcase
                        end
                	6'b101110: begin //LWX
                    		case( aluResult[1:0] )
                     		   	0:  data_read_aligned[7:0] = data_read_fDM[31:24];
                        		1:  data_read_aligned[15:0] = data_read_fDM[31:16];
                        		2:  data_read_aligned[23:0] = data_read_fDM[31:8];
                       		 	3:  data_read_aligned = data_read_fDM;
                    		endcase
                	end
                	6'b100001: begin //LB
		    		case( aluResult[1:0] )
		  			3: data_read_aligned={{24{data_read_fDM[7]}},data_read_fDM[7:0]};
					2: data_read_aligned={{24{data_read_fDM[15]}},data_read_fDM[15:8]};
					1: data_read_aligned={{24{data_read_fDM[23]}},data_read_fDM[23:16]};
					0: data_read_aligned={{24{data_read_fDM[31]}},data_read_fDM[31:24]};
					default: begin end
		    		endcase
      	         	end
         	        6'b101011: begin //LH
		    		case( aluResult[1:0] )
					0:data_read_aligned={{16{data_read_fDM[15]}},data_read_fDM[15:0]};
					2:data_read_aligned={{16{data_read_fDM[31]}},data_read_fDM[31:16]};
					default: begin end
		    		endcase
                	end
                	6'b101010: begin //LBU
                    		case( aluResult[1:0] )
					0: data_read_aligned={24'b0,data_read_fDM[31:24]};
					1: data_read_aligned={24'b0,data_read_fDM[23:16]};
					2: data_read_aligned={24'b0,data_read_fDM[15:8]};
					3: data_read_aligned={24'b0,data_read_fDM[7:0]};
					default: begin end 
		    		endcase
                	end
                	6'b101100: begin //LHU
		    		case(aluResult%4)
					0:data_read_aligned={16'b0,data_read_fDM[15:0]};
	            			2:data_read_aligned={16'b0,data_read_fDM[31:16]};
					default: begin end
		    		endcase
                	end
                        default: data_read_aligned = data_read_fDM;  
		endcase
     end


    // Pipeline Register 1 (MEM/WB)
   always @ (posedge CLK or posedge RESET)
     begin
       if(RESET == 1'b0)
         begin
           MemtoReg1_PR <= 1'b0;
           writeRegister1_PR <= 5'b0;
           aluResult1_PR <= 32'b0;
           data_read1_PR <= 32'b0;
           do_writeback1_PR <= 1'b0;
         end
       else
         begin
           MemtoReg1_PR <= MemtoReg1;
           writeRegister1_PR <= writeRegister1;
           aluResult1_PR <= aluResult1;
           data_read1_PR <= data_read_aligned;
	   do_writeback1_PR <= do_writeback1;
         end
     end
    // Pipeline Register 2 (MEM/WB)
   always @ (posedge CLK or posedge RESET)
     begin215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
       if(RESET == 1'b0)
         begin
           MemtoReg2_PR <= 1'b0;
           writeRegister2_PR <= 5'b0;
           aluResult2_PR <= 32'b0;
           data_read2_PR <= 32'b0;
           do_writeback2_PR <= 1'b0;
         end
       else
         begin
           MemtoReg2_PR <= MemtoReg2;
           writeRegister2_PR <= writeRegister2;
           aluResult2_PR <= aluResult2;
           data_read2_PR <= data_read_aligned;
     do_writeback2_PR <= do_writeback2;
         end
     end
     always @ (posedge CLK) begin
         if (comment) begin 
    $display("=============================================================");
    $display("[MEM]:Write Register 1:%d\t\t|Write Register 2:%x",writeRegister1,writeRegister2);
    $display("=============================================================");
    $display("[WB]:Write Register 1:%d\t\t|Write Register 2:%x",writeRegister1_PR,writeRegister2_PR); 
    /*$display("[MEM]:MemRead_2DM:%x",MemRead_2DM);
    $display("[MEM]:MemWrite_2DM:%x",MemWrite_2DM);
    $display("[MEM]:data_address_2DM:%x",data_address_2DM);
    $display("[MEM]:data_write_2DM:%x",data_write_2DM);
    $display("[MEM]:data_read_fDM:%x",data_read_fDM);
    $display("[MEM]:Data1_2ID:%x/t/tData2_2ID:%x",Data1_2ID,Data2_2ID);
    $display("[MEM]:aluResult1:%x\t|aluResult2:%x",aluResult1,aluResult2);
                $display("[MEM]:do_writeback1:%x\t\t|do_writeback2:%x",do_writeback1,do_writeback2);
    $display("[MEM]:data_read1_PR:%x\t|data_read2_PR:%x",data_read1_PR,data_read2_PR);
    $display("[MEM]:aluResult1_PR:%x\t|aluResult2_PR:%x",aluResult1_PR,aluResult2_PR);
    $display("[MEM]:MemWrite1:%x\t\t|MemWrite2:%x",MemWrite1,MemWrite2);
    $display("[MEM]:MemRead1:%x\t\t|MemRead2:%x",MemRead1,MemRead2);
                $display("[MEM]:do_writeback1_PR:%x\t|do_writeback2_PR:%x",do_writeback1_PR,do_writeback2_PR);
    /**/
         end
     end
endmodule
Commit summary: Extended description: (optional)
ELBradley ebradle4@u.rochester.edu

       if(RESET == 1'b0)
         begin
           MemtoReg2_PR <= 1'b0;
           writeRegister2_PR <= 5'b0;
           aluResult2_PR <= 32'b0;
           data_read2_PR <= 32'b0;
           do_writeback2_PR <= 1'b0;
         end
       else
         begin
           MemtoReg2_PR <= MemtoReg2;
           writeRegister2_PR <= writeRegister2;
           aluResult2_PR <= aluResult2;
           data_read2_PR <= data_read_aligned;
	   do_writeback2_PR <= do_writeback2;
         end
     end


     always @ (posedge CLK) begin
         if (comment) begin 
		$display("=============================================================");
		$display("[MEM]:Write Register 1:%d\t\t|Write Register 2:%x",writeRegister1,writeRegister2);
		$display("=============================================================");
		$display("[WB]:Write Register 1:%d\t\t|Write Register 2:%x",writeRegister1_PR,writeRegister2_PR);	
		/*$display("[MEM]:MemRead_2DM:%x",MemRead_2DM);
		$display("[MEM]:MemWrite_2DM:%x",MemWrite_2DM);
		$display("[MEM]:data_address_2DM:%x",data_address_2DM);
		$display("[MEM]:data_write_2DM:%x",data_write_2DM);
		$display("[MEM]:data_read_fDM:%x",data_read_fDM);
		$display("[MEM]:Data1_2ID:%x/t/tData2_2ID:%x",Data1_2ID,Data2_2ID);
		$display("[MEM]:aluResult1:%x\t|aluResult2:%x",aluResult1,aluResult2);
                $display("[MEM]:do_writeback1:%x\t\t|do_writeback2:%x",do_writeback1,do_writeback2);
		$display("[MEM]:data_read1_PR:%x\t|data_read2_PR:%x",data_read1_PR,data_read2_PR);
		$display("[MEM]:aluResult1_PR:%x\t|aluResult2_PR:%x",aluResult1_PR,aluResult2_PR);
		$display("[MEM]:MemWrite1:%x\t\t|MemWrite2:%x",MemWrite1,MemWrite2);
		$display("[MEM]:MemRead1:%x\t\t|MemRead2:%x",MemRead1,MemRead2);
                $display("[MEM]:do_writeback1_PR:%x\t|do_writeback2_PR:%x",do_writeback1_PR,do_writeback2_PR);
		/**/
         end
     end
endmodule

