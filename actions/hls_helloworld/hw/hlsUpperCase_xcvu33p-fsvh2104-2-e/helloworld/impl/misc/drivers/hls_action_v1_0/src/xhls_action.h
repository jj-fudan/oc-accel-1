// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XHLS_ACTION_H
#define XHLS_ACTION_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xhls_action_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
#else
typedef struct {
    u16 DeviceId;
    u32 Ctrl_reg_BaseAddress;
} XHls_action_Config;
#endif

typedef struct {
    u32 Ctrl_reg_BaseAddress;
    u32 IsReady;
} XHls_action;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
    u32 word_5;
    u32 word_6;
    u32 word_7;
    u32 word_8;
    u32 word_9;
    u32 word_10;
    u32 word_11;
    u32 word_12;
    u32 word_13;
    u32 word_14;
    u32 word_15;
    u32 word_16;
    u32 word_17;
    u32 word_18;
    u32 word_19;
    u32 word_20;
    u32 word_21;
    u32 word_22;
    u32 word_23;
    u32 word_24;
    u32 word_25;
    u32 word_26;
    u32 word_27;
    u32 word_28;
    u32 word_29;
    u32 word_30;
} XHls_action_Act_reg_i;

typedef struct {
    u32 word_0;
    u32 word_1;
    u32 word_2;
    u32 word_3;
    u32 word_4;
    u32 word_5;
    u32 word_6;
    u32 word_7;
    u32 word_8;
    u32 word_9;
    u32 word_10;
    u32 word_11;
    u32 word_12;
    u32 word_13;
    u32 word_14;
    u32 word_15;
    u32 word_16;
    u32 word_17;
    u32 word_18;
    u32 word_19;
    u32 word_20;
    u32 word_21;
    u32 word_22;
    u32 word_23;
    u32 word_24;
    u32 word_25;
    u32 word_26;
    u32 word_27;
    u32 word_28;
    u32 word_29;
    u32 word_30;
} XHls_action_Act_reg_o;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XHls_action_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XHls_action_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XHls_action_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XHls_action_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XHls_action_Initialize(XHls_action *InstancePtr, u16 DeviceId);
XHls_action_Config* XHls_action_LookupConfig(u16 DeviceId);
int XHls_action_CfgInitialize(XHls_action *InstancePtr, XHls_action_Config *ConfigPtr);
#else
int XHls_action_Initialize(XHls_action *InstancePtr, const char* InstanceName);
int XHls_action_Release(XHls_action *InstancePtr);
#endif

void XHls_action_Start(XHls_action *InstancePtr);
u32 XHls_action_IsDone(XHls_action *InstancePtr);
u32 XHls_action_IsIdle(XHls_action *InstancePtr);
u32 XHls_action_IsReady(XHls_action *InstancePtr);
void XHls_action_EnableAutoRestart(XHls_action *InstancePtr);
void XHls_action_DisableAutoRestart(XHls_action *InstancePtr);

void XHls_action_Set_din_gmem_V(XHls_action *InstancePtr, u64 Data);
u64 XHls_action_Get_din_gmem_V(XHls_action *InstancePtr);
void XHls_action_Set_dout_gmem_V(XHls_action *InstancePtr, u64 Data);
u64 XHls_action_Get_dout_gmem_V(XHls_action *InstancePtr);
void XHls_action_Set_act_reg_i(XHls_action *InstancePtr, XHls_action_Act_reg_i Data);
XHls_action_Act_reg_i XHls_action_Get_act_reg_i(XHls_action *InstancePtr);
XHls_action_Act_reg_o XHls_action_Get_act_reg_o(XHls_action *InstancePtr);
u32 XHls_action_Get_act_reg_o_vld(XHls_action *InstancePtr);

void XHls_action_InterruptGlobalEnable(XHls_action *InstancePtr);
void XHls_action_InterruptGlobalDisable(XHls_action *InstancePtr);
void XHls_action_InterruptEnable(XHls_action *InstancePtr, u32 Mask);
void XHls_action_InterruptDisable(XHls_action *InstancePtr, u32 Mask);
void XHls_action_InterruptClear(XHls_action *InstancePtr, u32 Mask);
u32 XHls_action_InterruptGetEnabled(XHls_action *InstancePtr);
u32 XHls_action_InterruptGetStatus(XHls_action *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
