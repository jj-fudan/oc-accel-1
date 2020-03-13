-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity hls_action_ctrl_reg_s_axi is
generic (
    C_S_AXI_ADDR_WIDTH    : INTEGER := 9;
    C_S_AXI_DATA_WIDTH    : INTEGER := 32);
port (
    ACLK                  :in   STD_LOGIC;
    ARESET                :in   STD_LOGIC;
    ACLK_EN               :in   STD_LOGIC;
    AWADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    AWVALID               :in   STD_LOGIC;
    AWREADY               :out  STD_LOGIC;
    WDATA                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    WSTRB                 :in   STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH/8-1 downto 0);
    WVALID                :in   STD_LOGIC;
    WREADY                :out  STD_LOGIC;
    BRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    BVALID                :out  STD_LOGIC;
    BREADY                :in   STD_LOGIC;
    ARADDR                :in   STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH-1 downto 0);
    ARVALID               :in   STD_LOGIC;
    ARREADY               :out  STD_LOGIC;
    RDATA                 :out  STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
    RRESP                 :out  STD_LOGIC_VECTOR(1 downto 0);
    RVALID                :out  STD_LOGIC;
    RREADY                :in   STD_LOGIC;
    interrupt             :out  STD_LOGIC;
    din_gmem_V            :out  STD_LOGIC_VECTOR(63 downto 0);
    dout_gmem_V           :out  STD_LOGIC_VECTOR(63 downto 0);
    act_reg_i             :out  STD_LOGIC_VECTOR(991 downto 0);
    act_reg_o             :in   STD_LOGIC_VECTOR(991 downto 0);
    act_reg_o_ap_vld      :in   STD_LOGIC;
    ap_start              :out  STD_LOGIC;
    ap_done               :in   STD_LOGIC;
    ap_ready              :in   STD_LOGIC;
    ap_idle               :in   STD_LOGIC
);
end entity hls_action_ctrl_reg_s_axi;

-- ------------------------Address Info-------------------
-- 0x000 : Control signals
--         bit 0  - ap_start (Read/Write/COH)
--         bit 1  - ap_done (Read/COR)
--         bit 2  - ap_idle (Read)
--         bit 3  - ap_ready (Read)
--         bit 7  - auto_restart (Read/Write)
--         others - reserved
-- 0x004 : Global Interrupt Enable Register
--         bit 0  - Global Interrupt Enable (Read/Write)
--         others - reserved
-- 0x008 : IP Interrupt Enable Register (Read/Write)
--         bit 0  - Channel 0 (ap_done)
--         bit 1  - Channel 1 (ap_ready)
--         others - reserved
-- 0x00c : IP Interrupt Status Register (Read/TOW)
--         bit 0  - Channel 0 (ap_done)
--         bit 1  - Channel 1 (ap_ready)
--         others - reserved
-- 0x030 : Data signal of din_gmem_V
--         bit 31~0 - din_gmem_V[31:0] (Read/Write)
-- 0x034 : Data signal of din_gmem_V
--         bit 31~0 - din_gmem_V[63:32] (Read/Write)
-- 0x038 : reserved
-- 0x040 : Data signal of dout_gmem_V
--         bit 31~0 - dout_gmem_V[31:0] (Read/Write)
-- 0x044 : Data signal of dout_gmem_V
--         bit 31~0 - dout_gmem_V[63:32] (Read/Write)
-- 0x048 : reserved
-- 0x100 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[31:0] (Read/Write)
-- 0x104 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[63:32] (Read/Write)
-- 0x108 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[95:64] (Read/Write)
-- 0x10c : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[127:96] (Read/Write)
-- 0x110 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[159:128] (Read/Write)
-- 0x114 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[191:160] (Read/Write)
-- 0x118 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[223:192] (Read/Write)
-- 0x11c : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[255:224] (Read/Write)
-- 0x120 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[287:256] (Read/Write)
-- 0x124 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[319:288] (Read/Write)
-- 0x128 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[351:320] (Read/Write)
-- 0x12c : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[383:352] (Read/Write)
-- 0x130 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[415:384] (Read/Write)
-- 0x134 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[447:416] (Read/Write)
-- 0x138 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[479:448] (Read/Write)
-- 0x13c : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[511:480] (Read/Write)
-- 0x140 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[543:512] (Read/Write)
-- 0x144 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[575:544] (Read/Write)
-- 0x148 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[607:576] (Read/Write)
-- 0x14c : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[639:608] (Read/Write)
-- 0x150 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[671:640] (Read/Write)
-- 0x154 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[703:672] (Read/Write)
-- 0x158 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[735:704] (Read/Write)
-- 0x15c : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[767:736] (Read/Write)
-- 0x160 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[799:768] (Read/Write)
-- 0x164 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[831:800] (Read/Write)
-- 0x168 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[863:832] (Read/Write)
-- 0x16c : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[895:864] (Read/Write)
-- 0x170 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[927:896] (Read/Write)
-- 0x174 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[959:928] (Read/Write)
-- 0x178 : Data signal of act_reg_i
--         bit 31~0 - act_reg_i[991:960] (Read/Write)
-- 0x17c : reserved
-- 0x180 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[31:0] (Read)
-- 0x184 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[63:32] (Read)
-- 0x188 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[95:64] (Read)
-- 0x18c : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[127:96] (Read)
-- 0x190 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[159:128] (Read)
-- 0x194 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[191:160] (Read)
-- 0x198 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[223:192] (Read)
-- 0x19c : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[255:224] (Read)
-- 0x1a0 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[287:256] (Read)
-- 0x1a4 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[319:288] (Read)
-- 0x1a8 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[351:320] (Read)
-- 0x1ac : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[383:352] (Read)
-- 0x1b0 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[415:384] (Read)
-- 0x1b4 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[447:416] (Read)
-- 0x1b8 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[479:448] (Read)
-- 0x1bc : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[511:480] (Read)
-- 0x1c0 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[543:512] (Read)
-- 0x1c4 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[575:544] (Read)
-- 0x1c8 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[607:576] (Read)
-- 0x1cc : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[639:608] (Read)
-- 0x1d0 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[671:640] (Read)
-- 0x1d4 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[703:672] (Read)
-- 0x1d8 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[735:704] (Read)
-- 0x1dc : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[767:736] (Read)
-- 0x1e0 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[799:768] (Read)
-- 0x1e4 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[831:800] (Read)
-- 0x1e8 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[863:832] (Read)
-- 0x1ec : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[895:864] (Read)
-- 0x1f0 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[927:896] (Read)
-- 0x1f4 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[959:928] (Read)
-- 0x1f8 : Data signal of act_reg_o
--         bit 31~0 - act_reg_o[991:960] (Read)
-- 0x1fc : Control signal of act_reg_o
--         bit 0  - act_reg_o_ap_vld (Read/COR)
--         others - reserved
-- (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

architecture behave of hls_action_ctrl_reg_s_axi is
    type states is (wridle, wrdata, wrresp, wrreset, rdidle, rddata, rdreset);  -- read and write fsm states
    signal wstate  : states := wrreset;
    signal rstate  : states := rdreset;
    signal wnext, rnext: states;
    constant ADDR_AP_CTRL            : INTEGER := 16#000#;
    constant ADDR_GIE                : INTEGER := 16#004#;
    constant ADDR_IER                : INTEGER := 16#008#;
    constant ADDR_ISR                : INTEGER := 16#00c#;
    constant ADDR_DIN_GMEM_V_DATA_0  : INTEGER := 16#030#;
    constant ADDR_DIN_GMEM_V_DATA_1  : INTEGER := 16#034#;
    constant ADDR_DIN_GMEM_V_CTRL    : INTEGER := 16#038#;
    constant ADDR_DOUT_GMEM_V_DATA_0 : INTEGER := 16#040#;
    constant ADDR_DOUT_GMEM_V_DATA_1 : INTEGER := 16#044#;
    constant ADDR_DOUT_GMEM_V_CTRL   : INTEGER := 16#048#;
    constant ADDR_ACT_REG_I_DATA_0   : INTEGER := 16#100#;
    constant ADDR_ACT_REG_I_DATA_1   : INTEGER := 16#104#;
    constant ADDR_ACT_REG_I_DATA_2   : INTEGER := 16#108#;
    constant ADDR_ACT_REG_I_DATA_3   : INTEGER := 16#10c#;
    constant ADDR_ACT_REG_I_DATA_4   : INTEGER := 16#110#;
    constant ADDR_ACT_REG_I_DATA_5   : INTEGER := 16#114#;
    constant ADDR_ACT_REG_I_DATA_6   : INTEGER := 16#118#;
    constant ADDR_ACT_REG_I_DATA_7   : INTEGER := 16#11c#;
    constant ADDR_ACT_REG_I_DATA_8   : INTEGER := 16#120#;
    constant ADDR_ACT_REG_I_DATA_9   : INTEGER := 16#124#;
    constant ADDR_ACT_REG_I_DATA_10  : INTEGER := 16#128#;
    constant ADDR_ACT_REG_I_DATA_11  : INTEGER := 16#12c#;
    constant ADDR_ACT_REG_I_DATA_12  : INTEGER := 16#130#;
    constant ADDR_ACT_REG_I_DATA_13  : INTEGER := 16#134#;
    constant ADDR_ACT_REG_I_DATA_14  : INTEGER := 16#138#;
    constant ADDR_ACT_REG_I_DATA_15  : INTEGER := 16#13c#;
    constant ADDR_ACT_REG_I_DATA_16  : INTEGER := 16#140#;
    constant ADDR_ACT_REG_I_DATA_17  : INTEGER := 16#144#;
    constant ADDR_ACT_REG_I_DATA_18  : INTEGER := 16#148#;
    constant ADDR_ACT_REG_I_DATA_19  : INTEGER := 16#14c#;
    constant ADDR_ACT_REG_I_DATA_20  : INTEGER := 16#150#;
    constant ADDR_ACT_REG_I_DATA_21  : INTEGER := 16#154#;
    constant ADDR_ACT_REG_I_DATA_22  : INTEGER := 16#158#;
    constant ADDR_ACT_REG_I_DATA_23  : INTEGER := 16#15c#;
    constant ADDR_ACT_REG_I_DATA_24  : INTEGER := 16#160#;
    constant ADDR_ACT_REG_I_DATA_25  : INTEGER := 16#164#;
    constant ADDR_ACT_REG_I_DATA_26  : INTEGER := 16#168#;
    constant ADDR_ACT_REG_I_DATA_27  : INTEGER := 16#16c#;
    constant ADDR_ACT_REG_I_DATA_28  : INTEGER := 16#170#;
    constant ADDR_ACT_REG_I_DATA_29  : INTEGER := 16#174#;
    constant ADDR_ACT_REG_I_DATA_30  : INTEGER := 16#178#;
    constant ADDR_ACT_REG_I_CTRL     : INTEGER := 16#17c#;
    constant ADDR_ACT_REG_O_DATA_0   : INTEGER := 16#180#;
    constant ADDR_ACT_REG_O_DATA_1   : INTEGER := 16#184#;
    constant ADDR_ACT_REG_O_DATA_2   : INTEGER := 16#188#;
    constant ADDR_ACT_REG_O_DATA_3   : INTEGER := 16#18c#;
    constant ADDR_ACT_REG_O_DATA_4   : INTEGER := 16#190#;
    constant ADDR_ACT_REG_O_DATA_5   : INTEGER := 16#194#;
    constant ADDR_ACT_REG_O_DATA_6   : INTEGER := 16#198#;
    constant ADDR_ACT_REG_O_DATA_7   : INTEGER := 16#19c#;
    constant ADDR_ACT_REG_O_DATA_8   : INTEGER := 16#1a0#;
    constant ADDR_ACT_REG_O_DATA_9   : INTEGER := 16#1a4#;
    constant ADDR_ACT_REG_O_DATA_10  : INTEGER := 16#1a8#;
    constant ADDR_ACT_REG_O_DATA_11  : INTEGER := 16#1ac#;
    constant ADDR_ACT_REG_O_DATA_12  : INTEGER := 16#1b0#;
    constant ADDR_ACT_REG_O_DATA_13  : INTEGER := 16#1b4#;
    constant ADDR_ACT_REG_O_DATA_14  : INTEGER := 16#1b8#;
    constant ADDR_ACT_REG_O_DATA_15  : INTEGER := 16#1bc#;
    constant ADDR_ACT_REG_O_DATA_16  : INTEGER := 16#1c0#;
    constant ADDR_ACT_REG_O_DATA_17  : INTEGER := 16#1c4#;
    constant ADDR_ACT_REG_O_DATA_18  : INTEGER := 16#1c8#;
    constant ADDR_ACT_REG_O_DATA_19  : INTEGER := 16#1cc#;
    constant ADDR_ACT_REG_O_DATA_20  : INTEGER := 16#1d0#;
    constant ADDR_ACT_REG_O_DATA_21  : INTEGER := 16#1d4#;
    constant ADDR_ACT_REG_O_DATA_22  : INTEGER := 16#1d8#;
    constant ADDR_ACT_REG_O_DATA_23  : INTEGER := 16#1dc#;
    constant ADDR_ACT_REG_O_DATA_24  : INTEGER := 16#1e0#;
    constant ADDR_ACT_REG_O_DATA_25  : INTEGER := 16#1e4#;
    constant ADDR_ACT_REG_O_DATA_26  : INTEGER := 16#1e8#;
    constant ADDR_ACT_REG_O_DATA_27  : INTEGER := 16#1ec#;
    constant ADDR_ACT_REG_O_DATA_28  : INTEGER := 16#1f0#;
    constant ADDR_ACT_REG_O_DATA_29  : INTEGER := 16#1f4#;
    constant ADDR_ACT_REG_O_DATA_30  : INTEGER := 16#1f8#;
    constant ADDR_ACT_REG_O_CTRL     : INTEGER := 16#1fc#;
    constant ADDR_BITS         : INTEGER := 9;

    signal waddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal wmask               : UNSIGNED(31 downto 0);
    signal aw_hs               : STD_LOGIC;
    signal w_hs                : STD_LOGIC;
    signal rdata_data          : UNSIGNED(31 downto 0);
    signal ar_hs               : STD_LOGIC;
    signal raddr               : UNSIGNED(ADDR_BITS-1 downto 0);
    signal AWREADY_t           : STD_LOGIC;
    signal WREADY_t            : STD_LOGIC;
    signal ARREADY_t           : STD_LOGIC;
    signal RVALID_t            : STD_LOGIC;
    -- internal registers
    signal int_ap_idle         : STD_LOGIC;
    signal int_ap_ready        : STD_LOGIC;
    signal int_ap_done         : STD_LOGIC := '0';
    signal int_ap_start        : STD_LOGIC := '0';
    signal int_auto_restart    : STD_LOGIC := '0';
    signal int_gie             : STD_LOGIC := '0';
    signal int_ier             : UNSIGNED(1 downto 0) := (others => '0');
    signal int_isr             : UNSIGNED(1 downto 0) := (others => '0');
    signal int_din_gmem_V      : UNSIGNED(63 downto 0) := (others => '0');
    signal int_dout_gmem_V     : UNSIGNED(63 downto 0) := (others => '0');
    signal int_act_reg_i       : UNSIGNED(991 downto 0) := (others => '0');
    signal int_act_reg_o       : UNSIGNED(991 downto 0) := (others => '0');
    signal int_act_reg_o_ap_vld : STD_LOGIC;


begin
-- ----------------------- Instantiation------------------

-- ----------------------- AXI WRITE ---------------------
    AWREADY_t <=  '1' when wstate = wridle else '0';
    AWREADY   <=  AWREADY_t;
    WREADY_t  <=  '1' when wstate = wrdata else '0';
    WREADY    <=  WREADY_t;
    BRESP     <=  "00";  -- OKAY
    BVALID    <=  '1' when wstate = wrresp else '0';
    wmask     <=  (31 downto 24 => WSTRB(3), 23 downto 16 => WSTRB(2), 15 downto 8 => WSTRB(1), 7 downto 0 => WSTRB(0));
    aw_hs     <=  AWVALID and AWREADY_t;
    w_hs      <=  WVALID and WREADY_t;

    -- write FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                wstate <= wrreset;
            elsif (ACLK_EN = '1') then
                wstate <= wnext;
            end if;
        end if;
    end process;

    process (wstate, AWVALID, WVALID, BREADY)
    begin
        case (wstate) is
        when wridle =>
            if (AWVALID = '1') then
                wnext <= wrdata;
            else
                wnext <= wridle;
            end if;
        when wrdata =>
            if (WVALID = '1') then
                wnext <= wrresp;
            else
                wnext <= wrdata;
            end if;
        when wrresp =>
            if (BREADY = '1') then
                wnext <= wridle;
            else
                wnext <= wrresp;
            end if;
        when others =>
            wnext <= wridle;
        end case;
    end process;

    waddr_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (aw_hs = '1') then
                    waddr <= UNSIGNED(AWADDR(ADDR_BITS-1 downto 0));
                end if;
            end if;
        end if;
    end process;

-- ----------------------- AXI READ ----------------------
    ARREADY_t <= '1' when (rstate = rdidle) else '0';
    ARREADY <= ARREADY_t;
    RDATA   <= STD_LOGIC_VECTOR(rdata_data);
    RRESP   <= "00";  -- OKAY
    RVALID_t  <= '1' when (rstate = rddata) else '0';
    RVALID    <= RVALID_t;
    ar_hs   <= ARVALID and ARREADY_t;
    raddr   <= UNSIGNED(ARADDR(ADDR_BITS-1 downto 0));

    -- read FSM
    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                rstate <= rdreset;
            elsif (ACLK_EN = '1') then
                rstate <= rnext;
            end if;
        end if;
    end process;

    process (rstate, ARVALID, RREADY, RVALID_t)
    begin
        case (rstate) is
        when rdidle =>
            if (ARVALID = '1') then
                rnext <= rddata;
            else
                rnext <= rdidle;
            end if;
        when rddata =>
            if (RREADY = '1' and RVALID_t = '1') then
                rnext <= rdidle;
            else
                rnext <= rddata;
            end if;
        when others =>
            rnext <= rdidle;
        end case;
    end process;

    rdata_proc : process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (ar_hs = '1') then
                    case (TO_INTEGER(raddr)) is
                    when ADDR_AP_CTRL =>
                        rdata_data <= (7 => int_auto_restart, 3 => int_ap_ready, 2 => int_ap_idle, 1 => int_ap_done, 0 => int_ap_start, others => '0');
                    when ADDR_GIE =>
                        rdata_data <= (0 => int_gie, others => '0');
                    when ADDR_IER =>
                        rdata_data <= (1 => int_ier(1), 0 => int_ier(0), others => '0');
                    when ADDR_ISR =>
                        rdata_data <= (1 => int_isr(1), 0 => int_isr(0), others => '0');
                    when ADDR_DIN_GMEM_V_DATA_0 =>
                        rdata_data <= RESIZE(int_din_gmem_V(31 downto 0), 32);
                    when ADDR_DIN_GMEM_V_DATA_1 =>
                        rdata_data <= RESIZE(int_din_gmem_V(63 downto 32), 32);
                    when ADDR_DOUT_GMEM_V_DATA_0 =>
                        rdata_data <= RESIZE(int_dout_gmem_V(31 downto 0), 32);
                    when ADDR_DOUT_GMEM_V_DATA_1 =>
                        rdata_data <= RESIZE(int_dout_gmem_V(63 downto 32), 32);
                    when ADDR_ACT_REG_I_DATA_0 =>
                        rdata_data <= RESIZE(int_act_reg_i(31 downto 0), 32);
                    when ADDR_ACT_REG_I_DATA_1 =>
                        rdata_data <= RESIZE(int_act_reg_i(63 downto 32), 32);
                    when ADDR_ACT_REG_I_DATA_2 =>
                        rdata_data <= RESIZE(int_act_reg_i(95 downto 64), 32);
                    when ADDR_ACT_REG_I_DATA_3 =>
                        rdata_data <= RESIZE(int_act_reg_i(127 downto 96), 32);
                    when ADDR_ACT_REG_I_DATA_4 =>
                        rdata_data <= RESIZE(int_act_reg_i(159 downto 128), 32);
                    when ADDR_ACT_REG_I_DATA_5 =>
                        rdata_data <= RESIZE(int_act_reg_i(191 downto 160), 32);
                    when ADDR_ACT_REG_I_DATA_6 =>
                        rdata_data <= RESIZE(int_act_reg_i(223 downto 192), 32);
                    when ADDR_ACT_REG_I_DATA_7 =>
                        rdata_data <= RESIZE(int_act_reg_i(255 downto 224), 32);
                    when ADDR_ACT_REG_I_DATA_8 =>
                        rdata_data <= RESIZE(int_act_reg_i(287 downto 256), 32);
                    when ADDR_ACT_REG_I_DATA_9 =>
                        rdata_data <= RESIZE(int_act_reg_i(319 downto 288), 32);
                    when ADDR_ACT_REG_I_DATA_10 =>
                        rdata_data <= RESIZE(int_act_reg_i(351 downto 320), 32);
                    when ADDR_ACT_REG_I_DATA_11 =>
                        rdata_data <= RESIZE(int_act_reg_i(383 downto 352), 32);
                    when ADDR_ACT_REG_I_DATA_12 =>
                        rdata_data <= RESIZE(int_act_reg_i(415 downto 384), 32);
                    when ADDR_ACT_REG_I_DATA_13 =>
                        rdata_data <= RESIZE(int_act_reg_i(447 downto 416), 32);
                    when ADDR_ACT_REG_I_DATA_14 =>
                        rdata_data <= RESIZE(int_act_reg_i(479 downto 448), 32);
                    when ADDR_ACT_REG_I_DATA_15 =>
                        rdata_data <= RESIZE(int_act_reg_i(511 downto 480), 32);
                    when ADDR_ACT_REG_I_DATA_16 =>
                        rdata_data <= RESIZE(int_act_reg_i(543 downto 512), 32);
                    when ADDR_ACT_REG_I_DATA_17 =>
                        rdata_data <= RESIZE(int_act_reg_i(575 downto 544), 32);
                    when ADDR_ACT_REG_I_DATA_18 =>
                        rdata_data <= RESIZE(int_act_reg_i(607 downto 576), 32);
                    when ADDR_ACT_REG_I_DATA_19 =>
                        rdata_data <= RESIZE(int_act_reg_i(639 downto 608), 32);
                    when ADDR_ACT_REG_I_DATA_20 =>
                        rdata_data <= RESIZE(int_act_reg_i(671 downto 640), 32);
                    when ADDR_ACT_REG_I_DATA_21 =>
                        rdata_data <= RESIZE(int_act_reg_i(703 downto 672), 32);
                    when ADDR_ACT_REG_I_DATA_22 =>
                        rdata_data <= RESIZE(int_act_reg_i(735 downto 704), 32);
                    when ADDR_ACT_REG_I_DATA_23 =>
                        rdata_data <= RESIZE(int_act_reg_i(767 downto 736), 32);
                    when ADDR_ACT_REG_I_DATA_24 =>
                        rdata_data <= RESIZE(int_act_reg_i(799 downto 768), 32);
                    when ADDR_ACT_REG_I_DATA_25 =>
                        rdata_data <= RESIZE(int_act_reg_i(831 downto 800), 32);
                    when ADDR_ACT_REG_I_DATA_26 =>
                        rdata_data <= RESIZE(int_act_reg_i(863 downto 832), 32);
                    when ADDR_ACT_REG_I_DATA_27 =>
                        rdata_data <= RESIZE(int_act_reg_i(895 downto 864), 32);
                    when ADDR_ACT_REG_I_DATA_28 =>
                        rdata_data <= RESIZE(int_act_reg_i(927 downto 896), 32);
                    when ADDR_ACT_REG_I_DATA_29 =>
                        rdata_data <= RESIZE(int_act_reg_i(959 downto 928), 32);
                    when ADDR_ACT_REG_I_DATA_30 =>
                        rdata_data <= RESIZE(int_act_reg_i(991 downto 960), 32);
                    when ADDR_ACT_REG_O_DATA_0 =>
                        rdata_data <= RESIZE(int_act_reg_o(31 downto 0), 32);
                    when ADDR_ACT_REG_O_DATA_1 =>
                        rdata_data <= RESIZE(int_act_reg_o(63 downto 32), 32);
                    when ADDR_ACT_REG_O_DATA_2 =>
                        rdata_data <= RESIZE(int_act_reg_o(95 downto 64), 32);
                    when ADDR_ACT_REG_O_DATA_3 =>
                        rdata_data <= RESIZE(int_act_reg_o(127 downto 96), 32);
                    when ADDR_ACT_REG_O_DATA_4 =>
                        rdata_data <= RESIZE(int_act_reg_o(159 downto 128), 32);
                    when ADDR_ACT_REG_O_DATA_5 =>
                        rdata_data <= RESIZE(int_act_reg_o(191 downto 160), 32);
                    when ADDR_ACT_REG_O_DATA_6 =>
                        rdata_data <= RESIZE(int_act_reg_o(223 downto 192), 32);
                    when ADDR_ACT_REG_O_DATA_7 =>
                        rdata_data <= RESIZE(int_act_reg_o(255 downto 224), 32);
                    when ADDR_ACT_REG_O_DATA_8 =>
                        rdata_data <= RESIZE(int_act_reg_o(287 downto 256), 32);
                    when ADDR_ACT_REG_O_DATA_9 =>
                        rdata_data <= RESIZE(int_act_reg_o(319 downto 288), 32);
                    when ADDR_ACT_REG_O_DATA_10 =>
                        rdata_data <= RESIZE(int_act_reg_o(351 downto 320), 32);
                    when ADDR_ACT_REG_O_DATA_11 =>
                        rdata_data <= RESIZE(int_act_reg_o(383 downto 352), 32);
                    when ADDR_ACT_REG_O_DATA_12 =>
                        rdata_data <= RESIZE(int_act_reg_o(415 downto 384), 32);
                    when ADDR_ACT_REG_O_DATA_13 =>
                        rdata_data <= RESIZE(int_act_reg_o(447 downto 416), 32);
                    when ADDR_ACT_REG_O_DATA_14 =>
                        rdata_data <= RESIZE(int_act_reg_o(479 downto 448), 32);
                    when ADDR_ACT_REG_O_DATA_15 =>
                        rdata_data <= RESIZE(int_act_reg_o(511 downto 480), 32);
                    when ADDR_ACT_REG_O_DATA_16 =>
                        rdata_data <= RESIZE(int_act_reg_o(543 downto 512), 32);
                    when ADDR_ACT_REG_O_DATA_17 =>
                        rdata_data <= RESIZE(int_act_reg_o(575 downto 544), 32);
                    when ADDR_ACT_REG_O_DATA_18 =>
                        rdata_data <= RESIZE(int_act_reg_o(607 downto 576), 32);
                    when ADDR_ACT_REG_O_DATA_19 =>
                        rdata_data <= RESIZE(int_act_reg_o(639 downto 608), 32);
                    when ADDR_ACT_REG_O_DATA_20 =>
                        rdata_data <= RESIZE(int_act_reg_o(671 downto 640), 32);
                    when ADDR_ACT_REG_O_DATA_21 =>
                        rdata_data <= RESIZE(int_act_reg_o(703 downto 672), 32);
                    when ADDR_ACT_REG_O_DATA_22 =>
                        rdata_data <= RESIZE(int_act_reg_o(735 downto 704), 32);
                    when ADDR_ACT_REG_O_DATA_23 =>
                        rdata_data <= RESIZE(int_act_reg_o(767 downto 736), 32);
                    when ADDR_ACT_REG_O_DATA_24 =>
                        rdata_data <= RESIZE(int_act_reg_o(799 downto 768), 32);
                    when ADDR_ACT_REG_O_DATA_25 =>
                        rdata_data <= RESIZE(int_act_reg_o(831 downto 800), 32);
                    when ADDR_ACT_REG_O_DATA_26 =>
                        rdata_data <= RESIZE(int_act_reg_o(863 downto 832), 32);
                    when ADDR_ACT_REG_O_DATA_27 =>
                        rdata_data <= RESIZE(int_act_reg_o(895 downto 864), 32);
                    when ADDR_ACT_REG_O_DATA_28 =>
                        rdata_data <= RESIZE(int_act_reg_o(927 downto 896), 32);
                    when ADDR_ACT_REG_O_DATA_29 =>
                        rdata_data <= RESIZE(int_act_reg_o(959 downto 928), 32);
                    when ADDR_ACT_REG_O_DATA_30 =>
                        rdata_data <= RESIZE(int_act_reg_o(991 downto 960), 32);
                    when ADDR_ACT_REG_O_CTRL =>
                        rdata_data <= (0 => int_act_reg_o_ap_vld, others => '0');
                    when others =>
                        rdata_data <= (others => '0');
                    end case;
                end if;
            end if;
        end if;
    end process;

-- ----------------------- Register logic ----------------
    interrupt            <= int_gie and (int_isr(0) or int_isr(1));
    ap_start             <= int_ap_start;
    din_gmem_V           <= STD_LOGIC_VECTOR(int_din_gmem_V);
    dout_gmem_V          <= STD_LOGIC_VECTOR(int_dout_gmem_V);
    act_reg_i            <= STD_LOGIC_VECTOR(int_act_reg_i);

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_start <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1' and WDATA(0) = '1') then
                    int_ap_start <= '1';
                elsif (ap_ready = '1') then
                    int_ap_start <= int_auto_restart; -- clear on handshake/auto restart
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_done <= '0';
            elsif (ACLK_EN = '1') then
                if (ap_done = '1') then
                    int_ap_done <= '1';
                elsif (ar_hs = '1' and raddr = ADDR_AP_CTRL) then
                    int_ap_done <= '0'; -- clear on read
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_idle <= '0';
            elsif (ACLK_EN = '1') then
                if (true) then
                    int_ap_idle <= ap_idle;
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ap_ready <= '0';
            elsif (ACLK_EN = '1') then
                if (true) then
                    int_ap_ready <= ap_ready;
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_auto_restart <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_AP_CTRL and WSTRB(0) = '1') then
                    int_auto_restart <= WDATA(7);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_gie <= '0';
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_GIE and WSTRB(0) = '1') then
                    int_gie <= WDATA(0);
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_ier <= "00";
            elsif (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_IER and WSTRB(0) = '1') then
                    int_ier <= UNSIGNED(WDATA(1 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_isr(0) <= '0';
            elsif (ACLK_EN = '1') then
                if (int_ier(0) = '1' and ap_done = '1') then
                    int_isr(0) <= '1';
                elsif (w_hs = '1' and waddr = ADDR_ISR and WSTRB(0) = '1') then
                    int_isr(0) <= int_isr(0) xor WDATA(0); -- toggle on write
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_isr(1) <= '0';
            elsif (ACLK_EN = '1') then
                if (int_ier(1) = '1' and ap_ready = '1') then
                    int_isr(1) <= '1';
                elsif (w_hs = '1' and waddr = ADDR_ISR and WSTRB(0) = '1') then
                    int_isr(1) <= int_isr(1) xor WDATA(1); -- toggle on write
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_DIN_GMEM_V_DATA_0) then
                    int_din_gmem_V(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_din_gmem_V(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_DIN_GMEM_V_DATA_1) then
                    int_din_gmem_V(63 downto 32) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_din_gmem_V(63 downto 32));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_DOUT_GMEM_V_DATA_0) then
                    int_dout_gmem_V(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_dout_gmem_V(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_DOUT_GMEM_V_DATA_1) then
                    int_dout_gmem_V(63 downto 32) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_dout_gmem_V(63 downto 32));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_0) then
                    int_act_reg_i(31 downto 0) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(31 downto 0));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_1) then
                    int_act_reg_i(63 downto 32) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(63 downto 32));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_2) then
                    int_act_reg_i(95 downto 64) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(95 downto 64));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_3) then
                    int_act_reg_i(127 downto 96) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(127 downto 96));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_4) then
                    int_act_reg_i(159 downto 128) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(159 downto 128));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_5) then
                    int_act_reg_i(191 downto 160) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(191 downto 160));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_6) then
                    int_act_reg_i(223 downto 192) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(223 downto 192));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_7) then
                    int_act_reg_i(255 downto 224) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(255 downto 224));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_8) then
                    int_act_reg_i(287 downto 256) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(287 downto 256));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_9) then
                    int_act_reg_i(319 downto 288) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(319 downto 288));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_10) then
                    int_act_reg_i(351 downto 320) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(351 downto 320));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_11) then
                    int_act_reg_i(383 downto 352) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(383 downto 352));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_12) then
                    int_act_reg_i(415 downto 384) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(415 downto 384));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_13) then
                    int_act_reg_i(447 downto 416) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(447 downto 416));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_14) then
                    int_act_reg_i(479 downto 448) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(479 downto 448));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_15) then
                    int_act_reg_i(511 downto 480) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(511 downto 480));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_16) then
                    int_act_reg_i(543 downto 512) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(543 downto 512));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_17) then
                    int_act_reg_i(575 downto 544) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(575 downto 544));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_18) then
                    int_act_reg_i(607 downto 576) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(607 downto 576));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_19) then
                    int_act_reg_i(639 downto 608) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(639 downto 608));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_20) then
                    int_act_reg_i(671 downto 640) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(671 downto 640));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_21) then
                    int_act_reg_i(703 downto 672) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(703 downto 672));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_22) then
                    int_act_reg_i(735 downto 704) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(735 downto 704));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_23) then
                    int_act_reg_i(767 downto 736) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(767 downto 736));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_24) then
                    int_act_reg_i(799 downto 768) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(799 downto 768));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_25) then
                    int_act_reg_i(831 downto 800) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(831 downto 800));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_26) then
                    int_act_reg_i(863 downto 832) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(863 downto 832));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_27) then
                    int_act_reg_i(895 downto 864) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(895 downto 864));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_28) then
                    int_act_reg_i(927 downto 896) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(927 downto 896));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_29) then
                    int_act_reg_i(959 downto 928) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(959 downto 928));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ACLK_EN = '1') then
                if (w_hs = '1' and waddr = ADDR_ACT_REG_I_DATA_30) then
                    int_act_reg_i(991 downto 960) <= (UNSIGNED(WDATA(31 downto 0)) and wmask(31 downto 0)) or ((not wmask(31 downto 0)) and int_act_reg_i(991 downto 960));
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_act_reg_o <= (others => '0');
            elsif (ACLK_EN = '1') then
                if (act_reg_o_ap_vld = '1') then
                    int_act_reg_o <= UNSIGNED(act_reg_o); -- clear on read
                end if;
            end if;
        end if;
    end process;

    process (ACLK)
    begin
        if (ACLK'event and ACLK = '1') then
            if (ARESET = '1') then
                int_act_reg_o_ap_vld <= '0';
            elsif (ACLK_EN = '1') then
                if (act_reg_o_ap_vld = '1') then
                    int_act_reg_o_ap_vld <= '1';
                elsif (ar_hs = '1' and raddr = ADDR_ACT_REG_O_CTRL) then
                    int_act_reg_o_ap_vld <= '0'; -- clear on read
                end if;
            end if;
        end if;
    end process;


-- ----------------------- Memory logic ------------------

end architecture behave;
