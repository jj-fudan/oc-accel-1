// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xhls_action.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XHls_action_CfgInitialize(XHls_action *InstancePtr, XHls_action_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Ctrl_reg_BaseAddress = ConfigPtr->Ctrl_reg_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XHls_action_Start(XHls_action *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_AP_CTRL) & 0x80;
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_AP_CTRL, Data | 0x01);
}

u32 XHls_action_IsDone(XHls_action *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XHls_action_IsIdle(XHls_action *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XHls_action_IsReady(XHls_action *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XHls_action_EnableAutoRestart(XHls_action *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_AP_CTRL, 0x80);
}

void XHls_action_DisableAutoRestart(XHls_action *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_AP_CTRL, 0);
}

void XHls_action_Set_din_gmem_V(XHls_action *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_DIN_GMEM_V_DATA, (u32)(Data));
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_DIN_GMEM_V_DATA + 4, (u32)(Data >> 32));
}

u64 XHls_action_Get_din_gmem_V(XHls_action *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_DIN_GMEM_V_DATA);
    Data += (u64)XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_DIN_GMEM_V_DATA + 4) << 32;
    return Data;
}

void XHls_action_Set_dout_gmem_V(XHls_action *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_DOUT_GMEM_V_DATA, (u32)(Data));
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_DOUT_GMEM_V_DATA + 4, (u32)(Data >> 32));
}

u64 XHls_action_Get_dout_gmem_V(XHls_action *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_DOUT_GMEM_V_DATA);
    Data += (u64)XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_DOUT_GMEM_V_DATA + 4) << 32;
    return Data;
}

void XHls_action_Set_act_reg_i(XHls_action *InstancePtr, XHls_action_Act_reg_i Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 0, Data.word_0);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 4, Data.word_1);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 8, Data.word_2);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 12, Data.word_3);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 16, Data.word_4);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 20, Data.word_5);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 24, Data.word_6);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 28, Data.word_7);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 32, Data.word_8);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 36, Data.word_9);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 40, Data.word_10);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 44, Data.word_11);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 48, Data.word_12);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 52, Data.word_13);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 56, Data.word_14);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 60, Data.word_15);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 64, Data.word_16);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 68, Data.word_17);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 72, Data.word_18);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 76, Data.word_19);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 80, Data.word_20);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 84, Data.word_21);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 88, Data.word_22);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 92, Data.word_23);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 96, Data.word_24);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 100, Data.word_25);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 104, Data.word_26);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 108, Data.word_27);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 112, Data.word_28);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 116, Data.word_29);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 120, Data.word_30);
}

XHls_action_Act_reg_i XHls_action_Get_act_reg_i(XHls_action *InstancePtr) {
    XHls_action_Act_reg_i Data;

    Data.word_0 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 0);
    Data.word_1 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 4);
    Data.word_2 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 8);
    Data.word_3 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 12);
    Data.word_4 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 16);
    Data.word_5 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 20);
    Data.word_6 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 24);
    Data.word_7 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 28);
    Data.word_8 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 32);
    Data.word_9 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 36);
    Data.word_10 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 40);
    Data.word_11 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 44);
    Data.word_12 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 48);
    Data.word_13 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 52);
    Data.word_14 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 56);
    Data.word_15 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 60);
    Data.word_16 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 64);
    Data.word_17 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 68);
    Data.word_18 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 72);
    Data.word_19 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 76);
    Data.word_20 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 80);
    Data.word_21 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 84);
    Data.word_22 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 88);
    Data.word_23 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 92);
    Data.word_24 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 96);
    Data.word_25 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 100);
    Data.word_26 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 104);
    Data.word_27 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 108);
    Data.word_28 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 112);
    Data.word_29 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 116);
    Data.word_30 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_I_DATA + 120);
    return Data;
}

XHls_action_Act_reg_o XHls_action_Get_act_reg_o(XHls_action *InstancePtr) {
    XHls_action_Act_reg_o Data;

    Data.word_0 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 0);
    Data.word_1 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 4);
    Data.word_2 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 8);
    Data.word_3 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 12);
    Data.word_4 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 16);
    Data.word_5 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 20);
    Data.word_6 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 24);
    Data.word_7 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 28);
    Data.word_8 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 32);
    Data.word_9 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 36);
    Data.word_10 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 40);
    Data.word_11 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 44);
    Data.word_12 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 48);
    Data.word_13 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 52);
    Data.word_14 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 56);
    Data.word_15 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 60);
    Data.word_16 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 64);
    Data.word_17 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 68);
    Data.word_18 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 72);
    Data.word_19 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 76);
    Data.word_20 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 80);
    Data.word_21 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 84);
    Data.word_22 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 88);
    Data.word_23 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 92);
    Data.word_24 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 96);
    Data.word_25 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 100);
    Data.word_26 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 104);
    Data.word_27 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 108);
    Data.word_28 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 112);
    Data.word_29 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 116);
    Data.word_30 = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_DATA + 120);
    return Data;
}

u32 XHls_action_Get_act_reg_o_vld(XHls_action *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ACT_REG_O_CTRL);
    return Data & 0x1;
}

void XHls_action_InterruptGlobalEnable(XHls_action *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_GIE, 1);
}

void XHls_action_InterruptGlobalDisable(XHls_action *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_GIE, 0);
}

void XHls_action_InterruptEnable(XHls_action *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_IER);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_IER, Register | Mask);
}

void XHls_action_InterruptDisable(XHls_action *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_IER);
    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_IER, Register & (~Mask));
}

void XHls_action_InterruptClear(XHls_action *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XHls_action_WriteReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ISR, Mask);
}

u32 XHls_action_InterruptGetEnabled(XHls_action *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_IER);
}

u32 XHls_action_InterruptGetStatus(XHls_action *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XHls_action_ReadReg(InstancePtr->Ctrl_reg_BaseAddress, XHLS_ACTION_CTRL_REG_ADDR_ISR);
}
