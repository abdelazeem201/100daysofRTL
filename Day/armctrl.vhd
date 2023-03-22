

library ieee;
use ieee.std_logic_1164.all;
use work.armpmodel.all;
use work.armdecode.all;

-- PREFIX: act_xxx
package armctrl is

-- Check insn condition
function act_checkcond(
  cpsr  : in  apm_cpsr;
  cond  : in std_logic_vector(3 downto 0)
) return std_logic;


end armctrl;

package body armctrl is

function act_checkcond(
  cpsr  : in  apm_cpsr;
  cond  : in std_logic_vector(3 downto 0)
) return std_logic is
variable tmp    : std_logic;
begin
  tmp := '0';
  case cond is
    when ADE_COND_EQ => tmp := cpsr.ex.z;
    when ADE_COND_NE => tmp := not cpsr.ex.z;
    when ADE_COND_CS => tmp := cpsr.ex.c;
    when ADE_COND_CC => tmp := not cpsr.ex.c;
    when ADE_COND_MI => tmp := cpsr.ex.n;
    when ADE_COND_PL => tmp := not cpsr.ex.n;
    when ADE_COND_VS => tmp := cpsr.ex.v;
    when ADE_COND_VC => tmp := not cpsr.ex.v;
    when ADE_COND_HI => tmp := cpsr.ex.c and (not cpsr.ex.z);
    when ADE_COND_LS => tmp := (not cpsr.ex.c) and cpsr.ex.z;
    when ADE_COND_GE => tmp := not (cpsr.ex.n xor cpsr.ex.v);
    when ADE_COND_LT => tmp := (cpsr.ex.n xor cpsr.ex.v);
    when ADE_COND_GT => tmp := (not cpsr.ex.z) and not (cpsr.ex.n xor cpsr.ex.v);
    when ADE_COND_LE => tmp := cpsr.ex.z or (cpsr.ex.n xor cpsr.ex.v);
    when ADE_COND_AL => tmp := '1';
    when ADE_COND_NV => tmp := '0';
    when others      => null;
  end case;
  return tmp;
end;

end armctrl;
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
 
   File /tmp/build_html/vhdl/arm/libs/armctrl.vhd 
used by /tmp/build_html/vhdl/arm/armiu_rsstg.vhd 
 
   Constant zero defined in /tmp/build_html/vhdl/sparc/pci_gr.vhd

constant zero : std_logic_vector(31 downto 0) := (others =>
 
   Type apm_excpsr defined in /tmp/build_html/vhdl/arm/libs/armpmodel.vhd

type apm_excpsr is record
   n      : std_logic;                  -- negative
   z      : std_logic;                  -- zero
   c      : std_logic;                  -- carry
   v      : std_logic;                  -- overflow
   -- extensions
   -- fext   : std_logic_vector(3 downto 0);  -- cpsr(27:24)
   -- xext   : std_logic_vector(7 downto 0);  -- cpsr(15:8)
   -- sext   : std_logic_vector(7 downto 0);  -- cpsr(23:16)
end record;
 
   Type apm_wrcpsr defined in /tmp/build_html/vhdl/arm/libs/armpmodel.vhd

type apm_wrcpsr is record
   i      : std_logic;                  -- [7] irq
   f      : std_logic;                  -- [6] fiq
   t      : std_logic;                  -- [5] thumb
   mode   : std_logic_vector(4 downto 0);
-- pragma translate_off
--   dbgmode  : aba_atyp_dbgpmode;       -- readable pmode for dbg
-- pragma translate_on
end record;
 
   Type apm_cpsr defined in /tmp/build_html/vhdl/arm/libs/armpmodel.vhd

type apm_cpsr is record
   ex : apm_excpsr;
   wr : apm_wrcpsr;
end record;
 
   Constant ADE_COND_EQ defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_EQ : std_logic_vector(3 downto 0) := "0000";
 
   Constant ADE_COND_NE defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_NE : std_logic_vector(3 downto 0) := "0001";
 
   Constant ADE_COND_CS defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_CS : std_logic_vector(3 downto 0) := "0010";
 
   Constant ADE_COND_CC defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_CC : std_logic_vector(3 downto 0) := "0011";
 
   Constant ADE_COND_MI defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_MI : std_logic_vector(3 downto 0) := "0100";
 
   Constant ADE_COND_PL defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_PL : std_logic_vector(3 downto 0) := "0101";
 
   Constant ADE_COND_VS defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_VS : std_logic_vector(3 downto 0) := "0110";
 
   Constant ADE_COND_VC defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_VC : std_logic_vector(3 downto 0) := "0111";
 
   Constant ADE_COND_HI defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_HI : std_logic_vector(3 downto 0) := "1000";
 
   Constant ADE_COND_LS defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_LS : std_logic_vector(3 downto 0) := "1001";
 
   Constant ADE_COND_GE defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_GE : std_logic_vector(3 downto 0) := "1010";
 
   Constant ADE_COND_LT defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_LT : std_logic_vector(3 downto 0) := "1011";
 
   Constant ADE_COND_GT defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_GT : std_logic_vector(3 downto 0) := "1100";
 
   Constant ADE_COND_LE defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_LE : std_logic_vector(3 downto 0) := "1101";
 
   Constant ADE_COND_AL defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_AL : std_logic_vector(3 downto 0) := "1110";
 
   Constant ADE_COND_NV defined in /tmp/build_html/vhdl/arm/libs/armdecode.vhd

constant ADE_COND_NV : std_logic_vector(3 downto 0) := "1111";
 
   Function act_checkcond defined in /tmp/build_html/vhdl/arm/libs/armctrl.vhd

function act_checkcond(
  cpsr  : in  apm_cpsr;
  cond  : in std_logic_vector(3 downto 0)
) return std_logic;


end armctrl;

package body armctrl is

function act_checkcond(
  cpsr  : in  apm_cpsr;
  cond  : in std_logic_vector(3 downto 0)
) return std_logic is
variable tmp    : std_logic;
begin
  tmp := '0';
  case cond is
    when ADE_COND_EQ => tmp := cpsr.ex.z;
    when ADE_COND_NE => tmp := not cpsr.ex.z;
    when ADE_COND_CS => tmp := cpsr.ex.c;
    when ADE_COND_CC => tmp := not cpsr.ex.c;
    when ADE_COND_MI => tmp := cpsr.ex.n;
    when ADE_COND_PL => tmp := not cpsr.ex.n;
    when ADE_COND_VS => tmp := cpsr.ex.v;
    when ADE_COND_VC => tmp := not cpsr.ex.v;
    when ADE_COND_HI => tmp := cpsr.ex.c and (not cpsr.ex.z);
    when ADE_COND_LS => tmp := (not cpsr.ex.c) and cpsr.ex.z;
    when ADE_COND_GE => tmp := not (cpsr.ex.n xor cpsr.ex.v);
    when ADE_COND_LT => tmp := (cpsr.ex.n xor cpsr.ex.v);
    when ADE_COND_GT => tmp := (not cpsr.ex.z) and not (cpsr.ex.n xor cpsr.ex.v);
    when ADE_COND_LE => tmp := cpsr.ex.z or (cpsr.ex.n xor cpsr.ex.v);
    when ADE_COND_AL => tmp := '1';
    when ADE_COND_NV => tmp := '0';
    when others      => null;
  end case;
  return tmp;
end;
 

--------------------------------------------------------------------------------


If you have question mail to: Konrad Eisele<eiselekd@web.de>, created: Wed Apr 14 13:07:33 WEDT 2004 ; 
This is part of the Core distribution 

 
*/