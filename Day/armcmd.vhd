

library ieee;
use ieee.std_logic_1164.all;
use work.armpmodel.all;
use work.armpctrl.all;
use work.armdecode.all;
use work.gendc_lib.all;

-- PREFIX: acm_xxx
package armcmd is
  
constant ACM_CNT_SZ    : integer := 5;
constant ACM_CNT_ZERO  : std_logic_vector(4 downto 0) := "00000";
constant ACM_CNT_ONE   : std_logic_vector(4 downto 0) := "00001";
constant ACM_CNT_TWO   : std_logic_vector(4 downto 0) := "00010";
constant ACM_CNT_THREE : std_logic_vector(4 downto 0) := "00011";

type acm_regsrc is (
  acm_none,
  acm_rrn,
  acm_rrm,
  acm_rrd,
  acm_rrs,
  acm_local
);

type acm_rdsrc is (
  acm_rdnone,
  acm_rdrrd,
  acm_rdrrn,
  acm_rdlocal,
  acm_rdpc,
  acm_rdlink
);

-- general cmd ctrlout
type acm_ctrlout is record
  nextinsn : std_logic;
  nextcnt  : std_logic;
  hold     : std_logic;     
end record;

-- general cmd ctrlin
type acm_ctrlin is record
  cnt   : std_logic_vector(ACM_CNT_SZ-1 downto 0);
  insn  : ade_insn;
  ctrlo : acm_ctrlout;                  -- preinitialized ctrlo
end record;

-------------------------------------------------------------------------------
-- pctrl for memory cmds

type acm_ctrlmemout is record
                       
  data1            : std_logic_vector(31 downto 0); -- immidiate 1 (pctrl.data1)
  data2            : std_logic_vector(31 downto 0); -- immidiate 2 (pctrl.data2)

  -- rrstg:
  r1_src    : acm_regsrc;  -- (micro.r1)
  r2_src    : acm_regsrc;  -- (micro.r2)
  rd_src    : acm_rdsrc;   -- (pctrl.wr.wrop_rd)
  
  -- rsstg: 
  rsop_op1_src     : apc_rsop_opsrc;    -- EXSTG operand1 source (pctrl.rs.rsop_op1_src)
  rsop_op2_src     : apc_rsop_opsrc;    -- EXSTG operand1 source (pctrl.rs.rsop_op2_src)
  rsop_buf1_src    : apc_rsop_bufsrc;   -- RSSTG buffer1 source (pctrl.rs.rsop_buf1_src)
  rsop_buf2_src    : apc_rsop_bufsrc;   -- RSSTG buffer2 source (pctrl.rs.rsop_buf2_src)
  
  -- exstg:
  exop_data_src : apc_exop_datasrc;  -- EXSTG pctrl.data1 source (pctrl.ex.data_src)
  exop_buf_src  : apc_exop_bufsrc;   -- ESSTG buffer source (pctl.ex.exop_buf_src)
  
  -- mestg:
  meop_param  : gdcl_param;  -- (pctl.me.meop_param)
  meop_enable : std_logic;   -- (pctl.me.meop_enable)
  
end record;

-- Init pctlr with acm_ctrlmemout
procedure acm_initmempctrl (
  pctrl : inout apc_pctrl;
  r1_src    : inout acm_regsrc;  -- (micro.r1)
  r2_src    : inout acm_regsrc;  -- (micro.r2)
  rd_src    : inout acm_rdsrc;   -- (pctrl.wr.wrop_rd)
  mem : in acm_ctrlmemout
);
  
-- general ldm stm control
type acm_ctrlmult_in is record
  ctrlmemo  : acm_ctrlmemout;
  ival  : std_logic_vector(31 downto 0);
  soff  : std_logic_vector(31 downto 0);
  eoff  : std_logic_vector(31 downto 0);
  reglist  : std_logic_vector(APM_REGLIST_SZ-1 downto 0);
  mem   : std_logic;                    -- mem still present in pipeline
  dabort   : std_logic;                    -- mem still present in pipeline
end record;


end armcmd;

package body armcmd is

procedure acm_initmempctrl (
  pctrl : inout apc_pctrl;
  r1_src    : inout acm_regsrc;  -- (micro.r1)
  r2_src    : inout acm_regsrc;  -- (micro.r2)
  rd_src    : inout acm_rdsrc;   -- (pctrl.wr.wrop_rd)
  mem : in acm_ctrlmemout
) is
begin

  pctrl.data1 := mem.data1; -- immidiate 1 
  pctrl.data2 := mem.data2; -- immidiate 2

  -- rrstg:
  r1_src := mem.r1_src;     -- (micro.r1)
  r2_src := mem.r2_src;     -- (micro.r2)
  rd_src := mem.rd_src;     -- (pctrl.wr.wrop_rd)
  
  -- rsstg: 
  pctrl.rs.rsop_op1_src := mem.rsop_op1_src;    -- EXSTG operand1 source 
  pctrl.rs.rsop_op2_src := mem.rsop_op2_src;    -- EXSTG operand1 source 
  pctrl.rs.rsop_buf1_src := mem.rsop_buf1_src;  -- RSSTG buffer1 source 
  pctrl.rs.rsop_buf2_src := mem.rsop_buf2_src;  -- RSSTG buffer2 source 
  
  -- exstg:
  pctrl.ex.exop_data_src := mem.exop_data_src;  -- EXSTG pctrl.data1 source 
  pctrl.ex.exop_buf_src := mem.exop_buf_src;    -- ESSTG buffer source      
  
  -- mestg:
  pctrl.me.meop_param := mem.meop_param; 
  pctrl.me.meop_enable:= mem.meop_enable; 

end;

end armcmd;


/*
   File /tmp/build_html/vhdl/arm/libs/armpmodel.vhd 
used by /tmp/build_html/vhdl/arm/libs/armdecode.vhd 
used by /tmp/build_html/vhdl/arm/libs/armpctrl.vhd 
used by /tmp/build_html/vhdl/arm/arm_comp.vhd 
used by /tmp/build_html/vhdl/arm/libs/armdebug.vhd 
used by /tmp/build_html/vhdl/arm/libs/armdebug.vhd 
used by /tmp/build_html/vhdl/arm/libs/armldst.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_al.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_bl.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_ld.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_st.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_lm.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sm.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sw.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cr.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cl.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cs.vhd 
used by /tmp/build_html/vhdl/arm/armiu_drstg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_rrstg.vhd 
used by /tmp/build_html/vhdl/arm/libs/armctrl.vhd 
used by /tmp/build_html/vhdl/arm/armiu_rsstg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_dmstg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_mestg.vhd 
 
   File /tmp/build_html/vhdl/arm/libs/armpctrl.vhd 
used by /tmp/build_html/vhdl/arm/arm_comp.vhd 
used by /tmp/build_html/vhdl/arm/libs/armcmd.vhd 
used by /tmp/build_html/vhdl/arm/libs/armldst.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_comp.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_al.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sr.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sr.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_bl.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_ld.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_st.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_lm.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sm.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sw.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cr.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cl.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cs.vhd 
used by /tmp/build_html/vhdl/arm/armiu_drstg.vhd 
used by /tmp/build_html/vhdl/arm/libs/armctrl.vhd 
used by /tmp/build_html/vhdl/arm/armiu_rsstg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_exstg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_dmstg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_mestg.vhd 
used by /tmp/build_html/vhdl/arm/cp/armcp_sctrl.vhd 
used by /tmp/build_html/soft/doc/test/.config.vhd 
 
   File /tmp/build_html/vhdl/arm/libs/armdecode.vhd 
used by /tmp/build_html/vhdl/arm/libs/armpctrl.vhd 
used by /tmp/build_html/vhdl/arm/arm_comp.vhd 
used by /tmp/build_html/vhdl/arm/armiu_festg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_destg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_destg.vhd 
used by /tmp/build_html/vhdl/arm/libs/armdebug.vhd 
used by /tmp/build_html/vhdl/arm/libs/armldst.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_comp.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_al.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sr.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_bl.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_ld.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_st.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_lm.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sm.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sw.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cr.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cs.vhd 
used by /tmp/build_html/vhdl/arm/armiu_drstg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_rrstg.vhd 
used by /tmp/build_html/vhdl/arm/libs/armctrl.vhd 
used by /tmp/build_html/vhdl/arm/armiu_rsstg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_dmstg.vhd 
used by /tmp/build_html/vhdl/arm/armiu_mestg.vhd 
 
   File /tmp/build_html/vhdl/mem/cache/libs/gendc_lib.vhd 
used by /tmp/build_html/vhdl/mem/cache/cache_comp.vhd 
used by /tmp/build_html/vhdl/mem/cache/gencmem.vhd 
used by /tmp/build_html/vhdl/mem/cache/gendc.vhd 
used by /tmp/build_html/vhdl/arm/armcache.vhd 
used by /tmp/build_html/vhdl/arm/libs/armpctrl.vhd 
used by /tmp/build_html/vhdl/arm/libs/armcmd.vhd 
used by /tmp/build_html/vhdl/arm/libs/armldst.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_comp.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_ld.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_st.vhd 
used by /tmp/build_html/soft/doc/test/.config.vhd 
 
   File /tmp/build_html/vhdl/arm/libs/armcmd.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_comp.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_al.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sr.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_bl.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_ld.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_st.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_lm.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_lm.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sm.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_sw.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cl.vhd 
used by /tmp/build_html/vhdl/arm/armcmd_cl.vhd 
used by /tmp/build_html/vhdl/arm/armiu_drstg.vhd 
 
   Constant ACM_CNT_SZ defined in /tmp/build_html/vhdl/arm/libs/armcmd.vhd

constant ACM_CNT_SZ    : integer := 5;
 
   Constant ACM_CNT_ZERO defined in /tmp/build_html/vhdl/arm/libs/armcmd.vhd

constant ACM_CNT_ZERO  : std_logic_vector(4 downto 0) := "00000";
 
   Constant ACM_CNT_ONE defined in /tmp/build_html/vhdl/arm/libs/armcmd.vhd

constant ACM_CNT_ONE   : std_logic_vector(4 downto 0) := "00001";
 
   Constant ACM_CNT_TWO defined in /tmp/build_html/vhdl/arm/libs/armcmd.vhd

constant ACM_CNT_TWO   : std_logic_vector(4 downto 0) := "00010";
 
   Constant ACM_CNT_THREE defined in /tmp/build_html/vhdl/arm/libs/armcmd.vhd

constant ACM_CNT_THREE : std_logic_vector(4 downto 0) := "00011";
 
   Enum acm_regsrc defined in /tmp/build_html/vhdl/arm/libs/armcmd.vhd

type acm_regsrc is (
  acm_none,
  acm_rrn,
  acm_rrm,
  acm_rrd,
  acm_rrs,
  acm_local
);
 
   Enum acm_rdsrc defined in /tmp/build_html/vhdl/arm/libs/armcmd.vhd

type acm_rdsrc is (
  acm_rdnone,
  acm_rdrrd,
  acm_rdrrn,
  acm_rdlocal,
  acm_rdpc,
  acm_rdlink
);
 
 */
