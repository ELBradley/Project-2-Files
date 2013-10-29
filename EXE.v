//-----------------------------------------
//           Execute Stage
//-----------------------------------------
module EXE(	CLK, 
		RESET,
		ALUSrc1_PR,
		ALUSrc2_PR,
		ALUSrc1,
		ALUSrc2,
		Instr1,
		Instr2,
		Instr1_PR,
		Instr2_PR,
		Dest_Value1,
		Dest_Value2,
		Dst1_PR,
		Dst2_PR,
		readDataB1,
		readDataB2,
		readDataB1_PR,
		readDataB2_PR,
		aluResult1_OUT,
 		aluResult2_OUT,
                do_writeback1_WB,
                do_writeback2_WB,
	        writeRegister1_WB,
	        writeRegister2_WB,
		Data1_WB,
		Data2_WB,
		ALU_control1_PR,
		ALU_control2_PR,
		ALU_control1,		
		ALU_control2,		
		Data1_MEM,
		Data2_MEM,
                writeRegister1_MEM,
                writeRegister2_MEM,
                do_writeback1_MEM, 
                do_writeback2_MEM, 
		do_writeback1_PR,
		do_writeback2_PR,
		do_writeback1_ID,
		do_writeback2_ID,
		readRegisterA1,
		readRegisterA2,
		readRegisterB1,
		readRegisterB2,
		writeRegister1, 
		writeRegister2, 
		writeRegister1_PR, 
		writeRegister2_PR, 
		Instr1_10_6, 
		Instr2_10_6, 
		MemRead1, 
		MemRead2, 
		MemWrite1, 
		MemWrite2, 
		MemRead1_PR, 
		MemRead2_PR, 
		MemWrite1_PR, 
		MemWrite2_PR, 
		Operand_A1, 
		Operand_A2, 
		Operand_B1, 
		Operand_B2, 
		MemtoReg1, 
		MemtoReg2, 
		MemtoReg1_PR, 
		MemtoReg2_PR, 
		aluResult1_PR,
		aluResult2_PR
		);

   output reg     [31: 0] aluResult1_PR;
   output reg     [31: 0] aluResult2_PR;
   output reg     [31: 0] Dst1_PR;
   output reg     [31: 0] Dst2_PR;
   output reg     [31: 0] aluResult1_OUT;
   output reg     [31: 0] aluResult2_OUT;
   output reg     [31: 0] readDataB1_PR;
   output reg     [31: 0] readDataB2_PR;

   output reg     [31: 0] Instr1_PR;
   output reg     [31: 0] Instr2_PR;
   output reg     [ 5: 0] ALU_control1_PR;
   output reg     [ 5: 0] ALU_control2_PR;
   output reg     [ 4: 0] writeRegister1_PR;
   output reg     [ 4: 0] writeRegister2_PR;
   output reg             MemtoReg1_PR;
   output reg             ALUSrc1_PR;
   output reg             ALUSrc2_PR;
   output reg             MemtoReg2_PR;
   output reg        	  MemRead1_PR;
   output reg        	  MemRead2_PR;
   output reg        	  MemWrite1_PR;
   output reg        	  MemWrite2_PR;
   output reg        	  do_writeback1_PR;
   output reg        	  do_writeback2_PR;

   input          [31: 0] Operand_A1;
   input          [31: 0] Operand_A2;
   input          [31: 0] Operand_B1;
   input          [31: 0] Operand_B2;
   input          [31: 0] Dest_Value1;
   input          [31: 0] Dest_Value2;
   input          [31: 0] Data1_MEM;
   input          [31: 0] Data2_MEM;
   input          [31: 0] Data1_WB;
   input          [31: 0] Data2_WB;
   input          [31: 0] readDataB1;
   input          [31: 0] readDataB2;
   input          [31: 0] Instr1;
   input          [31: 0] Instr2;
   input          [ 5: 0] ALU_control1;
   input          [ 5: 0] ALU_control2;
   input          [ 4: 0] writeRegister1_MEM;
   input          [ 4: 0] writeRegister2_MEM;
   input          [ 4: 0] readRegisterA1;
   input          [ 4: 0] readRegisterA2;
   input          [ 4: 0] readRegisterB1;
   input          [ 4: 0] readRegisterB2;
   input          [ 4: 0] writeRegister1;
   input          [ 4: 0] writeRegister2;
   input          [ 4: 0] Instr1_10_6;
   input          [ 4: 0] Instr2_10_6;
   input          [ 4: 0] writeRegister1_WB;
   input          [ 4: 0] writeRegister2_WB;
   input                  ALUSrc1;
   input                  ALUSrc2;
   input         	  do_writeback1_MEM;
   input         	  do_writeback2_MEM;
   input                  do_writeback1_WB;
   input                  do_writeback2_WB;
   input         	  do_writeback1_ID;
   input         	  do_writeback2_ID;
   input                  MemtoReg1;
   input                  MemtoReg2;
   input                  MemRead1;
   input                  MemRead2;
   input                  MemWrite1;
   input                  MemWrite2;
   input                  CLK;
   input        	  RESET;
        
   wire           [31: 0] aluResult1;
   wire           [31: 0] aluResult2;
   wire           [31: 0] OpA1;
   wire           [31: 0] OpA2;
   wire           [31: 0] OpB1;
   wire           [31: 0] OpB2;
   wire           [31: 0] Dst1;
   wire           [31: 0] Dst2;

   reg            [31: 0] HI;
   reg            [31: 0] LO;
   reg                    comment;


   	initial comment = 0;  //show EXE displays

	// Forwarding for Slot 1
	always begin
		// Operand A
		if(do_writeback2_PR && (writeRegister2_PR == readRegisterA1))
         		OpA1 = aluResult2_PR;
		else if(do_writeback1_PR && (writeRegister1_PR == readRegisterA1))
         		OpA1 = aluResult1_PR;
		else if(do_writeback2_MEM && (writeRegister2_MEM == readRegisterA1))
			OpA1 = Data2_MEM;
		else if(do_writeback1_MEM && (writeRegister1_MEM == readRegisterA1))
			OpA1 = Data1_MEM;
		else if(do_writeback2_WB && (writeRegister2_WB == readRegisterA1))
			OpA1 = Data2_WB;
		else if(do_writeback1_WB && (writeRegister1_WB == readRegisterA1))
			OpA1 = Data1_WB;
		else OpA1 = Operand_A1;
		// Operand B
		if(do_writeback2_PR && (writeRegister2_PR == readRegisterB1)/* && (ALUSrc1!=1)/**/)
			OpB1 = aluResult2_PR;
		else if(do_writeback1_PR && (writeRegister1_PR == readRegisterB1)/* && (ALUSrc1!=1)/**/)
			OpB1 = aluResult1_PR;
		else if(do_writeback2_MEM && (writeRegister2_MEM == readRegisterB1)/* && (ALUSrc1!=1)/**/)
			OpB1 = Data2_MEM;
		else if(do_writeback1_MEM && (writeRegister1_MEM == readRegisterB1)/* && (ALUSrc1!=1)/**/)
			OpB1 = Data1_MEM;
		else if(do_writeback2_WB && (writeRegister2_WB == readRegisterB1)/* && (ALUSrc1!=1)/**/)
			OpB1 = Data2_WB;
		else if(do_writeback1_WB && (writeRegister1_WB == readRegisterB1)/* && (ALUSrc1!=1)/**/)
			OpB1 = Data1_WB;
		else OpB1 = Operand_B1;
		// Destination
		if(do_writeback2_PR && (writeRegister2_PR == writeRegister1))
			Dst1 = aluResult2_PR;
		else if(do_writeback1_PR && (writeRegister1_PR == writeRegister1))
			Dst1 = aluResult1_PR;
		else if(do_writeback2_MEM && (writeRegister2_MEM == writeRegister1))
			Dst1 = Data2_MEM;
		else if(do_writeback1_MEM && (writeRegister1_MEM == writeRegister1))
			Dst1 = Data1_MEM;
		else if(do_writeback2_WB && (writeRegister2_WB == writeRegister1))
			Dst1 = Data2_WB;
		else if(do_writeback1_WB && (writeRegister1_WB == writeRegister1))
			Dst1 = Data1_WB;
		else Dst1 = Dest_Value1;
	end

	// Forwarding for Slot 2
	always begin
		// Operand A
		if(do_writeback2_PR && (writeRegister2_PR == readRegisterA2))
         		OpA2 = aluResult2_PR;
		else if(do_writeback1_PR && (writeRegister1_PR == readRegisterA2))
         		OpA2 = aluResult1_PR;
		else if(do_writeback2_MEM && (writeRegister2_MEM == readRegisterA2))
			OpA2 = Data2_MEM;
		else if(do_writeback1_MEM && (writeRegister1_MEM == readRegisterA2))
			OpA2 = Data1_MEM;
		else if(do_writeback2_WB && (writeRegister2_WB == readRegisterA2))
			OpA2 = Data2_WB;
		else if(do_writeback1_WB && (writeRegister1_WB == readRegisterA2))
			OpA2 = Data1_WB;
		else OpA2 = Operand_A2;
		// Operand B
		if(do_writeback2_PR && (writeRegister2_PR == readRegisterB2)/* && (ALUSrc2!=1)/**/)
			OpB2 = aluResult2_PR;
		else if(do_writeback1_PR && (writeRegister1_PR == readRegisterB2)/* && (ALUSrc2!=1)/**/)
			OpB2 = aluResult1_PR;
		else if(do_writeback2_MEM && (writeRegister2_MEM == readRegisterB2)/* && (ALUSrc2!=1)/**/)
			OpB2 = Data2_MEM;
		else if(do_writeback1_MEM && (writeRegister1_MEM == readRegisterB2)/* && (ALUSrc2!=1)/**/)
			OpB2 = Data1_MEM;
		else if(do_writeback2_WB && (writeRegister2_WB == readRegisterB2)/* && (ALUSrc2!=1)/**/)
			OpB2 = Data2_WB;
		else if(do_writeback1_WB && (writeRegister1_WB == readRegisterB2)/* && (ALUSrc2!=1)/**/)
			OpB2 = Data1_WB;
		else OpB2 = Operand_B2;
		// Destination
		if(do_writeback2_PR && (writeRegister2_PR == writeRegister2))
			Dst2 = aluResult2_PR;
		else if(do_writeback1_PR && (writeRegister1_PR == writeRegister2))
			Dst2 = aluResult1_PR;
		else if(do_writeback2_MEM && (writeRegister2_MEM == writeRegister2))
			Dst2 = Data2_MEM;
		else if(do_writeback1_MEM && (writeRegister1_MEM == writeRegister2))
			Dst2 = Data1_MEM;
		else if(do_writeback2_WB && (writeRegister2_WB == writeRegister2))
			Dst2 = Data2_WB;
		else if(do_writeback1_WB && (writeRegister1_WB == writeRegister2))
			Dst2 = Data1_WB;
		else Dst2 = Dest_Value2;
	end

   	assign aluResult1_OUT = aluResult1;
   	assign aluResult2_OUT = aluResult2;

	ALU ALU1(HI, LO, aluResult1, OpA1, OpB1, ALU_control1, Instr1_10_6, CLK);
	ALU ALU2(HI, LO, aluResult2, OpA2, OpB2, ALU_control2, Instr2_10_6, CLK);

	//Pipeline Stage 1

	always @ (posedge CLK or negedge RESET) begin
		if(!RESET) begin
			MemtoReg1_PR <= 1'b0;
			MemRead1_PR <= 1'b0;
			MemWrite1_PR <= 1'b0;
			aluResult1_PR <= 32'b0;
			writeRegister1_PR <= 5'b0;
			do_writeback1_PR <= 1'b0;
			ALU_control1_PR <= 6'b0;
			readDataB1_PR <= 32'b0;
			Dst1_PR <= 32'b0;
			Instr1_PR <= 32'b0;
			ALUSrc1_PR <= 1'b0;
		end
		else begin
		     	MemtoReg1_PR <= MemtoReg1;
		     	readDataB1_PR <= ((do_writeback1_MEM)&&(writeRegister1_MEM==writeRegister1))?Data1_MEM:(((do_writeback1_WB)&&(writeRegister1_WB==writeRegister1))?Data1_WB:readDataB1);
        	     	aluResult1_PR <= aluResult1;
		     	MemRead1_PR <= MemRead1;
		     	MemWrite1_PR <= MemWrite1;
		     	writeRegister1_PR <= writeRegister1;
		     	do_writeback1_PR <= do_writeback1_ID;
        	     	ALU_control1_PR <= ALU_control1;
		     	Dst1_PR <= Dst1;
		     	Instr1_PR <= Instr1;
		     	ALUSrc1_PR <= ALUSrc1;
		end
	end

  //Pipeline Stage 2
  always @ (posedge CLK or negedge RESET)
    begin
	if(!RESET)
	  begin
	     MemtoReg2_PR <= 1'b0;
	     MemRead2_PR <= 1'b0;
	     MemWrite2_PR <= 1'b0;
	     aluResult2_PR <= 32'b0;
	     writeRegister2_PR <= 5'b0;
	     do_writeback2_PR <= 1'b0;
             ALU_control2_PR <= 6'b0;
	     readDataB2_PR <= 32'b0;
	     Dst2_PR <= 32'b0;
	     Instr2_PR <= 32'b0;
	     ALUSrc2_PR <= 1'b0;
          end
	else
	  begin
	     MemtoReg2_PR <= MemtoReg2;
	     readDataB2_PR <= ((do_writeback2_MEM)&&(writeRegister2_MEM==writeRegister2))?Data2_MEM:(((do_writeback2_WB)&&(writeRegister2_WB==writeRegister2))?Data2_WB:readDataB2);
             aluResult2_PR <= aluResult2;
	     MemRead2_PR <= MemRead2;
	     MemWrite2_PR <= MemWrite2;
	     writeRegister2_PR <= writeRegister2;
	     do_writeback2_PR <= do_writeback2_ID;
             ALU_control2_PR <= ALU_control2;
	     Dst2_PR <= Dst2;     
	     Instr2_PR <= Instr2;
             ALUSrc2_PR <= ALUSrc2;
          end
    end
 
      
  always begin
	if(comment) begin
		$display("=============================================================");
		$display("[EXE]:Data1_WB:%x\t\t|Data2_WB:%x", Data1_WB, Data2_WB);
                $display("[EXE]:Data1_MEM:%x\t|Data2_MEM:%x", Data1_MEM, Data2_MEM);
		$display("[EXE]:OpA1:%x\t\t|OpA2:%x",OpA1,OpA2);
		$display("[EXE]:OpB1:%x\t\t|OpB2:%x",OpB1,OpB2);
		$display("[EXE]:Operand_A1:%x\t|Operand_A2:%x",Operand_A1,Operand_A2);
		$display("[EXE]:Operand_B1:%x\t|Operand_B2:%x",Operand_B1,Operand_B2);
		$display("[EXE]:aluResult1:%x\t|aluResult2:%x",aluResult1,aluResult2);
		$display("[EXE]:readRegisterA1:%x\t\t|readRegisterA2:%x",readRegisterA1,readRegisterA2);
		$display("[EXE]:readRegisterB1:%x\t\t|readRegisterB2:%x",readRegisterB1,readRegisterB2);
		$display("[EXE]:writeRegister1:%x\t\t|writeRegister2:%x",writeRegister1,writeRegister2);
		$display("[EXE]:do_writeback1_PR:%x\t|do_writeback2_PR:%x",do_writeback1_PR,do_writeback2_PR);
		$display("[EXE]:writeRegister1_PR:%x\t|writeRegister2_PR:%x",writeRegister1_PR,writeRegister2_PR);
		$display("[EXE]:aluResult1_PR:%x\t|aluResult2_PR:%x",aluResult1_PR,aluResult2_PR);
		$display("[EXE]:do_writeback1_MEM:%x\t|do_writeback2_MEM:%x",do_writeback1_MEM,do_writeback2_MEM);
 		$display("[EXE]:writeRegister1_MEM:%x\t|writeRegister2_MEM:%x",writeRegister1_MEM,writeRegister2_MEM);
		$display("[EXE]:Data1_MEM:%x\t|Data2_MEM:%x",Data1_MEM,Data2_MEM);
 		$display("[EXE]:do_writeback1_WB:%x\t|do_writeback2_WB:%x",do_writeback1_WB,do_writeback2_WB);
		$display("[EXE]:writeRegister1_WB:%x\t|writeRegister2_WB:%x",writeRegister1_WB,writeRegister2_WB);
		$display("[EXE]:Data1_WB:%x\t\t|Data2_WB:%x",Data1_WB,Data2_WB);
		$display("[EXE]:readDataB1_PR:%x\t|readDataB2_PR:%x",readDataB1_PR,readDataB2_PR);
		/**/				
	end	
   end

endmodule
