// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
`timescale 1ns/1ps
module hls_action_ctrl_reg_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 9,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire                          interrupt,
    output wire [63:0]                   din_gmem_V,
    output wire [63:0]                   dout_gmem_V,
    output wire [991:0]                  act_reg_i,
    input  wire [991:0]                  act_reg_o,
    input  wire                          act_reg_o_ap_vld,
    output wire                          ap_start,
    input  wire                          ap_done,
    input  wire                          ap_ready,
    input  wire                          ap_idle
);
//------------------------Address Info-------------------
// 0x000 : Control signals
//         bit 0  - ap_start (Read/Write/COH)
//         bit 1  - ap_done (Read/COR)
//         bit 2  - ap_idle (Read)
//         bit 3  - ap_ready (Read)
//         bit 7  - auto_restart (Read/Write)
//         others - reserved
// 0x004 : Global Interrupt Enable Register
//         bit 0  - Global Interrupt Enable (Read/Write)
//         others - reserved
// 0x008 : IP Interrupt Enable Register (Read/Write)
//         bit 0  - Channel 0 (ap_done)
//         bit 1  - Channel 1 (ap_ready)
//         others - reserved
// 0x00c : IP Interrupt Status Register (Read/TOW)
//         bit 0  - Channel 0 (ap_done)
//         bit 1  - Channel 1 (ap_ready)
//         others - reserved
// 0x030 : Data signal of din_gmem_V
//         bit 31~0 - din_gmem_V[31:0] (Read/Write)
// 0x034 : Data signal of din_gmem_V
//         bit 31~0 - din_gmem_V[63:32] (Read/Write)
// 0x038 : reserved
// 0x040 : Data signal of dout_gmem_V
//         bit 31~0 - dout_gmem_V[31:0] (Read/Write)
// 0x044 : Data signal of dout_gmem_V
//         bit 31~0 - dout_gmem_V[63:32] (Read/Write)
// 0x048 : reserved
// 0x100 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[31:0] (Read/Write)
// 0x104 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[63:32] (Read/Write)
// 0x108 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[95:64] (Read/Write)
// 0x10c : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[127:96] (Read/Write)
// 0x110 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[159:128] (Read/Write)
// 0x114 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[191:160] (Read/Write)
// 0x118 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[223:192] (Read/Write)
// 0x11c : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[255:224] (Read/Write)
// 0x120 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[287:256] (Read/Write)
// 0x124 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[319:288] (Read/Write)
// 0x128 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[351:320] (Read/Write)
// 0x12c : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[383:352] (Read/Write)
// 0x130 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[415:384] (Read/Write)
// 0x134 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[447:416] (Read/Write)
// 0x138 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[479:448] (Read/Write)
// 0x13c : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[511:480] (Read/Write)
// 0x140 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[543:512] (Read/Write)
// 0x144 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[575:544] (Read/Write)
// 0x148 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[607:576] (Read/Write)
// 0x14c : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[639:608] (Read/Write)
// 0x150 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[671:640] (Read/Write)
// 0x154 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[703:672] (Read/Write)
// 0x158 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[735:704] (Read/Write)
// 0x15c : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[767:736] (Read/Write)
// 0x160 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[799:768] (Read/Write)
// 0x164 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[831:800] (Read/Write)
// 0x168 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[863:832] (Read/Write)
// 0x16c : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[895:864] (Read/Write)
// 0x170 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[927:896] (Read/Write)
// 0x174 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[959:928] (Read/Write)
// 0x178 : Data signal of act_reg_i
//         bit 31~0 - act_reg_i[991:960] (Read/Write)
// 0x17c : reserved
// 0x180 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[31:0] (Read)
// 0x184 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[63:32] (Read)
// 0x188 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[95:64] (Read)
// 0x18c : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[127:96] (Read)
// 0x190 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[159:128] (Read)
// 0x194 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[191:160] (Read)
// 0x198 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[223:192] (Read)
// 0x19c : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[255:224] (Read)
// 0x1a0 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[287:256] (Read)
// 0x1a4 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[319:288] (Read)
// 0x1a8 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[351:320] (Read)
// 0x1ac : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[383:352] (Read)
// 0x1b0 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[415:384] (Read)
// 0x1b4 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[447:416] (Read)
// 0x1b8 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[479:448] (Read)
// 0x1bc : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[511:480] (Read)
// 0x1c0 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[543:512] (Read)
// 0x1c4 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[575:544] (Read)
// 0x1c8 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[607:576] (Read)
// 0x1cc : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[639:608] (Read)
// 0x1d0 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[671:640] (Read)
// 0x1d4 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[703:672] (Read)
// 0x1d8 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[735:704] (Read)
// 0x1dc : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[767:736] (Read)
// 0x1e0 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[799:768] (Read)
// 0x1e4 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[831:800] (Read)
// 0x1e8 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[863:832] (Read)
// 0x1ec : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[895:864] (Read)
// 0x1f0 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[927:896] (Read)
// 0x1f4 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[959:928] (Read)
// 0x1f8 : Data signal of act_reg_o
//         bit 31~0 - act_reg_o[991:960] (Read)
// 0x1fc : Control signal of act_reg_o
//         bit 0  - act_reg_o_ap_vld (Read/COR)
//         others - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

//------------------------Parameter----------------------
localparam
    ADDR_AP_CTRL            = 9'h000,
    ADDR_GIE                = 9'h004,
    ADDR_IER                = 9'h008,
    ADDR_ISR                = 9'h00c,
    ADDR_DIN_GMEM_V_DATA_0  = 9'h030,
    ADDR_DIN_GMEM_V_DATA_1  = 9'h034,
    ADDR_DIN_GMEM_V_CTRL    = 9'h038,
    ADDR_DOUT_GMEM_V_DATA_0 = 9'h040,
    ADDR_DOUT_GMEM_V_DATA_1 = 9'h044,
    ADDR_DOUT_GMEM_V_CTRL   = 9'h048,
    ADDR_ACT_REG_I_DATA_0   = 9'h100,
    ADDR_ACT_REG_I_DATA_1   = 9'h104,
    ADDR_ACT_REG_I_DATA_2   = 9'h108,
    ADDR_ACT_REG_I_DATA_3   = 9'h10c,
    ADDR_ACT_REG_I_DATA_4   = 9'h110,
    ADDR_ACT_REG_I_DATA_5   = 9'h114,
    ADDR_ACT_REG_I_DATA_6   = 9'h118,
    ADDR_ACT_REG_I_DATA_7   = 9'h11c,
    ADDR_ACT_REG_I_DATA_8   = 9'h120,
    ADDR_ACT_REG_I_DATA_9   = 9'h124,
    ADDR_ACT_REG_I_DATA_10  = 9'h128,
    ADDR_ACT_REG_I_DATA_11  = 9'h12c,
    ADDR_ACT_REG_I_DATA_12  = 9'h130,
    ADDR_ACT_REG_I_DATA_13  = 9'h134,
    ADDR_ACT_REG_I_DATA_14  = 9'h138,
    ADDR_ACT_REG_I_DATA_15  = 9'h13c,
    ADDR_ACT_REG_I_DATA_16  = 9'h140,
    ADDR_ACT_REG_I_DATA_17  = 9'h144,
    ADDR_ACT_REG_I_DATA_18  = 9'h148,
    ADDR_ACT_REG_I_DATA_19  = 9'h14c,
    ADDR_ACT_REG_I_DATA_20  = 9'h150,
    ADDR_ACT_REG_I_DATA_21  = 9'h154,
    ADDR_ACT_REG_I_DATA_22  = 9'h158,
    ADDR_ACT_REG_I_DATA_23  = 9'h15c,
    ADDR_ACT_REG_I_DATA_24  = 9'h160,
    ADDR_ACT_REG_I_DATA_25  = 9'h164,
    ADDR_ACT_REG_I_DATA_26  = 9'h168,
    ADDR_ACT_REG_I_DATA_27  = 9'h16c,
    ADDR_ACT_REG_I_DATA_28  = 9'h170,
    ADDR_ACT_REG_I_DATA_29  = 9'h174,
    ADDR_ACT_REG_I_DATA_30  = 9'h178,
    ADDR_ACT_REG_I_CTRL     = 9'h17c,
    ADDR_ACT_REG_O_DATA_0   = 9'h180,
    ADDR_ACT_REG_O_DATA_1   = 9'h184,
    ADDR_ACT_REG_O_DATA_2   = 9'h188,
    ADDR_ACT_REG_O_DATA_3   = 9'h18c,
    ADDR_ACT_REG_O_DATA_4   = 9'h190,
    ADDR_ACT_REG_O_DATA_5   = 9'h194,
    ADDR_ACT_REG_O_DATA_6   = 9'h198,
    ADDR_ACT_REG_O_DATA_7   = 9'h19c,
    ADDR_ACT_REG_O_DATA_8   = 9'h1a0,
    ADDR_ACT_REG_O_DATA_9   = 9'h1a4,
    ADDR_ACT_REG_O_DATA_10  = 9'h1a8,
    ADDR_ACT_REG_O_DATA_11  = 9'h1ac,
    ADDR_ACT_REG_O_DATA_12  = 9'h1b0,
    ADDR_ACT_REG_O_DATA_13  = 9'h1b4,
    ADDR_ACT_REG_O_DATA_14  = 9'h1b8,
    ADDR_ACT_REG_O_DATA_15  = 9'h1bc,
    ADDR_ACT_REG_O_DATA_16  = 9'h1c0,
    ADDR_ACT_REG_O_DATA_17  = 9'h1c4,
    ADDR_ACT_REG_O_DATA_18  = 9'h1c8,
    ADDR_ACT_REG_O_DATA_19  = 9'h1cc,
    ADDR_ACT_REG_O_DATA_20  = 9'h1d0,
    ADDR_ACT_REG_O_DATA_21  = 9'h1d4,
    ADDR_ACT_REG_O_DATA_22  = 9'h1d8,
    ADDR_ACT_REG_O_DATA_23  = 9'h1dc,
    ADDR_ACT_REG_O_DATA_24  = 9'h1e0,
    ADDR_ACT_REG_O_DATA_25  = 9'h1e4,
    ADDR_ACT_REG_O_DATA_26  = 9'h1e8,
    ADDR_ACT_REG_O_DATA_27  = 9'h1ec,
    ADDR_ACT_REG_O_DATA_28  = 9'h1f0,
    ADDR_ACT_REG_O_DATA_29  = 9'h1f4,
    ADDR_ACT_REG_O_DATA_30  = 9'h1f8,
    ADDR_ACT_REG_O_CTRL     = 9'h1fc,
    WRIDLE                  = 2'd0,
    WRDATA                  = 2'd1,
    WRRESP                  = 2'd2,
    WRRESET                 = 2'd3,
    RDIDLE                  = 2'd0,
    RDDATA                  = 2'd1,
    RDRESET                 = 2'd2,
    ADDR_BITS         = 9;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [31:0]                   wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [31:0]                   rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg                           int_ap_idle;
    reg                           int_ap_ready;
    reg                           int_ap_done = 1'b0;
    reg                           int_ap_start = 1'b0;
    reg                           int_auto_restart = 1'b0;
    reg                           int_gie = 1'b0;
    reg  [1:0]                    int_ier = 2'b0;
    reg  [1:0]                    int_isr = 2'b0;
    reg  [63:0]                   int_din_gmem_V = 'b0;
    reg  [63:0]                   int_dout_gmem_V = 'b0;
    reg  [991:0]                  int_act_reg_i = 'b0;
    reg  [991:0]                  int_act_reg_o = 'b0;
    reg                           int_act_reg_o_ap_vld;

//------------------------Instantiation------------------

//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 1'b0;
            case (raddr)
                ADDR_AP_CTRL: begin
                    rdata[0] <= int_ap_start;
                    rdata[1] <= int_ap_done;
                    rdata[2] <= int_ap_idle;
                    rdata[3] <= int_ap_ready;
                    rdata[7] <= int_auto_restart;
                end
                ADDR_GIE: begin
                    rdata <= int_gie;
                end
                ADDR_IER: begin
                    rdata <= int_ier;
                end
                ADDR_ISR: begin
                    rdata <= int_isr;
                end
                ADDR_DIN_GMEM_V_DATA_0: begin
                    rdata <= int_din_gmem_V[31:0];
                end
                ADDR_DIN_GMEM_V_DATA_1: begin
                    rdata <= int_din_gmem_V[63:32];
                end
                ADDR_DOUT_GMEM_V_DATA_0: begin
                    rdata <= int_dout_gmem_V[31:0];
                end
                ADDR_DOUT_GMEM_V_DATA_1: begin
                    rdata <= int_dout_gmem_V[63:32];
                end
                ADDR_ACT_REG_I_DATA_0: begin
                    rdata <= int_act_reg_i[31:0];
                end
                ADDR_ACT_REG_I_DATA_1: begin
                    rdata <= int_act_reg_i[63:32];
                end
                ADDR_ACT_REG_I_DATA_2: begin
                    rdata <= int_act_reg_i[95:64];
                end
                ADDR_ACT_REG_I_DATA_3: begin
                    rdata <= int_act_reg_i[127:96];
                end
                ADDR_ACT_REG_I_DATA_4: begin
                    rdata <= int_act_reg_i[159:128];
                end
                ADDR_ACT_REG_I_DATA_5: begin
                    rdata <= int_act_reg_i[191:160];
                end
                ADDR_ACT_REG_I_DATA_6: begin
                    rdata <= int_act_reg_i[223:192];
                end
                ADDR_ACT_REG_I_DATA_7: begin
                    rdata <= int_act_reg_i[255:224];
                end
                ADDR_ACT_REG_I_DATA_8: begin
                    rdata <= int_act_reg_i[287:256];
                end
                ADDR_ACT_REG_I_DATA_9: begin
                    rdata <= int_act_reg_i[319:288];
                end
                ADDR_ACT_REG_I_DATA_10: begin
                    rdata <= int_act_reg_i[351:320];
                end
                ADDR_ACT_REG_I_DATA_11: begin
                    rdata <= int_act_reg_i[383:352];
                end
                ADDR_ACT_REG_I_DATA_12: begin
                    rdata <= int_act_reg_i[415:384];
                end
                ADDR_ACT_REG_I_DATA_13: begin
                    rdata <= int_act_reg_i[447:416];
                end
                ADDR_ACT_REG_I_DATA_14: begin
                    rdata <= int_act_reg_i[479:448];
                end
                ADDR_ACT_REG_I_DATA_15: begin
                    rdata <= int_act_reg_i[511:480];
                end
                ADDR_ACT_REG_I_DATA_16: begin
                    rdata <= int_act_reg_i[543:512];
                end
                ADDR_ACT_REG_I_DATA_17: begin
                    rdata <= int_act_reg_i[575:544];
                end
                ADDR_ACT_REG_I_DATA_18: begin
                    rdata <= int_act_reg_i[607:576];
                end
                ADDR_ACT_REG_I_DATA_19: begin
                    rdata <= int_act_reg_i[639:608];
                end
                ADDR_ACT_REG_I_DATA_20: begin
                    rdata <= int_act_reg_i[671:640];
                end
                ADDR_ACT_REG_I_DATA_21: begin
                    rdata <= int_act_reg_i[703:672];
                end
                ADDR_ACT_REG_I_DATA_22: begin
                    rdata <= int_act_reg_i[735:704];
                end
                ADDR_ACT_REG_I_DATA_23: begin
                    rdata <= int_act_reg_i[767:736];
                end
                ADDR_ACT_REG_I_DATA_24: begin
                    rdata <= int_act_reg_i[799:768];
                end
                ADDR_ACT_REG_I_DATA_25: begin
                    rdata <= int_act_reg_i[831:800];
                end
                ADDR_ACT_REG_I_DATA_26: begin
                    rdata <= int_act_reg_i[863:832];
                end
                ADDR_ACT_REG_I_DATA_27: begin
                    rdata <= int_act_reg_i[895:864];
                end
                ADDR_ACT_REG_I_DATA_28: begin
                    rdata <= int_act_reg_i[927:896];
                end
                ADDR_ACT_REG_I_DATA_29: begin
                    rdata <= int_act_reg_i[959:928];
                end
                ADDR_ACT_REG_I_DATA_30: begin
                    rdata <= int_act_reg_i[991:960];
                end
                ADDR_ACT_REG_O_DATA_0: begin
                    rdata <= int_act_reg_o[31:0];
                end
                ADDR_ACT_REG_O_DATA_1: begin
                    rdata <= int_act_reg_o[63:32];
                end
                ADDR_ACT_REG_O_DATA_2: begin
                    rdata <= int_act_reg_o[95:64];
                end
                ADDR_ACT_REG_O_DATA_3: begin
                    rdata <= int_act_reg_o[127:96];
                end
                ADDR_ACT_REG_O_DATA_4: begin
                    rdata <= int_act_reg_o[159:128];
                end
                ADDR_ACT_REG_O_DATA_5: begin
                    rdata <= int_act_reg_o[191:160];
                end
                ADDR_ACT_REG_O_DATA_6: begin
                    rdata <= int_act_reg_o[223:192];
                end
                ADDR_ACT_REG_O_DATA_7: begin
                    rdata <= int_act_reg_o[255:224];
                end
                ADDR_ACT_REG_O_DATA_8: begin
                    rdata <= int_act_reg_o[287:256];
                end
                ADDR_ACT_REG_O_DATA_9: begin
                    rdata <= int_act_reg_o[319:288];
                end
                ADDR_ACT_REG_O_DATA_10: begin
                    rdata <= int_act_reg_o[351:320];
                end
                ADDR_ACT_REG_O_DATA_11: begin
                    rdata <= int_act_reg_o[383:352];
                end
                ADDR_ACT_REG_O_DATA_12: begin
                    rdata <= int_act_reg_o[415:384];
                end
                ADDR_ACT_REG_O_DATA_13: begin
                    rdata <= int_act_reg_o[447:416];
                end
                ADDR_ACT_REG_O_DATA_14: begin
                    rdata <= int_act_reg_o[479:448];
                end
                ADDR_ACT_REG_O_DATA_15: begin
                    rdata <= int_act_reg_o[511:480];
                end
                ADDR_ACT_REG_O_DATA_16: begin
                    rdata <= int_act_reg_o[543:512];
                end
                ADDR_ACT_REG_O_DATA_17: begin
                    rdata <= int_act_reg_o[575:544];
                end
                ADDR_ACT_REG_O_DATA_18: begin
                    rdata <= int_act_reg_o[607:576];
                end
                ADDR_ACT_REG_O_DATA_19: begin
                    rdata <= int_act_reg_o[639:608];
                end
                ADDR_ACT_REG_O_DATA_20: begin
                    rdata <= int_act_reg_o[671:640];
                end
                ADDR_ACT_REG_O_DATA_21: begin
                    rdata <= int_act_reg_o[703:672];
                end
                ADDR_ACT_REG_O_DATA_22: begin
                    rdata <= int_act_reg_o[735:704];
                end
                ADDR_ACT_REG_O_DATA_23: begin
                    rdata <= int_act_reg_o[767:736];
                end
                ADDR_ACT_REG_O_DATA_24: begin
                    rdata <= int_act_reg_o[799:768];
                end
                ADDR_ACT_REG_O_DATA_25: begin
                    rdata <= int_act_reg_o[831:800];
                end
                ADDR_ACT_REG_O_DATA_26: begin
                    rdata <= int_act_reg_o[863:832];
                end
                ADDR_ACT_REG_O_DATA_27: begin
                    rdata <= int_act_reg_o[895:864];
                end
                ADDR_ACT_REG_O_DATA_28: begin
                    rdata <= int_act_reg_o[927:896];
                end
                ADDR_ACT_REG_O_DATA_29: begin
                    rdata <= int_act_reg_o[959:928];
                end
                ADDR_ACT_REG_O_DATA_30: begin
                    rdata <= int_act_reg_o[991:960];
                end
                ADDR_ACT_REG_O_CTRL: begin
                    rdata[0] <= int_act_reg_o_ap_vld;
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign interrupt   = int_gie & (|int_isr);
assign ap_start    = int_ap_start;
assign din_gmem_V  = int_din_gmem_V;
assign dout_gmem_V = int_dout_gmem_V;
assign act_reg_i   = int_act_reg_i;
// int_ap_start
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_start <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0] && WDATA[0])
            int_ap_start <= 1'b1;
        else if (ap_ready)
            int_ap_start <= int_auto_restart; // clear on handshake/auto restart
    end
end

// int_ap_done
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_done <= 1'b0;
    else if (ACLK_EN) begin
        if (ap_done)
            int_ap_done <= 1'b1;
        else if (ar_hs && raddr == ADDR_AP_CTRL)
            int_ap_done <= 1'b0; // clear on read
    end
end

// int_ap_idle
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_idle <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_idle <= ap_idle;
    end
end

// int_ap_ready
always @(posedge ACLK) begin
    if (ARESET)
        int_ap_ready <= 1'b0;
    else if (ACLK_EN) begin
            int_ap_ready <= ap_ready;
    end
end

// int_auto_restart
always @(posedge ACLK) begin
    if (ARESET)
        int_auto_restart <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_AP_CTRL && WSTRB[0])
            int_auto_restart <=  WDATA[7];
    end
end

// int_gie
always @(posedge ACLK) begin
    if (ARESET)
        int_gie <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_GIE && WSTRB[0])
            int_gie <= WDATA[0];
    end
end

// int_ier
always @(posedge ACLK) begin
    if (ARESET)
        int_ier <= 1'b0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_IER && WSTRB[0])
            int_ier <= WDATA[1:0];
    end
end

// int_isr[0]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[0] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[0] & ap_done)
            int_isr[0] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[0] <= int_isr[0] ^ WDATA[0]; // toggle on write
    end
end

// int_isr[1]
always @(posedge ACLK) begin
    if (ARESET)
        int_isr[1] <= 1'b0;
    else if (ACLK_EN) begin
        if (int_ier[1] & ap_ready)
            int_isr[1] <= 1'b1;
        else if (w_hs && waddr == ADDR_ISR && WSTRB[0])
            int_isr[1] <= int_isr[1] ^ WDATA[1]; // toggle on write
    end
end

// int_din_gmem_V[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_din_gmem_V[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DIN_GMEM_V_DATA_0)
            int_din_gmem_V[31:0] <= (WDATA[31:0] & wmask) | (int_din_gmem_V[31:0] & ~wmask);
    end
end

// int_din_gmem_V[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_din_gmem_V[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DIN_GMEM_V_DATA_1)
            int_din_gmem_V[63:32] <= (WDATA[31:0] & wmask) | (int_din_gmem_V[63:32] & ~wmask);
    end
end

// int_dout_gmem_V[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_dout_gmem_V[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DOUT_GMEM_V_DATA_0)
            int_dout_gmem_V[31:0] <= (WDATA[31:0] & wmask) | (int_dout_gmem_V[31:0] & ~wmask);
    end
end

// int_dout_gmem_V[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_dout_gmem_V[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DOUT_GMEM_V_DATA_1)
            int_dout_gmem_V[63:32] <= (WDATA[31:0] & wmask) | (int_dout_gmem_V[63:32] & ~wmask);
    end
end

// int_act_reg_i[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_0)
            int_act_reg_i[31:0] <= (WDATA[31:0] & wmask) | (int_act_reg_i[31:0] & ~wmask);
    end
end

// int_act_reg_i[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_1)
            int_act_reg_i[63:32] <= (WDATA[31:0] & wmask) | (int_act_reg_i[63:32] & ~wmask);
    end
end

// int_act_reg_i[95:64]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[95:64] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_2)
            int_act_reg_i[95:64] <= (WDATA[31:0] & wmask) | (int_act_reg_i[95:64] & ~wmask);
    end
end

// int_act_reg_i[127:96]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[127:96] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_3)
            int_act_reg_i[127:96] <= (WDATA[31:0] & wmask) | (int_act_reg_i[127:96] & ~wmask);
    end
end

// int_act_reg_i[159:128]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[159:128] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_4)
            int_act_reg_i[159:128] <= (WDATA[31:0] & wmask) | (int_act_reg_i[159:128] & ~wmask);
    end
end

// int_act_reg_i[191:160]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[191:160] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_5)
            int_act_reg_i[191:160] <= (WDATA[31:0] & wmask) | (int_act_reg_i[191:160] & ~wmask);
    end
end

// int_act_reg_i[223:192]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[223:192] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_6)
            int_act_reg_i[223:192] <= (WDATA[31:0] & wmask) | (int_act_reg_i[223:192] & ~wmask);
    end
end

// int_act_reg_i[255:224]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[255:224] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_7)
            int_act_reg_i[255:224] <= (WDATA[31:0] & wmask) | (int_act_reg_i[255:224] & ~wmask);
    end
end

// int_act_reg_i[287:256]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[287:256] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_8)
            int_act_reg_i[287:256] <= (WDATA[31:0] & wmask) | (int_act_reg_i[287:256] & ~wmask);
    end
end

// int_act_reg_i[319:288]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[319:288] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_9)
            int_act_reg_i[319:288] <= (WDATA[31:0] & wmask) | (int_act_reg_i[319:288] & ~wmask);
    end
end

// int_act_reg_i[351:320]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[351:320] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_10)
            int_act_reg_i[351:320] <= (WDATA[31:0] & wmask) | (int_act_reg_i[351:320] & ~wmask);
    end
end

// int_act_reg_i[383:352]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[383:352] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_11)
            int_act_reg_i[383:352] <= (WDATA[31:0] & wmask) | (int_act_reg_i[383:352] & ~wmask);
    end
end

// int_act_reg_i[415:384]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[415:384] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_12)
            int_act_reg_i[415:384] <= (WDATA[31:0] & wmask) | (int_act_reg_i[415:384] & ~wmask);
    end
end

// int_act_reg_i[447:416]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[447:416] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_13)
            int_act_reg_i[447:416] <= (WDATA[31:0] & wmask) | (int_act_reg_i[447:416] & ~wmask);
    end
end

// int_act_reg_i[479:448]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[479:448] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_14)
            int_act_reg_i[479:448] <= (WDATA[31:0] & wmask) | (int_act_reg_i[479:448] & ~wmask);
    end
end

// int_act_reg_i[511:480]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[511:480] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_15)
            int_act_reg_i[511:480] <= (WDATA[31:0] & wmask) | (int_act_reg_i[511:480] & ~wmask);
    end
end

// int_act_reg_i[543:512]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[543:512] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_16)
            int_act_reg_i[543:512] <= (WDATA[31:0] & wmask) | (int_act_reg_i[543:512] & ~wmask);
    end
end

// int_act_reg_i[575:544]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[575:544] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_17)
            int_act_reg_i[575:544] <= (WDATA[31:0] & wmask) | (int_act_reg_i[575:544] & ~wmask);
    end
end

// int_act_reg_i[607:576]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[607:576] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_18)
            int_act_reg_i[607:576] <= (WDATA[31:0] & wmask) | (int_act_reg_i[607:576] & ~wmask);
    end
end

// int_act_reg_i[639:608]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[639:608] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_19)
            int_act_reg_i[639:608] <= (WDATA[31:0] & wmask) | (int_act_reg_i[639:608] & ~wmask);
    end
end

// int_act_reg_i[671:640]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[671:640] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_20)
            int_act_reg_i[671:640] <= (WDATA[31:0] & wmask) | (int_act_reg_i[671:640] & ~wmask);
    end
end

// int_act_reg_i[703:672]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[703:672] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_21)
            int_act_reg_i[703:672] <= (WDATA[31:0] & wmask) | (int_act_reg_i[703:672] & ~wmask);
    end
end

// int_act_reg_i[735:704]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[735:704] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_22)
            int_act_reg_i[735:704] <= (WDATA[31:0] & wmask) | (int_act_reg_i[735:704] & ~wmask);
    end
end

// int_act_reg_i[767:736]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[767:736] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_23)
            int_act_reg_i[767:736] <= (WDATA[31:0] & wmask) | (int_act_reg_i[767:736] & ~wmask);
    end
end

// int_act_reg_i[799:768]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[799:768] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_24)
            int_act_reg_i[799:768] <= (WDATA[31:0] & wmask) | (int_act_reg_i[799:768] & ~wmask);
    end
end

// int_act_reg_i[831:800]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[831:800] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_25)
            int_act_reg_i[831:800] <= (WDATA[31:0] & wmask) | (int_act_reg_i[831:800] & ~wmask);
    end
end

// int_act_reg_i[863:832]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[863:832] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_26)
            int_act_reg_i[863:832] <= (WDATA[31:0] & wmask) | (int_act_reg_i[863:832] & ~wmask);
    end
end

// int_act_reg_i[895:864]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[895:864] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_27)
            int_act_reg_i[895:864] <= (WDATA[31:0] & wmask) | (int_act_reg_i[895:864] & ~wmask);
    end
end

// int_act_reg_i[927:896]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[927:896] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_28)
            int_act_reg_i[927:896] <= (WDATA[31:0] & wmask) | (int_act_reg_i[927:896] & ~wmask);
    end
end

// int_act_reg_i[959:928]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[959:928] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_29)
            int_act_reg_i[959:928] <= (WDATA[31:0] & wmask) | (int_act_reg_i[959:928] & ~wmask);
    end
end

// int_act_reg_i[991:960]
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_i[991:960] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ACT_REG_I_DATA_30)
            int_act_reg_i[991:960] <= (WDATA[31:0] & wmask) | (int_act_reg_i[991:960] & ~wmask);
    end
end

// int_act_reg_o
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_o <= 0;
    else if (ACLK_EN) begin
        if (act_reg_o_ap_vld)
            int_act_reg_o <= act_reg_o;
    end
end

// int_act_reg_o_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_act_reg_o_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (act_reg_o_ap_vld)
            int_act_reg_o_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_ACT_REG_O_CTRL)
            int_act_reg_o_ap_vld <= 1'b0; // clear on read
    end
end


//------------------------Memory logic-------------------

endmodule
