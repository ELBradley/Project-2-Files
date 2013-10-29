//-----------------------------------------
//         Instruction Decode Stage
//-----------------------------------------
module ID ( 	CLK,
		RESET,
		ALUSrc1_PR,
		ALUSrc2_PR,
		fetchNull1_OUT,
		fetchNull2_OUT,
		single_fetch_OUT,
		Instr1_PR,
		Instr2_PR,
		Dest_Value1_PR,
		Dest_Value2_PR,
                insertBubble_OUT,
                SYS_OUT,
		readDataB1_PR,
		readDataB2_PR,
		Instr1_10_6_PR,
		Instr2_10_6_PR,
                do_writeback1_MEM,
		do_writeback2_MEM,
                writeRegister1_MEM,
		writeRegister2_MEM,
                Data1_MEM,
		Data2_MEM,
                do_writeback1_WB,
		do_writeback2_WB,
                writeRegister1_WB,
		writeRegister2_WB,
                Data1_WB,
		Data2_WB,
		aluResult1,
		aluResult2,	
		do_writeback1_PR,
		do_writeback2_PR,
		readRegisterA1_PR,
		readRegisterB1_PR,
		readRegisterA2_PR,
		readRegisterB2_PR,
		taken_branch1_PR,
		taken_branch2_PR,
		aluResult1_WB,
		aluResult2_WB,
	 	writeRegister1_PR,
	 	writeRegister2_PR,
		nextInstruction_address_PR,
		Reg,
		R2_output_PR,
		Operand_A1_PR,
		Operand_B1_PR,
		Operand_A2_PR,
		Operand_B2_PR,
		ALU_control1_PR,
		ALU_control2_PR,
		MemRead1_PR,
		MemRead2_PR,
		MemWrite1_PR,
		MemWrite2_PR,
		MemtoReg1_PR,
		MemtoReg2_PR,
		Instr1,
		Instr2,
		PCA,
		writeData1_WB,
		writeData2_WB,
		R2_input,
		CIA
		);
   	
	output reg      [31: 0] R2_output_PR;
	output reg      [31: 0] Operand_A1_PR;
	output reg      [31: 0] Operand_A2_PR;
	output reg      [31: 0] Operand_B1_PR;
	output reg      [31: 0] Operand_B2_PR;
	output reg      [31: 0] Dest_Value1_PR;
	output reg      [31: 0] Dest_Value2_PR;
	output reg      [31: 0] nextInstruction_address_PR;
	output reg      [31: 0] Reg [0:31];
	output reg      [31: 0] readDataB1_PR;
	output reg      [31: 0] readDataB2_PR;
	output reg      [31: 0] Instr1_PR;
	output reg      [31: 0] Instr2_PR;
	output reg      [ 5: 0] ALU_control1_PR;
	output reg      [ 5: 0] ALU_control2_PR;
	output reg      [ 4: 0] writeRegister1_PR;
	output reg      [ 4: 0] writeRegister2_PR;
     	output reg      [ 4: 0] readRegisterA1_PR;
	output reg      [ 4: 0] readRegisterA2_PR;
     	output reg      [ 4: 0] readRegisterB1_PR;
	output reg      [ 4: 0] readRegisterB2_PR;
        output reg      [ 4: 0] Instr1_10_6_PR;
        output reg      [ 4: 0] Instr2_10_6_PR;
        output reg              ALUSrc1_PR;
        output reg              ALUSrc2_PR;	
	output reg 	        single_fetch_OUT;
	output reg 	        taken_branch1_PR;
	output reg 	        taken_branch2_PR;
	output reg              MemRead1_PR;
	output reg              MemRead2_PR;
	output reg              MemtoReg1_PR;
	output reg              MemtoReg2_PR;
	output reg              MemWrite1_PR;
	output reg              MemWrite2_PR;
	output reg	        do_writeback1_PR;
	output reg	        do_writeback2_PR;
        output reg              insertBubble_OUT;
        output reg              SYS_OUT;
	output reg              fetchNull1_OUT;
	output reg              fetchNull2_OUT;

	input           [31: 0] Data1_MEM;
	input           [31: 0] Data2_MEM;
	input           [31 :0] Data1_WB;
	input           [31 :0] Data2_WB;
        input           [31: 0] Instr1;//_IN;
	input           [31: 0] Instr2;//_IN;
	input           [31: 0] aluResult1;
	input           [31: 0] aluResult2;
	input           [31: 0] aluResult1_WB;
	input           [31: 0] aluResult2_WB;
	input           [31: 0] PCA;
	input           [31: 0] writeData1_WB;
	input           [31: 0] writeData2_WB;
	input           [31: 0] R2_input;
	input           [31: 0] CIA;
	input           [ 4: 0] writeRegister1_WB;
	input           [ 4: 0] writeRegister2_WB;
	input           [ 4: 0] writeRegister1_MEM;
	input           [ 4: 0] writeRegister2_MEM;
	input                   do_writeback1_WB;
	input                   do_writeback2_WB;
	input                   do_writeback1_MEM;
	input                   do_writeback2_MEM;
	input                   CLK;
	input                   RESET;

        wire            [31: 0] Instr1;
	wire            [31: 0] Instr2;
        wire            [31: 0] com_OpA1;
	wire            [31: 0] com_OpB1;
        wire            [31: 0] com_OpA2;
	wire            [31: 0] com_OpB2;
	wire            [31: 0] signExtended_output1;
	wire            [31: 0] signExtended_output2;
	wire            [31: 0] Shift_addResult1;
	wire            [31: 0] Shift_addResult2;
	wire            [31: 0] Jump_address1;
	wire            [31: 0] Jump_address2;
	wire            [31: 0] R2_output;
	wire            [31: 0] readDataA1;
        wire            [31: 0] readDataA2;
	wire            [31: 0] readDataB1;
	wire            [31: 0] readDataB2;
	wire            [31: 0] Operand_B1;
	wire            [31: 0] Operand_B2;
	wire            [31: 0] nextInstruction_address;
	wire            [31: 0] CIAp4;	
	wire            [31: 0] PCAp4;	
	wire            [31: 0] nia1;	
	wire            [31: 0] nia2;	
	wire            [ 5: 0] ALU_control1;
	wire            [ 5: 0] ALU_control2;
	wire            [ 5: 0] opcode1;
	wire            [ 5: 0] opcode2;
	wire            [ 5: 0] funct1;
	wire            [ 5: 0] funct2;
	wire            [ 4: 0] readRegisterA1;
	wire            [ 4: 0] readRegisterA2;
	wire            [ 4: 0] readRegisterB1;
	wire            [ 4: 0] readRegisterB2;
     	wire            [ 4: 0] format1;
	wire            [ 4: 0] format2;
     	wire            [ 4: 0] rt1;
	wire            [ 4: 0] rt2;
	wire            [ 4: 0] writeRegister1;
	wire            [ 4: 0] writeRegister2;
	wire                    taken_branch1;
	wire                    taken_branch2;
	wire                    link1;
	wire                    link2;
	wire                    RegDst1;
	wire                    RegDst2;
	wire                    jump1;
	wire                    jump2;
	wire                    branch1;
	wire                    branch2;
	wire                    MemRead1;
	wire                    MemRead2;
	wire                    MemtoReg1;
	wire                    MemtoReg2;
	wire                    MemWrite1;
	wire                    MemWrite2;
	wire                    ALUSrc1;
	wire                    ALUSrc2;
	wire                    RegWrite1;
	wire                    RegWrite2;
	wire                    jumpRegister_Flag1;
	wire                    jumpRegister_Flag2;
	wire                    sign_or_zero_Flag1;
	wire                    sign_or_zero_Flag2;
	wire                    syscal1;
	wire                    syscal2;
	wire			MemHazard;
	wire			SysHazard;
	wire			WAWHazard;
	wire			RAWHazard;
	wire			JMPHazard;
	wire			NOPHazard;

        reg             [ 1: 0] syscalBubbleCounter;
	reg                     comment1;
	reg                     comment2;  
	reg                     comment3;
 	reg			single_fetch_PR;
	
	initial begin
		comment1 = 0; //show isntruction type for core 1
		comment2 = 0; //show isntruction type for core 2
		comment3 = 0; //show ID displays
	end

	assign fetchNull1_OUT = taken_branch1 & !single_fetch_OUT;
	assign fetchNull2_OUT = taken_branch1;

	assign CIAp4 = CIA + 32'h00000004;
	assign PCAp4 = PCA + 32'h00000004;
        assign insertBubble_OUT = syscal1 && (syscalBubbleCounter != 0);
        assign SYS_OUT = syscal1 && (syscalBubbleCounter == 0);
	assign Jump_address1=(jumpRegister_Flag1)?{CIA[31:28],Instr1[25:0],2'b0}:com_OpA1;//readDataA1;
	assign Jump_address2=(jumpRegister_Flag2)?{CIAp4[31:28],Instr2[25:0],2'b0}:com_OpA2;//readDataA1;
	assign signExtended_output1 = (sign_or_zero_Flag1)?{{16{Instr1[15]}},Instr1[15:0]}:{16'b0,Instr1[15:0]};
	assign signExtended_output2 = (sign_or_zero_Flag2)?{{16{Instr2[15]}},Instr2[15:0]}:{16'b0,Instr2[15:0]};
	assign Shift_addResult1 = PCA+(signExtended_output1<<2);	
	assign Shift_addResult2 = PCAp4+(signExtended_output2<<2);	
	assign nia1 = (jump1)? Jump_address1: ((taken_branch1)? Shift_addResult1: PCA);
	assign nia2 = (jump2)? Jump_address2: ((taken_branch2)? Shift_addResult2: PCAp4);
	assign nextInstruction_address = (single_fetch_PR)? nia1: nia1-4;//(jump1 || taken_branch1)? nia1: nia2;
	assign readRegisterA1=Instr1[25:21];
	assign readRegisterB1=Instr1[20:16];
	assign writeRegister1 = (RegDst1)?Instr1[15:11]:((link1)?5'b11111:((syscal1)?5'b00000:Instr1[20:16]));
	assign readDataA1 = Reg[readRegisterA1];
	assign readDataB1 = Reg[readRegisterB1];
	assign Operand_B1 = (ALUSrc1)?signExtended_output1:readDataB1;
	assign R2_output = Reg[2];

	always begin 
		//Forwarded Operand A
		if (do_writeback2_PR && (readRegisterA1 == writeRegister2_PR))
			com_OpA1 = aluResult2;
		else if (do_writeback1_PR && (readRegisterA1 == writeRegister1_PR))
			com_OpA1 = aluResult1;
		else if (do_writeback2_MEM && (readRegisterA1 == writeRegister2_MEM))
			com_OpA1 = Data2_MEM;
		else if (do_writeback1_MEM && (readRegisterA1 == writeRegister1_MEM))
			com_OpA1 = Data1_MEM;
		else if (do_writeback2_WB && (readRegisterA1 == writeRegister2_WB))
			com_OpA1 = Data2_WB;
		else if (do_writeback1_WB && (readRegisterA1 == writeRegister1_WB))	
			com_OpA1 = Data1_WB;	
		else com_OpA1 = readDataA1;
		//Forwarded Operand B
		if (do_writeback2_PR && (readRegisterB1 == writeRegister2_PR)/* && (ALUSrc1!=1)/**/)
			com_OpB1 = aluResult2;
		else if (do_writeback1_PR && (readRegisterB1 == writeRegister1_PR)/* && (ALUSrc1!=1)/**/)
			com_OpB1 = aluResult1;
		else if (do_writeback2_MEM && (readRegisterB1 == writeRegister2_MEM)/* && (ALUSrc1!=1)/**/)
			com_OpB1 = Data2_MEM;
		else if (do_writeback1_MEM && (readRegisterB1 == writeRegister1_MEM)/* && (ALUSrc1!=1)/**/)
			com_OpB1 = Data1_MEM;
		else if (do_writeback2_WB && (readRegisterB1 == writeRegister2_WB)/* && (ALUSrc1!=1)/**/)
			com_OpB1 = Data2_WB;
		else if (do_writeback1_WB && (readRegisterB1 == writeRegister1_WB)/* && (ALUSrc1!=1)/**/)
			com_OpB1 = Data1_WB;
		else com_OpB1 = Operand_B1;
	end
	
	compare compare1(jump1,com_OpA1,com_OpB1,Instr1,taken_branch1);
	assign readRegisterA2=Instr2[25:21];
	assign readRegisterB2=Instr2[20:16];
	assign writeRegister2 = (RegDst2)?Instr2[15:11]:((link2)?5'b11111:((syscal2)?5'b00000:Instr2[20:16]));
	assign readDataA2 = Reg[readRegisterA2];
	assign readDataB2 = Reg[readRegisterB2];
	assign Operand_B2 = (ALUSrc2)?signExtended_output2:readDataB2;

	always begin 
	   //Forwarded Operand A
	   	if (do_writeback2_PR && (readRegisterA2 == writeRegister2_PR))
	      		com_OpA2 = aluResult2;
	   	else if (do_writeback1_PR && (readRegisterA2 == writeRegister1_PR))
	      		com_OpA2 = aluResult1;
	   	else if (do_writeback2_MEM && (readRegisterA2 == writeRegister2_MEM))
	      		com_OpA2 = Data2_MEM;
	   	else if (do_writeback1_MEM && (readRegisterA2 == writeRegister1_MEM))
	      		com_OpA2 = Data1_MEM;
	   	else if (do_writeback2_WB && (readRegisterA2 == writeRegister2_WB))
	      		com_OpA2 = Data2_WB;
	   	else if (do_writeback1_WB && (readRegisterA2 == writeRegister1_WB))
	      		com_OpA2 = Data1_WB;
	   	else com_OpA2 = readDataA2;
		//Forwarded Operand B
		if (do_writeback2_PR && (readRegisterB2 == writeRegister2_PR)/* && (ALUSrc2!=1)/**/)
			com_OpB2 = aluResult2;
		else if (do_writeback1_PR && (readRegisterB2 == writeRegister1_PR)/* && (ALUSrc2!=1)/**/)
			com_OpB2 = aluResult1;
		else if (do_writeback2_MEM && (readRegisterB2 == writeRegister2_MEM)/* && (ALUSrc2!=1)/**/)
			com_OpB2 = Data2_MEM;
		else if (do_writeback1_MEM && (readRegisterB2 == writeRegister1_MEM)/* && (ALUSrc2!=1)/**/)
			com_OpB2 = Data1_MEM;
		else if (do_writeback2_WB && (readRegisterB2 == writeRegister2_WB)/* && (ALUSrc2!=1)/**/)
			com_OpB2 = Data2_WB;
		else if (do_writeback1_WB && (readRegisterB2 == writeRegister1_WB)/* && (ALUSrc2!=1)/**/)
			com_OpB2 = Data1_WB;
		else com_OpB2 = Operand_B2;
	end

	compare compare2(jump2,com_OpA2,com_OpB2,Instr2,taken_branch2);
	assign MemHazard = MemRead1 | MemWrite1 | MemRead2 | MemWrite2 | MemRead1_PR | MemWrite1_PR;
	assign SysHazard = (Instr1 == 32'h0000000c)|(Instr2 == 32'h0000000c);
	assign WAWHazard = (writeRegister1==writeRegister2)?1:0;
	assign RAWHazard = ((readRegisterA2 == writeRegister1)||(readRegisterB2 == writeRegister1))?1:0;
	assign JMPHazard = branch1 | branch2 | jump1 | jump2;
	assign NOPHazard = (Instr1 == 0) | (Instr2 == 0);
	assign single_fetch_OUT = /*1;///**/MemHazard | SysHazard | WAWHazard | RAWHazard | JMPHazard | NOPHazard;

	//CONTROLLER1
	//*note, syscall, and all link instructions have been assigned alucontrol of addi
	always begin
     		opcode1 = Instr1[31:26];
     		format1 = Instr1[25:21];
     		rt1     = Instr1[20:16];
     		funct1  = Instr1[5:0];
		case ( opcode1 )
		     6'b000000: begin //SPECIAL
                    	case ( funct1 )
                        		6'b000000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001000010011;if(comment1)$display("[1]sll,nop\n");end//SLL,NOP
					6'b000010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001000011011;if(comment1)$display("[1]srl\n");end//SRL
					6'b000011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001000011001;if(comment1)$display("[1]sra\n");end//SRA
					6'b000100: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001000010100;if(comment1)$display("[1]sllv\n");end//SLLV
					6'b000110: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001000011100;if(comment1)$display("[1]srlv\n");end//SRLV
					6'b000111: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001000011010;if(comment1)$display("[1]srav\n");end//SRAV
					6'b001000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b001100000000111110;if(comment1)$display("[1]jr\n");end//JR
					6'b001001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b101100001000000001;if(comment1)$display("[1]jalr\n");end//JALR
					6'b001100: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000011011000001;if(comment1)$display("[1]syscal1\n");end//syscal1*
					6'b001101: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000011000010011;if(comment1)$display("[1]break\n");end//BREAK*
					6'b010000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001000001001;if(comment1)$display("[1]mfhi\n");end//MFHI
					6'b010001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000000000001011;if(comment1)$display("[1]mthi\n");end//MTHI
					6'b010010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001000001010;if(comment1)$display("[1]mflo\n");end//MFLO
					6'b010011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000000000001100;if(comment1)$display("[1]mtlo\n");end//MTLO
					6'b011000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000000000001101;if(comment1)$display("[1]mult\n");end//mult
					6'b011001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000000000001101;if(comment1)$display("[1]multu\n");end//multu
					6'b011010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000000000000101;if(comment1)$display("[1]div\n");end//div
					6'b011011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000000000000110;if(comment1)$display("[1]divu\n");end//divu
					6'b100000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001100000000;if(comment1)$display("[1]add\n");end//add
					6'b100001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001100110111;if(comment1)$display("[1]addu\n");end//addu
					6'b100010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001100011101;if(comment1)$display("[1]sub\n");end//sub
					6'b100011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001100011110;if(comment1)$display("[1]subu\n");end//subu
					6'b100100: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001100000100;if(comment1)$display("[1]and\n");end//and
					6'b100101: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001100010000;if(comment1)$display("[1]or\n");end//or
					6'b100110: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001100011111;if(comment1)$display("[1]xor\n");end//Xor
					6'b100111: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001100001111;if(comment1)$display("[1]nor\n");end//nor
					6'b101010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001100010101;if(comment1)$display("[1]slt\n");end//slt
					6'b101011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000001000111111;if(comment1)$display("[1]sltu\n");end//sltu
                        		default: $display("Not an Instruction!");
                    		endcase
                	end
			6'b000001: begin
                		case ( rt1 )
                     			5'b00000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010100111;if(comment1)$display("[1]bltz\n");end//BLTZ
					5'b00001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010100011;if(comment1)$display("[1]bgez\n");end//BGEZ
					5'b10000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b100100011010000001;if(comment1)$display("[1]bltzal\n");end//BLTZAL
					5'b10001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b100100011010000001;if(comment1)$display("[1]bgezal\n");end//BGEZAL
                        		default: $display("Not an Instruction!");
                    		endcase
                	end
			6'b000010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b001100000100001110;if(comment1)$display("[1]jump\n");end//J
			6'b000011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b101000011010000001;if(comment1)$display("[1]jal\n");end//JAL
			6'b000100: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010100010;if(comment1)$display("[1]beq\n");end//BEQ
			6'b000101: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010101001;if(comment1)$display("[1]bne\n");end//BNE
			6'b000110: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010100110;if(comment1)$display("[1]blez\n");end//BLEZ
			6'b000111: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010100101;if(comment1)$display("[1]bgtz\n");end//BGTZ
			6'b001000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000011010000001;if(comment1)$display("[1]addi\n");end//ADDI  
			6'b001001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000011010000010;if(comment1)$display("[1]addiu\n");end//ADDIU
			6'b001010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000011010010101;if(comment1)$display("[1]slti\n");end//SLTI
			6'b001011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000011010010101;if(comment1)$display("[1]sltiu\n");end//SLTIU
			6'b001100: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000011000000100;if(comment1)$display("[1]andi\n");end//ANDI
			6'b001101: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000011000010000;if(comment1)$display("[1]ori\n");end//ORI
			6'b001110: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000011000100000;if(comment1)$display("[1]xori\n");end//XorI
			6'b001111: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000011000001000;if(comment1)$display("[1]lui\n");end//LUI
	        	6'b010001: begin //COP1
		     		case( format1 )
		          		5'b00000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000001010011100;if(comment1)$display("[1]mfc1\n");end//MFC1
			  		5'b00010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000001010011010;if(comment1)$display("[1]cfc1\n");end//CFC1
			  		5'b00100: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000010111000;if(comment1)$display("[1]mtc1\n");end//MTC1
			  		5'b00110: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000010110100;if(comment1)$display("[1]ctc1\n");end//CTC1
			  		5'b01000:begin
			       			case( Instr1[16] )
			            			1'b1: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010011101;if(comment1)$display("[1]bc1t\n");end//BC1T
				    			1'b0: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010001111;if(comment1)$display("[1]bc1f\n");end//BC1F
			       			endcase
			  		end
			  		5'b10000:begin 
						if( Instr1[7:4] == 4'b0011 ) begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000000000011111;if(comment1)$display("[1]fp c.cond\n");end//fp c.cond
			       			else begin
			        			case( funct1 )
				         			6'b000000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000000011011;if(comment1)$display("[1]fp add\n");end//fp add
			                 			6'b000001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000000000000;if(comment1)$display("[1]fp sub\n");end//fp sub
                                     				6'b000010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000000001101;if(comment1)$display("[1]fp mul\n");end//fp mul
                                    				6'b000011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000000000101;if(comment1)$display("[1]fp div\n");end//fp div
                                    				6'b000101: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000000110111;if(comment1)$display("[1]fp abs\n");end//fp abs
                                    				6'b000110: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000010000100;if(comment1)$display("[1]fp mov\n");end//MOV.FMT
                                   				6'b000111: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000000010000;if(comment1)$display("[1]fp neg\n");end//fp neg
				         			default: $display("Not an Instruction!");
			            			endcase
			       			end
					end
		     			5'b10001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b010000000010001000;if(comment1)$display("[1]fp cvt.s\n");end//CVT.S.FMT
		          		default: $display("Not an Instruction!");
		 		endcase
			end
			6'b100000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000011011100100001;if(comment1)$display("[1]lb\n");end//LB
			6'b100001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000011011100101011;if(comment1)$display("[1]lh\n");end//LH
			6'b100010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000011011100101101;if(comment1)$display("[1]lwl\n");end//LWL
			6'b100011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000011011100111101;if(comment1)$display("[1]lw\n");end//LW
	        	6'b110000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000011011100111101;if(comment1)$display("[1]lwc0\n");end//LWC0
			6'b100100: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000011011100101010;if(comment1)$display("[1]lbu\n");end//LBU
			6'b100101: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000011011100101100;if(comment1)$display("[1]lhu\n");end//LHU
			6'b100110: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000011011100101110;if(comment1)$display("[1]lwr\n");end//LWR
			6'b101000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000110100101111;if(comment1)$display("[1]sb\n");end//SB
			6'b101001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000110100110000;if(comment1)$display("[1]sh\n");end//SH
			6'b101010: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000110100110010;if(comment1)$display("[1]swl\n");end//SWL
			6'b101011: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000110100110001;if(comment1)$display("[1]sw\n");end//SW
	        	6'b111000: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000110100110001;if(comment1)$display("[1]swc0\n");end//SWC0
			6'b101110: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000110100110011;if(comment1)$display("[1]swr\n");end//SWR
			6'b110001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000011010010110101;if(comment1)$display("[1]lwc1\n");end//LWC1
			6'b111001: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000000110010111001;if(comment1)$display("[1]swc1\n");end//SWC1
			6'b010100: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010111010;if(comment1)$display("[1]beql\n");end//BEQL
			6'b010110: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010111011;if(comment1)$display("[1]blezl\n");end//BLEZL
			6'b010101: begin {link1,RegDst1,jump1,branch1,MemRead1,MemtoReg1,MemWrite1,ALUSrc1,RegWrite1,jumpRegister_Flag1,sign_or_zero_Flag1,syscal1,ALU_control1} = 18'b000100000010111100;if(comment1)$display("[1]bnel\n");end//BNEL
			default: $display("Not an Instruction!");
		endcase
	end

	//CONTROLLER2
	//*note, syscall, and all link instructions have been assigned alucontrol of addi
	always begin
     		opcode2 = Instr2[31:26];
     		format2 = Instr2[25:21];
     		rt2 = Instr2[20:16];
     		funct2 = Instr2[5:0];
		case ( opcode2 )
		     6'b000000: begin //SPECIAL
                    	case ( funct2 )
                        		6'b000000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001000010011;if(comment2)$display("[2]sll,nop\n");end//SLL,NOP
					6'b000010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001000011011;if(comment2)$display("[2]srl\n");end//SRL
					6'b000011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001000011001;if(comment2)$display("[2]sra\n");end//SRA
					6'b000100: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001000010100;if(comment2)$display("[2]sllv\n");end//SLLV
					6'b000110: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001000011100;if(comment2)$display("[2]srlv\n");end//SRLV
					6'b000111: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001000011010;if(comment2)$display("[2]srav\n");end//SRAV
					6'b001000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b001100000000111110;if(comment2)$display("[2]jr\n");end//JR
					6'b001001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b101100001000000001;if(comment2)$display("[2]jalr\n");end//JALR
					6'b001100: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000011011000001;if(comment2)$display("[2]syscal1\n");end//syscal1*
					6'b001101: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000011000010011;if(comment2)$display("[2]break\n");end//BREAK*
					6'b010000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001000001001;if(comment2)$display("[2]mfhi\n");end//MFHI
					6'b010001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000000000001011;if(comment2)$display("[2]mthi\n");end//MTHI
					6'b010010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001000001010;if(comment2)$display("[2]mflo\n");end//MFLO
					6'b010011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000000000001100;if(comment2)$display("[2]mtlo\n");end//MTLO
					6'b011000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000000000001101;if(comment2)$display("[2]mult\n");end//mult
					6'b011001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000000000001101;if(comment2)$display("[2]multu\n");end//multu
					6'b011010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000000000000101;if(comment2)$display("[2]div\n");end//div
					6'b011011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000000000000110;if(comment2)$display("[2]divu\n");end//divu
					6'b100000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001100000000;if(comment2)$display("[2]add\n");end//add
					6'b100001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001100110111;if(comment2)$display("[2]addu\n");end//addu
					6'b100010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001100011101;if(comment2)$display("[2]sub\n");end//sub
					6'b100011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001100011110;if(comment2)$display("[2]subu\n");end//subu
					6'b100100: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001100000100;if(comment2)$display("[2]and\n");end//and
					6'b100101: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001100010000;if(comment2)$display("[2]or\n");end//or
					6'b100110: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001100011111;if(comment2)$display("[2]xor\n");end//Xor
					6'b100111: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001100001111;if(comment2)$display("[2]nor\n");end//nor
					6'b101010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001100010101;if(comment2)$display("[2]slt\n");end//slt
					6'b101011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000001000111111;if(comment2)$display("[2]sltu\n");end//sltu
                        		default: $display("Not an Instruction!");
                    		endcase
                	end  
			6'b000001: begin
                		case ( rt2 )
                     			5'b00000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010100111;if(comment2)$display("[2]bltz\n");end//BLTZ
					5'b00001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010100011;if(comment2)$display("[2]bgez\n");end//BGEZ
					5'b10000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b100100011010000001;if(comment2)$display("[2]bltzal\n");end//BLTZAL
					5'b10001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b100100011010000001;if(comment2)$display("[2]bgezal\n");end//BGEZAL
                        		default: $display("Not an Instruction!");
                    		endcase
                	end  
			6'b000010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b001100000100001110;if(comment2)$display("[2]jump\n");end//J
			6'b000011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b101000011010000001;if(comment2)$display("[2]jal\n");end//JAL
			6'b000100: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010100010;if(comment2)$display("[2]beq\n");end//BEQ
			6'b000101: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010101001;if(comment2)$display("[2]bne\n");end//BNE
			6'b000110: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010100110;if(comment2)$display("[2]blez\n");end//BLEZ
			6'b000111: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010100101;if(comment2)$display("[2]bgtz\n");end//BGTZ
			6'b001000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000011010000001;if(comment2)$display("[2]addi\n");end//ADDI  
			6'b001001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000011010000010;if(comment2)$display("[2]addiu\n");end//ADDIU
			6'b001010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000011010010101;if(comment2)$display("[2]slti\n");end//SLTI
			6'b001011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000011010010101;if(comment2)$display("[2]sltiu\n");end//SLTIU
			6'b001100: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000011000000100;if(comment2)$display("[2]andi\n");end//ANDI
			6'b001101: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000011000010000;if(comment2)$display("[2]ori\n");end//ORI
			6'b001110: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000011000100000;if(comment2)$display("[2]xori\n");end//XorI
			6'b001111: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000011000001000;if(comment2)$display("[2]lui\n");end//LUI
	        	6'b010001: begin //COP1
		     		case( format2 )
		          		5'b00000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000001010011100;if(comment2)$display("[2]mfc1\n");end//MFC1
			  		5'b00010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000001010011010;if(comment2)$display("[2]cfc1\n");end//CFC1
			  		5'b00100: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000010111000;if(comment2)$display("[2]mtc1\n");end//MTC1
			  		5'b00110: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000010110100;if(comment2)$display("[2]ctc1\n");end//CTC1
			  		5'b01000:begin
			       			case( Instr2[16] )
			            			1'b1: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010011101;if(comment2)$display("[2]bc1t\n");end//BC1T
				    			1'b0: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010001111;if(comment2)$display("[2]bc1f\n");end//BC1F
			       			endcase
			  		end
			  		5'b10000:begin 
						if( Instr2[7:4] == 4'b0011 ) begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000000000011111;if(comment2)$display("[2]fp c.cond\n");end//fp c.cond
			       			else begin
			        			case( funct2 )
				         			6'b000000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000000011011;if(comment2)$display("[2]fp add\n");end//fp add
			                 			6'b000001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000000000000;if(comment2)$display("[2]fp sub\n");end//fp sub
                                     				6'b000010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000000001101;if(comment2)$display("[2]fp mul\n");end//fp mul
                                    				6'b000011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000000000101;if(comment2)$display("[2]fp div\n");end//fp div
                                    				6'b000101: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000000110111;if(comment2)$display("[2]fp abs\n");end//fp abs
                                    				6'b000110: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000010000100;if(comment2)$display("[2]fp mov\n");end//MOV.FMT
                                   				6'b000111: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000000010000;if(comment2)$display("[2]fp neg\n");end//fp neg
				         			default: $display("Not an Instruction!");
			            			endcase
			       			end
					end
		     			5'b10001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b010000000010001000;if(comment2)$display("[2]fp cvt.s\n");end//CVT.S.FMT
		          		default: $display("Not an Instruction!");
		 		endcase
			end
			6'b100000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000011011100100001;if(comment2)$display("[2]lb\n");end//LB
			6'b100001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000011011100101011;if(comment2)$display("[2]lh\n");end//LH
			6'b100010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000011011100101101;if(comment2)$display("[2]lwl\n");end//LWL
			6'b100011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000011011100111101;if(comment2)$display("[2]lw\n");end//LW
	        	6'b110000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000011011100111101;if(comment2)$display("[2]lwc0\n");end//LWC0
			6'b100100: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000011011100101010;if(comment2)$display("[2]lbu\n");end//LBU
			6'b100101: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000011011100101100;if(comment2)$display("[2]lhu\n");end//LHU
			6'b100110: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000011011100101110;if(comment2)$display("[2]lwr\n");end//LWR
			6'b101000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000110100101111;if(comment2)$display("[2]sb\n");end//SB
			6'b101001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000110100110000;if(comment2)$display("[2]sh\n");end//SH
			6'b101010: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000110100110010;if(comment2)$display("[2]swl\n");end//SWL
			6'b101011: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000110100110001;if(comment2)$display("[2]sw\n");end//SW
	        	6'b111000: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000110100110001;if(comment2)$display("[2]swc0\n");end//SWC0
			6'b101110: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000110100110011;if(comment2)$display("[2]swr\n");end//SWR
			6'b110001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000011010010110101;if(comment2)$display("[2]lwc1\n");end//LWC1
			6'b111001: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000000110010111001;if(comment2)$display("[2]swc1\n");end//SWC1
			6'b010100: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010111010;if(comment2)$display("[2]beql\n");end//BEQL
			6'b010110: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010111011;if(comment2)$display("[2]blezl\n");end//BLEZL
			6'b010101: begin {link2,RegDst2,jump2,branch2,MemRead2,MemtoReg2,MemWrite2,ALUSrc2,RegWrite2,jumpRegister_Flag2,sign_or_zero_Flag2,syscal2,ALU_control2} = 18'b000100000010111100;if(comment2)$display("[2]bnel\n");end//BNEL
                default: $display("Not an Instruction!");
            endcase
        end

	// PIPE REGISTERS 0
	always @ (posedge CLK or negedge RESET) begin
		if(!RESET) 
	           begin
			R2_output_PR <= 32'b0;
			nextInstruction_address_PR <= 32'b0;
                        syscalBubbleCounter <= 2'b11; /// only allowed here
			single_fetch_PR <= 1'b0;
     		   end
    		else 
		   begin
			R2_output_PR <= (insertBubble_OUT)? 0: R2_output;
			nextInstruction_address_PR <= (insertBubble_OUT)? 0: nextInstruction_address;
                        syscalBubbleCounter <= (syscal1)? syscalBubbleCounter - 1: 2'b11;
			single_fetch_PR <= single_fetch_OUT;
		end
	end
	//REGISTER FILE
	always @ (posedge CLK)
		begin
			if (do_writeback1_WB) // lower priority
				Reg[writeRegister1_WB] = writeData1_WB;
			if (do_writeback2_WB) // higher priority
				Reg[writeRegister2_WB] = writeData2_WB;
		end


	//PIPE REGISTERS 1
	always @ (posedge CLK or negedge RESET) begin
		if(!RESET || insertBubble_OUT) 
	           begin
			Operand_A1_PR <= 32'b0;
			Operand_B1_PR <= 32'b0;
			writeRegister1_PR <= 5'b0;
			taken_branch1_PR <= 1'b0;
			MemRead1_PR <= 1'b0;
			MemtoReg1_PR <= 1'b0;
			MemWrite1_PR <= 1'b0;
			ALU_control1_PR <=6'b0;
			readRegisterA1_PR <= 5'b0;
			readRegisterB1_PR <= 5'b0;
			do_writeback1_PR <= 1'b0;
                        Instr1_10_6_PR <= 5'b0;
			readDataB1_PR <= 32'b0;
                        Dest_Value1_PR <= 32'b0;
			Instr1_PR <= 32'b0;
			ALUSrc1_PR <= 1'b0;
      		   end
    		else 
		   begin
			Operand_A1_PR <= (link1)?PCA:((syscal1)?R2_input:readDataA1);
			Operand_B1_PR <= (link1)?32'h00000004:((syscal1)?32'h00000000:Operand_B1);
			writeRegister1_PR <= writeRegister1;
			taken_branch1_PR <= taken_branch1;
			MemRead1_PR <= MemRead1;
			MemtoReg1_PR <= MemtoReg1;
			MemWrite1_PR <= MemWrite1;
			ALU_control1_PR <= ALU_control1;
			readRegisterA1_PR <= (link1 || syscal1)?5'b00000:readRegisterA1;
			readRegisterB1_PR <= (ALUSrc1 || link1 || syscal1)?5'b00000:readRegisterB1;
			do_writeback1_PR <= ((RegWrite1)&&(writeRegister1!=5'b00000)&&(ALU_control1!=6'b110100))||MemtoReg1;
                        Instr1_10_6_PR <= Instr1[10: 6];
			readDataB1_PR <= readDataB1;
                        Dest_Value1_PR <= Reg[writeRegister1];
			Instr1_PR <= Instr1;
			ALUSrc1_PR <= ALUSrc1;
                   end
	end

	//PIPE REGISTERS 2
	always @ (posedge CLK or negedge RESET) begin
		if(!RESET || single_fetch_OUT || insertBubble_OUT) 
	           begin
			Operand_A2_PR <= 32'b0;
			Operand_B2_PR <= 32'b0;
			writeRegister2_PR <= 5'b0;
			taken_branch2_PR <= 1'b0;
			MemRead2_PR <= 1'b0;
			MemtoReg2_PR <= 1'b0;
			MemWrite2_PR <= 1'b0;
			ALU_control2_PR <=6'b0;
			readRegisterA2_PR <= 5'b0;
			readRegisterB2_PR <= 5'b0;
			do_writeback2_PR <= 1'b0;
                        Instr2_10_6_PR <= 5'b0;
			readDataB2_PR <= 32'b0;
                        Dest_Value2_PR <= 32'b0;
			Instr2_PR <= 32'b0;
			ALUSrc2_PR <= 1'b0;
      		   end
    		else 
		   begin
			Operand_A2_PR <= (link2)?PCA:((syscal2)?R2_input:readDataA2);
			Operand_B2_PR <= (link2)?32'h00000004:((syscal2)?32'h00000000:Operand_B2);
			writeRegister2_PR <= writeRegister2;
			taken_branch2_PR <= taken_branch2;
			MemRead2_PR <= MemRead2;
			MemtoReg2_PR <= MemtoReg2;
			MemWrite2_PR <= MemWrite2;
			ALU_control2_PR <= ALU_control2;
			readRegisterA2_PR <= (link2 || syscal2)?5'b00000:readRegisterA2;
			readRegisterB2_PR <= (ALUSrc2 || link2 || syscal2)?5'b00000:readRegisterB2;
			do_writeback2_PR <= ((RegWrite2)&&(writeRegister2!=5'b00000)&&(ALU_control2!=6'b110100))||MemtoReg2;
                        Instr2_10_6_PR <= Instr2[10: 6];
			readDataB2_PR <= readDataB2;
                        Dest_Value2_PR <= Reg[writeRegister2];
			Instr2_PR <= Instr2;
			ALUSrc2_PR <= ALUSrc2;
                   end
	end


	always  /*@ (posedge CLK)*/ begin
	   if(comment3) begin
		$display("=============================================================");
		$display("[ID]:Read Register A1:%d\t\t|Read Register A2:%d",readRegisterA1,readRegisterA2);
		$display("[ID]:Read Register B1:%d\t\t|Read Register B2:%d",readRegisterB1,readRegisterB2);
		$display("[ID]:Write Register 1:%d\t\t|Write Register 2:%d",writeRegister1,writeRegister2);
		$display("[ID]:\tsyscalBubbleCounter:%x",syscalBubbleCounter);
                $display("[ID]:\tinsertBubble_OUT:%x",insertBubble_OUT);
		$display("[ID]:\tsingle_fetch_OUT:%x",single_fetch_OUT);
		$display("[ID]:\tsingle_fetch_PR:%x",single_fetch_PR);
                $display("[ID]:\tSYS_OUT:%x",SYS_OUT);
		$display("[ID]:\tPCA:%x",PCA);
		$display("[ID]:\tCIA:%x",CIA);
		$display("[ID]:\tbranch1:%x\n[ID]:\tbranch2:%x",branch1,branch2);/*
		$display("[ID]:\tInstr1:%x\n[ID]:\tInstr2:%x",Instr1,Instr2);/*
		$display("[ID]:\tnextInstruction_address:%x",nextInstruction_address);
                $display("[ID]:syscal1:%x\t\t\t|syscal2:%x",syscal1,syscal2);
	 	$display("[ID]:writeRegister1_PR:%x\t|writeRegister2_PR:%x",writeRegister1_PR,writeRegister2_PR); 
		$display("[ID]:com_OpA1:%x\t\t|com_OpA2:%x",com_OpA1,com_OpA2);
		$display("[ID]:com_OpB1:%x\t\t|com_OpB1:%x",com_OpB1,com_OpB2);
		$display("[ID]:writeRegister1_WB:%x\t|writeRegister2_WB:%x",writeRegister1_WB,writeRegister2_WB);
                $display("[ID]:writeRegister1_MEM:%x\t|writeRegister2_MEM:%x",writeRegister1_MEM,writeRegister2_MEM);
		$display("[ID]:readRegisterA1:%x\t\t|readRegisterA1:%x",readRegisterA1,readRegisterA2);
		$display("[ID]:readRegisterB1:%x\t\t|readRegisterB1:%x",readRegisterB1,readRegisterB2);
		$display("[ID]:writeRegister1:%x\t\t|writeRegister2:%x",writeRegister1,writeRegister2);
		$display("[ID]:do_writeback1_WB:%x\t\t|do_writeback2_WB:%x",do_writeback1_WB,do_writeback2_WB);
                $display("[ID]:do_writeback1_MEM:%x\t|do_writeback2_MEM:%x",do_writeback1_MEM,do_writeback2_MEM);
		$display("[ID]:do_writeback1_PR:%x\t\t|do_writeback2_PR:%x",do_writeback1_PR,do_writeback2_PR);
		$display("[ID]:aluResult1:%x\t|aluResult2:%x",aluResult1,aluResult2);
		$display("[ID]:aluResult1_WB:%x\t|aluResult2_WB:%x",aluResult1_WB,aluResult2_WB);
		$display("[ID]:aluResult1:%x\t|aluResult2:%x",aluResult1,aluResult2);
		$display("[ID]:writeData1_WB:%x\t|writeData2_WB:%x",writeData1_WB,writeData2_WB);
                $display("[ID]:writeRegister1_WB:%x\t|writeRegister2_WB:%x",writeRegister1_WB,writeRegister2_WB);	
		$display("[ID]:readRegisterA1_PR:%x\t|readRegisterA2_PR:%x",readRegisterA1_PR,readRegisterA2_PR);
		$display("[ID]:readRegisterB1_PR:%x\t|readRegisterB2_PR:%x",readRegisterB1_PR,readRegisterB2_PR);		
		$display("[ID]:Operand_A1:%x\t|Operand_A2:%x",(link1)?PCA:((syscal1)?R2_input:readDataA1), (link2)?PCA:((syscal2)?R2_input:readDataA2));
		$display("[ID]:readDataA1:%x\t|readDataA2:%x",readDataA1,readDataA2);
		$display("[ID]:Operand_B1:%x\t|Operand_B2:%x",(link1)?32'h00000008:((syscal1)?32'h00000000:Operand_B1),(link2)?32'h00000008:((syscal2)?32'h00000000:Operand_B2));
		$display("[ID]:readDataB1:%x\t|readDataB2:%x",readDataB1,readDataB2);
		$display("[ID]:Instr1:%x\t\t|Instr2:%x",Instr1,Instr2);
		$display("[ID]:Jump_address1:%x\t|Jump_address2:%x",Jump_address1,Jump_address2);
		$display("[ID]:Shift_addResult1:%x\t|Shift_addResult2:%x",Shift_addResult1,Shift_addResult2);
		$display("[ID]:Data1_MEM:%x\t\t|Data1_MEM:%x",Data1_MEM,Data2_MEM);
		$display("[ID]:Data1_WB:%x\t\t|Data2_WB:%x",Data1_WB,Data2_WB);
		$display("[ID]:taken_branch1:%x\t\t|taken_branch2:%x",taken_branch1,taken_branch2);
		$display("[ID]:RegDst1:%x\t\t\t|RegDst2:%x",RegDst1,RegDst2);
		$display("[ID]:link1:%x\t\t\t|link2:%x",link1,link2);
		/**/
		$display("=============================================================");
		$display("[EXE]:Read Register A1:%d\t\t|Read Register A2:%d",readRegisterA1_PR,readRegisterA2_PR);
		$display("[EXE]:Read Register B1:%d\t\t|Read Register B2:%d",readRegisterB1_PR,readRegisterB2_PR);
		$display("[EXE]:Write Register 1:%d\t\t|Write Register 2:%d",writeRegister1_PR,writeRegister2_PR);
			   end
	end	

endmodule
