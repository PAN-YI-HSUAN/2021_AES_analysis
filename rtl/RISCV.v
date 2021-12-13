// Your code
module  RISCV(clk, rst, src_i, a_I_i, a_D_i, d_I_i, d_D_i, q_o, det_a_o);
    input               clk, rst;
    input       [1:0]   src_i;
    input       [31:0]  a_I_i, a_D_i;
    input       [31:0]  d_I_i, d_D_i;
    output      [31:0]  q_o, det_a_o;

    wire        [31:0]  mem_rdata_I;
    wire        [31:0]  mem_rdata_D;
    wire        [31:0]  mem_wdata_D;
    wire                mem_wen_D;
    wire        [31:0]  mem_addr_I;
    wire        [31:0]  mem_addr_D;
    wire        [31:0]  mem_I_a;
    wire        [31:0]  mem_D_a;
    wire        [31:0]  mem_D_d;
    wire                mem_D_wen;

    CPU cpu(
        .clk(clk),
        .rst(rst),
        // for mem_D
        .mem_wen_D_o(mem_wen_D),
        .mem_addr_D_o(mem_addr_D),
        .mem_wdata_D_o(mem_wdata_D),
        .mem_rdata_D(mem_rdata_D),
        // for mem_I
        .mem_addr_I_o(mem_addr_I),
        .mem_rdata_I(mem_rdata_I)
    );

    sram_1024x32 mem_I(
        .clk(clk),
        .rst(rst),
        .wen(src_i[0]),
        .a(mem_I_a), 
        .d(d_I_i), 
        .q(mem_rdata_I),
        .src(src_i)
        );
    sram_2048x32 mem_D(
        .clk(clk),
        .rst(rst),
        .wen(mem_D_wen),
        .a(mem_D_a),
        .d(mem_D_d),
        .q(mem_rdata_D),
        .src(src_i)
        );

    assign  mem_I_a = (src_i[0])? a_I_i : mem_addr_I;
    assign  mem_D_a = (|src_i)? a_D_i : mem_addr_D;
    assign  mem_D_d = (src_i[0])? d_D_i : mem_wdata_D;
    assign  mem_D_wen = ({src_i[0]} | mem_wen_D)&(~{src_i[1]});
    assign  q_o = mem_rdata_D;
    assign  det_a_o = mem_addr_I;
    // assign  q = 32'b0;
    
endmodule
module  CPU(clk,
            rst,
            // for mem_D
            mem_wen_D_o,
            mem_addr_D_o,
            mem_wdata_D_o,
            mem_rdata_D,
            // for mem_I
            mem_addr_I_o,
            mem_rdata_I);

    input               clk, rst;
    input       [31:0]  mem_rdata_I;
    input       [31:0]  mem_rdata_D;
    output              mem_wen_D_o;
    output reg  [31:0]  mem_addr_I_o;
    output      [31:0]  mem_addr_D_o;
    output      [31:0]  mem_wdata_D_o;

    // 1
    wire    [31:0]  instruction_1;
    // 2
    reg     [31:0]  instruction_2;
    wire    [31:0]  immediate_2;
    wire            Jal_2;
    wire            Jalr_2;
    wire            MemWrite_2;
    wire            MemtoReg_2;
    wire            RegWrite_2;
    wire            ALUSrc_2;
    wire            ALUOP_2;
    wire            md_valid_2;
    wire            AES_2;
    wire    [31:0]  r_data1_2, r_data2_2;
    wire            pre_WB_data1, pre_WB_data2;
    wire            MEM_forwd_in1_2, MEM_forwd_in2_2;
    wire            WB_forwd_in1_2, WB_forwd_in2_2;
    wire            no_forwd_in1_2;
    wire            no_forwd_in2_2;
    // 3
    reg     [31:0]  instruction_3;
    reg     [31:0]  mem_addr_I;
    reg     [31:0]  immediate_3;
    reg             Jal_3;
    reg             Jalr_3;
    reg             MemWrite_3;
    reg             MemtoReg_3;
    reg             RegWrite_3;
    reg             ALUSrc_3;
    reg             ALUOP_3;
    reg             md_valid_3;
    reg             AES_3;
    reg     [31:0]  r_data1_3, r_data2_3;
    reg             MEM_forwd_in1_3, MEM_forwd_in2_3;
    reg             WB_forwd_in1_3, WB_forwd_in2_3;
    reg             no_forwd_in1_3;
    reg             no_forwd_in2_3;
    wire            load_use_hazd_in1, load_use_hazd_in2;
    wire    [31:0]  f_data1_3, f_data2_3;
    wire    [31:0]  PC_4_out_3, PC_imm_out, Jalr_adder_out;
    wire            Branch;
    wire    [31:0]  ALU_in1, ALU_in2, ALU_result_3;
    wire    [31:0]  AES_result_3;
    wire    [63:0]  mudi_result_3;
    wire    [31:0]  nxt_mem_addr_I;
    wire            flush;
    wire            stall;
    wire            md_ready_3;
    // 4
    reg     [31:0]  instruction_4;
    reg     [31:0]  PC_4_out_4;
    reg     [31:0]  Cpu_result_4;
    reg     [31:0]  f_data2_4;
    reg             Jal_4;
    reg             Jalr_4;
    reg             MemtoReg_4;
    reg             MemWrite_4;
    reg             RegWrite_4;
    // wire    [31:0]  mem_data_4;
    wire    [31:0]  forwd_data_4;
    // 5
    reg     [31:0]  instruction_5;
    reg     [31:0]  mem_data_5;
    reg     [31:0]  PC_4_out_5;
    reg     [31:0]  Cpu_result_5;
    reg             Jal_5;
    reg             Jalr_5;
    reg             MemtoReg_5;
    reg             RegWrite_5;
    wire    [31:0]  Reg_write_data;
    wire    [31:0]  forwd_data_5;

    // First stage start
    // assign instruction_1 = {mem_rdata_I[7:0], mem_rdata_I[15:8],
    //                         mem_rdata_I[23:16], mem_rdata_I[31:24]};
    assign instruction_1 = mem_rdata_I;

    always @(posedge clk or posedge rst) begin
        if (rst) instruction_2 <= 0;
        else begin
            if (flush| md_valid_2 | (md_valid_3^md_ready_3)) instruction_2 <= 0; 
            else instruction_2 <= instruction_1;
        end
    end
    // First stage end

    // Second stage start
    CONTROL control(
        .clk(clk), .rst(rst), .opcode(instruction_2[6:2]),
        .Jal(Jal_2), .Jalr(Jalr_2), .MemWrite(MemWrite_2),
        .MemtoReg(MemtoReg_2), .RegWrite(RegWrite_2),
        .ALUSrc(ALUSrc_2), .ALUOP(ALUOP_2), .AES(AES_2)
    );

    Imm_Gen imm_gen(
        .immediate(immediate_2), .instruction(instruction_2)
    );

    REGISTERS registers(
        .clk(clk), .rst(rst), .instruction({instruction_2[31:12],instruction_5[11:7],instruction_2[6:0]}),
        .Regwrite(RegWrite_5), .Writedata(Reg_write_data),
        .reg_data1(r_data1_2), .reg_data2(r_data2_2)
    );

    MULDIV_Unit md_unit(
        .opcode(instruction_2[6:2]),
        .funct7(instruction_2[25]),
        .valid(md_valid_2)
    );
    
    assign  pre_WB_data1 = RegWrite_5&(instruction_5[11:7]==instruction_2[19:15])&(instruction_5[11:7]!=5'b0);
    assign  pre_WB_data2 = RegWrite_5&(instruction_5[11:7]==instruction_2[24:20])&(instruction_5[11:7]!=5'b0);
    assign  MEM_forwd_in1_2   = (instruction_3[11:7]==instruction_2[19:15])&RegWrite_3&(instruction_3[11:7]!=5'b0);
    assign  MEM_forwd_in2_2   = (instruction_3[11:7]==instruction_2[24:20])&RegWrite_3&(instruction_3[11:7]!=5'b0);
    assign  WB_forwd_in1_2    = (instruction_4[11:7]==instruction_2[19:15])&RegWrite_4&(instruction_4[11:7]!=5'b0);
    assign  WB_forwd_in2_2    = (instruction_4[11:7]==instruction_2[24:20])&RegWrite_4&(instruction_4[11:7]!=5'b0);
    //assign  no_forwd_in1_2    = !((MEM_forwd_in1_2)|(WB_forwd_in1_2));
    //assign  no_forwd_in2_2    = !((MEM_forwd_in2_2)|(WB_forwd_in2_2));
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            Jal_3           <= 0;
            Jalr_3          <= 0;
            MemWrite_3      <= 0;
            MemtoReg_3      <= 0;
            RegWrite_3      <= 0;
            ALUSrc_3        <= 0;
            ALUOP_3         <= 0;
            md_valid_3      <= 0;
            AES_3           <= 0;
            instruction_3   <= 0;
            immediate_3     <= 0;
            r_data1_3       <= 0;
            r_data2_3       <= 0;
            MEM_forwd_in1_3 <= 0;
            MEM_forwd_in2_3 <= 0;
            WB_forwd_in1_3  <= 0;
            WB_forwd_in2_3  <= 0;
            //no_forwd_in1_3  <= 0;
            //no_forwd_in2_3  <= 0;
        end
        else begin
            if (flush|stall) begin
                Jal_3           <= 0;
                Jalr_3          <= 0;
                MemWrite_3      <= 0;
                MemtoReg_3      <= 0;
                RegWrite_3      <= 0;
                ALUSrc_3        <= 0;
                ALUOP_3         <= 0;
                md_valid_3      <= 0;
                AES_3           <= 0;
                instruction_3   <= 0;
                immediate_3     <= 0;
                r_data1_3       <= 0;
                r_data2_3       <= 0;
                MEM_forwd_in1_3 <= 0;
                MEM_forwd_in2_3 <= 0;
                WB_forwd_in1_3  <= 0;
                WB_forwd_in2_3  <= 0;
                //no_forwd_in1_3  <= 0;
                //no_forwd_in2_3  <= 0;
            end
            else begin
                if (md_valid_3^md_ready_3) begin
                    Jal_3           <= Jal_3;          
                    Jalr_3          <= Jalr_3;         
                    MemWrite_3      <= MemWrite_3;     
                    MemtoReg_3      <= MemtoReg_3;    
                    RegWrite_3      <= RegWrite_3;     
                    ALUSrc_3        <= ALUSrc_3;       
                    ALUOP_3         <= ALUOP_3;
                    md_valid_3      <= md_valid_3;        
                    AES_3           <= AES_3; 
                    instruction_3   <= instruction_3;
                    immediate_3     <= immediate_3; 
                    MEM_forwd_in1_3 <= MEM_forwd_in1_3;
                    MEM_forwd_in2_3 <= MEM_forwd_in2_3;
                    WB_forwd_in1_3  <= WB_forwd_in1_3;
                    WB_forwd_in2_3  <= WB_forwd_in2_3;
                    //no_forwd_in1_3  <= no_forwd_in1_2;
                    //no_forwd_in2_3  <= no_forwd_in2_2;
                    if (pre_WB_data1)   r_data1_3 <= r_data1_3;
                    else                r_data1_3 <= r_data1_3;
                    if (pre_WB_data2)   r_data2_3 <= r_data2_3;
                    else                r_data2_3 <= r_data2_3;
                end
                else begin
                    Jal_3           <= Jal_2;
                    Jalr_3          <= Jalr_2;
                    MemWrite_3      <= MemWrite_2;
                    MemtoReg_3      <= MemtoReg_2;
                    RegWrite_3      <= RegWrite_2;
                    ALUSrc_3        <= ALUSrc_2;
                    ALUOP_3         <= ALUOP_2;
                    md_valid_3      <= md_valid_2;
                    AES_3           <= AES_2;
                    instruction_3   <= instruction_2;
                    immediate_3     <= immediate_2;
                    MEM_forwd_in1_3 <= MEM_forwd_in1_2;
                    MEM_forwd_in2_3 <= MEM_forwd_in2_2;
                    WB_forwd_in1_3  <= WB_forwd_in1_2;
                    WB_forwd_in2_3  <= WB_forwd_in2_2;
                    //no_forwd_in1_3  <= no_forwd_in1_2;
                    //no_forwd_in2_3  <= no_forwd_in2_2;
                    if (pre_WB_data1)   r_data1_3 <= Reg_write_data;
                    else                r_data1_3 <= r_data1_2;
                    if (pre_WB_data2)   r_data2_3 <= Reg_write_data;
                    else                r_data2_3 <= r_data2_2;
                end
            end
        end
    end
    // Second stage end

    // Third stage start
    assign  load_use_hazd_in1   = (instruction_5[6:0]==7'b11)&(instruction_5[11:7]==instruction_3[19:15])&(instruction_5[11:7]!=5'b0);
    assign  load_use_hazd_in2   = (instruction_5[6:0]==7'b11)&(instruction_5[11:7]==instruction_3[24:20])&(instruction_5[11:7]!=5'b0);
    //assign  MEM_forwd_in1_3       = (instruction_4[11:7]==instruction_3[19:15])&RegWrite_4&(instruction_4[11:7]!=5'b0);
    //assign  MEM_forwd_in2_3       = (instruction_4[11:7]==instruction_3[24:20])&RegWrite_4&(instruction_4[11:7]!=5'b0);
    //assign  WB_forwd_in1_3        = (instruction_5[11:7]==instruction_3[19:15])&RegWrite_5&(instruction_5[11:7]!=5'b0);
    //assign  WB_forwd_in2_3        = (instruction_5[11:7]==instruction_3[24:20])&RegWrite_5&(instruction_5[11:7]!=5'b0);
    assign  flush               = Branch|Jal_3|Jalr_3;
    assign  stall               = ((instruction_3[6:0]==7'b11)
            &((instruction_3[11:7]==instruction_2[19:15])|(instruction_3[11:7]==instruction_2[24:20])));

    assign  f_data1_3   = (MEM_forwd_in1_3)? forwd_data_4 : (WB_forwd_in1_3)?forwd_data_5 : r_data1_3;
    assign  f_data2_3   = (MEM_forwd_in2_3)? forwd_data_4 : (WB_forwd_in2_3)?forwd_data_5 : r_data2_3;
    
    // FORWD_UNIT  forwd_unit(
    //     .f_data1(f_data1_3), .f_data2(f_data2_3), .data1(r_data1_3), .data2(r_data2_3),
    //     .MEM_data1(forwd_data_4), .MEM_data2(forwd_data_4),
    //     .WB_data1(forwd_data_5), .WB_data2(forwd_data_5),
    //     .ctrl1({MEM_forwd_in1_3,WB_forwd_in1_3}), .ctrl2({MEM_forwd_in2_3,WB_forwd_in2_3})
    // );
    assign  ALU_in1 = (ALUOP_3 | ~RegWrite_3 | MemtoReg_3)? f_data1_3 : (instruction_3[5])? {32'b0} : (mem_addr_I)-8;
    assign  ALU_in2 = (ALUSrc_3)? immediate_3 : f_data2_3;
    assign  PC_4_out_3 = mem_addr_I + 4;
    assign  PC_imm_out = mem_addr_I + immediate_3;
    assign  Jalr_adder_out = f_data1_3 + immediate_3;
    assign  nxt_mem_addr_I = (Branch || Jal_3)? (PC_imm_out-8) : (Jalr_3) ? Jalr_adder_out : PC_4_out_3;

    Branch_Unit BRANCH(
        .Branch(Branch), .opcode(instruction_3[6:0]), .funct3(instruction_3[14:12]),
        .r_data_1(f_data1_3), .r_data_2(f_data2_3)
    );

    ALU alu(
        .Z(ALU_result_3), .A(ALU_in1), .B(ALU_in2),
        .inst({instruction_3[5],instruction_3[30],instruction_3[14:12]}), .ALUOP(ALUOP_3)
    );

    mulDiv muldiv(
        .clk(clk),
        .rst(rst),
        .valid(md_valid_3),
        .ready(md_ready_3),
        .mode(instruction_3[14]),
        .in_A(f_data1_3),
        .in_B(ALU_in2),
        .out(mudi_result_3)
    );

    SAES32 aes32(
        .valid(AES_3), .fn(instruction_3[29:25]), .rs1(f_data1_3),
        .rs2(f_data2_3), .rd(AES_result_3)
    );
    always @(*) begin
        if (rst) mem_addr_I_o = 32'h10000;
        else begin
            if ((md_valid_2 | (md_valid_3^md_ready_3) | ((instruction_2[6:0]==7'b11)
                &((instruction_2[11:7]==instruction_1[19:15])|(instruction_2[11:7]==instruction_1[24:20]))))&(~Jalr_3 & ~Jal_3 & ~Branch))
                mem_addr_I_o = nxt_mem_addr_I-4;
            else mem_addr_I_o = nxt_mem_addr_I;
        end
    end
        
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mem_addr_I    <= 32'h10000-4;
            instruction_4   <= 0;
            PC_4_out_4      <= 0;
            Cpu_result_4    <= 0;
            f_data2_4       <= 0;
            Jal_4           <= 0;
            Jalr_4          <= 0;
            MemtoReg_4      <= 0;
            MemWrite_4      <= 0;
            RegWrite_4      <= 0;
        end
        else begin
                // load-use hazard
            if ((md_valid_2 | (md_valid_3^md_ready_3) | ((instruction_2[6:0]==7'b11)
                &((instruction_2[11:7]==instruction_1[19:15])|(instruction_2[11:7]==instruction_1[24:20]))))&(~Jalr_3 & ~Jal_3 & ~Branch))
                mem_addr_I <= nxt_mem_addr_I-4;
            else mem_addr_I <= nxt_mem_addr_I;

            if (AES_3)  Cpu_result_4 <= AES_result_3;
            else begin
                if (md_ready_3) Cpu_result_4 <= mudi_result_3[31:0];
                else            Cpu_result_4 <= ALU_result_3;
            end
            instruction_4   <= instruction_3;
            PC_4_out_4      <= PC_4_out_3;
            f_data2_4       <= f_data2_3;
            Jal_4           <= Jal_3;
            Jalr_4          <= Jalr_3;
            MemtoReg_4      <= MemtoReg_3;
            MemWrite_4      <= MemWrite_3;
            RegWrite_4      <= RegWrite_3;
        end
    end
    // Third stage end

    // Fourth stage start
    assign mem_addr_D_o = Cpu_result_4;
    assign mem_wen_D_o = MemWrite_4;
    // assign mem_data_4 = {mem_rdata_D[7:0],mem_rdata_D[15:8],mem_rdata_D[23:16],mem_rdata_D[31:24]};
    // assign mem_data_4 = mem_rdata_D;
    // assign mem_wdata_D_o = {f_data2_4[7:0],f_data2_4[15:8],f_data2_4[23:16],f_data2_4[31:24]};
    assign mem_wdata_D_o = f_data2_4;
    assign forwd_data_4 = Cpu_result_4;
    always @(posedge clk or posedge rst)begin
        if (rst) begin
            instruction_5 <= 0;
            // mem_data_5  <= 0;
            Jal_5       <= 0;
            Jalr_5      <= 0;
            MemtoReg_5  <= 0;
            RegWrite_5  <= 0;
            PC_4_out_5  <= 0;
            Cpu_result_5 <= 0;
        end
        else begin
            instruction_5 <= instruction_4;
            // mem_data_5  <= mem_data_4;
            Jal_5       <= Jal_4;
            Jalr_5      <= Jalr_4;
            MemtoReg_5  <= MemtoReg_4;
            RegWrite_5  <= RegWrite_4;
            PC_4_out_5  <= PC_4_out_4;
            Cpu_result_5 <= Cpu_result_4;
        end
    end
    // Fourth stage end

    // Fifth stage start
    assign Reg_write_data = (Jalr_5 || Jal_5)? (PC_4_out_5-8) : (MemtoReg_5)? mem_data_5 : Cpu_result_5;
    assign forwd_data_5 = (MemtoReg_5)? mem_data_5 : Cpu_result_5;
    always @(*) begin
        case (instruction_5[14:12])
            3'b0: begin
                case (Cpu_result_5[1:0])
                    2'b00: mem_data_5 = {{24{mem_rdata_D[7]}},mem_rdata_D[7:0]};
                    2'b01: mem_data_5 = {{24{mem_rdata_D[15]}},mem_rdata_D[15:8]};
                    2'b10: mem_data_5 = {{24{mem_rdata_D[23]}},mem_rdata_D[23:16]};
                    2'b11: mem_data_5 = {{24{mem_rdata_D[31]}},mem_rdata_D[31:24]};
                endcase
            end
            3'b100: begin
                case (Cpu_result_5[1:0])
                    2'b00: mem_data_5 = {24'b0,mem_rdata_D[7:0]};
                    2'b01: mem_data_5 = {24'b0,mem_rdata_D[15:8]};
                    2'b10: mem_data_5 = {24'b0,mem_rdata_D[23:16]};
                    2'b11: mem_data_5 = {24'b0,mem_rdata_D[31:24]};
                endcase
            end
            default: mem_data_5 = mem_rdata_D;
        endcase
    end
    //Fifth stage end
endmodule

module MULDIV_Unit(
                opcode,
                funct7,
                valid
);
    input   [6:2]   opcode;
    input           funct7;
    output  reg     valid;

    always @(*) begin
        case (opcode)
            5'b01100:   valid = funct7;
            default :   valid = 1'b0;
        endcase
    end
endmodule

module FORWD_UNIT(f_data1,
                f_data2,
                data1,
                data2,
                MEM_data1,
                MEM_data2,
                WB_data1,
                WB_data2,
                ctrl1,
                ctrl2);
    input       [63:0]  data1, data2;
    input       [63:0]  MEM_data1, MEM_data2;
    input       [63:0]  WB_data1, WB_data2;
    input       [1:0]   ctrl1, ctrl2;
    output reg  [63:0]  f_data1, f_data2;

    always @(*) begin
        case (ctrl1)
            2'b10 : f_data1 = MEM_data1;
            2'b01 : f_data1 = WB_data1;
            default : f_data1 = data1;
        endcase
        case (ctrl2)
            2'b10 : f_data2 = MEM_data2;
            2'b01 : f_data2 = WB_data2;
            default : f_data2 = data2;
        endcase
    end
endmodule

module ALU(Z,A,B,inst,ALUOP);
    input  [31:0]   A,B;
    input  [4:0]    inst;
    input           ALUOP;
    output [31:0]   Z;

    reg    [31:0]   Z;
    wire   [3:0]    ctrl;
    assign ctrl = (ALUOP) ? inst[3:0] : 4'b0000;

    always @(*) begin
        case (ctrl)
            4'b0000 : Z = A + B;        //ADD
            4'b0001 : Z = A << B;       //SLL
            4'b1001 : Z = A << B;       //SLLI
            4'b0010 : Z = (A<B)?1:0;    //SLT
            4'b1010 : Z = (A<B)?1:0;    //SLTI
            4'b0100 : Z = A^B;          //XOR
            4'b1100 : Z = A^B;          //XORI
            4'b0101 : Z = A >> B;       //SRL
            4'b0110 : Z = A | B;        //OR
            4'b1110 : Z = A | B;        //ORI
            4'b0111 : Z = A & B;        //AND
            4'b1111 : Z = A & B;        //ANDI
            4'b1000 : Z = (inst[4])? (A - B) : (A+B);        //SUB
            4'b1101 : Z = A >>> B;      //SRA
            default : Z = A;
        endcase
    end
endmodule

module CONTROL(clk,
            rst,
            opcode,
            Jal,
            Jalr,
            MemWrite,
            MemtoReg,
            RegWrite,
            ALUSrc,
            ALUOP,
            AES
			);
    input           clk, rst;
    input   [6:2]   opcode;
	output          Jal, Jalr, MemWrite, MemtoReg, RegWrite, ALUSrc, ALUOP, AES;
    // local parameter
    localparam JAL      = 5'b11011;
    localparam JALR     = 5'b11001;
    localparam LD       = 5'b00000;
    localparam SD       = 5'b01000;
    localparam R_TYPE   = 5'b01100;
    localparam SB       = 5'b11000;
    localparam U_type   = 5'b00101; // auipc
    localparam U_type_2 = 5'b01101; // lui
    localparam AES32    = 5'b00010;
	// wire/reg
	assign Jal       = (opcode == JAL)? 1 : 0;
    assign Jalr      = (opcode == JALR)? 1 : 0;
    assign MemWrite  = (opcode == SD)? 1 : 0;
    assign MemtoReg  = (opcode == LD)? 1 : 0;
    assign RegWrite  = (opcode == SD || opcode == SB)? 0 : 1; 
    assign ALUSrc    = (opcode == R_TYPE || opcode == JAL || opcode == SB || opcode == AES32)? 0 : 1;
    assign ALUOP     = (opcode == SD || opcode ==LD  || opcode == U_type || opcode == U_type_2)? 0 : 1;
    assign AES       = (opcode == AES32)? 1 : 0;
endmodule

module Branch_Unit(
                Branch,
                opcode,
                funct3,
                r_data_1,
                r_data_2
);
    input   [6:0]   opcode;
    input   [14:12] funct3;
    input   [31:0]  r_data_1, r_data_2;
    output          Branch;

    localparam SB = 7'b1100011;
    localparam BEQ = 3'b0;
    localparam BNE = 3'b1;

    wire equal, beq, bne;

    assign equal = ~|(r_data_1 ^ r_data_2);
    assign beq = (opcode == SB && funct3 == BEQ)? 1 : 0;
    assign bne = (opcode == SB && funct3 == BNE)? 1 : 0;
    assign Branch = ((beq && equal) || (bne && !equal))? 1 : 0;
endmodule

module Imm_Gen (
            immediate,
            instruction
);
    input      [31:0] instruction;
    output reg [31:0] immediate;

    wire [6:0] opcode;
    assign opcode = instruction[6:0];

    always @(*) begin
        // I_type
        immediate[11:0]  = instruction[31:20];
        immediate[31:12] = { 20{instruction[31]} };
        case (opcode[6:2])
            5'b01000: begin // S_type
                immediate[11:5]  = instruction[31:25];
                immediate[4:0]   = instruction[11:7];
                immediate[31:12] = { 20{instruction[31]} };
            end
            5'b11000: begin // B_type
                immediate[12]    = instruction[31];
                immediate[10:5]  = instruction[30:25];
                immediate[4:1]   = instruction[11:8];
                immediate[11]    = instruction[7];
                immediate[31:13] = { 19{instruction[31]} };
                immediate[0]     = 0;
            end
            5'b11011: begin // J_type
                immediate[20]    = instruction[31];
                immediate[10:1]  = instruction[30:21];
                immediate[11]    = instruction[20];
                immediate[19:12] = instruction[19:12];
                immediate[31:21] = { 11{instruction[31]} };
                immediate[0]     = 0;
            end
            5'b00100: begin // I:slli,srli,srai
                if (instruction[13:12] == 2'b01) begin
                    immediate[5:0]  = instruction[25:20];
                    immediate[31:6] = { 26{instruction[25]} };
                end
            end
            5'b00101: begin // U_type
                immediate = {instruction[31:12],12'b0};
            end
            5'b01101: begin // U_type
                immediate = {instruction[31:12],12'b0};
            end
        endcase
    end

endmodule

module mulDiv(clk, rst, valid, ready, mode, in_A, in_B, out);
    // Definition of ports
    input         clk, rst;
    input         valid, mode; // mode: 0: mulu, 1: divu
    output        ready;
    input  [31:0] in_A, in_B;
    output [63:0] out;

    // Definition of states
    localparam IDLE = 2'b00;
    localparam MUL  = 2'b01;
    localparam DIV  = 2'b10;
    localparam OUT  = 2'b11;

    wire [63:0] out_nxt, mul_out, div_out;

    reg  [ 1:0] state, state_nxt;
    reg         counter, counter_nxt;

    reg         ready;
    reg  [63:0] out;

    
    DW02_mult_2_stage #(32, 32) MULT (.A(in_A), .B(in_B), .TC(1'b0), .CLK(clk), .PRODUCT(mul_out));
    DW_div_pipe       #(32, 32, 0, 0, 2, 1, 0) DIVI (.clk(clk), .rst_n(~rst), .en(valid), .a(in_A), .b(in_B), .quotient(div_out), .remainder());

    assign  out_nxt = (state == MUL) ? mul_out : div_out;
   // Combinational always block
    always @(*) begin
        case(state)
            IDLE: begin
                if (valid) begin
                    if (mode) state_nxt = DIV;
                    else state_nxt = MUL;
                end
                else state_nxt = IDLE;
            end
            MUL : state_nxt = MUL;
            DIV : state_nxt = DIV;
            OUT : state_nxt = IDLE;
        endcase
    end
    always @(*) begin
        case (state)
            MUL : counter_nxt = counter+1;
            DIV : counter_nxt = counter+1;
            default : counter_nxt = 0;
        endcase
    end
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 0;
            ready <= 0;
            out <= 0;
        end
        else begin
            if (counter == 1'b1) begin
                state <= OUT;
                ready <= 1;
            end
            else begin
                state <= state_nxt;
                ready <= 0;
            end
            out     <= out_nxt;
            counter <= counter_nxt;
        end
    end

endmodule

module REGISTERS(clk,
                rst,
                instruction,
                Regwrite,
                Writedata,
                reg_data1,
                reg_data2);

    input   [31:0]  instruction;
    input           Regwrite,rst,clk;
    input   [31:0]  Writedata;
    output  [31:0]  reg_data1, reg_data2;

    reg     [31:0]  x[0:31];
    reg     [31:0]  nxt_x[0:31];

    wire    [4:0]   read_1, read_2, write_1;

    assign read_1 = instruction[19:15];
    assign read_2 = instruction[24:20];
    assign write_1 = instruction[11:7];

    assign reg_data1 = x[read_1];
    assign reg_data2 = x[read_2];
    
    integer i;

    always @(*) begin
        nxt_x[0] = x[0];
        for (i=1; i<32; i=i+1)
            nxt_x[i] = (Regwrite && (write_1 == i)) ? Writedata : x[i];
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i=0; i<32; i=i+1) begin
                case(i)
                    32'd2: x[i] <= 32'hbffffff0;
                    32'd3: x[i] <= 32'h10008000;
                    default: x[i] <= 32'h0;
                endcase
            end
        end
        else begin
            for (i=0; i<32; i=i+1)
                x[i] <= nxt_x[i];
        end
    end
endmodule

//  code from https://github.com/mjosaarinen/lwaes_isa.git
//  saes32.v
//	2020-01-29	Markku-Juhani O. Saarinen <mjos@pqshield.com>
//	Copyright (c) 2020, PQShield Ltd. All rights reserved.

//	Proposed SAES32 instruction for lightweight AES, AES^-1, and SM4 (RV32).
//	aes encrypt

module SAES32(valid, fn, rs1, rs2, rd);
    input       [4:0]   fn;
    input       [31:0]  rs1, rs2;
    input               valid;
    output      [31:0]  rd;

    wire [7:0]  x;
    wire [31:0] aes_32, aesi_32, y, z;
    
    assign  x =	fn[1:0] == 2'b00 ?	rs2[ 7: 0] :
				fn[1:0] == 2'b01 ?	rs2[15: 8] :
				fn[1:0] == 2'b10 ?	rs2[23:16] :
									rs2[31:24];
    assign  y = (fn[3])? aesi_32 : aes_32;
    assign  z = fn[1:0] == 2'b00 ?	y :
				fn[1:0] == 2'b01 ?	{ y[23: 0], y[31:24] } :
				fn[1:0] == 2'b10 ?	{ y[15: 0], y[31:16] } :
									{ y[ 7: 0], y[31: 8] };
    assign	rd = (valid)? z ^ rs1 : 32'b0;
    
	aes_t	aes (.out(aes_32), .in(x), .f(fn[2]));
    aesi_t	aesi(.out(aesi_32), .in(x), .f(fn[2]));

endmodule

module aes_t( output [31:0] out, input [7:0] in, input f );

	wire [7:0] x;
	wire [7:0] x2;

	aes_sbox  sbox	(.fx(x), .in(in));
	aes_xtime lfsr1 (.out(x2), .in(x));

	//	NOP / MixColumns MDS Matrix

	assign out = f ? { 24'b0, x } : { x ^ x2, x, x, x2 } ;

endmodule

module aesi_t( output [31:0] out, input [7:0] in, input f );

	wire [7:0] x;
	wire [7:0] x2;
	wire [7:0] x4;
	wire [7:0] x8;

	aesi_sbox  sbox	 ( .fx(x), .in(in));
	aes_xtime  lfsr1 (.out(x2), .in(x ));			//	todo: reduce circuit depth
	aes_xtime  lfsr2 (.out(x4), .in(x2));
	aes_xtime  lfsr3 (.out(x8), .in(x4));

	//	NOP / Inverse MixColumns MDS Matrix

	assign out = f ? { 24'b0, x } :
		{ x ^ x2 ^ x8, x ^ x4 ^ x8, x ^ x8, x2 ^ x4 ^ x8 };

endmodule

//	Multiply by 0x02 in AES's GF(256) - LFSR style

module aes_xtime( output [7:0] out, input [7:0] in );
	assign	out = { in[6:0], 1'b0 } ^ ( in[7] ? 8'h1B : 8'h00 );
endmodule

//	AES s-box

module aes_sbox( output [7:0] fx, input [7:0] in );

	wire [20:0] t1;
	wire [17:0] t2;

	sbox_aes_top top ( .y(t1), .x(in) );
	sbox_inv_mid mid ( .y(t2), .x(t1) );
	sbox_aes_out out ( .y(fx), .x(t2) );

endmodule

//	AES inverse S-box

module aesi_sbox( output [7:0] fx, input [7:0] in );

	wire [20:0] t1;
	wire [17:0] t2;

	sbox_aesi_top top ( .y(t1), .x(in) );
	sbox_inv_mid  mid ( .y(t2), .x(t1) );
	sbox_aesi_out out ( .y(fx), .x(t2) );

endmodule

//	top (inner) linear layer for AES

module sbox_aes_top( output [20:0] y, input [7:0] x);

	wire [5:0] t;

	assign	y[ 0] = x[ 0];
	assign	y[ 1] = x[ 7] ^	 x[ 4];
	assign	y[ 2] = x[ 7] ^	 x[ 2];
	assign	y[ 3] = x[ 7] ^	 x[ 1];
	assign	y[ 4] = x[ 4] ^	 x[ 2];
	assign	t[ 0] = x[ 3] ^	 x[ 1];
	assign	y[ 5] = y[ 1] ^	 t[ 0];
	assign	t[ 1] = x[ 6] ^	 x[ 5];
	assign	y[ 6] = x[ 0] ^	 y[ 5];
	assign	y[ 7] = x[ 0] ^	 t[ 1];
	assign	y[ 8] = y[ 5] ^	 t[ 1];
	assign	t[ 2] = x[ 6] ^	 x[ 2];
	assign	t[ 3] = x[ 5] ^	 x[ 2];
	assign	y[ 9] = y[ 3] ^	 y[ 4];
	assign	y[10] = y[ 5] ^	 t[ 2];
	assign	y[11] = t[ 0] ^	 t[ 2];
	assign	y[12] = t[ 0] ^	 t[ 3];
	assign	y[13] = y[ 7] ^	 y[12];
	assign	t[ 4] = x[ 4] ^	 x[ 0];
	assign	y[14] = t[ 1] ^	 t[ 4];
	assign	y[15] = y[ 1] ^	 y[14];
	assign	t[ 5] = x[ 1] ^	 x[ 0];
	assign	y[16] = t[ 1] ^	 t[ 5];
	assign	y[17] = y[ 2] ^	 y[16];
	assign	y[18] = y[ 2] ^	 y[ 8];
	assign	y[19] = y[15] ^	 y[13];
	assign	y[20] = y[ 1] ^	 t[ 3];

endmodule

//	bottom (outer) linear layer for AES

module sbox_aes_out( output [7:0] y, input [17:0] x);

	wire [29:0] t;

	assign	t[ 0] = x[11] ^	 x[12];
	assign	t[ 1] = x[ 0] ^	 x[ 6];
	assign	t[ 2] = x[14] ^	 x[16];
	assign	t[ 3] = x[15] ^	 x[ 5];
	assign	t[ 4] = x[ 4] ^	 x[ 8];
	assign	t[ 5] = x[17] ^	 x[11];
	assign	t[ 6] = x[12] ^	 t[ 5];
	assign	t[ 7] = x[14] ^	 t[ 3];
	assign	t[ 8] = x[ 1] ^	 x[ 9];
	assign	t[ 9] = x[ 2] ^	 x[ 3];
	assign	t[10] = x[ 3] ^	 t[ 4];
	assign	t[11] = x[10] ^	 t[ 2];
	assign	t[12] = x[16] ^	 x[ 1];
	assign	t[13] = x[ 0] ^	 t[ 0];
	assign	t[14] = x[ 2] ^	 x[11];
	assign	t[15] = x[ 5] ^	 t[ 1];
	assign	t[16] = x[ 6] ^	 t[ 0];
	assign	t[17] = x[ 7] ^	 t[ 1];
	assign	t[18] = x[ 8] ^	 t[ 8];
	assign	t[19] = x[13] ^	 t[ 4];
	assign	t[20] = t[ 0] ^	 t[ 1];
	assign	t[21] = t[ 1] ^	 t[ 7];
	assign	t[22] = t[ 3] ^	 t[12];
	assign	t[23] = t[18] ^	 t[ 2];
	assign	t[24] = t[15] ^	 t[ 9];
	assign	t[25] = t[ 6] ^	 t[10];
	assign	t[26] = t[ 7] ^	 t[ 9];
	assign	t[27] = t[ 8] ^	 t[10];
	assign	t[28] = t[11] ^	 t[14];
	assign	t[29] = t[11] ^	 t[17];
	assign	y[ 0] = t[ 6] ^~ t[23];
	assign	y[ 1] = t[13] ^~ t[27];
	assign	y[ 2] = t[25] ^	 t[29];
	assign	y[ 3] = t[20] ^	 t[22];
	assign	y[ 4] = t[ 6] ^	 t[21];
	assign	y[ 5] = t[19] ^~ t[28];
	assign	y[ 6] = t[16] ^~ t[26];
	assign	y[ 7] = t[ 6] ^	 t[24];

endmodule

//	top (inner) linear layer for AES^-1

module sbox_inv_mid( output [17:0] y, input [20:0] x );

	wire [45:0] t;

	assign	t[ 0] = x[ 3] ^	 x[12];
	assign	t[ 1] = x[ 9] &	 x[ 5];
	assign	t[ 2] = x[17] &	 x[ 6];
	assign	t[ 3] = x[10] ^	 t[ 1];
	assign	t[ 4] = x[14] &	 x[ 0];
	assign	t[ 5] = t[ 4] ^	 t[ 1];
	assign	t[ 6] = x[ 3] &	 x[12];
	assign	t[ 7] = x[16] &	 x[ 7];
	assign	t[ 8] = t[ 0] ^	 t[ 6];
	assign	t[ 9] = x[15] &	 x[13];
	assign	t[10] = t[ 9] ^	 t[ 6];
	assign	t[11] = x[ 1] &	 x[11];
	assign	t[12] = x[ 4] &	 x[20];
	assign	t[13] = t[12] ^	 t[11];
	assign	t[14] = x[ 2] &	 x[ 8];
	assign	t[15] = t[14] ^	 t[11];
	assign	t[16] = t[ 3] ^	 t[ 2];
	assign	t[17] = t[ 5] ^	 x[18];
	assign	t[18] = t[ 8] ^	 t[ 7];
	assign	t[19] = t[10] ^	 t[15];
	assign	t[20] = t[16] ^	 t[13];
	assign	t[21] = t[17] ^	 t[15];
	assign	t[22] = t[18] ^	 t[13];
	assign	t[23] = t[19] ^	 x[19];
	assign	t[24] = t[22] ^	 t[23];
	assign	t[25] = t[22] &	 t[20];
	assign	t[26] = t[21] ^	 t[25];
	assign	t[27] = t[20] ^	 t[21];
	assign	t[28] = t[23] ^	 t[25];
	assign	t[29] = t[28] &	 t[27];
	assign	t[30] = t[26] &	 t[24];
	assign	t[31] = t[20] &	 t[23];
	assign	t[32] = t[27] &	 t[31];
	assign	t[33] = t[27] ^	 t[25];
	assign	t[34] = t[21] &	 t[22];
	assign	t[35] = t[24] &	 t[34];
	assign	t[36] = t[24] ^	 t[25];
	assign	t[37] = t[21] ^	 t[29];
	assign	t[38] = t[32] ^	 t[33];
	assign	t[39] = t[23] ^	 t[30];
	assign	t[40] = t[35] ^	 t[36];
	assign	t[41] = t[38] ^	 t[40];
	assign	t[42] = t[37] ^	 t[39];
	assign	t[43] = t[37] ^	 t[38];
	assign	t[44] = t[39] ^	 t[40];
	assign	t[45] = t[42] ^	 t[41];
	assign	y[ 0] = t[38] &	 x[ 7];
	assign	y[ 1] = t[37] &	 x[13];
	assign	y[ 2] = t[42] &	 x[11];
	assign	y[ 3] = t[45] &	 x[20];
	assign	y[ 4] = t[41] &	 x[ 8];
	assign	y[ 5] = t[44] &	 x[ 9];
	assign	y[ 6] = t[40] &	 x[17];
	assign	y[ 7] = t[39] &	 x[14];
	assign	y[ 8] = t[43] &	 x[ 3];
	assign	y[ 9] = t[38] &	 x[16];
	assign	y[10] = t[37] &	 x[15];
	assign	y[11] = t[42] &	 x[ 1];
	assign	y[12] = t[45] &	 x[ 4];
	assign	y[13] = t[41] &	 x[ 2];
	assign	y[14] = t[44] &	 x[ 5];
	assign	y[15] = t[40] &	 x[ 6];
	assign	y[16] = t[39] &	 x[ 0];
	assign	y[17] = t[43] &	 x[12];

endmodule

module sbox_aesi_top( output [20:0] y, input [7:0] x);

	wire [4:0] t;

	assign	y[17] = x[ 7] ^	 x[ 4];
	assign	y[16] = x[ 6] ^~ x[ 4];
	assign	y[ 2] = x[ 7] ^~ x[ 6];
	assign	y[ 1] = x[ 4] ^	 x[ 3];
	assign	y[18] = x[ 3] ^~ x[ 0];
	assign	t[ 0] = x[ 1] ^	 x[ 0];
	assign	y[ 6] = x[ 6] ^~ y[17];
	assign	y[14] = y[16] ^	 t[ 0];
	assign	y[ 7] = x[ 0] ^~ y[ 1];
	assign	y[ 8] = y[ 2] ^	 y[18];
	assign	y[ 9] = y[ 2] ^	 t[ 0];
	assign	y[ 3] = y[ 1] ^	 t[ 0];
	assign	y[19] = x[ 5] ^~ y[ 1];
	assign	t[ 1] = x[ 6] ^	 x[ 1];
	assign	y[13] = x[ 5] ^~ y[14];
	assign	y[15] = y[18] ^	 t[ 1];
	assign	y[ 4] = x[ 3] ^	 y[ 6];
	assign	t[ 2] = x[ 5] ^~ x[ 2];
	assign	t[ 3] = x[ 2] ^~ x[ 1];
	assign	t[ 4] = x[ 5] ^~ x[ 3];
	assign	y[ 5] = y[16] ^	 t[ 2];
	assign	y[12] = t[ 1] ^	 t[ 4];
	assign	y[20] = y[ 1] ^	 t[ 3];
	assign	y[11] = y[ 8] ^	 y[20];
	assign	y[10] = y[ 8] ^	 t[ 3];
	assign	y[ 0] = x[ 7] ^	 t[ 2];

endmodule

//	bottom (outer) linear layer for AES^-1

module sbox_aesi_out( output [7:0] y, input [17:0] x);

	wire [29:0] t;

	assign	t[ 0] = x[ 2] ^	 x[11];
	assign	t[ 1] = x[ 8] ^	 x[ 9];
	assign	t[ 2] = x[ 4] ^	 x[12];
	assign	t[ 3] = x[15] ^	 x[ 0];
	assign	t[ 4] = x[16] ^	 x[ 6];
	assign	t[ 5] = x[14] ^	 x[ 1];
	assign	t[ 6] = x[17] ^	 x[10];
	assign	t[ 7] = t[ 0] ^	 t[ 1];
	assign	t[ 8] = x[ 0] ^	 x[ 3];
	assign	t[ 9] = x[ 5] ^	 x[13];
	assign	t[10] = x[ 7] ^	 t[ 4];
	assign	t[11] = t[ 0] ^	 t[ 3];
	assign	t[12] = x[14] ^	 x[16];
	assign	t[13] = x[17] ^	 x[ 1];
	assign	t[14] = x[17] ^	 x[12];
	assign	t[15] = x[ 4] ^	 x[ 9];
	assign	t[16] = x[ 7] ^	 x[11];
	assign	t[17] = x[ 8] ^	 t[ 2];
	assign	t[18] = x[13] ^	 t[ 5];
	assign	t[19] = t[ 2] ^	 t[ 3];
	assign	t[20] = t[ 4] ^	 t[ 6];
	assign	t[22] = t[ 2] ^	 t[ 7];
	assign	t[23] = t[ 7] ^	 t[ 8];
	assign	t[24] = t[ 5] ^	 t[ 7];
	assign	t[25] = t[ 6] ^	 t[10];
	assign	t[26] = t[ 9] ^	 t[11];
	assign	t[27] = t[10] ^	 t[18];
	assign	t[28] = t[11] ^	 t[25];
	assign	t[29] = t[15] ^	 t[20];
	assign	y[ 0] = t[ 9] ^	 t[16];
	assign	y[ 1] = t[14] ^	 t[23];
	assign	y[ 2] = t[19] ^	 t[24];
	assign	y[ 3] = t[23] ^	 t[27];
	assign	y[ 4] = t[12] ^	 t[22];
	assign	y[ 5] = t[17] ^	 t[28];
	assign	y[ 6] = t[26] ^	 t[29];
	assign	y[ 7] = t[13] ^	 t[22];

endmodule

/*module sram_512x32(clk, rst, wen, a, d, q, src);
    parameter BITS = 32;
    parameter word_depth = 512;

    input   clk, rst, wen; // wen: 0:read | 1:write
    input   [1:0]       src;
    input   [BITS-1:0]  d;
    input   [BITS-1:0]  a;


    output  [BITS-1:0]  q;

    reg     [BITS-1:0]  offset_1;
    reg     [BITS-1:0]  offset_2;

    wire    [BITS-1:0]  q;

    wire    [8:0]       a_chag;
    wire                wen_inv;
    wire    [7:0]       q_1, q_2, q_3, q_4;

    integer i;

    
    sram_512x8  front_bit(
        .Q(q_1),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv),
        .A(a_chag),
        .D(d[31:24])
    );
    sram_512x8  middle_front_bit(
        .Q(q_2),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv),
        .A(a_chag),
        .D(d[23:16])
    );
    sram_512x8  middle_rear_bit(
        .Q(q_3),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv),
        .A(a_chag),
        .D(d[15:8])
    );
    sram_512x8  rear_bit(
        .Q(q_4),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv),
        .A(a_chag),
        .D(d[7:0])
    );
    
    assign  a_chag = (a > (offset_1+1024))? 256+((a-offset_2)>>2)
                                          : (a-offset_1)>>2;
    assign  wen_inv = ~wen;
    assign  q = {q_1,q_2,q_3,q_4};

    always @(posedge clk) begin
        if (src == 2'b11) begin
            offset_1 <= a;
            offset_2 <= d;
        end
        else begin
            offset_1 <= offset_1;
            offset_2 <= offset_2;
        end
    end
endmodule*/

module sram_1024x32(clk, rst, wen, a, d, q, src);
    parameter BITS = 32;
    parameter word_depth = 1024;

    input   clk, rst, wen; // wen: 0:read | 1:write
    input   [1:0]       src;
    input   [BITS-1:0]  d;
    input   [BITS-1:0]  a;


    output  [BITS-1:0]  q;

    reg     [BITS-1:0]  offset_1;
    reg     [BITS-1:0]  offset_2;
    reg     [BITS-1:0]  a_pre;

    wire    [BITS-1:0]  q;

    wire    [8:0]       a_chag;
    wire                wen_inv_l;
    wire                wen_inv_h;
    wire    [7:0]       q_1_l, q_2_l, q_3_l, q_4_l;
    wire    [7:0]       q_1_h, q_2_h, q_3_h, q_4_h;

    integer i;

    
    sram_512x8  front_bit_low(
        .Q(q_1_l),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_l),
        .A(a_chag),
        .D(d[31:24])
    );
    sram_512x8  middle_front_bit_low(
        .Q(q_2_l),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_l),
        .A(a_chag),
        .D(d[23:16])
    );
    sram_512x8  middle_rear_bit_low(
        .Q(q_3_l),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_l),
        .A(a_chag),
        .D(d[15:8])
    );
    sram_512x8  rear_bit_low(
        .Q(q_4_l),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_l),
        .A(a_chag),
        .D(d[7:0])
    );

    sram_512x8  front_bit_high(
        .Q(q_1_h),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_h),
        .A(a_chag),
        .D(d[31:24])
    );
    sram_512x8  middle_front_bit_high(
        .Q(q_2_h),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_h),
        .A(a_chag),
        .D(d[23:16])
    );
    sram_512x8  middle_rear_bit_high(
        .Q(q_3_h),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_h),
        .A(a_chag),
        .D(d[15:8])
    );
    sram_512x8  rear_bit_high(
        .Q(q_4_h),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_h),
        .A(a_chag),
        .D(d[7:0])
    );
    
    assign  a_chag = (a >= offset_2)?       (a-offset_2)>>2:
                                            (a-offset_1)>>2;
    assign  wen_inv_l = (a >= (offset_2))? 1'b1: (~wen);
    assign  wen_inv_h = (a >= (offset_2))? (~wen): 1'b1;
    assign  q = (a_pre >= (offset_2))?  {q_1_h,q_2_h,q_3_h,q_4_h}:
                                            {q_1_l,q_2_l,q_3_l,q_4_l};

    always @(posedge clk) begin
        if (src == 2'b11) begin
            offset_1 <= a;
            offset_2 <= d;
        end
        else begin
            offset_1 <= offset_1;
            offset_2 <= offset_2;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst)    a_pre <= 0;
        else        a_pre <= a;
    end
endmodule

module sram_2048x32(clk, rst, wen, a, d, q, src);
    parameter BITS = 32;
    parameter word_depth = 2048;

    input   clk, rst, wen; // wen: 0:read | 1:write
    input   [1:0]       src;
    input   [BITS-1:0]  d;
    input   [BITS-1:0]  a;


    output  [BITS-1:0]  q;

    reg     [BITS-1:0]  offset_1;
    reg     [BITS-1:0]  offset_2;
    reg     [BITS-1:0]  a_pre;

    wire    [BITS-1:0]  q;

    wire    [8:0]       a_chag;
    wire                wen_inv_1;
    wire                wen_inv_2;
    wire                wen_inv_3;
    wire                wen_inv_4;
    wire    [7:0]       q_1[0:3];
    wire    [7:0]       q_2[0:3];
    wire    [7:0]       q_3[0:3];
    wire    [7:0]       q_4[0:3];
    wire    [BITS-1:0]  base_2;
    wire    [BITS-1:0]  base_3;
    wire    [BITS-1:0]  base_4;

    integer i;

    
    sram_512x8  front_bit_1(
        .Q(q_1[0]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_1),
        .A(a_chag),
        .D(d[31:24])
    );
    sram_512x8  middle_front_bit_1(
        .Q(q_1[1]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_1),
        .A(a_chag),
        .D(d[23:16])
    );
    sram_512x8  middle_rear_bit_1(
        .Q(q_1[2]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_1),
        .A(a_chag),
        .D(d[15:8])
    );
    sram_512x8  rear_bit_1(
        .Q(q_1[3]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_1),
        .A(a_chag),
        .D(d[7:0])
    );

    sram_512x8  front_bit_2(
        .Q(q_2[0]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_2),
        .A(a_chag),
        .D(d[31:24])
    );
    sram_512x8  middle_front_bit_2(
        .Q(q_2[1]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_2),
        .A(a_chag),
        .D(d[23:16])
    );
    sram_512x8  middle_rear_bit_2(
        .Q(q_2[2]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_2),
        .A(a_chag),
        .D(d[15:8])
    );
    sram_512x8  rear_bit_2(
        .Q(q_2[3]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_2),
        .A(a_chag),
        .D(d[7:0])
    );

    sram_512x8  front_bit_3(
        .Q(q_3[0]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_3),
        .A(a_chag),
        .D(d[31:24])
    );
    sram_512x8  middle_front_bit_3(
        .Q(q_3[1]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_3),
        .A(a_chag),
        .D(d[23:16])
    );
    sram_512x8  middle_rear_bit_3(
        .Q(q_3[2]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_3),
        .A(a_chag),
        .D(d[15:8])
    );
    sram_512x8  rear_bit_3(
        .Q(q_3[3]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_3),
        .A(a_chag),
        .D(d[7:0])
    );

    sram_512x8  front_bit_4(
        .Q(q_4[0]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_4),
        .A(a_chag),
        .D(d[31:24])
    );
    sram_512x8  middle_front_bit_4(
        .Q(q_4[1]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_4),
        .A(a_chag),
        .D(d[23:16])
    );
    sram_512x8  middle_rear_bit_4(
        .Q(q_4[2]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_4),
        .A(a_chag),
        .D(d[15:8])
    );
    sram_512x8  rear_bit_4(
        .Q(q_4[3]),
        .CLK(clk),
        .CEN(1'b0),
        .WEN(wen_inv_4),
        .A(a_chag),
        .D(d[7:0])
    );
    
    assign  base_2 = offset_1 + 2048;
    assign  base_3 = offset_1 + 4096;
    assign  base_4 = offset_1 + 6144;

    assign  a_chag = (a >= offset_2)? 256+((a-offset_2)>>2):
                     (a >= base_4)? (a-base_4)>>2:
                     (a >= base_3)? (a-base_3)>>2:
                     (a >= base_2)? (a-base_2)>>2:
                                    (a-offset_1)>>2;

    assign  wen_inv_1 = (a >= base_2)? 1'b1: (~wen);
    assign  wen_inv_2 = ((a >= base_2)&(a < base_3))? (~wen): 1'b1;
    assign  wen_inv_3 = ((a >= base_3)&(a < base_4))? (~wen): 1'b1;
    assign  wen_inv_4 = (a >= base_4)? (~wen): 1'b1;

    assign  q = (a_pre >= base_4)?  {q_4[0],q_4[1],q_4[2],q_4[3]}:
                (a_pre >= base_3)?  {q_3[0],q_3[1],q_3[2],q_3[3]}:
                (a_pre >= base_2)?  {q_2[0],q_2[1],q_2[2],q_2[3]}:
                                    {q_1[0],q_1[1],q_1[2],q_1[3]};

    always @(posedge clk) begin
        if (src == 2'b11) begin
            offset_1 <= a;
            offset_2 <= d;
        end
        else begin
            offset_1 <= offset_1;
            offset_2 <= offset_2;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst)    a_pre <= 0;
        else        a_pre <= a;
    end
endmodule