// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
// ctrl_reg
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

#define XHLS_ACTION_CTRL_REG_ADDR_AP_CTRL          0x000
#define XHLS_ACTION_CTRL_REG_ADDR_GIE              0x004
#define XHLS_ACTION_CTRL_REG_ADDR_IER              0x008
#define XHLS_ACTION_CTRL_REG_ADDR_ISR              0x00c
#define XHLS_ACTION_CTRL_REG_ADDR_DIN_GMEM_V_DATA  0x030
#define XHLS_ACTION_CTRL_REG_BITS_DIN_GMEM_V_DATA  64
#define XHLS_ACTION_CTRL_REG_ADDR_DOUT_GMEM_V_DATA 0x040
#define XHLS_ACTION_CTRL_REG_BITS_DOUT_GMEM_V_DATA 64
#define XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA   0x100
#define XHLS_ACTION_CTRL_REG_BITS_ACT_REG_I_DATA   992
#define XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA_  0x128
#define XHLS_ACTION_CTRL_REG_BITS_ACT_REG_I_DATA   992
#define XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA   0x180
#define XHLS_ACTION_CTRL_REG_BITS_ACT_REG_O_DATA   992
#define XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA_  0x1a8
#define XHLS_ACTION_CTRL_REG_BITS_ACT_REG_O_DATA   992
#define XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_CTRL   0x1fc

