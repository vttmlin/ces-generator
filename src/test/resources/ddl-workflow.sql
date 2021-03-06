CREATE SCHEMA IF NOT EXISTS XFZX;
DROP TABLE IF EXISTS XFZX.T_XFZX_YLGL_LBCRD_LC;
CREATE TABLE "XFZX"."T_XFZX_YLGL_LBCRD_LC" (
  "ID"                  VARCHAR2(50) PRIMARY KEY NOT NULL,
  "JBXX_ID"             VARCHAR2(50),
  "XM"                  VARCHAR2(200),
  "XM_SZM"              VARCHAR2(100),
  "BH"                  VARCHAR2(20),
  "JY_ID"               VARCHAR2(4),
  "JQ_ID"               VARCHAR2(20),
  "RJ_RQ"               DATE,
  "XB"                  CHAR(1),
  "NL"                  NUMBER(3, 0),
  "JG"                  VARCHAR2(20),
  "WHCD"                VARCHAR2(20),
  "HYZK"                VARCHAR2(20),
  "CYDJ"                VARCHAR2(20),
  "ZM"                  VARCHAR2(200),
  "XQ"                  VARCHAR2(10),
  "ZXXQ"                VARCHAR2(10),
  "ZXXQ_QR"             DATE,
  "ZXXQ_ZR"             DATE,
  "YX"                  VARCHAR2(10),
  "BC_RD_BC_QK"         VARCHAR2(500),
  "LNF_RD_SJ"           DATE,
  "LNF_RD_NL"           NUMBER(3, 0),
  "BC_RD_YXQ"           VARCHAR2(50),
  "BC_RD_YXQ_QR"        DATE,
  "BC_RD_YXQ_ZR"        DATE,
  "BC_RD_BCS"           VARCHAR2(500),
  "BC_RD_BQ"            VARCHAR2(500),
  "BC_RD_JD_JL"         VARCHAR2(500),
  "LBC_LB"              VARCHAR2(50),
  "FJQYJ_JG"            CHAR(1),
  "FJQYJ_WB"            VARCHAR2(500),
  "FJQYJ_QM"            VARCHAR2(50),
  "FJQYJ_QM_ID"         VARCHAR2(50),
  "FJQYJ_QZ"            VARCHAR2(50),
  "FJQYJ_RQ"            DATETIME(6),
  "JQYJ_JG"             CHAR(1),
  "JQYJ_WB"             VARCHAR2(500),
  "JQYJ_QM"             VARCHAR2(50),
  "JQYJ_QM_ID"          VARCHAR2(50),
  "JQYJ_QZ"             VARCHAR2(50),
  "JQYJ_RQ"             DATETIME(6),
  "JDXZYJ_QM"           VARCHAR2(50),
  "JDXZYJ_QM_ID"        VARCHAR2(50),
  "JDXZYJ_QZ"           VARCHAR2(50),
  "JDXZYJ_RQ"           VARCHAR2(50),
  "PSXZYJ_JG"           CHAR(10),
  "PSXZYJ_WB"           VARCHAR2(50),
  "PSXZYJ_QM"           VARCHAR2(50),
  "PSXZYJ_QM_ID"        VARCHAR2(50),
  "PSXZYJ_QZ"           VARCHAR2(50),
  "PSXZYJ_RQ"           DATETIME(6),
  "JYYJ_JG"             CHAR(1),
  "JYYJ_WB"             VARCHAR2(500),
  "JYYJ_QM"             VARCHAR2(50),
  "JYYJ_QM_ID"          VARCHAR2(50),
  "JYYJ_QZ"             VARCHAR2(50),
  "JYYJ_RQ"             DATETIME(6),
  "SP_JG"               CHAR(1),
  "PROCESS_INSTANCE_ID" VARCHAR2(50),
  "C_CJR"               VARCHAR2(50),
  "C_CJR_ID"            VARCHAR2(50),
  "C_CJ_RQ"             DATETIME(6),
  "C_GXR"               VARCHAR2(50),
  "C_GXR_ID"            VARCHAR2(50),
  "C_GX_RQ"             DATETIME(6),
  "C_SCR"               VARCHAR2(50),
  "C_SCR_ID"            VARCHAR2(50),
  "C_SC_RQ"             DATETIME(6),
  "C_SCBZ"              CHAR(1) DEFAULT 'N',
  "C_BZ"                VARCHAR2(1000)
);


COMMENT ON TABLE XFZX.T_XFZX_YLGL_LBCRD_LC IS '刑罚执行_医疗管理_老病残认定';
-- 业务基础字段
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.ID IS '主键';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JBXX_ID IS '罪犯基本信息';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.XM IS '姓名';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.XM_SZM IS '姓名首字母';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.BH IS '编号';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JY_ID IS '监狱ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JQ_ID IS '监区ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.RJ_RQ IS '入监日期';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.XB IS '性别【4.3.3】';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.NL IS '年龄';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JG IS '籍贯【4.3.2】';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.WHCD IS '文化程度【4.3.7】';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.HYZK IS '婚姻状况【4.3.4】';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.CYDJ IS '处遇等级【4.6.6】';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.ZM IS '罪名';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.XQ IS '刑期';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.ZXXQ IS '执行刑期';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.ZXXQ_QR IS '执行刑期起日';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.ZXXQ_ZR IS '执行刑期止日';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.YX IS '余刑';
-- 业务字段
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.BC_RD_BC_QK IS '病残认定 病残情况';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.LNF_RD_SJ IS '老年犯认定 时间';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.LNF_RD_NL IS '老年犯认定 年龄';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.BC_RD_YXQ IS '病残认定 有效期';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.BC_RD_YXQ_QR IS '病残认定 有效期起日';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.BC_RD_YXQ_ZR IS '病残认定 有效期止日';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.BC_RD_BCS IS '病残认定 鉴定情况 病残史';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.BC_RD_BQ IS ' 病残认定 鉴定情况 病情';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.BC_RD_JD_JL IS '病残认定 鉴定情况 鉴定结论';

-- 流程节点字段
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.FJQYJ_JG IS '分监区意见结果【4.0.3】';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.FJQYJ_WB IS '分监区意见文本';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.FJQYJ_QM IS '分监区意见签名';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.FJQYJ_QM_ID IS '分监区意见签名ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.FJQYJ_QZ IS '分监区意见签章';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.FJQYJ_RQ IS '分监区意见日期';

COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JQYJ_JG IS '监区意见结果【4.0.3】';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JQYJ_WB IS '监区意见文本';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JQYJ_QM IS '监区意见签名';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JQYJ_QM_ID IS '监区意见签名ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JQYJ_QZ IS '监区意见签章';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JQYJ_RQ IS '监区意见日期';

COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.PSXZYJ_JG IS '评审小组意见结果【4.0.3】';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.PSXZYJ_WB IS '评审小组意见文本';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.PSXZYJ_QM IS '评审小组意见签名';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.PSXZYJ_QM_ID IS '评审小组意见签名ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.PSXZYJ_QZ IS '评审小组意见签章';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.PSXZYJ_RQ IS '评审小组意见日期';

COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JYYJ_JG IS '监狱意见结果【4.0.3】';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JYYJ_WB IS '监狱意见文本';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JYYJ_QM IS '监狱意见签名';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JYYJ_QM_ID IS '监狱意见签名ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JYYJ_QZ IS '监狱意见签章';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JYYJ_RQ IS '监狱意见日期';
-- 流程字段
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.SP_JG IS '审批结果';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.PROCESS_INSTANCE_ID IS '流程实例ID';
-- 基础字段
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_CJR IS '创建人';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_CJR_ID IS '创建人ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_CJ_RQ IS '创建时间';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_GXR IS '更新人';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_GXR_ID IS '更新人ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_GX_RQ IS '更新时间';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_SCR IS '删除人';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_SCR_ID IS '删除人ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_SC_RQ IS '删除日期';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_SCBZ IS '删除标志';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.C_BZ IS '备注';

COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.LBC_LB IS '1 老年犯 2 疾病犯 3 残疾犯';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JDXZYJ_QM IS '鉴定小组意见签名';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JDXZYJ_QM_ID IS '鉴定小组意见签名ID';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JDXZYJ_QZ IS '鉴定小组意见签章';
COMMENT ON COLUMN XFZX.T_XFZX_YLGL_LBCRD_LC.JDXZYJ_RQ IS '鉴定小组意见日期';