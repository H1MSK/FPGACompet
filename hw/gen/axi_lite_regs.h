/*
 * 
 * Reg Interface C-Header [AUTOGENERATE by SpinalHDL]
 */

#ifndef axi_lite_regs_REGIF_H
#define axi_lite_regs_REGIF_H

#define IP_M_CTRL      0x0000
#define IP_M_CTRL_F_START_SHIFT      0
#define IP_M_CTRL_F_START_MASK       0x00000001 /* f_start, WS, 1 bit */
#define IP_M_STAT      0x0004
#define IP_M_STAT_F_DONE_SHIFT       0
#define IP_M_STAT_F_DONE_MASK        0x00000001 /* f_done, RC, 1 bit */
#define IP_M_THRES_0   0x0080
#define IP_M_THRES_0_$ANONFUN_SHIFT  0
#define IP_M_THRES_0_$ANONFUN_MASK   0x000000ff /* $anonfun, RW, 8 bit */
#define IP_M_THRES_1   0x0084
#define IP_M_THRES_1_$ANONFUN_SHIFT  0
#define IP_M_THRES_1_$ANONFUN_MASK   0x000000ff /* $anonfun, RW, 8 bit */
#define IP_M_COEFF_0   0x0100
#define IP_M_COEFF_0_$ANONFUN_SHIFT  0
#define IP_M_COEFF_0_$ANONFUN_MASK   0x000000ff /* $anonfun, RW, 8 bit */
#define IP_M_COEFF_1   0x0104
#define IP_M_COEFF_1_$ANONFUN_SHIFT  0
#define IP_M_COEFF_1_$ANONFUN_MASK   0x000000ff /* $anonfun, RW, 8 bit */
#define IP_M_COEFF_2   0x0108
#define IP_M_COEFF_2_$ANONFUN_SHIFT  0
#define IP_M_COEFF_2_$ANONFUN_MASK   0x000000ff /* $anonfun, RW, 8 bit */
#define IP_M_COEFF_3   0x010c
#define IP_M_COEFF_3_$ANONFUN_SHIFT  0
#define IP_M_COEFF_3_$ANONFUN_MASK   0x000000ff /* $anonfun, RW, 8 bit */
#define IP_M_COEFF_4   0x0110
#define IP_M_COEFF_4_$ANONFUN_SHIFT  0
#define IP_M_COEFF_4_$ANONFUN_MASK   0x000000ff /* $anonfun, RW, 8 bit */
#define IP_M_COEFF_5   0x0114
#define IP_M_COEFF_5_$ANONFUN_SHIFT  0
#define IP_M_COEFF_5_$ANONFUN_MASK   0x000000ff /* $anonfun, RW, 8 bit */



/**
  * @union       ip_m_ctrl_t
  * @address     0x0000
  * @brief       ctrl
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t f_start    :  1; /* WS, reset: 0x0, write 1 to start processing image */
        uint32_t reserved_0 : 31; /* NA, reserved */
    } reg;
} ip_m_ctrl_t;
/**
  * @union       ip_m_stat_t
  * @address     0x0004
  * @brief       stat
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t f_done     :  1; /* RC, reset: 0x0, read 1 when done */
        uint32_t reserved_0 : 31; /* NA, reserved */
    } reg;
} ip_m_stat_t;
/**
  * @union       ip_m_thres_0_t
  * @address     0x0080
  * @brief       thres_0
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t $anonfun   :  8; /* RW, reset: 0x00, threshold #0 field */
        uint32_t reserved_0 : 24; /* NA, reserved */
    } reg;
} ip_m_thres_0_t;
/**
  * @union       ip_m_thres_1_t
  * @address     0x0084
  * @brief       thres_1
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t $anonfun   :  8; /* RW, reset: 0x00, threshold #1 field */
        uint32_t reserved_0 : 24; /* NA, reserved */
    } reg;
} ip_m_thres_1_t;
/**
  * @union       ip_m_coeff_0_t
  * @address     0x0100
  * @brief       coeff_0
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t $anonfun   :  8; /* RW, reset: 0x00, coefficient #0 field */
        uint32_t reserved_0 : 24; /* NA, reserved */
    } reg;
} ip_m_coeff_0_t;
/**
  * @union       ip_m_coeff_1_t
  * @address     0x0104
  * @brief       coeff_1
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t $anonfun   :  8; /* RW, reset: 0x00, coefficient #1 field */
        uint32_t reserved_0 : 24; /* NA, reserved */
    } reg;
} ip_m_coeff_1_t;
/**
  * @union       ip_m_coeff_2_t
  * @address     0x0108
  * @brief       coeff_2
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t $anonfun   :  8; /* RW, reset: 0x00, coefficient #2 field */
        uint32_t reserved_0 : 24; /* NA, reserved */
    } reg;
} ip_m_coeff_2_t;
/**
  * @union       ip_m_coeff_3_t
  * @address     0x010c
  * @brief       coeff_3
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t $anonfun   :  8; /* RW, reset: 0x00, coefficient #3 field */
        uint32_t reserved_0 : 24; /* NA, reserved */
    } reg;
} ip_m_coeff_3_t;
/**
  * @union       ip_m_coeff_4_t
  * @address     0x0110
  * @brief       coeff_4
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t $anonfun   :  8; /* RW, reset: 0x00, coefficient #4 field */
        uint32_t reserved_0 : 24; /* NA, reserved */
    } reg;
} ip_m_coeff_4_t;
/**
  * @union       ip_m_coeff_5_t
  * @address     0x0114
  * @brief       coeff_5
  */
typedef union {
    uint32_t val;
    struct {
        uint32_t $anonfun   :  8; /* RW, reset: 0x00, coefficient #5 field */
        uint32_t reserved_0 : 24; /* NA, reserved */
    } reg;
} ip_m_coeff_5_t;


#endif /* axi_lite_regs_REGIF_H */
