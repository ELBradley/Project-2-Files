//-----------------------------------------
//           Write Back Stage
//-----------------------------------------
module WB (	CLK,
		RESET,
                do_writeback1_PR,
                do_writeback2_PR,
		writeRegister1_PR,
		writeRegister2_PR,
		writeData1_PR,
		writeData2_PR,
		do_writeback1,
		do_writeback2,
		aluResult1_OUT,
		aluResult2_OUT,
		writeRegister1,
		writeRegister2,
		writeRegister1_OUT,
		writeRegister2_OUT,
		writeData1_OUT,
		writeData2_OUT,
		do_writeback1_OUT,
		do_writeback2_OUT,
		aluResult1,
		aluResult2,
		Data_input1,
		Data_input2,
		MemtoReg1,
		MemtoReg2
		);

   output reg      [31: 0] writeData1_OUT;
   output reg      [31: 0] writeData2_OUT;
   output reg      [31: 0] aluResult1_OUT;
   output reg      [31: 0] aluResult2_OUT;
   output reg      [31: 0] writeData1_PR;
   output reg      [31: 0] writeData2_PR;
   output reg      [ 4: 0] writeRegister1_PR;
   output reg      [ 4: 0] writeRegister2_PR;
   output reg      [ 4: 0] writeRegister1_OUT;
   output reg      [ 4: 0] writeRegister2_OUT;
   output reg              do_writeback1_OUT;
   output reg              do_writeback2_OUT;
   output reg              do_writeback1_PR;
   output reg              do_writeback2_PR;
     
   input           [31: 0] aluResult1;
   input           [31: 0] aluResult2;
   input           [31: 0] Data_input1;
   input           [31: 0] Data_input2;
   input           [ 4: 0] writeRegister1;
   input           [ 4: 0] writeRegister2;
   input   	           MemtoReg1;
   input   	           MemtoReg2;
   input  	           CLK;
   input   	           RESET;
   input            	   do_writeback1;     
   input            	   do_writeback2;     

   wire                    do_writeback1;     
   wire                    do_writeback2;     
   
   reg                     comment;

   initial comment = 0; //show WB displays

   assign writeRegister1_OUT = writeRegister1; 
   assign writeRegister2_OUT = writeRegister2; 
   assign do_writeback1_OUT = do_writeback1;
   assign do_writeback2_OUT = do_writeback2;
   assign aluResult1_OUT = aluResult1;
   assign aluResult2_OUT = aluResult2;
   assign writeData1_OUT = (MemtoReg1)?Data_input1:aluResult1;
   assign writeData2_OUT = (MemtoReg2)?Data_input2:aluResult2;

  //Pipe Register 1

   always @ (posedge CLK or negedge RESET) begin
       if(!RESET) begin
             writeData1_PR <= 32'b0;
	     writeRegister1_PR <= 5'b0;
             do_writeback1_PR <= 1'b0;
       end
       else begin
             writeData1_PR <= writeData1_OUT;
	     writeRegister1_PR <= writeRegister1;
             do_writeback1_PR <= do_writeback1;
       end
    end

  //Pipe Register 2

   always @ (posedge CLK or negedge RESET) begin
       if(!RESET) begin
             writeData2_PR <= 32'b0;
	     writeRegister2_PR <= 5'b0;
             do_writeback2_PR <= 1'b0;
       end
       else begin
             writeData2_PR <= writeData2_OUT;
	     writeRegister2_PR <= writeRegister2;
             do_writeback2_PR <= do_writeback2;
       end
    end

    always begin
       if (comment) begin
		$display("=============================================================");
		$display ("[WB]:\t\tData_input1:%x",Data_input1);
		$display ("[WB]:writeData1_PR:%x\t|writeData2_PR:%x",writeData1_PR,writeData2_PR);
		$display ("[WB]:MemtoReg1:%x\t\t|MemtoReg2:%x",MemtoReg1,MemtoReg2);
		$display ("[WB]:aluResult1:%x\t|aluResult2:%x",aluResult1,aluResult2);
		$display ("[WB]:writeRegister1_PR:%x\t|writeRegister2_PR:%x",writeRegister1_PR,writeRegister2_PR);
		$display ("[WB]:do_writeback1_PR:%x\t\t|do_writeback2_PR:%x",do_writeback1_PR,do_writeback2_PR);
		$display ("[WB]:do_writeback1_OUT:%x\t|do_writeback2_OUT:%x",do_writeback1_OUT,do_writeback2_OUT);
		$display ("[WB]:writeRegister1_OUT:%x\t|writeRegister2_OUT:%x",writeRegister1_OUT,writeRegister2_OUT);
		$display ("[WB]:writeData1_OUT:%x\t|writeData2_OUT:%x",writeData1_OUT,writeData2_OUT);
		/**/ 
      end
    end   



endmodule
