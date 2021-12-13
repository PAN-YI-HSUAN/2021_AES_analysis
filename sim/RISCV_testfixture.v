`timescale 1ns/1ps

`ifndef CYCLE
  `define CYCLE  10.0  // a default cycle time
`endif

`ifndef SPP_END_RATIO
  // max window after layout: `define SPP_END_RATIO 2.55
  `define SPP_END_RATIO 0.5
`endif

`ifndef PATTERN
  `define PATTERN 1
`endif

// `include "../rtl/memory.v"

`ifdef EDAC
`define SDFFILE    "../synthesis/RISCV_syn_edac.sdf"
`else
`define SDFFILE    "../synthesis/RISCV_syn.sdf"
`endif

`define End_CYCLE  20000 	// Modify cycle times once your design need more cycle times!
`define SIZE_TEXT 1024  // You can change the size
`define SIZE_DATA 1792  // You can change the size
`define SIZE_STACK 256 // You can change the size

module testfixture;

	reg        	clk;
	reg         rst;
    reg  [31:0] mem_data_ans [0:`SIZE_DATA-1];
	reg  [31:0]	mem_inst [0:`SIZE_TEXT-1];
	reg	 [31:0]	mem_data [0:`SIZE_DATA-1];
	reg	 [1:0]	src;
	reg	 [31:0]	a_I, a_D;
	reg	 [31:0] d_I, d_D;
	wire [31:0]	q, det_a;
    
	integer      pattern_switch;
    integer i,j;
    
    integer eof;
    reg eof_find;
	integer error_num;

	`ifdef SDF
	initial $sdf_annotate(`SDFFILE, chip0);
	`endif

	initial begin
	`ifdef VCD
	  	`ifdef SDF
	  	`define WAVEFORMFILE  "RISCV_syn.vcd"
	  	`else
	  	`define WAVEFORMFILE  "RISCV.vcd"
	  	`endif
	  	$dumpfile(`WAVEFORMFILE);
	  	$dumpvars;
	`endif

	`ifdef FSDB
	  	`ifdef SDF
	  	`define WAVEFORMFILE  "RISCV_syn.fsdb"
	  	`else
	  	`define WAVEFORMFILE  "RISCV.fsdb"
	  	`endif
	  	$fsdbDumpfile(`WAVEFORMFILE);
	  	$fsdbDumpvars(0,testfixture,"+mda"); //This command is for dumping 2D array
	`endif
	end

	`ifdef EDAC
	real err_cnt;
	wire [268:0] err;
	wire err_or, err_sdl;
	assign err_or = |err;
	RISCV chip0(
		.clk(clk),
		.rst(rst),
		.src_i(src),
		.a_I_i(a_I),
		.a_D_i(a_D),
		.d_I_i(d_I),
		.d_D_i(d_D),
		.q_o(q),
		.det_a_o(det_a),
		.err_o(err));

	SDLHQD1BWP30P140HVT sdl(.D(err_or), .E(clk), .Q(err_sdl));
	always@(posedge clk or posedge rst) begin
		if (rst) err_cnt <= 0.0;
		else if (err_sdl) err_cnt <= err_cnt + 1.0;
	end
	// FIR DUT(.data_valid_i(en), .data_i(data), .clk(clk), .rst(reset), .fir_d_o(fir_d), .fir_valid_o(fir_valid));
	`else
	RISCV chip0(
		.clk(clk),
		.rst(rst),
		.src_i(src),
		.a_I_i(a_I),
		.a_D_i(a_D),
		.d_I_i(d_I),
		.d_D_i(d_D),
		.q_o(q),
		.det_a_o(det_a)
		);

	`endif
	
	initial begin
		rst     = 0;
		clk 	= 1;
		pattern_switch = `PATTERN;
	  	case (pattern_switch)
	    	1: $readmemh("./pattern/inst_RV32I_1.txt", mem_inst);
	    	2: $readmemh("./pattern/inst_RV32I_2.txt", mem_inst);
			3: $readmemh("./pattern/inst_RV32I_3.txt", mem_inst);
			4: $readmemh("./pattern/inst_RV32I_4.txt", mem_inst);
			5: $readmemh("./pattern/inst_RV32I_5.txt", mem_inst);
			6: $readmemh("./leaf/leaf_text.txt", mem_inst);
			7: $readmemh("./fact/fact_text.txt", mem_inst);
			8: $readmemh("./hw1/hw1_text.txt", mem_inst);
	    	default: 
				$readmemh("./pattern/inst_RV32I_1.txt", mem_inst);
	  	endcase
	  	eof_find = 0;
        for (i=0; i<`SIZE_TEXT; i=i+1) begin
            if (mem_inst[i] === 32'bx) begin
                if (eof_find == 0) begin
                    eof_find = 1;
                    eof = 32'h00010000 + (i+4)*4;
                end
            end
        end
		src = 2'b11;
		a_I = 32'h00010000;
		d_I = 32'h00010000 + `SIZE_TEXT*2;
		a_D = eof - 8;
		d_D = 32'hbffffff4 - `SIZE_STACK*4;
		#(`CYCLE*1.2);
		src = 2'b01;
		// chip0.mem_I.offset_1 = 32'h00010000;
		// chip0.mem_I.offset_2 = 32'h00010000 + `SIZE_TEXT*4;
        // chip0.mem_D.offset_2 = 32'hbffffff4 - `SIZE_STACK*4;
		// chip0.mem_D.offset_1 = eof - 8; // there are two more instruction, so basically adding 8. But owing to 5-stages(delay 4 instructions), thus subtracting 4*4
		rst = 1'b1; 
		for (i=0; i<`SIZE_TEXT; i=i+1) mem_inst[i]    = 32'h33_00_00_00;
		for (i=0; i<`SIZE_DATA; i=i+1) mem_data[i]    = 32'h00_00_00_00; // reset data in mem_D
		for (i=0; i<`SIZE_DATA; i=i+1) mem_data_ans[i] = 32'h00_00_00_00;
	  	pattern_switch = `PATTERN;
	  	case (pattern_switch)
	    	1: begin 
				$readmemh("./pattern/data_1.txt", mem_data);
				$readmemh("./pattern/ans_1.txt", mem_data_ans);
				$readmemh("./pattern/inst_RV32I_1.txt", mem_inst);
			end
	    	2: begin 
				$readmemh("./pattern/data_2.txt", mem_data);
				$readmemh("./pattern/ans_2.txt", mem_data_ans);
				$readmemh("./pattern/inst_RV32I_2.txt", mem_inst);
			end
			3: begin 
				$readmemh("./pattern/data_3.txt", mem_data);
				$readmemh("./pattern/ans_3.txt", mem_data_ans);
				$readmemh("./pattern/inst_RV32I_3.txt", mem_inst);
			end
			4: begin 
				$readmemh("./pattern/data_4.txt", mem_data);
				$readmemh("./pattern/ans_4.txt", mem_data_ans);
				$readmemh("./pattern/inst_RV32I_4.txt", mem_inst);
			end
			5: begin 
				$readmemh("./pattern/data_5.txt", mem_data);
				$readmemh("./pattern/ans_5.txt", mem_data_ans);
				$readmemh("./pattern/inst_RV32I_5.txt", mem_inst);
			end
			6: begin 
				$readmemh("./leaf/leaf_data.txt", mem_data);
				$readmemh("./leaf/leaf_data_ans.txt", mem_data_ans);
				$readmemh("./leaf/leaf_text.txt", mem_inst);
			end
			7: begin 
				$readmemh("./fact/fact_data.txt", mem_data);
				$readmemh("./fact/fact_data_ans.txt", mem_data_ans);
				$readmemh("./fact/fact_text.txt", mem_inst);
			end
			8: begin 
				$readmemh("./hw1/hw1_data.txt", mem_data);
				$readmemh("./hw1/hw1_data_ans.txt", mem_data_ans);
				$readmemh("./hw1/hw1_text.txt", mem_inst);
			end
	    	default: begin 
				$readmemh("./pattern/data_1.txt", mem_data);
				$readmemh("./pattern/ans_1.txt", mem_data_ans);
				$readmemh("./pattern/inst_RV32I_1.txt", mem_inst);
			end
	  	endcase
		a_I = 32'h00010000;
		a_D = eof - 8;
		for (i=0; i<`SIZE_TEXT; i=i+1) begin
			d_I = mem_inst[i];
			d_D = mem_data[i];
			# (`CYCLE);
			a_I = a_I + 4;
			a_D = a_D + 4;
		end
		for (i=0; i<(`SIZE_DATA-`SIZE_TEXT); i=i+1) begin
			d_D = mem_data[i+`SIZE_TEXT];
			# (`CYCLE);
			a_D = a_D + 4;
		end
		src = 2'b0;
		a_I = 32'h00010000;
		a_D = eof - 8;
		d_I = 32'h0;
		d_D = 32'h0;
		rst = 1'b0;
	end

	//============================================================================================================
	//============================================================================================================
	//============================================================================================================
	// RISCV data output verify
	always @(negedge clk) begin
        if (det_a >= eof) begin
			#(`CYCLE);
			src = 2'b10;
            error_num = 0;
			a_D = eof - 8;
            for (i=0; i<`SIZE_DATA; i=i+1) begin
				#(`CYCLE);
                if (q !== mem_data_ans[i]) begin
                    if (error_num == 0)
                        $display("Error!");
                    error_num = error_num + 1;
                    $display("  Addr = 0x%2h  Correct ans: 0x%h  Your ans: 0x%h", 4*i, mem_data_ans[i], q);
				end
				a_D = a_D + 4;
            end
			`ifdef EDAC
	  		$display("You get %3d timing error(s)" ,err_cnt);
	  		// $display("Timing error rate = " , err_cnt/1024);
	  		`endif
	  		if ( error_num == 0 ) begin
	    		$display("-----------------------------------------------------\n");
	    		$display("Congratulations! All data have been generated successfully!\n");
	    		$display("-------------------------PASS------------------------\n");
	  		#(`CYCLE/2); $finish;
	  		end
	  		else begin
	    		$display("-----------------------------------------------------\n");
	    		$display("Fail!! There are some error with your code!\n");
	    		$display("-------------------------FAIL------------------------\n");
	  		#(`CYCLE/2); $finish;
	  		end
		end
	end

	//============================================================================================================
	//============================================================================================================
	//============================================================================================================

	// Terminate the simulation, FAIL
	initial  begin
	  	#(`CYCLE * `End_CYCLE);
	  	$display("============================================================\n");
    	$display("Simulation time is longer than expected.");
    	$display("The test result is .....FAIL :(\n");
    	$display("============================================================\n");
	  	$finish;
	end
	
	always begin
		#(`SPP_END_RATIO * `CYCLE) clk = 0;
		#(`CYCLE - `SPP_END_RATIO * `CYCLE) clk = 1;
	end

endmodule
