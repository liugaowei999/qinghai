--------------------------------------------------
-- Export file for user QINGHAI                 --
-- Created by liugaowei on 2018-05-18, 15:11:52 --
--------------------------------------------------

set define off
spool qinghai_ddl.log

prompt
prompt Creating table ACT_RE_DEPLOYMENT
prompt ================================
prompt
create table ACT_RE_DEPLOYMENT
(
  id_          NVARCHAR2(64) not null,
  name_        NVARCHAR2(255),
  category_    NVARCHAR2(255),
  tenant_id_   NVARCHAR2(255) default '',
  deploy_time_ TIMESTAMP(6)
)
;
alter table ACT_RE_DEPLOYMENT
  add primary key (ID_);

prompt
prompt Creating table ACT_GE_BYTEARRAY
prompt ===============================
prompt
create table ACT_GE_BYTEARRAY
(
  id_            NVARCHAR2(64) not null,
  rev_           INTEGER,
  name_          NVARCHAR2(255),
  deployment_id_ NVARCHAR2(64),
  bytes_         BLOB,
  generated_     NUMBER(1)
)
;
create index ACT_IDX_BYTEAR_DEPL on ACT_GE_BYTEARRAY (DEPLOYMENT_ID_);
alter table ACT_GE_BYTEARRAY
  add primary key (ID_);
alter table ACT_GE_BYTEARRAY
  add constraint ACT_FK_BYTEARR_DEPL foreign key (DEPLOYMENT_ID_)
  references ACT_RE_DEPLOYMENT (ID_)
  disable;
alter table ACT_GE_BYTEARRAY
  add check (GENERATED_ IN (1,0));

prompt
prompt Creating table ACT_GE_PROPERTY
prompt ==============================
prompt
create table ACT_GE_PROPERTY
(
  name_  NVARCHAR2(64) not null,
  value_ NVARCHAR2(300),
  rev_   INTEGER
)
;
alter table ACT_GE_PROPERTY
  add primary key (NAME_);

prompt
prompt Creating table ACT_HI_ACTINST
prompt =============================
prompt
create table ACT_HI_ACTINST
(
  id_                NVARCHAR2(64) not null,
  proc_def_id_       NVARCHAR2(64) not null,
  proc_inst_id_      NVARCHAR2(64) not null,
  execution_id_      NVARCHAR2(64) not null,
  act_id_            NVARCHAR2(255) not null,
  task_id_           NVARCHAR2(64),
  call_proc_inst_id_ NVARCHAR2(64),
  act_name_          NVARCHAR2(255),
  act_type_          NVARCHAR2(255) not null,
  assignee_          NVARCHAR2(255),
  start_time_        TIMESTAMP(6) not null,
  end_time_          TIMESTAMP(6),
  duration_          NUMBER(19),
  tenant_id_         NVARCHAR2(255) default ''
)
;
create index ACT_IDX_HI_ACT_INST_END on ACT_HI_ACTINST (END_TIME_);
create index ACT_IDX_HI_ACT_INST_EXEC on ACT_HI_ACTINST (EXECUTION_ID_, ACT_ID_);
create index ACT_IDX_HI_ACT_INST_PROCINST on ACT_HI_ACTINST (PROC_INST_ID_, ACT_ID_);
create index ACT_IDX_HI_ACT_INST_START on ACT_HI_ACTINST (START_TIME_);
alter table ACT_HI_ACTINST
  add primary key (ID_);

prompt
prompt Creating table ACT_HI_ATTACHMENT
prompt ================================
prompt
create table ACT_HI_ATTACHMENT
(
  id_           NVARCHAR2(64) not null,
  rev_          INTEGER,
  user_id_      NVARCHAR2(255),
  name_         NVARCHAR2(255),
  description_  NVARCHAR2(2000),
  type_         NVARCHAR2(255),
  task_id_      NVARCHAR2(64),
  proc_inst_id_ NVARCHAR2(64),
  url_          NVARCHAR2(2000),
  content_id_   NVARCHAR2(64),
  time_         TIMESTAMP(6)
)
;
alter table ACT_HI_ATTACHMENT
  add primary key (ID_);

prompt
prompt Creating table ACT_HI_COMMENT
prompt =============================
prompt
create table ACT_HI_COMMENT
(
  id_           NVARCHAR2(64) not null,
  type_         NVARCHAR2(255),
  time_         TIMESTAMP(6) not null,
  user_id_      NVARCHAR2(255),
  task_id_      NVARCHAR2(64),
  proc_inst_id_ NVARCHAR2(64),
  action_       NVARCHAR2(255),
  message_      NVARCHAR2(2000),
  full_msg_     BLOB
)
;
alter table ACT_HI_COMMENT
  add primary key (ID_);

prompt
prompt Creating table ACT_HI_DETAIL
prompt ============================
prompt
create table ACT_HI_DETAIL
(
  id_           NVARCHAR2(64) not null,
  type_         NVARCHAR2(255) not null,
  proc_inst_id_ NVARCHAR2(64),
  execution_id_ NVARCHAR2(64),
  task_id_      NVARCHAR2(64),
  act_inst_id_  NVARCHAR2(64),
  name_         NVARCHAR2(255) not null,
  var_type_     NVARCHAR2(64),
  rev_          INTEGER,
  time_         TIMESTAMP(6) not null,
  bytearray_id_ NVARCHAR2(64),
  double_       NUMBER(*,10),
  long_         NUMBER(19),
  text_         NVARCHAR2(2000),
  text2_        NVARCHAR2(2000)
)
;
create index ACT_IDX_HI_DETAIL_ACT_INST on ACT_HI_DETAIL (ACT_INST_ID_);
create index ACT_IDX_HI_DETAIL_NAME on ACT_HI_DETAIL (NAME_);
create index ACT_IDX_HI_DETAIL_PROC_INST on ACT_HI_DETAIL (PROC_INST_ID_);
create index ACT_IDX_HI_DETAIL_TASK_ID on ACT_HI_DETAIL (TASK_ID_);
create index ACT_IDX_HI_DETAIL_TIME on ACT_HI_DETAIL (TIME_);
alter table ACT_HI_DETAIL
  add primary key (ID_);

prompt
prompt Creating table ACT_HI_IDENTITYLINK
prompt ==================================
prompt
create table ACT_HI_IDENTITYLINK
(
  id_           NVARCHAR2(64) not null,
  group_id_     NVARCHAR2(255),
  type_         NVARCHAR2(255),
  user_id_      NVARCHAR2(255),
  task_id_      NVARCHAR2(64),
  proc_inst_id_ NVARCHAR2(64)
)
;
create index ACT_IDX_HI_IDENT_LNK_PROCINST on ACT_HI_IDENTITYLINK (PROC_INST_ID_);
create index ACT_IDX_HI_IDENT_LNK_TASK on ACT_HI_IDENTITYLINK (TASK_ID_);
create index ACT_IDX_HI_IDENT_LNK_USER on ACT_HI_IDENTITYLINK (USER_ID_);
alter table ACT_HI_IDENTITYLINK
  add primary key (ID_);

prompt
prompt Creating table ACT_HI_PROCINST
prompt ==============================
prompt
create table ACT_HI_PROCINST
(
  id_                        NVARCHAR2(64) not null,
  proc_inst_id_              NVARCHAR2(64) not null,
  business_key_              NVARCHAR2(255),
  proc_def_id_               NVARCHAR2(64) not null,
  start_time_                TIMESTAMP(6) not null,
  end_time_                  TIMESTAMP(6),
  duration_                  NUMBER(19),
  start_user_id_             NVARCHAR2(255),
  start_act_id_              NVARCHAR2(255),
  end_act_id_                NVARCHAR2(255),
  super_process_instance_id_ NVARCHAR2(64),
  delete_reason_             NVARCHAR2(2000),
  tenant_id_                 NVARCHAR2(255) default '',
  name_                      NVARCHAR2(255)
)
;
create index ACT_IDX_HI_PRO_INST_END on ACT_HI_PROCINST (END_TIME_);
create index ACT_IDX_HI_PRO_I_BUSKEY on ACT_HI_PROCINST (BUSINESS_KEY_);
alter table ACT_HI_PROCINST
  add primary key (ID_);
alter table ACT_HI_PROCINST
  add unique (PROC_INST_ID_);

prompt
prompt Creating table ACT_HI_TASKINST
prompt ==============================
prompt
create table ACT_HI_TASKINST
(
  id_             NVARCHAR2(64) not null,
  proc_def_id_    NVARCHAR2(64),
  task_def_key_   NVARCHAR2(255),
  proc_inst_id_   NVARCHAR2(64),
  execution_id_   NVARCHAR2(64),
  parent_task_id_ NVARCHAR2(64),
  name_           NVARCHAR2(255),
  description_    NVARCHAR2(2000),
  owner_          NVARCHAR2(255),
  assignee_       NVARCHAR2(255),
  start_time_     TIMESTAMP(6) not null,
  claim_time_     TIMESTAMP(6),
  end_time_       TIMESTAMP(6),
  duration_       NUMBER(19),
  delete_reason_  NVARCHAR2(2000),
  priority_       INTEGER,
  due_date_       TIMESTAMP(6),
  form_key_       NVARCHAR2(255),
  category_       NVARCHAR2(255),
  tenant_id_      NVARCHAR2(255) default ''
)
;
create index ACT_IDX_HI_TASK_INST_PROCINST on ACT_HI_TASKINST (PROC_INST_ID_);
alter table ACT_HI_TASKINST
  add primary key (ID_);

prompt
prompt Creating table ACT_HI_VARINST
prompt =============================
prompt
create table ACT_HI_VARINST
(
  id_                NVARCHAR2(64) not null,
  proc_inst_id_      NVARCHAR2(64),
  execution_id_      NVARCHAR2(64),
  task_id_           NVARCHAR2(64),
  name_              NVARCHAR2(255) not null,
  var_type_          NVARCHAR2(100),
  rev_               INTEGER,
  bytearray_id_      NVARCHAR2(64),
  double_            NUMBER(*,10),
  long_              NUMBER(19),
  text_              NVARCHAR2(2000),
  text2_             NVARCHAR2(2000),
  create_time_       TIMESTAMP(6),
  last_updated_time_ TIMESTAMP(6)
)
;
create index ACT_IDX_HI_PROCVAR_NAME_TYPE on ACT_HI_VARINST (NAME_, VAR_TYPE_);
create index ACT_IDX_HI_PROCVAR_PROC_INST on ACT_HI_VARINST (PROC_INST_ID_);
create index ACT_IDX_HI_PROCVAR_TASK_ID on ACT_HI_VARINST (TASK_ID_);
alter table ACT_HI_VARINST
  add primary key (ID_);

prompt
prompt Creating table ACT_ID_GROUP
prompt ===========================
prompt
create table ACT_ID_GROUP
(
  id_   NVARCHAR2(64) not null,
  rev_  INTEGER,
  name_ NVARCHAR2(255),
  type_ NVARCHAR2(255)
)
;
alter table ACT_ID_GROUP
  add primary key (ID_);

prompt
prompt Creating table ACT_ID_INFO
prompt ==========================
prompt
create table ACT_ID_INFO
(
  id_        NVARCHAR2(64) not null,
  rev_       INTEGER,
  user_id_   NVARCHAR2(64),
  type_      NVARCHAR2(64),
  key_       NVARCHAR2(255),
  value_     NVARCHAR2(255),
  password_  BLOB,
  parent_id_ NVARCHAR2(255)
)
;
alter table ACT_ID_INFO
  add primary key (ID_);

prompt
prompt Creating table ACT_ID_USER
prompt ==========================
prompt
create table ACT_ID_USER
(
  id_         NVARCHAR2(64) not null,
  rev_        INTEGER,
  first_      NVARCHAR2(255),
  last_       NVARCHAR2(255),
  email_      NVARCHAR2(255),
  pwd_        NVARCHAR2(255),
  picture_id_ NVARCHAR2(64)
)
;
alter table ACT_ID_USER
  add primary key (ID_);

prompt
prompt Creating table ACT_ID_MEMBERSHIP
prompt ================================
prompt
create table ACT_ID_MEMBERSHIP
(
  user_id_  NVARCHAR2(64) not null,
  group_id_ NVARCHAR2(64) not null
)
;
create index ACT_IDX_MEMB_GROUP on ACT_ID_MEMBERSHIP (GROUP_ID_);
create index ACT_IDX_MEMB_USER on ACT_ID_MEMBERSHIP (USER_ID_);
alter table ACT_ID_MEMBERSHIP
  add primary key (USER_ID_, GROUP_ID_);
alter table ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_GROUP foreign key (GROUP_ID_)
  references ACT_ID_GROUP (ID_);
alter table ACT_ID_MEMBERSHIP
  add constraint ACT_FK_MEMB_USER foreign key (USER_ID_)
  references ACT_ID_USER (ID_);

prompt
prompt Creating table ACT_RE_PROCDEF
prompt =============================
prompt
create table ACT_RE_PROCDEF
(
  id_                     NVARCHAR2(64) not null,
  rev_                    INTEGER,
  category_               NVARCHAR2(255),
  name_                   NVARCHAR2(255),
  key_                    NVARCHAR2(255) not null,
  version_                INTEGER not null,
  deployment_id_          NVARCHAR2(64),
  resource_name_          NVARCHAR2(2000),
  dgrm_resource_name_     VARCHAR2(4000),
  description_            NVARCHAR2(2000),
  has_start_form_key_     NUMBER(1),
  has_graphical_notation_ NUMBER(1),
  suspension_state_       INTEGER,
  tenant_id_              NVARCHAR2(255) default ''
)
;
alter table ACT_RE_PROCDEF
  add primary key (ID_);
alter table ACT_RE_PROCDEF
  add constraint ACT_UNIQ_PROCDEF unique (KEY_, VERSION_, TENANT_ID_);
alter table ACT_RE_PROCDEF
  add check (HAS_START_FORM_KEY_ IN (1,0));
alter table ACT_RE_PROCDEF
  add check (HAS_GRAPHICAL_NOTATION_ IN (1,0));

prompt
prompt Creating table ACT_PROCDEF_INFO
prompt ===============================
prompt
create table ACT_PROCDEF_INFO
(
  id_           NVARCHAR2(64) not null,
  proc_def_id_  NVARCHAR2(64) not null,
  rev_          INTEGER,
  info_json_id_ NVARCHAR2(64)
)
;
create index ACT_IDX_PROCDEF_INFO_JSON on ACT_PROCDEF_INFO (INFO_JSON_ID_);
create index ACT_IDX_PROCDEF_INFO_PROC on ACT_PROCDEF_INFO (PROC_DEF_ID_);
alter table ACT_PROCDEF_INFO
  add primary key (ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_UNIQ_INFO_PROCDEF unique (PROC_DEF_ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_JSON_BA foreign key (INFO_JSON_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_PROCDEF_INFO
  add constraint ACT_FK_INFO_PROCDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);

prompt
prompt Creating table ACT_RE_MODEL
prompt ===========================
prompt
create table ACT_RE_MODEL
(
  id_                           NVARCHAR2(64) not null,
  rev_                          INTEGER,
  name_                         NVARCHAR2(255),
  key_                          NVARCHAR2(255),
  category_                     NVARCHAR2(255),
  create_time_                  TIMESTAMP(6),
  last_update_time_             TIMESTAMP(6),
  version_                      INTEGER,
  meta_info_                    NVARCHAR2(2000),
  deployment_id_                NVARCHAR2(64),
  editor_source_value_id_       NVARCHAR2(64),
  editor_source_extra_value_id_ NVARCHAR2(64),
  tenant_id_                    NVARCHAR2(255) default ''
)
;
create index ACT_IDX_MODEL_DEPLOYMENT on ACT_RE_MODEL (DEPLOYMENT_ID_);
create index ACT_IDX_MODEL_SOURCE on ACT_RE_MODEL (EDITOR_SOURCE_VALUE_ID_);
create index ACT_IDX_MODEL_SOURCE_EXTRA on ACT_RE_MODEL (EDITOR_SOURCE_EXTRA_VALUE_ID_);
alter table ACT_RE_MODEL
  add primary key (ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_DEPLOYMENT foreign key (DEPLOYMENT_ID_)
  references ACT_RE_DEPLOYMENT (ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE foreign key (EDITOR_SOURCE_VALUE_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_RE_MODEL
  add constraint ACT_FK_MODEL_SOURCE_EXTRA foreign key (EDITOR_SOURCE_EXTRA_VALUE_ID_)
  references ACT_GE_BYTEARRAY (ID_);

prompt
prompt Creating table ACT_RU_EXECUTION
prompt ===============================
prompt
create table ACT_RU_EXECUTION
(
  id_               NVARCHAR2(64) not null,
  rev_              INTEGER,
  proc_inst_id_     NVARCHAR2(64),
  business_key_     NVARCHAR2(255),
  parent_id_        NVARCHAR2(64),
  proc_def_id_      NVARCHAR2(64),
  super_exec_       NVARCHAR2(64),
  act_id_           NVARCHAR2(255),
  is_active_        NUMBER(1),
  is_concurrent_    NUMBER(1),
  is_scope_         NUMBER(1),
  is_event_scope_   NUMBER(1),
  suspension_state_ INTEGER,
  cached_ent_state_ INTEGER,
  tenant_id_        NVARCHAR2(255) default '',
  name_             NVARCHAR2(255),
  lock_time_        TIMESTAMP(6)
)
;
create index ACT_IDX_EXEC_BUSKEY on ACT_RU_EXECUTION (BUSINESS_KEY_);
create index ACT_IDX_EXE_PARENT on ACT_RU_EXECUTION (PARENT_ID_);
create index ACT_IDX_EXE_PROCDEF on ACT_RU_EXECUTION (PROC_DEF_ID_);
create index ACT_IDX_EXE_PROCINST on ACT_RU_EXECUTION (PROC_INST_ID_);
create index ACT_IDX_EXE_SUPER on ACT_RU_EXECUTION (SUPER_EXEC_);
alter table ACT_RU_EXECUTION
  add primary key (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PARENT foreign key (PARENT_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_EXECUTION
  add constraint ACT_FK_EXE_SUPER foreign key (SUPER_EXEC_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_EXECUTION
  add check (IS_ACTIVE_ IN (1,0));
alter table ACT_RU_EXECUTION
  add check (IS_CONCURRENT_ IN (1,0));
alter table ACT_RU_EXECUTION
  add check (IS_SCOPE_ IN (1,0));
alter table ACT_RU_EXECUTION
  add check (IS_EVENT_SCOPE_ IN (1,0));

prompt
prompt Creating table ACT_RU_EVENT_SUBSCR
prompt ==================================
prompt
create table ACT_RU_EVENT_SUBSCR
(
  id_            NVARCHAR2(64) not null,
  rev_           INTEGER,
  event_type_    NVARCHAR2(255) not null,
  event_name_    NVARCHAR2(255),
  execution_id_  NVARCHAR2(64),
  proc_inst_id_  NVARCHAR2(64),
  activity_id_   NVARCHAR2(64),
  configuration_ NVARCHAR2(255),
  created_       TIMESTAMP(6) not null,
  proc_def_id_   NVARCHAR2(64),
  tenant_id_     NVARCHAR2(255) default ''
)
;
create index ACT_IDX_EVENT_SUBSCR on ACT_RU_EVENT_SUBSCR (EXECUTION_ID_);
create index ACT_IDX_EVENT_SUBSCR_CONFIG_ on ACT_RU_EVENT_SUBSCR (CONFIGURATION_);
alter table ACT_RU_EVENT_SUBSCR
  add primary key (ID_);
alter table ACT_RU_EVENT_SUBSCR
  add constraint ACT_FK_EVENT_EXEC foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_);

prompt
prompt Creating table ACT_RU_TASK
prompt ==========================
prompt
create table ACT_RU_TASK
(
  id_               NVARCHAR2(64) not null,
  rev_              INTEGER,
  execution_id_     NVARCHAR2(64),
  proc_inst_id_     NVARCHAR2(64),
  proc_def_id_      NVARCHAR2(64),
  name_             NVARCHAR2(255),
  parent_task_id_   NVARCHAR2(64),
  description_      NVARCHAR2(2000),
  task_def_key_     NVARCHAR2(255),
  owner_            NVARCHAR2(255),
  assignee_         NVARCHAR2(255),
  delegation_       NVARCHAR2(64),
  priority_         INTEGER,
  create_time_      TIMESTAMP(6),
  due_date_         TIMESTAMP(6),
  category_         NVARCHAR2(255),
  suspension_state_ INTEGER,
  tenant_id_        NVARCHAR2(255) default '',
  form_key_         NVARCHAR2(255)
)
;
create index ACT_IDX_TASK_CREATE on ACT_RU_TASK (CREATE_TIME_);
create index ACT_IDX_TASK_EXEC on ACT_RU_TASK (EXECUTION_ID_);
create index ACT_IDX_TASK_PROCDEF on ACT_RU_TASK (PROC_DEF_ID_);
create index ACT_IDX_TASK_PROCINST on ACT_RU_TASK (PROC_INST_ID_);
alter table ACT_RU_TASK
  add primary key (ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_EXE foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
alter table ACT_RU_TASK
  add constraint ACT_FK_TASK_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);

prompt
prompt Creating table ACT_RU_IDENTITYLINK
prompt ==================================
prompt
create table ACT_RU_IDENTITYLINK
(
  id_           NVARCHAR2(64) not null,
  rev_          INTEGER,
  group_id_     NVARCHAR2(255),
  type_         NVARCHAR2(255),
  user_id_      NVARCHAR2(255),
  task_id_      NVARCHAR2(64),
  proc_inst_id_ NVARCHAR2(64),
  proc_def_id_  NVARCHAR2(64)
)
;
create index ACT_IDX_ATHRZ_PROCEDEF on ACT_RU_IDENTITYLINK (PROC_DEF_ID_);
create index ACT_IDX_IDENT_LNK_GROUP on ACT_RU_IDENTITYLINK (GROUP_ID_);
create index ACT_IDX_IDENT_LNK_USER on ACT_RU_IDENTITYLINK (USER_ID_);
create index ACT_IDX_IDL_PROCINST on ACT_RU_IDENTITYLINK (PROC_INST_ID_);
create index ACT_IDX_TSKASS_TASK on ACT_RU_IDENTITYLINK (TASK_ID_);
alter table ACT_RU_IDENTITYLINK
  add primary key (ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_ATHRZ_PROCEDEF foreign key (PROC_DEF_ID_)
  references ACT_RE_PROCDEF (ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_IDL_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_IDENTITYLINK
  add constraint ACT_FK_TSKASS_TASK foreign key (TASK_ID_)
  references ACT_RU_TASK (ID_);

prompt
prompt Creating table ACT_RU_JOB
prompt =========================
prompt
create table ACT_RU_JOB
(
  id_                  NVARCHAR2(64) not null,
  rev_                 INTEGER,
  type_                NVARCHAR2(255) not null,
  lock_exp_time_       TIMESTAMP(6),
  lock_owner_          NVARCHAR2(255),
  exclusive_           NUMBER(1),
  execution_id_        NVARCHAR2(64),
  process_instance_id_ NVARCHAR2(64),
  proc_def_id_         NVARCHAR2(64),
  retries_             INTEGER,
  exception_stack_id_  NVARCHAR2(64),
  exception_msg_       NVARCHAR2(2000),
  duedate_             TIMESTAMP(6),
  repeat_              NVARCHAR2(255),
  handler_type_        NVARCHAR2(255),
  handler_cfg_         NVARCHAR2(2000),
  tenant_id_           NVARCHAR2(255) default ''
)
;
create index ACT_IDX_JOB_EXCEPTION on ACT_RU_JOB (EXCEPTION_STACK_ID_);
alter table ACT_RU_JOB
  add primary key (ID_);
alter table ACT_RU_JOB
  add constraint ACT_FK_JOB_EXCEPTION foreign key (EXCEPTION_STACK_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_RU_JOB
  add check (EXCLUSIVE_ IN (1,0));

prompt
prompt Creating table ACT_RU_VARIABLE
prompt ==============================
prompt
create table ACT_RU_VARIABLE
(
  id_           NVARCHAR2(64) not null,
  rev_          INTEGER,
  type_         NVARCHAR2(255) not null,
  name_         NVARCHAR2(255) not null,
  execution_id_ NVARCHAR2(64),
  proc_inst_id_ NVARCHAR2(64),
  task_id_      NVARCHAR2(64),
  bytearray_id_ NVARCHAR2(64),
  double_       NUMBER(*,10),
  long_         NUMBER(19),
  text_         NVARCHAR2(2000),
  text2_        NVARCHAR2(2000)
)
;
create index ACT_IDX_VARIABLE_TASK_ID on ACT_RU_VARIABLE (TASK_ID_);
create index ACT_IDX_VAR_BYTEARRAY on ACT_RU_VARIABLE (BYTEARRAY_ID_);
create index ACT_IDX_VAR_EXE on ACT_RU_VARIABLE (EXECUTION_ID_);
create index ACT_IDX_VAR_PROCINST on ACT_RU_VARIABLE (PROC_INST_ID_);
alter table ACT_RU_VARIABLE
  add primary key (ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_BYTEARRAY foreign key (BYTEARRAY_ID_)
  references ACT_GE_BYTEARRAY (ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_EXE foreign key (EXECUTION_ID_)
  references ACT_RU_EXECUTION (ID_);
alter table ACT_RU_VARIABLE
  add constraint ACT_FK_VAR_PROCINST foreign key (PROC_INST_ID_)
  references ACT_RU_EXECUTION (ID_);

prompt
prompt Creating table BPS_ALERT_MESSAGE
prompt ================================
prompt
create table BPS_ALERT_MESSAGE
(
  hostname      VARCHAR2(50) not null,
  name          VARCHAR2(256) not null,
  type          VARCHAR2(20) not null,
  alert_message VARCHAR2(512),
  alert_date    DATE
)
;

prompt
prompt Creating table BPS_BN_CONF
prompt ==========================
prompt
create table BPS_BN_CONF
(
  id             VARCHAR2(64) not null,
  down_date      VARCHAR2(8),
  file_name      VARCHAR2(128),
  issue_org_code VARCHAR2(11),
  card_bin_no    VARCHAR2(10),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14),
  create_by      VARCHAR2(64) not null,
  create_date    TIMESTAMP(6) not null,
  update_by      VARCHAR2(64) not null,
  update_date    TIMESTAMP(6) not null,
  remarks        NVARCHAR2(255),
  del_flag       CHAR(1) default 0 not null
)
;
comment on column BPS_BN_CONF.id
  is '主键ID';
comment on column BPS_BN_CONF.down_date
  is '下发日期';
comment on column BPS_BN_CONF.file_name
  is '文件名称';
comment on column BPS_BN_CONF.issue_org_code
  is '发卡机构代码';
comment on column BPS_BN_CONF.card_bin_no
  is '卡BIN';
comment on column BPS_BN_CONF.deal_time
  is '处理时间';
comment on column BPS_BN_CONF.indb_time
  is '入库时间';
comment on column BPS_BN_CONF.create_by
  is '创建人';
comment on column BPS_BN_CONF.create_date
  is '创建时间';
comment on column BPS_BN_CONF.update_by
  is '修改人';
comment on column BPS_BN_CONF.update_date
  is '修改时间';
comment on column BPS_BN_CONF.remarks
  is '备注';
comment on column BPS_BN_CONF.del_flag
  is '删除标志';
alter table BPS_BN_CONF
  add primary key (ID);

prompt
prompt Creating table BPS_DC_CONF
prompt ==========================
prompt
create table BPS_DC_CONF
(
  id             VARCHAR2(64) not null,
  down_date      VARCHAR2(8),
  file_name      VARCHAR2(128),
  issue_org_code VARCHAR2(11),
  card_no        VARCHAR2(20),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14),
  create_by      VARCHAR2(64) not null,
  create_date    TIMESTAMP(6) not null,
  update_by      VARCHAR2(64) not null,
  update_date    TIMESTAMP(6) not null,
  remarks        NVARCHAR2(255),
  del_flag       CHAR(1) default 0 not null
)
;
comment on column BPS_DC_CONF.id
  is '主键ID';
comment on column BPS_DC_CONF.down_date
  is '下发日期';
comment on column BPS_DC_CONF.file_name
  is '文件名称';
comment on column BPS_DC_CONF.issue_org_code
  is '发卡机构代码';
comment on column BPS_DC_CONF.card_no
  is '卡号';
comment on column BPS_DC_CONF.deal_time
  is '处理时间';
comment on column BPS_DC_CONF.indb_time
  is '入库时间';
comment on column BPS_DC_CONF.create_by
  is '创建人';
comment on column BPS_DC_CONF.create_date
  is '创建时间';
comment on column BPS_DC_CONF.update_by
  is '修改人';
comment on column BPS_DC_CONF.update_date
  is '修改时间';
comment on column BPS_DC_CONF.remarks
  is '备注';
comment on column BPS_DC_CONF.del_flag
  is '删除标志';
alter table BPS_DC_CONF
  add primary key (ID);

prompt
prompt Creating table BPS_DICT_DEF
prompt ===========================
prompt
create table BPS_DICT_DEF
(
  dict_id     VARCHAR2(32) not null,
  enum_code   VARCHAR2(128) not null,
  enum_desc   VARCHAR2(256),
  create_by   VARCHAR2(64),
  create_date DATE,
  update_by   VARCHAR2(64),
  update_date DATE,
  remark      VARCHAR2(512),
  deal_flag   CHAR(1)
)
;
alter table BPS_DICT_DEF
  add constraint PK_BPS_DICT_DEF primary key (DICT_ID, ENUM_CODE);

prompt
prompt Creating table BPS_ER_CONF
prompt ==========================
prompt
create table BPS_ER_CONF
(
  id          VARCHAR2(64) not null,
  down_date   VARCHAR2(8),
  file_name   VARCHAR2(128),
  err_code    VARCHAR2(6),
  err_info    VARCHAR2(40),
  deal_time   VARCHAR2(14),
  indb_time   VARCHAR2(14),
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default 0 not null
)
;
comment on column BPS_ER_CONF.id
  is '主键ID';
comment on column BPS_ER_CONF.down_date
  is '下发日期';
comment on column BPS_ER_CONF.file_name
  is '文件名称';
comment on column BPS_ER_CONF.err_code
  is '错误代码';
comment on column BPS_ER_CONF.err_info
  is '错误代码描述';
comment on column BPS_ER_CONF.deal_time
  is '处理时间';
comment on column BPS_ER_CONF.indb_time
  is '入库时间';
comment on column BPS_ER_CONF.create_by
  is '创建人';
comment on column BPS_ER_CONF.create_date
  is '创建时间';
comment on column BPS_ER_CONF.update_by
  is '修改人';
comment on column BPS_ER_CONF.update_date
  is '修改时间';
comment on column BPS_ER_CONF.remarks
  is '备注';
comment on column BPS_ER_CONF.del_flag
  is '删除标志';
alter table BPS_ER_CONF
  add primary key (ID);

prompt
prompt Creating table BPS_FILETRANS_LOG_201612
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201612
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;
comment on column BPS_FILETRANS_LOG_201612.module_id
  is '模块ID';
comment on column BPS_FILETRANS_LOG_201612.file_name
  is '文件名';
comment on column BPS_FILETRANS_LOG_201612.file_size
  is '原始文件大小， 单位字节';
comment on column BPS_FILETRANS_LOG_201612.is_sucess
  is '是否成功';
comment on column BPS_FILETRANS_LOG_201612.process_time
  is '上传或下载时间 yyyymmddhh24miss';
comment on column BPS_FILETRANS_LOG_201612.isup
  is '1: 上传 0：下载';
comment on column BPS_FILETRANS_LOG_201612.trans_size
  is '已传输的文件内容大小， 单位字节';
comment on column BPS_FILETRANS_LOG_201612.remark
  is '备注';

prompt
prompt Creating table BPS_FILETRANS_LOG_201701
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201701
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201702
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201702
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201703
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201703
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201704
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201704
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201705
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201705
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201706
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201706
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201707
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201707
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201708
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201708
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201709
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201709
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201710
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201710
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201711
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201711
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201712
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201712
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201801
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201801
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201802
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201802
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201803
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201803
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201804
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201804
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201805
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201805
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201806
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201806
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201807
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201807
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201808
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201808
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201809
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201809
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201810
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201810
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201811
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201811
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_201812
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_201812
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_FILETRANS_LOG_YYYYMM
prompt =======================================
prompt
create table BPS_FILETRANS_LOG_YYYYMM
(
  module_id    NUMBER(6) not null,
  file_name    VARCHAR2(256) not null,
  file_size    NUMBER(10) not null,
  is_sucess    NUMBER(1) not null,
  process_time DATE not null,
  isup         NUMBER(1) not null,
  trans_size   NUMBER(10) not null,
  remark       VARCHAR2(256)
)
;
comment on column BPS_FILETRANS_LOG_YYYYMM.module_id
  is '模块ID';
comment on column BPS_FILETRANS_LOG_YYYYMM.file_name
  is '文件名';
comment on column BPS_FILETRANS_LOG_YYYYMM.file_size
  is '原始文件大小， 单位字节';
comment on column BPS_FILETRANS_LOG_YYYYMM.is_sucess
  is '是否成功';
comment on column BPS_FILETRANS_LOG_YYYYMM.process_time
  is '上传或下载时间 yyyymmddhh24miss';
comment on column BPS_FILETRANS_LOG_YYYYMM.isup
  is '1: 上传 0：下载';
comment on column BPS_FILETRANS_LOG_YYYYMM.trans_size
  is '已传输的文件内容大小， 单位字节';
comment on column BPS_FILETRANS_LOG_YYYYMM.remark
  is '备注';

prompt
prompt Creating table BPS_MODULE_LOG_201612
prompt ====================================
prompt
create table BPS_MODULE_LOG_201612
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256),
  sett_date       VARCHAR2(8)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201701
prompt ====================================
prompt
create table BPS_MODULE_LOG_201701
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201702
prompt ====================================
prompt
create table BPS_MODULE_LOG_201702
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201703
prompt ====================================
prompt
create table BPS_MODULE_LOG_201703
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201704
prompt ====================================
prompt
create table BPS_MODULE_LOG_201704
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201705
prompt ====================================
prompt
create table BPS_MODULE_LOG_201705
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201706
prompt ====================================
prompt
create table BPS_MODULE_LOG_201706
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201707
prompt ====================================
prompt
create table BPS_MODULE_LOG_201707
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201708
prompt ====================================
prompt
create table BPS_MODULE_LOG_201708
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201709
prompt ====================================
prompt
create table BPS_MODULE_LOG_201709
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201710
prompt ====================================
prompt
create table BPS_MODULE_LOG_201710
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201711
prompt ====================================
prompt
create table BPS_MODULE_LOG_201711
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201712
prompt ====================================
prompt
create table BPS_MODULE_LOG_201712
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201801
prompt ====================================
prompt
create table BPS_MODULE_LOG_201801
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201802
prompt ====================================
prompt
create table BPS_MODULE_LOG_201802
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201803
prompt ====================================
prompt
create table BPS_MODULE_LOG_201803
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201804
prompt ====================================
prompt
create table BPS_MODULE_LOG_201804
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201805
prompt ====================================
prompt
create table BPS_MODULE_LOG_201805
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201806
prompt ====================================
prompt
create table BPS_MODULE_LOG_201806
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201807
prompt ====================================
prompt
create table BPS_MODULE_LOG_201807
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201808
prompt ====================================
prompt
create table BPS_MODULE_LOG_201808
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201809
prompt ====================================
prompt
create table BPS_MODULE_LOG_201809
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201810
prompt ====================================
prompt
create table BPS_MODULE_LOG_201810
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201811
prompt ====================================
prompt
create table BPS_MODULE_LOG_201811
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_201812
prompt ====================================
prompt
create table BPS_MODULE_LOG_201812
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_MODULE_LOG_YYYYMM
prompt ====================================
prompt
create table BPS_MODULE_LOG_YYYYMM
(
  module_id       NUMBER(6),
  file_name       VARCHAR2(256),
  file_type       VARCHAR2(8),
  file_size       NUMBER(10),
  sett_date       VARCHAR2(8),
  file_date       DATE,
  begin_deal_time DATE,
  end_deal_time   DATE,
  total_count     NUMBER(8),
  normal_count    NUMBER(8),
  error_count     NUMBER(8),
  dup_count       NUMBER(8),
  nouse_count     NUMBER(8),
  changed_count   NUMBER(8),
  merge_count     NUMBER(8),
  split_count     NUMBER(8),
  other1          NUMBER(8),
  other2          NUMBER(8),
  asn_badblock    NUMBER(8),
  early_time      VARCHAR2(16),
  late_time       VARCHAR2(16),
  reserve1        VARCHAR2(256)
)
;

prompt
prompt Creating table BPS_RECORD_FORMAT
prompt ================================
prompt
create table BPS_RECORD_FORMAT
(
  dr_type     VARCHAR2(20),
  filed_name  VARCHAR2(32),
  filed_index NUMBER,
  value_type  NUMBER,
  seq         NUMBER,
  note        VARCHAR2(128),
  oper_id     VARCHAR2(30),
  oper_time   DATE,
  dict_id     VARCHAR2(32)
)
;
comment on column BPS_RECORD_FORMAT.value_type
  is '1:int32  |  2:int64  |  3:float  |  4:double  |  5:char  |  6:string';

prompt
prompt Creating table BPS_SETL_CYCLE
prompt =============================
prompt
create table BPS_SETL_CYCLE
(
  id          VARCHAR2(30),
  setl_cycle  VARCHAR2(8),
  setl_mode   NUMBER(2),
  end_time    VARCHAR2(8) default 030000,
  create_by   VARCHAR2(64),
  create_date TIMESTAMP(6),
  update_by   VARCHAR2(64),
  update_date TIMESTAMP(6),
  remark      VARCHAR2(512),
  del_flag    CHAR(1)
)
;
comment on column BPS_SETL_CYCLE.setl_cycle
  is '日终结算：YYYYMMDD， 月终结算：YYYYMM ---暂时不用';
comment on column BPS_SETL_CYCLE.setl_mode
  is '结算方式， 1：日终结算 2：月终结算';
comment on column BPS_SETL_CYCLE.end_time
  is 'HHMISS（时分秒）。日切时间或者月切时间';
comment on column BPS_SETL_CYCLE.create_by
  is '创建人';
comment on column BPS_SETL_CYCLE.create_date
  is '创建时间';
comment on column BPS_SETL_CYCLE.update_by
  is '更新操作人';
comment on column BPS_SETL_CYCLE.update_date
  is '更新时间';
comment on column BPS_SETL_CYCLE.remark
  is '备注';
comment on column BPS_SETL_CYCLE.del_flag
  is '删除标记';

prompt
prompt Creating table BPS_SYS_BUSINESS_TYPE_DEF
prompt ========================================
prompt
create table BPS_SYS_BUSINESS_TYPE_DEF
(
  id            VARCHAR2(30) not null,
  business_type VARCHAR2(32) not null,
  business_name VARCHAR2(128),
  create_by     VARCHAR2(64),
  create_date   DATE,
  update_by     VARCHAR2(64),
  update_date   DATE,
  remark        VARCHAR2(512),
  deal_flag     CHAR(1)
)
;
alter table BPS_SYS_BUSINESS_TYPE_DEF
  add constraint PK_BPS_SYS_BUSINESS_TYPE_DEF primary key (ID, BUSINESS_TYPE);

prompt
prompt Creating table BPS_SYS_MODULE
prompt =============================
prompt
create table BPS_SYS_MODULE
(
  module_id    NUMBER(6) not null,
  module_code  VARCHAR2(32) not null,
  module_name  VARCHAR2(32) not null,
  program_name VARCHAR2(128) not null,
  note         VARCHAR2(256)
)
;
comment on table BPS_SYS_MODULE
  is '模块定义表';
comment on column BPS_SYS_MODULE.module_id
  is '模块标识';
comment on column BPS_SYS_MODULE.module_code
  is '模块编码';
comment on column BPS_SYS_MODULE.module_name
  is '模块名称';
comment on column BPS_SYS_MODULE.program_name
  is '程序名称';
comment on column BPS_SYS_MODULE.note
  is '备注';
create unique index BPS_SYS_MODULE_IDX1 on BPS_SYS_MODULE (MODULE_CODE);
alter table BPS_SYS_MODULE
  add constraint PK_SYS_MODULE primary key (MODULE_ID);

prompt
prompt Creating table BPS_SYS_MODULE_PARAM
prompt ===================================
prompt
create table BPS_SYS_MODULE_PARAM
(
  module_id    NUMBER(6) not null,
  section_code VARCHAR2(32) not null,
  param_code   VARCHAR2(32) not null,
  param_value  VARCHAR2(1024) not null,
  note         VARCHAR2(256)
)
;
comment on table BPS_SYS_MODULE_PARAM
  is '模块参数明细表';
comment on column BPS_SYS_MODULE_PARAM.module_id
  is '模块标识';
comment on column BPS_SYS_MODULE_PARAM.section_code
  is '参数类别';
comment on column BPS_SYS_MODULE_PARAM.param_code
  is '参数编码';
comment on column BPS_SYS_MODULE_PARAM.param_value
  is '参数取值';
comment on column BPS_SYS_MODULE_PARAM.note
  is '备注';

prompt
prompt Creating table BPS_SYS_ORG_INFO
prompt ===============================
prompt
create table BPS_SYS_ORG_INFO
(
  id              VARCHAR2(30),
  org_code        VARCHAR2(11),
  org_name        VARCHAR2(32),
  area_type       VARCHAR2(2),
  city_code       VARCHAR2(32),
  eff_date        DATE,
  exp_date        DATE,
  create_by       VARCHAR2(64),
  create_date     DATE,
  update_by       VARCHAR2(64),
  update_date     DATE,
  remark          VARCHAR2(512),
  deal_flag       CHAR(1),
  org_attr        VARCHAR2(2),
  center_org_code VARCHAR2(11)
)
;
comment on column BPS_SYS_ORG_INFO.area_type
  is '01：省外
02：省内
03：公司内';
comment on column BPS_SYS_ORG_INFO.org_attr
  is '入网机构属性, 01: 发卡 02:收单 03:发卡收单';

prompt
prompt Creating table BPS_SYS_SERVICE_TYPE_DEF
prompt =======================================
prompt
create table BPS_SYS_SERVICE_TYPE_DEF
(
  id           VARCHAR2(30) not null,
  service_type VARCHAR2(32) not null,
  service_name VARCHAR2(128),
  create_by    VARCHAR2(64),
  create_date  DATE,
  update_by    VARCHAR2(64),
  update_date  DATE,
  remark       VARCHAR2(512),
  deal_flag    CHAR(1)
)
;
alter table BPS_SYS_SERVICE_TYPE_DEF
  add constraint PK_BPS_SYS_SERVICE_TYPE_DEF primary key (ID, SERVICE_TYPE);

prompt
prompt Creating table BPS_SYS_SETT_RATE
prompt ================================
prompt
create table BPS_SYS_SETT_RATE
(
  business_type  VARCHAR2(32) not null,
  service_type   VARCHAR2(8) not null,
  recv_org_code  VARCHAR2(32) not null,
  issue_org_code VARCHAR2(32) not null,
  charge_rate    VARCHAR2(12),
  recv_rate      VARCHAR2(12),
  issue_rate     VARCHAR2(12),
  eff_date       DATE not null,
  exp_date       DATE,
  create_by      VARCHAR2(64),
  create_date    DATE,
  update_by      VARCHAR2(64),
  update_date    DATE,
  remark         VARCHAR2(512),
  deal_flag      CHAR(1),
  id             VARCHAR2(30) not null
)
;
comment on column BPS_SYS_SETT_RATE.business_type
  is '-1：所有行业
1：交通行业
2：其他行业';
comment on column BPS_SYS_SETT_RATE.service_type
  is '01: 公交车
02: 地铁
03: 自行车租赁
04：出租车
-1：所有业务（不区分业务类型）';
comment on column BPS_SYS_SETT_RATE.recv_org_code
  is '收单方机构代码。
-1：不区分收单方，收单分润费率适用于所有收单机构';
comment on column BPS_SYS_SETT_RATE.issue_org_code
  is '发卡方机构代码。
-1：不区分发卡方，发卡分润费率适用于所有发卡机构';
alter table BPS_SYS_SETT_RATE
  add constraint PK_SETT_RATE_KEY1 primary key (ID);

prompt
prompt Creating table BPS_UC_CONF
prompt ==========================
prompt
create table BPS_UC_CONF
(
  id             VARCHAR2(64) not null,
  send_date      VARCHAR2(8),
  send_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  issue_org_code VARCHAR2(11),
  card_no        VARCHAR2(20),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14),
  create_by      VARCHAR2(64) not null,
  create_date    TIMESTAMP(6) not null,
  update_by      VARCHAR2(64) not null,
  update_date    TIMESTAMP(6) not null,
  remarks        NVARCHAR2(255),
  del_flag       CHAR(1) default 0 not null
)
;
comment on column BPS_UC_CONF.id
  is '主键ID';
comment on column BPS_UC_CONF.send_date
  is '发送日期';
comment on column BPS_UC_CONF.send_org_code
  is '发送机构代码';
comment on column BPS_UC_CONF.file_name
  is '文件名称';
comment on column BPS_UC_CONF.issue_org_code
  is '发卡机构代码';
comment on column BPS_UC_CONF.card_no
  is '卡号';
comment on column BPS_UC_CONF.deal_time
  is '处理时间';
comment on column BPS_UC_CONF.indb_time
  is '入库时间';
comment on column BPS_UC_CONF.create_by
  is '创建人';
comment on column BPS_UC_CONF.create_date
  is '创建时间';
comment on column BPS_UC_CONF.update_by
  is '修改人';
comment on column BPS_UC_CONF.update_date
  is '修改时间';
comment on column BPS_UC_CONF.remarks
  is '备注';
comment on column BPS_UC_CONF.del_flag
  is '删除标志';
alter table BPS_UC_CONF
  add primary key (ID);

prompt
prompt Creating table CASH_PROVISIONS
prompt ==============================
prompt
create table CASH_PROVISIONS
(
  id                VARCHAR2(64) not null,
  provisions_no     VARCHAR2(64) not null,
  bankcard_no       VARCHAR2(64) not null,
  pay_period        CHAR(1) not null,
  deposite          NUMBER(38,2) default 0,
  total_amount      NUMBER(38,2) default 0,
  remaining_sum     NUMBER(38,2) default 0,
  withdraw_deposite NUMBER(38,2) default 0,
  need_pay          NUMBER(38,2) default 0,
  user_id           VARCHAR2(64) not null,
  create_by         VARCHAR2(64) not null,
  create_date       DATE not null,
  update_by         VARCHAR2(64) not null,
  update_date       DATE not null,
  remarks           NVARCHAR2(255),
  del_flag          CHAR(1) default '0' not null
)
;
comment on column CASH_PROVISIONS.id
  is '备付金帐号表编号';
comment on column CASH_PROVISIONS.provisions_no
  is '备付金帐号';
comment on column CASH_PROVISIONS.bankcard_no
  is '银行卡号';
comment on column CASH_PROVISIONS.pay_period
  is '缴存周期';
comment on column CASH_PROVISIONS.deposite
  is '押金';
comment on column CASH_PROVISIONS.total_amount
  is '总额';
comment on column CASH_PROVISIONS.remaining_sum
  is '可用余额';
comment on column CASH_PROVISIONS.withdraw_deposite
  is '可提现金额';
comment on column CASH_PROVISIONS.need_pay
  is '应付清算金额';
comment on column CASH_PROVISIONS.user_id
  is '关联的系统用户';
comment on column CASH_PROVISIONS.create_by
  is '创建者';
comment on column CASH_PROVISIONS.create_date
  is '创建时间';
comment on column CASH_PROVISIONS.update_by
  is '更新者';
comment on column CASH_PROVISIONS.update_date
  is '更新时间';
comment on column CASH_PROVISIONS.remarks
  is '备注信息';
comment on column CASH_PROVISIONS.del_flag
  is '删除标记';
alter table CASH_PROVISIONS
  add primary key (ID);

prompt
prompt Creating table CASH_ADVICE_INFO
prompt ===============================
prompt
create table CASH_ADVICE_INFO
(
  id            VARCHAR2(64) not null,
  provisions_id VARCHAR2(64) not null,
  need_pay      NUMBER(38,8) not null,
  reason        VARCHAR2(255),
  pay_deadline  TIMESTAMP(0),
  deal_state    CHAR(1) default 0 not null,
  advice_type   CHAR(1) default 0,
  create_by     VARCHAR2(64) not null,
  create_date   TIMESTAMP(0) not null,
  update_by     VARCHAR2(64) not null,
  update_date   TIMESTAMP(0) not null,
  remarks       NVARCHAR2(255),
  del_flag      CHAR(1) default '0' not null,
  message       NVARCHAR2(255)
)
;
comment on column CASH_ADVICE_INFO.id
  is '编号';
comment on column CASH_ADVICE_INFO.provisions_id
  is '备付金帐号表编号';
comment on column CASH_ADVICE_INFO.need_pay
  is '缴存金额';
comment on column CASH_ADVICE_INFO.reason
  is '缴存状态';
comment on column CASH_ADVICE_INFO.deal_state
  is '处理状态（0:未处理，1:已处理）';
comment on column CASH_ADVICE_INFO.advice_type
  is '通知类型（0:告警通知，1:常规调整通知，2:紧急调整通知,3:周期变更通知，4：提现结果通知）';
comment on column CASH_ADVICE_INFO.create_by
  is '创建者';
comment on column CASH_ADVICE_INFO.create_date
  is '创建时间';
comment on column CASH_ADVICE_INFO.update_by
  is '更新者';
comment on column CASH_ADVICE_INFO.update_date
  is '更新时间';
comment on column CASH_ADVICE_INFO.remarks
  is '备注信息';
comment on column CASH_ADVICE_INFO.del_flag
  is '删除标记';
comment on column CASH_ADVICE_INFO.message
  is '通知内容';
alter table CASH_ADVICE_INFO
  add primary key (ID);
alter table CASH_ADVICE_INFO
  add constraint FK_CASH_ADVICE_INFO foreign key (PROVISIONS_ID)
  references CASH_PROVISIONS (ID);

prompt
prompt Creating table CASH_PAY_PERIOD_RECORD
prompt =====================================
prompt
create table CASH_PAY_PERIOD_RECORD
(
  id              VARCHAR2(64) not null,
  provisions_id   VARCHAR2(64) not null,
  ori_pay_period  CHAR(1) not null,
  cur_pay_period  CHAR(1) not null,
  create_by       VARCHAR2(64) not null,
  create_date     TIMESTAMP(0) not null,
  update_by       VARCHAR2(64) not null,
  update_date     TIMESTAMP(0) not null,
  remarks         NVARCHAR2(255),
  del_flag        CHAR(1) default '0' not null,
  modify_status   CHAR(1) not null,
  nee_pay_money   NUMBER(38,2),
  pay_period_flag CHAR(1) not null,
  examine_status  CHAR(1) not null,
  period_status   CHAR(1) not null
)
;
comment on column CASH_PAY_PERIOD_RECORD.id
  is '备付金帐号表编号';
comment on column CASH_PAY_PERIOD_RECORD.provisions_id
  is '备付金帐号表编号';
comment on column CASH_PAY_PERIOD_RECORD.ori_pay_period
  is '原缴存周期';
comment on column CASH_PAY_PERIOD_RECORD.cur_pay_period
  is '现缴存周期';
comment on column CASH_PAY_PERIOD_RECORD.create_by
  is '创建者';
comment on column CASH_PAY_PERIOD_RECORD.create_date
  is '创建时间';
comment on column CASH_PAY_PERIOD_RECORD.update_by
  is '更新者';
comment on column CASH_PAY_PERIOD_RECORD.update_date
  is '更新时间';
comment on column CASH_PAY_PERIOD_RECORD.remarks
  is '备注信息';
comment on column CASH_PAY_PERIOD_RECORD.del_flag
  is '删除标记';
comment on column CASH_PAY_PERIOD_RECORD.modify_status
  is '变更状态';
comment on column CASH_PAY_PERIOD_RECORD.nee_pay_money
  is '需缴存金额';
comment on column CASH_PAY_PERIOD_RECORD.pay_period_flag
  is '是否缴存';
comment on column CASH_PAY_PERIOD_RECORD.examine_status
  is '审核状态';
comment on column CASH_PAY_PERIOD_RECORD.period_status
  is '申请状态';
alter table CASH_PAY_PERIOD_RECORD
  add primary key (ID);
alter table CASH_PAY_PERIOD_RECORD
  add constraint FK_CASH_PAY_PERIOD_RECORD foreign key (PROVISIONS_ID)
  references CASH_PROVISIONS (ID);

prompt
prompt Creating table CASH_PAY_RECORD
prompt ==============================
prompt
create table CASH_PAY_RECORD
(
  id            VARCHAR2(64) not null,
  provisions_id VARCHAR2(64) not null,
  pay_money     NUMBER(38,8) not null,
  pay_state     CHAR(1) default '0' not null,
  create_by     VARCHAR2(64) not null,
  create_date   TIMESTAMP(0) not null,
  update_by     VARCHAR2(64) not null,
  update_date   TIMESTAMP(0) not null,
  remarks       NVARCHAR2(255),
  del_flag      CHAR(1) default '0' not null,
  office_name   VARCHAR2(100) not null
)
;
comment on column CASH_PAY_RECORD.id
  is '编号';
comment on column CASH_PAY_RECORD.provisions_id
  is '备付金帐号表编号';
comment on column CASH_PAY_RECORD.pay_money
  is '缴存金额';
comment on column CASH_PAY_RECORD.pay_state
  is '缴存状态';
comment on column CASH_PAY_RECORD.create_by
  is '创建者';
comment on column CASH_PAY_RECORD.create_date
  is '创建时间';
comment on column CASH_PAY_RECORD.update_by
  is '更新者';
comment on column CASH_PAY_RECORD.update_date
  is '更新时间';
comment on column CASH_PAY_RECORD.remarks
  is '备注信息';
comment on column CASH_PAY_RECORD.del_flag
  is '删除标记';
comment on column CASH_PAY_RECORD.office_name
  is '所属组织名称';
alter table CASH_PAY_RECORD
  add primary key (ID);
alter table CASH_PAY_RECORD
  add constraint FK_CASH_PAY_RECORD foreign key (PROVISIONS_ID)
  references CASH_PROVISIONS (ID);

prompt
prompt Creating table CASH_WARN_PARA
prompt =============================
prompt
create table CASH_WARN_PARA
(
  id          VARCHAR2(64) not null,
  pay_period  CHAR(1) not null,
  warn_val    NUMBER(10,2) not null,
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(0) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(0) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on column CASH_WARN_PARA.id
  is '备付金帐号表编号';
comment on column CASH_WARN_PARA.pay_period
  is '缴存周期';
comment on column CASH_WARN_PARA.warn_val
  is '告警值';
comment on column CASH_WARN_PARA.create_by
  is '创建者';
comment on column CASH_WARN_PARA.create_date
  is '创建时间';
comment on column CASH_WARN_PARA.update_by
  is '更新者';
comment on column CASH_WARN_PARA.update_date
  is '更新时间';
comment on column CASH_WARN_PARA.remarks
  is '备注信息';
comment on column CASH_WARN_PARA.del_flag
  is '删除标记';
alter table CASH_WARN_PARA
  add primary key (ID);

prompt
prompt Creating table CASH_WITHDRAW_RECORD
prompt ===================================
prompt
create table CASH_WITHDRAW_RECORD
(
  id                     VARCHAR2(64) not null,
  provisions_id          VARCHAR2(64) not null,
  withdraw_deposite      NUMBER(38,8),
  pre_withdraw_deposite  NUMBER(38,8),
  next_withdraw_deposite NUMBER(38,8),
  withdraw_type          CHAR(1) not null,
  withdraw_state         CHAR(1) not null,
  create_by              VARCHAR2(64) not null,
  create_date            TIMESTAMP(0) not null,
  update_by              VARCHAR2(64) not null,
  update_date            TIMESTAMP(0) not null,
  remarks                NVARCHAR2(255),
  del_flag               CHAR(1) default '0' not null
)
;
comment on column CASH_WITHDRAW_RECORD.id
  is '备付金帐号表编号';
comment on column CASH_WITHDRAW_RECORD.provisions_id
  is '备付金帐号表编号';
comment on column CASH_WITHDRAW_RECORD.withdraw_deposite
  is '提现金额';
comment on column CASH_WITHDRAW_RECORD.pre_withdraw_deposite
  is '提现前金额';
comment on column CASH_WITHDRAW_RECORD.next_withdraw_deposite
  is '提现后金额';
comment on column CASH_WITHDRAW_RECORD.withdraw_type
  is '提现类型（0:自动划拨，1:申请提现）';
comment on column CASH_WITHDRAW_RECORD.withdraw_state
  is '提现状态（0:正在提现，1:已提现，2:提现失败）';
comment on column CASH_WITHDRAW_RECORD.create_by
  is '创建者';
comment on column CASH_WITHDRAW_RECORD.create_date
  is '创建时间';
comment on column CASH_WITHDRAW_RECORD.update_by
  is '更新者';
comment on column CASH_WITHDRAW_RECORD.update_date
  is '更新时间';
comment on column CASH_WITHDRAW_RECORD.remarks
  is '备注信息';
comment on column CASH_WITHDRAW_RECORD.del_flag
  is '删除标记';
alter table CASH_WITHDRAW_RECORD
  add primary key (ID);
alter table CASH_WITHDRAW_RECORD
  add constraint FK_CASH_WITHDRAW_RECORD foreign key (PROVISIONS_ID)
  references CASH_PROVISIONS (ID);

prompt
prompt Creating table CDFILE
prompt =====================
prompt
create table CDFILE
(
  file_name VARCHAR2(64)
)
;

prompt
prompt Creating table CDFILE_SYS
prompt =========================
prompt
create table CDFILE_SYS
(
  file_name VARCHAR2(256)
)
;

prompt
prompt Creating table CMS_ARTICLE
prompt ==========================
prompt
create table CMS_ARTICLE
(
  id                  VARCHAR2(64) not null,
  category_id         VARCHAR2(64) not null,
  title               VARCHAR2(255) not null,
  link                VARCHAR2(255),
  color               VARCHAR2(50),
  image               VARCHAR2(255),
  keywords            VARCHAR2(255),
  description         VARCHAR2(255),
  weight              NUMBER(10) default 0,
  weight_date         TIMESTAMP(6),
  hits                NUMBER(10) default 0,
  posid               VARCHAR2(10),
  custom_content_view VARCHAR2(255),
  view_config         CLOB,
  create_by           VARCHAR2(64),
  create_date         TIMESTAMP(6),
  update_by           VARCHAR2(64),
  update_date         TIMESTAMP(6),
  remarks             VARCHAR2(255),
  del_flag            CHAR(1) default '0' not null
)
;
comment on table CMS_ARTICLE
  is '文章表';
comment on column CMS_ARTICLE.id
  is '编号';
comment on column CMS_ARTICLE.category_id
  is '栏目编号';
comment on column CMS_ARTICLE.title
  is '标题';
comment on column CMS_ARTICLE.link
  is '文章链接';
comment on column CMS_ARTICLE.color
  is '标题颜色';
comment on column CMS_ARTICLE.image
  is '文章图片';
comment on column CMS_ARTICLE.keywords
  is '关键字';
comment on column CMS_ARTICLE.description
  is '描述、摘要';
comment on column CMS_ARTICLE.weight
  is '权重，越大越靠前';
comment on column CMS_ARTICLE.weight_date
  is '权重期限';
comment on column CMS_ARTICLE.hits
  is '点击数';
comment on column CMS_ARTICLE.posid
  is '推荐位，多选';
comment on column CMS_ARTICLE.custom_content_view
  is '自定义内容视图';
comment on column CMS_ARTICLE.view_config
  is '视图配置';
comment on column CMS_ARTICLE.create_by
  is '创建者';
comment on column CMS_ARTICLE.create_date
  is '创建时间';
comment on column CMS_ARTICLE.update_by
  is '更新者';
comment on column CMS_ARTICLE.update_date
  is '更新时间';
comment on column CMS_ARTICLE.remarks
  is '备注信息';
comment on column CMS_ARTICLE.del_flag
  is '删除标记';
create index CMS_ARTICLE_CATEGORY_ID on CMS_ARTICLE (CATEGORY_ID);
create index CMS_ARTICLE_CREATE_BY on CMS_ARTICLE (CREATE_BY);
create index CMS_ARTICLE_DEL_FLAG on CMS_ARTICLE (DEL_FLAG);
create index CMS_ARTICLE_KEYWORDS on CMS_ARTICLE (KEYWORDS);
create index CMS_ARTICLE_TITLE on CMS_ARTICLE (TITLE);
create index CMS_ARTICLE_UPDATE_DATE on CMS_ARTICLE (UPDATE_DATE);
create index CMS_ARTICLE_WEIGHT on CMS_ARTICLE (WEIGHT);
alter table CMS_ARTICLE
  add primary key (ID);

prompt
prompt Creating table CMS_ARTICLE_DATA
prompt ===============================
prompt
create table CMS_ARTICLE_DATA
(
  id            VARCHAR2(64) not null,
  content       CLOB,
  copyfrom      VARCHAR2(255),
  relation      VARCHAR2(255),
  allow_comment CHAR(1)
)
;
comment on table CMS_ARTICLE_DATA
  is '文章详表';
comment on column CMS_ARTICLE_DATA.id
  is '编号';
comment on column CMS_ARTICLE_DATA.content
  is '文章内容';
comment on column CMS_ARTICLE_DATA.copyfrom
  is '文章来源';
comment on column CMS_ARTICLE_DATA.relation
  is '相关文章';
comment on column CMS_ARTICLE_DATA.allow_comment
  is '是否允许评论';
alter table CMS_ARTICLE_DATA
  add primary key (ID);

prompt
prompt Creating table CMS_CATEGORY
prompt ===========================
prompt
create table CMS_CATEGORY
(
  id                  VARCHAR2(64) not null,
  parent_id           VARCHAR2(64) not null,
  parent_ids          VARCHAR2(2000) not null,
  site_id             VARCHAR2(64) default '1',
  office_id           VARCHAR2(64),
  module              VARCHAR2(20),
  name                VARCHAR2(100) not null,
  image               VARCHAR2(255),
  href                VARCHAR2(255),
  target              VARCHAR2(20),
  description         VARCHAR2(255),
  keywords            VARCHAR2(255),
  sort                NUMBER(10) default 30,
  in_menu             CHAR(1) default '1',
  in_list             CHAR(1) default '1',
  show_modes          CHAR(1) default '0',
  allow_comment       CHAR(1),
  is_audit            CHAR(1),
  custom_list_view    VARCHAR2(255),
  custom_content_view VARCHAR2(255),
  view_config         CLOB,
  create_by           VARCHAR2(64),
  create_date         TIMESTAMP(6),
  update_by           VARCHAR2(64),
  update_date         TIMESTAMP(6),
  remarks             VARCHAR2(255),
  del_flag            CHAR(1) default '0' not null
)
;
comment on table CMS_CATEGORY
  is '栏目表';
comment on column CMS_CATEGORY.id
  is '编号';
comment on column CMS_CATEGORY.parent_id
  is '父级编号';
comment on column CMS_CATEGORY.parent_ids
  is '所有父级编号';
comment on column CMS_CATEGORY.site_id
  is '站点编号';
comment on column CMS_CATEGORY.office_id
  is '归属机构';
comment on column CMS_CATEGORY.module
  is '栏目模块';
comment on column CMS_CATEGORY.name
  is '栏目名称';
comment on column CMS_CATEGORY.image
  is '栏目图片';
comment on column CMS_CATEGORY.href
  is '链接';
comment on column CMS_CATEGORY.target
  is '目标';
comment on column CMS_CATEGORY.description
  is '描述';
comment on column CMS_CATEGORY.keywords
  is '关键字';
comment on column CMS_CATEGORY.sort
  is '排序（升序）';
comment on column CMS_CATEGORY.in_menu
  is '是否在导航中显示';
comment on column CMS_CATEGORY.in_list
  is '是否在分类页中显示列表';
comment on column CMS_CATEGORY.show_modes
  is '展现方式';
comment on column CMS_CATEGORY.allow_comment
  is '是否允许评论';
comment on column CMS_CATEGORY.is_audit
  is '是否需要审核';
comment on column CMS_CATEGORY.custom_list_view
  is '自定义列表视图';
comment on column CMS_CATEGORY.custom_content_view
  is '自定义内容视图';
comment on column CMS_CATEGORY.view_config
  is '视图配置';
comment on column CMS_CATEGORY.create_by
  is '创建者';
comment on column CMS_CATEGORY.create_date
  is '创建时间';
comment on column CMS_CATEGORY.update_by
  is '更新者';
comment on column CMS_CATEGORY.update_date
  is '更新时间';
comment on column CMS_CATEGORY.remarks
  is '备注信息';
comment on column CMS_CATEGORY.del_flag
  is '删除标记';
create index CMS_CATEGORY_DEL_FLAG on CMS_CATEGORY (DEL_FLAG);
create index CMS_CATEGORY_MODULE on CMS_CATEGORY (MODULE);
create index CMS_CATEGORY_NAME on CMS_CATEGORY (NAME);
create index CMS_CATEGORY_OFFICE_ID on CMS_CATEGORY (OFFICE_ID);
create index CMS_CATEGORY_PARENT_ID on CMS_CATEGORY (PARENT_ID);
create index CMS_CATEGORY_PARENT_IDS on CMS_CATEGORY (PARENT_IDS);
create index CMS_CATEGORY_SITE_ID on CMS_CATEGORY (SITE_ID);
create index CMS_CATEGORY_SORT on CMS_CATEGORY (SORT);
alter table CMS_CATEGORY
  add primary key (ID);

prompt
prompt Creating table CMS_COMMENT
prompt ==========================
prompt
create table CMS_COMMENT
(
  id            VARCHAR2(64) not null,
  category_id   VARCHAR2(64) not null,
  content_id    VARCHAR2(64) not null,
  title         VARCHAR2(255),
  content       VARCHAR2(255),
  name          VARCHAR2(100),
  ip            VARCHAR2(100),
  create_date   TIMESTAMP(6) not null,
  audit_user_id VARCHAR2(64),
  audit_date    TIMESTAMP(6),
  del_flag      CHAR(1) default '0' not null
)
;
comment on table CMS_COMMENT
  is '评论表';
comment on column CMS_COMMENT.id
  is '编号';
comment on column CMS_COMMENT.category_id
  is '栏目编号';
comment on column CMS_COMMENT.content_id
  is '栏目内容的编号';
comment on column CMS_COMMENT.title
  is '栏目内容的标题';
comment on column CMS_COMMENT.content
  is '评论内容';
comment on column CMS_COMMENT.name
  is '评论姓名';
comment on column CMS_COMMENT.ip
  is '评论IP';
comment on column CMS_COMMENT.create_date
  is '评论时间';
comment on column CMS_COMMENT.audit_user_id
  is '审核人';
comment on column CMS_COMMENT.audit_date
  is '审核时间';
comment on column CMS_COMMENT.del_flag
  is '删除标记';
create index CMS_COMMENT_CATEGORY_ID on CMS_COMMENT (CATEGORY_ID);
create index CMS_COMMENT_CONTENT_ID on CMS_COMMENT (CONTENT_ID);
create index CMS_COMMENT_STATUS on CMS_COMMENT (DEL_FLAG);
alter table CMS_COMMENT
  add primary key (ID);

prompt
prompt Creating table CMS_GUESTBOOK
prompt ============================
prompt
create table CMS_GUESTBOOK
(
  id          VARCHAR2(64) not null,
  type        CHAR(1) not null,
  content     VARCHAR2(255) not null,
  name        VARCHAR2(100) not null,
  email       VARCHAR2(100) not null,
  phone       VARCHAR2(100) not null,
  workunit    VARCHAR2(100) not null,
  ip          VARCHAR2(100) not null,
  create_date TIMESTAMP(6) not null,
  re_user_id  VARCHAR2(64),
  re_date     TIMESTAMP(6),
  re_content  VARCHAR2(100),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table CMS_GUESTBOOK
  is '留言板';
comment on column CMS_GUESTBOOK.id
  is '编号';
comment on column CMS_GUESTBOOK.type
  is '留言分类';
comment on column CMS_GUESTBOOK.content
  is '留言内容';
comment on column CMS_GUESTBOOK.name
  is '姓名';
comment on column CMS_GUESTBOOK.email
  is '邮箱';
comment on column CMS_GUESTBOOK.phone
  is '电话';
comment on column CMS_GUESTBOOK.workunit
  is '单位';
comment on column CMS_GUESTBOOK.ip
  is 'IP';
comment on column CMS_GUESTBOOK.create_date
  is '留言时间';
comment on column CMS_GUESTBOOK.re_user_id
  is '回复人';
comment on column CMS_GUESTBOOK.re_date
  is '回复时间';
comment on column CMS_GUESTBOOK.re_content
  is '回复内容';
comment on column CMS_GUESTBOOK.del_flag
  is '删除标记';
create index CMS_GUESTBOOK_DEL_FLAG on CMS_GUESTBOOK (DEL_FLAG);
alter table CMS_GUESTBOOK
  add primary key (ID);

prompt
prompt Creating table CMS_LINK
prompt =======================
prompt
create table CMS_LINK
(
  id          VARCHAR2(64) not null,
  category_id VARCHAR2(64) not null,
  title       VARCHAR2(255) not null,
  color       VARCHAR2(50),
  image       VARCHAR2(255),
  href        VARCHAR2(255),
  weight      NUMBER(10) default 0,
  weight_date TIMESTAMP(6),
  create_by   VARCHAR2(64),
  create_date TIMESTAMP(6),
  update_by   VARCHAR2(64),
  update_date TIMESTAMP(6),
  remarks     VARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table CMS_LINK
  is '友情链接';
comment on column CMS_LINK.id
  is '编号';
comment on column CMS_LINK.category_id
  is '栏目编号';
comment on column CMS_LINK.title
  is '链接名称';
comment on column CMS_LINK.color
  is '标题颜色';
comment on column CMS_LINK.image
  is '链接图片';
comment on column CMS_LINK.href
  is '链接地址';
comment on column CMS_LINK.weight
  is '权重，越大越靠前';
comment on column CMS_LINK.weight_date
  is '权重期限';
comment on column CMS_LINK.create_by
  is '创建者';
comment on column CMS_LINK.create_date
  is '创建时间';
comment on column CMS_LINK.update_by
  is '更新者';
comment on column CMS_LINK.update_date
  is '更新时间';
comment on column CMS_LINK.remarks
  is '备注信息';
comment on column CMS_LINK.del_flag
  is '删除标记';
create index CMS_LINK_CATEGORY_ID on CMS_LINK (CATEGORY_ID);
create index CMS_LINK_CREATE_BY on CMS_LINK (CREATE_BY);
create index CMS_LINK_DEL_FLAG on CMS_LINK (DEL_FLAG);
create index CMS_LINK_TITLE on CMS_LINK (TITLE);
create index CMS_LINK_UPDATE_DATE on CMS_LINK (UPDATE_DATE);
create index CMS_LINK_WEIGHT on CMS_LINK (WEIGHT);
alter table CMS_LINK
  add primary key (ID);

prompt
prompt Creating table CMS_SITE
prompt =======================
prompt
create table CMS_SITE
(
  id                VARCHAR2(64) not null,
  name              VARCHAR2(100) not null,
  title             VARCHAR2(100) not null,
  logo              VARCHAR2(255),
  domain            VARCHAR2(255),
  description       VARCHAR2(255),
  keywords          VARCHAR2(255),
  theme             VARCHAR2(255) default 'default',
  copyright         CLOB,
  custom_index_view VARCHAR2(255),
  create_by         VARCHAR2(64),
  create_date       TIMESTAMP(6),
  update_by         VARCHAR2(64),
  update_date       TIMESTAMP(6),
  remarks           VARCHAR2(255),
  del_flag          CHAR(1) default '0' not null
)
;
comment on table CMS_SITE
  is '站点表';
comment on column CMS_SITE.id
  is '编号';
comment on column CMS_SITE.name
  is '站点名称';
comment on column CMS_SITE.title
  is '站点标题';
comment on column CMS_SITE.logo
  is '站点Logo';
comment on column CMS_SITE.domain
  is '站点域名';
comment on column CMS_SITE.description
  is '描述';
comment on column CMS_SITE.keywords
  is '关键字';
comment on column CMS_SITE.theme
  is '主题';
comment on column CMS_SITE.copyright
  is '版权信息';
comment on column CMS_SITE.custom_index_view
  is '自定义站点首页视图';
comment on column CMS_SITE.create_by
  is '创建者';
comment on column CMS_SITE.create_date
  is '创建时间';
comment on column CMS_SITE.update_by
  is '更新者';
comment on column CMS_SITE.update_date
  is '更新时间';
comment on column CMS_SITE.remarks
  is '备注信息';
comment on column CMS_SITE.del_flag
  is '删除标记';
create index CMS_SITE_DEL_FLAG on CMS_SITE (DEL_FLAG);
alter table CMS_SITE
  add primary key (ID);

prompt
prompt Creating table DR_BILL_DETAIL_201611
prompt ====================================
prompt
create table DR_BILL_DETAIL_201611
(
  dr_type              VARCHAR2(20),
  send_org_code        VARCHAR2(11),
  send_date            VARCHAR2(8),
  sett_date            VARCHAR2(8),
  file_name            VARCHAR2(128),
  trade_code           VARCHAR2(3),
  block_mark           VARCHAR2(4),
  main_account_id      VARCHAR2(19),
  trade_charge         NUMBER(12),
  currency_code        VARCHAR2(3),
  trans_time           VARCHAR2(10),
  trace_no             VARCHAR2(6),
  response_code        VARCHAR2(6),
  grant_date           VARCHAR2(4),
  retriev_no           VARCHAR2(12),
  recv_org_id          VARCHAR2(11),
  send_org_id          VARCHAR2(11),
  seller_type          VARCHAR2(4),
  terminal_id          VARCHAR2(8),
  acquirer_id          VARCHAR2(15),
  acquirer_addr        VARCHAR2(40),
  ori_trade_info       VARCHAR2(23),
  message_code         VARCHAR2(4),
  info_code            VARCHAR2(1),
  sett_org_no          VARCHAR2(9),
  bill_org_code        VARCHAR2(11),
  issue_org_code       VARCHAR2(11),
  sett_notice          VARCHAR2(1),
  trade_channel        VARCHAR2(2),
  trade_sign           VARCHAR2(1),
  settle_stand         VARCHAR2(8),
  condition_code       VARCHAR2(2),
  own_charge           NUMBER(12),
  trade_area_id        VARCHAR2(1),
  etc_flag             VARCHAR2(2),
  special_charge_id    VARCHAR2(2),
  special_charge_level VARCHAR2(1),
  trade_mode           VARCHAR2(1),
  card_no              VARCHAR2(20),
  trade_charge1        VARCHAR2(8),
  trade_type           VARCHAR2(2),
  terminal_num         VARCHAR2(12),
  terminal_trade_no    VARCHAR2(8),
  trade_date           VARCHAR2(8),
  trade_time           VARCHAR2(6),
  tac_code             VARCHAR2(8),
  key_version          VARCHAR2(2),
  key_index            VARCHAR2(2),
  offline_trade_no     VARCHAR2(4),
  trade_balance        VARCHAR2(8),
  issue_org_id         VARCHAR2(16),
  random_num           NUMBER(8),
  cardholder_name      VARCHAR2(40),
  certificates_type    VARCHAR2(2),
  certificates_num     VARCHAR2(30),
  cardholder_type      VARCHAR2(4),
  recv_org_code        VARCHAR2(11),
  recv_org_no          VARCHAR2(12),
  recv_date            VARCHAR2(8),
  sett_org_no1         VARCHAR2(12),
  discount_type        VARCHAR2(4),
  beforetrade_charge   VARCHAR2(8),
  receivable_charge    VARCHAR2(8),
  trade_state          VARCHAR2(2),
  algorithm_flag       VARCHAR2(2),
  card_org_id          VARCHAR2(3),
  tlv_data             VARCHAR2(256),
  roam_type            VARCHAR2(3),
  rate_id              VARCHAR2(6),
  service_fee          NUMBER(12,7),
  issue_fee            NUMBER(12,7),
  bill_fee             NUMBER(12,7),
  sys_error_code       VARCHAR2(4),
  deal_time            VARCHAR2(14),
  indb_time            DATE,
  other_fee            NUMBER(12,7)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201612
prompt ====================================
prompt
create table DR_BILL_DETAIL_201612
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201612_LGW
prompt ========================================
prompt
create table DR_BILL_DETAIL_201612_LGW
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201612_QINGHAI
prompt ============================================
prompt
create table DR_BILL_DETAIL_201612_QINGHAI
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201701
prompt ====================================
prompt
create table DR_BILL_DETAIL_201701
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201702
prompt ====================================
prompt
create table DR_BILL_DETAIL_201702
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201703
prompt ====================================
prompt
create table DR_BILL_DETAIL_201703
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201704
prompt ====================================
prompt
create table DR_BILL_DETAIL_201704
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201705
prompt ====================================
prompt
create table DR_BILL_DETAIL_201705
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201706
prompt ====================================
prompt
create table DR_BILL_DETAIL_201706
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201707
prompt ====================================
prompt
create table DR_BILL_DETAIL_201707
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201708
prompt ====================================
prompt
create table DR_BILL_DETAIL_201708
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201709
prompt ====================================
prompt
create table DR_BILL_DETAIL_201709
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201710
prompt ====================================
prompt
create table DR_BILL_DETAIL_201710
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201711
prompt ====================================
prompt
create table DR_BILL_DETAIL_201711
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201712
prompt ====================================
prompt
create table DR_BILL_DETAIL_201712
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201801
prompt ====================================
prompt
create table DR_BILL_DETAIL_201801
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201802
prompt ====================================
prompt
create table DR_BILL_DETAIL_201802
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201803
prompt ====================================
prompt
create table DR_BILL_DETAIL_201803
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_20180314
prompt ======================================
prompt
create table DR_BILL_DETAIL_20180314
(
  card_no  VARCHAR2(50),
  datetime DATE,
  tac      VARCHAR2(20),
  yue      VARCHAR2(20),
  charge   VARCHAR2(20),
  msg      VARCHAR2(20)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201804
prompt ====================================
prompt
create table DR_BILL_DETAIL_201804
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201805
prompt ====================================
prompt
create table DR_BILL_DETAIL_201805
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201806
prompt ====================================
prompt
create table DR_BILL_DETAIL_201806
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201807
prompt ====================================
prompt
create table DR_BILL_DETAIL_201807
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201808
prompt ====================================
prompt
create table DR_BILL_DETAIL_201808
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201809
prompt ====================================
prompt
create table DR_BILL_DETAIL_201809
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201810
prompt ====================================
prompt
create table DR_BILL_DETAIL_201810
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201811
prompt ====================================
prompt
create table DR_BILL_DETAIL_201811
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_201812
prompt ====================================
prompt
create table DR_BILL_DETAIL_201812
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_DIFF
prompt ==================================
prompt
create table DR_BILL_DETAIL_DIFF
(
  card_no  VARCHAR2(50),
  tac_code VARCHAR2(20)
)
;

prompt
prompt Creating table DR_BILL_DETAIL_YYYYMM
prompt ====================================
prompt
create table DR_BILL_DETAIL_YYYYMM
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE default sysdate,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table DR_CD_201612
prompt ===========================
prompt
create table DR_CD_201612
(
  send_org_code         VARCHAR2(11),
  send_date             VARCHAR2(8),
  sett_date             VARCHAR2(8),
  file_name             VARCHAR2(128),
  trade_code            VARCHAR2(3),
  block_mark            VARCHAR2(4),
  main_account_id       VARCHAR2(19),
  trade_charge          NUMBER(12),
  currency_code         VARCHAR2(3),
  trans_time            VARCHAR2(10),
  trace_no              VARCHAR2(6),
  response_code         VARCHAR2(6),
  grant_date            VARCHAR2(4),
  retriev_no            VARCHAR2(12),
  recv_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  seller_type           VARCHAR2(4),
  terminal_id           VARCHAR2(8),
  acquirer_id           VARCHAR2(15),
  acquirer_addr         VARCHAR2(40),
  ori_trade_info        VARCHAR2(23),
  message_code          VARCHAR2(4),
  info_code             VARCHAR2(1),
  sett_org_no           VARCHAR2(9),
  bill_org_code         VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  sett_notice           VARCHAR2(1),
  trade_channel         VARCHAR2(2),
  trade_sign            VARCHAR2(1),
  settle_stand          VARCHAR2(8),
  condition_code        VARCHAR2(2),
  own_charge            NUMBER(12),
  trade_area_id         VARCHAR2(1),
  etc_flag              VARCHAR2(2),
  special_charge_id     VARCHAR2(2),
  special_charge_level  VARCHAR2(1),
  trade_mode            VARCHAR2(1),
  servc_mode            VARCHAR2(3),
  author_flag           VARCHAR2(1),
  pay_type              VARCHAR2(2),
  sett_charge           NUMBER(12),
  sett_currency         VARCHAR2(3),
  sett_rate             NUMBER(8),
  cardholder_charge     NUMBER(12),
  cardholder_currency   VARCHAR2(3),
  cardholder_rate       NUMBER(8),
  poundage_charge       NUMBER(12),
  oversea_org_name      VARCHAR2(3),
  card_no               VARCHAR2(20),
  trade_charge1         VARCHAR2(8),
  trade_type            VARCHAR2(2),
  terminal_num          VARCHAR2(12),
  terminal_trade_no     VARCHAR2(8),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  tac_code              VARCHAR2(8),
  key_version           VARCHAR2(2),
  key_index             VARCHAR2(2),
  offline_trade_no      VARCHAR2(4),
  trade_balance         VARCHAR2(8),
  issue_org_id          VARCHAR2(16),
  random_num            NUMBER(8),
  cryptogram_data       VARCHAR2(16),
  servc_mode1           VARCHAR2(3),
  card_no2              VARCHAR2(3),
  read_ability          VARCHAR2(1),
  card_conti_code       VARCHAR2(1),
  terminal_ability      VARCHAR2(6),
  terminal_result       VARCHAR2(10),
  unpredictable         VARCHAR2(8),
  interface_no          VARCHAR2(8),
  issue_data            VARCHAR2(64),
  trade_count           VARCHAR2(4),
  interact_charct       VARCHAR2(4),
  trade_date2           VARCHAR2(6),
  country_code          VARCHAR2(3),
  trade_response_no     VARCHAR2(2),
  trade_type2           VARCHAR2(2),
  grant_charge          NUMBER(12),
  trade_currency_code   VARCHAR2(3),
  cryptogram_result     VARCHAR2(1),
  invalid_date          VARCHAR2(4),
  cryptogram_info       VARCHAR2(2),
  other_charge          NUMBER(12),
  verification_result   VARCHAR2(6),
  terminal_type         VARCHAR2(2),
  special_file_name     VARCHAR2(32),
  trade_serial_count    NUMBER(4),
  ec_authorization_code VARCHAR2(8),
  card_info             VARCHAR2(6),
  application_version   VARCHAR2(24),
  cardholder_name       VARCHAR2(40),
  certificates_type     VARCHAR2(2),
  certificates_num      VARCHAR2(30),
  cardholder_type       VARCHAR2(4),
  recv_org_code         VARCHAR2(11),
  recv_org_no           VARCHAR2(12),
  recv_date             VARCHAR2(8),
  sett_org_no1          VARCHAR2(12),
  discount_type         VARCHAR2(4),
  beforetrade_charge    VARCHAR2(8),
  receivable_charge     VARCHAR2(8),
  trade_state           VARCHAR2(2),
  algorithm_flag        VARCHAR2(2),
  card_org_id           VARCHAR2(3),
  tlv_data              VARCHAR2(256),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table DR_WALLET_201612
prompt ===============================
prompt
create table DR_WALLET_201612
(
  file_name            VARCHAR2(128),
  file_type            VARCHAR2(10),
  trade_code           VARCHAR2(3),
  block_mark           VARCHAR2(4),
  main_account_id      VARCHAR2(19),
  trade_amount         NUMBER(12),
  currency_code        VARCHAR2(3),
  trans_time           VARCHAR2(10),
  trace_no             VARCHAR2(6),
  response_code        VARCHAR2(6),
  grant_date           VARCHAR2(4),
  retriev_no           VARCHAR2(12),
  recv_org_id          VARCHAR2(11),
  send_org_id          VARCHAR2(11),
  seller_type          VARCHAR2(4),
  terminal_id          VARCHAR2(8),
  acquirer_id          VARCHAR2(15),
  acquirer_addr        VARCHAR2(40),
  ori_trade_info       VARCHAR2(23),
  message_code         VARCHAR2(4),
  info_code            VARCHAR2(1),
  sett_seril_no        VARCHAR2(9),
  recv_org_id1         VARCHAR2(11),
  issue_org_id1        VARCHAR2(11),
  sett_notice          VARCHAR2(1),
  trade_channel        VARCHAR2(2),
  trade_sign           VARCHAR2(1),
  settle_stand         VARCHAR2(8),
  condition_code       VARCHAR2(2),
  own_charge           NUMBER(12),
  trade_area_id        VARCHAR2(1),
  etc_flag             VARCHAR2(2),
  special_charge_id    VARCHAR2(2),
  special_charge_level VARCHAR2(1),
  trade_mode           VARCHAR2(1),
  servc_mode           VARCHAR2(3),
  author_flag          VARCHAR2(1),
  pay_type             VARCHAR2(2),
  sett_charge          NUMBER(12),
  sett_currency        VARCHAR2(3),
  sett_rate            NUMBER(8),
  cardholder_charge    NUMBER(12),
  cardholder_currency  VARCHAR2(3),
  cardholder_rate      NUMBER(8),
  poundage_charge      NUMBER(12),
  oversea_org_name     VARCHAR2(3),
  card_no              VARCHAR2(20),
  trade_charge1        NUMBER(8),
  trade_type           VARCHAR2(2),
  terminal_num         VARCHAR2(12),
  terminal_serial_no   VARCHAR2(8),
  trade_date           VARCHAR2(8),
  trade_time           VARCHAR2(6),
  tac_code             VARCHAR2(8),
  key_version          VARCHAR2(2),
  key_index            VARCHAR2(2),
  offline_trade_no     VARCHAR2(4),
  trade_charge         NUMBER(8),
  issue_org_id         VARCHAR2(16),
  random_num           NUMBER(8),
  cardholder_name      VARCHAR2(40),
  certificates_type    VARCHAR2(2),
  certificates_num     VARCHAR2(30),
  cardholder_type      VARCHAR2(4),
  recv_org_code        VARCHAR2(11),
  recv_seril_no        VARCHAR2(12),
  recv_date            VARCHAR2(8),
  sett_seril_no1       VARCHAR2(12),
  discount_type        VARCHAR2(4),
  beforetrade_amount   NUMBER(8),
  charge_amount        NUMBER(8),
  trade_state          VARCHAR2(2),
  algorithm_flag       VARCHAR2(2),
  card_org_id          VARCHAR2(3),
  tlv_data             VARCHAR2(256),
  deal_time            VARCHAR2(8),
  indb_time            VARCHAR2(8)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201612
prompt ====================================
prompt
create table ER_BILL_DETAIL_201612
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201701
prompt ====================================
prompt
create table ER_BILL_DETAIL_201701
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201702
prompt ====================================
prompt
create table ER_BILL_DETAIL_201702
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201703
prompt ====================================
prompt
create table ER_BILL_DETAIL_201703
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201704
prompt ====================================
prompt
create table ER_BILL_DETAIL_201704
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201705
prompt ====================================
prompt
create table ER_BILL_DETAIL_201705
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201706
prompt ====================================
prompt
create table ER_BILL_DETAIL_201706
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201707
prompt ====================================
prompt
create table ER_BILL_DETAIL_201707
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201708
prompt ====================================
prompt
create table ER_BILL_DETAIL_201708
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201709
prompt ====================================
prompt
create table ER_BILL_DETAIL_201709
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201710
prompt ====================================
prompt
create table ER_BILL_DETAIL_201710
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201711
prompt ====================================
prompt
create table ER_BILL_DETAIL_201711
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201712
prompt ====================================
prompt
create table ER_BILL_DETAIL_201712
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201801
prompt ====================================
prompt
create table ER_BILL_DETAIL_201801
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201802
prompt ====================================
prompt
create table ER_BILL_DETAIL_201802
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201803
prompt ====================================
prompt
create table ER_BILL_DETAIL_201803
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201804
prompt ====================================
prompt
create table ER_BILL_DETAIL_201804
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201805
prompt ====================================
prompt
create table ER_BILL_DETAIL_201805
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201806
prompt ====================================
prompt
create table ER_BILL_DETAIL_201806
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201807
prompt ====================================
prompt
create table ER_BILL_DETAIL_201807
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201808
prompt ====================================
prompt
create table ER_BILL_DETAIL_201808
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201809
prompt ====================================
prompt
create table ER_BILL_DETAIL_201809
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201810
prompt ====================================
prompt
create table ER_BILL_DETAIL_201810
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201811
prompt ====================================
prompt
create table ER_BILL_DETAIL_201811
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_201812
prompt ====================================
prompt
create table ER_BILL_DETAIL_201812
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table ER_BILL_DETAIL_YYYYMM
prompt ====================================
prompt
create table ER_BILL_DETAIL_YYYYMM
(
  dr_type                VARCHAR2(20),
  file_type              VARCHAR2(5),
  send_org_code          VARCHAR2(11),
  send_date              VARCHAR2(8),
  sett_date              VARCHAR2(8),
  file_name              VARCHAR2(128),
  trade_code             VARCHAR2(3),
  block_mark             VARCHAR2(4),
  main_account_id        VARCHAR2(19),
  trade_charge           NUMBER(12),
  currency_code          VARCHAR2(3),
  trans_time             VARCHAR2(10),
  trace_no               VARCHAR2(6),
  response_code          VARCHAR2(6),
  grant_date             VARCHAR2(4),
  retriev_no             VARCHAR2(12),
  recv_org_id            VARCHAR2(11),
  send_org_id            VARCHAR2(11),
  seller_type            VARCHAR2(4),
  terminal_id            VARCHAR2(8),
  acquirer_id            VARCHAR2(15),
  acquirer_addr          VARCHAR2(40),
  ori_trade_info         VARCHAR2(23),
  message_code           VARCHAR2(4),
  info_code              VARCHAR2(1),
  sett_org_no            VARCHAR2(9),
  bill_org_code          VARCHAR2(11),
  issue_org_code         VARCHAR2(11),
  sett_notice            VARCHAR2(1),
  trade_channel          VARCHAR2(2),
  trade_sign             VARCHAR2(1),
  settle_stand           VARCHAR2(8),
  condition_code         VARCHAR2(2),
  own_charge             NUMBER(12),
  trade_area_id          VARCHAR2(1),
  etc_flag               VARCHAR2(2),
  special_charge_id      VARCHAR2(2),
  special_charge_level   VARCHAR2(1),
  trade_mode             VARCHAR2(1),
  card_no                VARCHAR2(20),
  trade_charge1          VARCHAR2(8),
  trade_type             VARCHAR2(2),
  terminal_num           VARCHAR2(12),
  terminal_trade_no      VARCHAR2(8),
  trade_date             VARCHAR2(8),
  trade_time             VARCHAR2(6),
  tac_code               VARCHAR2(8),
  key_version            VARCHAR2(2),
  key_index              VARCHAR2(2),
  offline_trade_no       VARCHAR2(6),
  trade_balance          VARCHAR2(8),
  issue_org_id           VARCHAR2(16),
  random_num             NUMBER(8),
  cardholder_name        VARCHAR2(40),
  certificates_type      VARCHAR2(2),
  certificates_num       VARCHAR2(30),
  cardholder_type        VARCHAR2(4),
  recv_org_code          VARCHAR2(11),
  recv_org_no            VARCHAR2(12),
  recv_date              VARCHAR2(8),
  sett_org_no1           VARCHAR2(12),
  discount_type          VARCHAR2(4),
  beforetrade_charge     VARCHAR2(8),
  receivable_charge      VARCHAR2(8),
  trade_state            VARCHAR2(2),
  algorithm_flag         VARCHAR2(2),
  card_org_id            VARCHAR2(3),
  tlv_data               VARCHAR2(256),
  actual_issue_org_code  VARCHAR2(16),
  roam_type              VARCHAR2(3),
  rate_id                VARCHAR2(6),
  service_fee            NUMBER(12,7),
  issue_fee              NUMBER(12,7),
  bill_fee               NUMBER(12,7),
  sys_error_code         VARCHAR2(6),
  sys_error_msg          VARCHAR2(64),
  deal_time              VARCHAR2(14),
  indb_time              DATE default sysdate,
  other_fee              NUMBER(12,7),
  beforetrade_charge_dec NUMBER(12),
  balance_type           VARCHAR2(2),
  test_flag              VARCHAR2(2)
)
;

prompt
prompt Creating table GEN_DISCOUNT_ACCT
prompt ================================
prompt
create table GEN_DISCOUNT_ACCT
(
  id          NUMBER(12),
  accountid   NUMBER(20) not null,
  state       CHAR(1),
  discount_id NUMBER(12),
  memo        VARCHAR2(100)
)
;

prompt
prompt Creating table GEN_DISCOUNT_RULE
prompt ================================
prompt
create table GEN_DISCOUNT_RULE
(
  id         NUMBER(12),
  siso       NUMBER,
  sisi       NUMBER,
  cquick     NUMBER,
  cmail      NUMBER,
  confirm    NUMBER,
  b          NUMBER,
  c          NUMBER,
  btlx       NUMBER,
  f          NUMBER,
  f_mpds     NUMBER,
  f_mini     NUMBER,
  m          NUMBER,
  cond_b     VARCHAR2(1000),
  cond_btlx  VARCHAR2(1000),
  cond_m     VARCHAR2(1000),
  cond_mpds  VARCHAR2(1000),
  cond_mini  VARCHAR2(1000),
  cond_f     VARCHAR2(1000),
  cond_c     VARCHAR2(1000),
  name       VARCHAR2(200),
  swift      NUMBER,
  cond_swift VARCHAR2(1000),
  cond_cmail VARCHAR2(1000)
)
;

prompt
prompt Creating table GEN_SCHEME
prompt =========================
prompt
create table GEN_SCHEME
(
  id                   VARCHAR2(64) not null,
  name                 NVARCHAR2(200),
  category             VARCHAR2(2000),
  package_name         VARCHAR2(500),
  module_name          VARCHAR2(30),
  sub_module_name      VARCHAR2(30),
  function_name        NVARCHAR2(500),
  function_name_simple NVARCHAR2(100),
  function_author      NVARCHAR2(100),
  gen_table_id         VARCHAR2(200),
  create_by            VARCHAR2(64),
  create_date          TIMESTAMP(6),
  update_by            VARCHAR2(64),
  update_date          TIMESTAMP(6),
  remarks              NVARCHAR2(255),
  del_flag             CHAR(1) default '0' not null
)
;
comment on table GEN_SCHEME
  is '生成方案';
comment on column GEN_SCHEME.id
  is '编号';
comment on column GEN_SCHEME.name
  is '名称';
comment on column GEN_SCHEME.category
  is '分类';
comment on column GEN_SCHEME.package_name
  is '生成包路径';
comment on column GEN_SCHEME.module_name
  is '生成模块名';
comment on column GEN_SCHEME.sub_module_name
  is '生成子模块名';
comment on column GEN_SCHEME.function_name
  is '生成功能名';
comment on column GEN_SCHEME.function_name_simple
  is '生成功能名（简写）';
comment on column GEN_SCHEME.function_author
  is '生成功能作者';
comment on column GEN_SCHEME.gen_table_id
  is '生成表编号';
comment on column GEN_SCHEME.create_by
  is '创建者';
comment on column GEN_SCHEME.create_date
  is '创建时间';
comment on column GEN_SCHEME.update_by
  is '更新者';
comment on column GEN_SCHEME.update_date
  is '更新时间';
comment on column GEN_SCHEME.remarks
  is '备注信息';
comment on column GEN_SCHEME.del_flag
  is '删除标记（0：正常；1：删除）';
create index GEN_SCHEME_DEL_FLAG on GEN_SCHEME (DEL_FLAG);
alter table GEN_SCHEME
  add primary key (ID);

prompt
prompt Creating table GEN_TABLE
prompt ========================
prompt
create table GEN_TABLE
(
  id              VARCHAR2(64) not null,
  name            NVARCHAR2(200),
  comments        NVARCHAR2(500),
  class_name      VARCHAR2(100),
  parent_table    VARCHAR2(200),
  parent_table_fk VARCHAR2(100),
  create_by       VARCHAR2(64),
  create_date     TIMESTAMP(6),
  update_by       VARCHAR2(64),
  update_date     TIMESTAMP(6),
  remarks         NVARCHAR2(255),
  del_flag        CHAR(1) default '0' not null
)
;
comment on table GEN_TABLE
  is '业务表';
comment on column GEN_TABLE.id
  is '编号';
comment on column GEN_TABLE.name
  is '名称';
comment on column GEN_TABLE.comments
  is '描述';
comment on column GEN_TABLE.class_name
  is '实体类名称';
comment on column GEN_TABLE.parent_table
  is '关联父表';
comment on column GEN_TABLE.parent_table_fk
  is '关联父表外键';
comment on column GEN_TABLE.create_by
  is '创建者';
comment on column GEN_TABLE.create_date
  is '创建时间';
comment on column GEN_TABLE.update_by
  is '更新者';
comment on column GEN_TABLE.update_date
  is '更新时间';
comment on column GEN_TABLE.remarks
  is '备注信息';
comment on column GEN_TABLE.del_flag
  is '删除标记（0：正常；1：删除）';
create index GEN_TABLE_DEL_FLAG on GEN_TABLE (DEL_FLAG);
create index GEN_TABLE_NAME on GEN_TABLE (NAME);
alter table GEN_TABLE
  add primary key (ID);

prompt
prompt Creating table GEN_TABLE_COLUMN
prompt ===============================
prompt
create table GEN_TABLE_COLUMN
(
  id            VARCHAR2(64) not null,
  gen_table_id  VARCHAR2(64),
  name          NVARCHAR2(200),
  comments      NVARCHAR2(500),
  jdbc_type     VARCHAR2(100),
  java_type     VARCHAR2(500),
  java_field    VARCHAR2(200),
  is_pk         CHAR(1),
  is_null       CHAR(1),
  is_insert     CHAR(1),
  is_edit       CHAR(1),
  is_list       CHAR(1),
  is_query      CHAR(1),
  query_type    VARCHAR2(200),
  show_type     VARCHAR2(200),
  dict_type     VARCHAR2(200),
  settings      NVARCHAR2(2000),
  sort          NUMBER,
  create_by     VARCHAR2(64),
  create_date   TIMESTAMP(6),
  update_by     VARCHAR2(64),
  update_date   TIMESTAMP(6),
  remarks       NVARCHAR2(255),
  del_flag      CHAR(1) default '0' not null,
  is_list_order CHAR(1) default 0
)
;
comment on table GEN_TABLE_COLUMN
  is '业务表字段';
comment on column GEN_TABLE_COLUMN.id
  is '编号';
comment on column GEN_TABLE_COLUMN.gen_table_id
  is '归属表编号';
comment on column GEN_TABLE_COLUMN.name
  is '名称';
comment on column GEN_TABLE_COLUMN.comments
  is '描述';
comment on column GEN_TABLE_COLUMN.jdbc_type
  is '列的数据类型的字节长度';
comment on column GEN_TABLE_COLUMN.java_type
  is 'JAVA类型';
comment on column GEN_TABLE_COLUMN.java_field
  is 'JAVA字段名';
comment on column GEN_TABLE_COLUMN.is_pk
  is '是否主键';
comment on column GEN_TABLE_COLUMN.is_null
  is '是否可为空';
comment on column GEN_TABLE_COLUMN.is_insert
  is '是否为插入字段';
comment on column GEN_TABLE_COLUMN.is_edit
  is '是否编辑字段';
comment on column GEN_TABLE_COLUMN.is_list
  is '是否列表字段';
comment on column GEN_TABLE_COLUMN.is_query
  is '是否查询字段';
comment on column GEN_TABLE_COLUMN.query_type
  is '查询方式（等于、不等于、大于、小于、范围、左LIKE、右LIKE、左右LIKE）';
comment on column GEN_TABLE_COLUMN.show_type
  is '字段生成方案（文本框、文本域、下拉框、复选框、单选框、字典选择、人员选择、部门选择、区域选择）';
comment on column GEN_TABLE_COLUMN.dict_type
  is '字典类型';
comment on column GEN_TABLE_COLUMN.settings
  is '其它设置（扩展字段JSON）';
comment on column GEN_TABLE_COLUMN.sort
  is '排序（升序）';
comment on column GEN_TABLE_COLUMN.create_by
  is '创建者';
comment on column GEN_TABLE_COLUMN.create_date
  is '创建时间';
comment on column GEN_TABLE_COLUMN.update_by
  is '更新者';
comment on column GEN_TABLE_COLUMN.update_date
  is '更新时间';
comment on column GEN_TABLE_COLUMN.remarks
  is '备注信息';
comment on column GEN_TABLE_COLUMN.del_flag
  is '删除标记（0：正常；1：删除）';
comment on column GEN_TABLE_COLUMN.is_list_order
  is '字段是否排序';
create index GEN_TABLE_COLUMN_DEL_FLAG on GEN_TABLE_COLUMN (DEL_FLAG);
create index GEN_TABLE_COLUMN_NAME on GEN_TABLE_COLUMN (NAME);
create index GEN_TABLE_COLUMN_SORT on GEN_TABLE_COLUMN (SORT);
create index GEN_TABLE_COLUMN_TABLE_ID on GEN_TABLE_COLUMN (GEN_TABLE_ID);
alter table GEN_TABLE_COLUMN
  add primary key (ID);

prompt
prompt Creating table GEN_TEMPLATE
prompt ===========================
prompt
create table GEN_TEMPLATE
(
  id          VARCHAR2(64) not null,
  name        NVARCHAR2(200),
  category    VARCHAR2(2000),
  file_path   VARCHAR2(500),
  file_name   VARCHAR2(200),
  content     CLOB,
  create_by   VARCHAR2(64),
  create_date TIMESTAMP(6),
  update_by   VARCHAR2(64),
  update_date TIMESTAMP(6),
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table GEN_TEMPLATE
  is '代码模板表';
comment on column GEN_TEMPLATE.id
  is '编号';
comment on column GEN_TEMPLATE.name
  is '名称';
comment on column GEN_TEMPLATE.category
  is '分类';
comment on column GEN_TEMPLATE.file_path
  is '生成文件路径';
comment on column GEN_TEMPLATE.file_name
  is '生成文件名';
comment on column GEN_TEMPLATE.content
  is '内容';
comment on column GEN_TEMPLATE.create_by
  is '创建者';
comment on column GEN_TEMPLATE.create_date
  is '创建时间';
comment on column GEN_TEMPLATE.update_by
  is '更新者';
comment on column GEN_TEMPLATE.update_date
  is '更新时间';
comment on column GEN_TEMPLATE.remarks
  is '备注信息';
comment on column GEN_TEMPLATE.del_flag
  is '删除标记（0：正常；1：删除）';
create index GEN_TEMPLATE_DEL_FALG on GEN_TEMPLATE (DEL_FLAG);
alter table GEN_TEMPLATE
  add primary key (ID);

prompt
prompt Creating table INFO_BN_CONF
prompt ===========================
prompt
create table INFO_BN_CONF
(
  down_date      VARCHAR2(8),
  file_name      VARCHAR2(128),
  issue_org_code VARCHAR2(11),
  card_bin_no    VARCHAR2(10),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table INFO_BN_CONF_TEMP
prompt ================================
prompt
create table INFO_BN_CONF_TEMP
(
  down_date      VARCHAR2(8),
  file_name      VARCHAR2(128),
  issue_org_code VARCHAR2(11),
  card_bin_no    VARCHAR2(10),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table INFO_DC_CONF
prompt ===========================
prompt
create table INFO_DC_CONF
(
  down_date      VARCHAR2(8),
  file_name      VARCHAR2(128),
  issue_org_code VARCHAR2(11),
  card_no        VARCHAR2(20),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table INFO_ER_CONF
prompt ===========================
prompt
create table INFO_ER_CONF
(
  down_date VARCHAR2(8),
  file_name VARCHAR2(128),
  err_code  VARCHAR2(6),
  err_info  VARCHAR2(40),
  deal_time VARCHAR2(14),
  indb_time VARCHAR2(14)
)
;

prompt
prompt Creating table INFO_ER_CONF_TEMP
prompt ================================
prompt
create table INFO_ER_CONF_TEMP
(
  down_date VARCHAR2(8),
  file_name VARCHAR2(128),
  err_code  VARCHAR2(6),
  err_info  VARCHAR2(40),
  deal_time VARCHAR2(14),
  indb_time VARCHAR2(14),
  id        VARCHAR2(40)
)
;

prompt
prompt Creating table INFO_UC_CONF
prompt ===========================
prompt
create table INFO_UC_CONF
(
  send_date      VARCHAR2(8),
  send_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  issue_org_code VARCHAR2(11),
  card_no        VARCHAR2(20),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table INFO_UC_CONF_TEMP
prompt ================================
prompt
create table INFO_UC_CONF_TEMP
(
  send_date      VARCHAR2(8),
  send_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  issue_org_code VARCHAR2(11),
  card_no        VARCHAR2(20),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table OA_LEAVE
prompt =======================
prompt
create table OA_LEAVE
(
  id                  VARCHAR2(64) not null,
  process_instance_id VARCHAR2(64),
  start_time          TIMESTAMP(6),
  end_time            TIMESTAMP(6),
  leave_type          VARCHAR2(20),
  reason              NVARCHAR2(255),
  apply_time          TIMESTAMP(6),
  reality_start_time  TIMESTAMP(6),
  reality_end_time    TIMESTAMP(6),
  create_by           VARCHAR2(64) not null,
  create_date         TIMESTAMP(6) not null,
  update_by           VARCHAR2(64) not null,
  update_date         TIMESTAMP(6) not null,
  remarks             NVARCHAR2(255),
  del_flag            CHAR(1) default '0' not null
)
;
comment on table OA_LEAVE
  is '请假流程表';
comment on column OA_LEAVE.id
  is '编号';
comment on column OA_LEAVE.process_instance_id
  is '流程实例编号';
comment on column OA_LEAVE.start_time
  is '开始时间';
comment on column OA_LEAVE.end_time
  is '结束时间';
comment on column OA_LEAVE.leave_type
  is '请假类型';
comment on column OA_LEAVE.reason
  is '请假理由';
comment on column OA_LEAVE.apply_time
  is '申请时间';
comment on column OA_LEAVE.reality_start_time
  is '实际开始时间';
comment on column OA_LEAVE.reality_end_time
  is '实际结束时间';
comment on column OA_LEAVE.create_by
  is '创建者';
comment on column OA_LEAVE.create_date
  is '创建时间';
comment on column OA_LEAVE.update_by
  is '更新者';
comment on column OA_LEAVE.update_date
  is '更新时间';
comment on column OA_LEAVE.remarks
  is '备注信息';
comment on column OA_LEAVE.del_flag
  is '删除标记';
create index OA_LEAVE_CREATE_BY on OA_LEAVE (CREATE_BY);
create index OA_LEAVE_DEL_FLAG on OA_LEAVE (DEL_FLAG);
create index OA_LEAVE_PROCESS_INSTANCE_ID on OA_LEAVE (PROCESS_INSTANCE_ID);
alter table OA_LEAVE
  add primary key (ID);

prompt
prompt Creating table OA_NOTIFY
prompt ========================
prompt
create table OA_NOTIFY
(
  id          VARCHAR2(64) not null,
  type        CHAR(1),
  title       NVARCHAR2(200),
  content     NVARCHAR2(2000),
  files       NVARCHAR2(2000),
  status      CHAR(1),
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table OA_NOTIFY
  is '通知通告';
comment on column OA_NOTIFY.id
  is '编号';
comment on column OA_NOTIFY.type
  is '类型';
comment on column OA_NOTIFY.title
  is '标题';
comment on column OA_NOTIFY.content
  is '内容';
comment on column OA_NOTIFY.files
  is '附件';
comment on column OA_NOTIFY.status
  is '状态';
comment on column OA_NOTIFY.create_by
  is '创建者';
comment on column OA_NOTIFY.create_date
  is '创建时间';
comment on column OA_NOTIFY.update_by
  is '更新者';
comment on column OA_NOTIFY.update_date
  is '更新时间';
comment on column OA_NOTIFY.remarks
  is '备注信息';
comment on column OA_NOTIFY.del_flag
  is '删除标记';
create index OA_NOTIFY_DEL_FLAG on OA_NOTIFY (DEL_FLAG);
alter table OA_NOTIFY
  add primary key (ID);

prompt
prompt Creating table OA_NOTIFY_RECORD
prompt ===============================
prompt
create table OA_NOTIFY_RECORD
(
  id           VARCHAR2(64) not null,
  oa_notify_id VARCHAR2(64),
  user_id      VARCHAR2(64),
  read_flag    CHAR(1) default '0',
  read_date    DATE
)
;
comment on table OA_NOTIFY_RECORD
  is '通知通告发送记录';
comment on column OA_NOTIFY_RECORD.id
  is '编号';
comment on column OA_NOTIFY_RECORD.oa_notify_id
  is '通知通告ID';
comment on column OA_NOTIFY_RECORD.user_id
  is '接受人';
comment on column OA_NOTIFY_RECORD.read_flag
  is '阅读标记';
comment on column OA_NOTIFY_RECORD.read_date
  is '阅读时间';
create index OA_NOTIFY_RECORD_NOTIFY_ID on OA_NOTIFY_RECORD (OA_NOTIFY_ID);
create index OA_NOTIFY_RECORD_READ_FLAG on OA_NOTIFY_RECORD (READ_FLAG);
create index OA_NOTIFY_RECORD_USER_ID on OA_NOTIFY_RECORD (USER_ID);
alter table OA_NOTIFY_RECORD
  add primary key (ID);

prompt
prompt Creating table OA_TEST_AUDIT
prompt ============================
prompt
create table OA_TEST_AUDIT
(
  id             VARCHAR2(64) not null,
  proc_ins_id    VARCHAR2(64),
  user_id        VARCHAR2(64),
  office_id      VARCHAR2(64),
  post           NVARCHAR2(255),
  age            CHAR(1),
  edu            NVARCHAR2(255),
  content        NVARCHAR2(255),
  olda           VARCHAR2(255),
  oldb           VARCHAR2(255),
  oldc           VARCHAR2(255),
  newa           VARCHAR2(255),
  newb           VARCHAR2(255),
  newc           VARCHAR2(255),
  add_num        VARCHAR2(255),
  exe_date       VARCHAR2(255),
  hr_text        NVARCHAR2(255),
  lead_text      NVARCHAR2(255),
  main_lead_text NVARCHAR2(255),
  create_by      VARCHAR2(64) not null,
  create_date    TIMESTAMP(6) not null,
  update_by      VARCHAR2(64) not null,
  update_date    TIMESTAMP(6) not null,
  remarks        NVARCHAR2(255),
  del_flag       CHAR(1) default '0' not null
)
;
comment on table OA_TEST_AUDIT
  is '审批流程测试表';
comment on column OA_TEST_AUDIT.id
  is '编号';
comment on column OA_TEST_AUDIT.proc_ins_id
  is '流程实例ID';
comment on column OA_TEST_AUDIT.user_id
  is '变动用户';
comment on column OA_TEST_AUDIT.office_id
  is '归属部门';
comment on column OA_TEST_AUDIT.post
  is '岗位';
comment on column OA_TEST_AUDIT.age
  is '性别';
comment on column OA_TEST_AUDIT.edu
  is '学历';
comment on column OA_TEST_AUDIT.content
  is '调整原因';
comment on column OA_TEST_AUDIT.olda
  is '现行标准 薪酬档级';
comment on column OA_TEST_AUDIT.oldb
  is '现行标准 月工资额';
comment on column OA_TEST_AUDIT.oldc
  is '现行标准 年薪总额';
comment on column OA_TEST_AUDIT.newa
  is '调整后标准 薪酬档级';
comment on column OA_TEST_AUDIT.newb
  is '调整后标准 月工资额';
comment on column OA_TEST_AUDIT.newc
  is '调整后标准 年薪总额';
comment on column OA_TEST_AUDIT.add_num
  is '月增资';
comment on column OA_TEST_AUDIT.exe_date
  is '执行时间';
comment on column OA_TEST_AUDIT.hr_text
  is '人力资源部门意见';
comment on column OA_TEST_AUDIT.lead_text
  is '分管领导意见';
comment on column OA_TEST_AUDIT.main_lead_text
  is '集团主要领导意见';
comment on column OA_TEST_AUDIT.create_by
  is '创建者';
comment on column OA_TEST_AUDIT.create_date
  is '创建时间';
comment on column OA_TEST_AUDIT.update_by
  is '更新者';
comment on column OA_TEST_AUDIT.update_date
  is '更新时间';
comment on column OA_TEST_AUDIT.remarks
  is '备注信息';
comment on column OA_TEST_AUDIT.del_flag
  is '删除标记';
create index OA_TEST_AUDIT_DEL_FLAG on OA_TEST_AUDIT (DEL_FLAG);
alter table OA_TEST_AUDIT
  add primary key (ID);

prompt
prompt Creating table OB_DATABASE_CONFIG
prompt =================================
prompt
create table OB_DATABASE_CONFIG
(
  suit_id     VARCHAR2(16) not null,
  database_id NUMBER(3) not null,
  conn_id     NUMBER(3) not null,
  remark      VARCHAR2(64)
)
;
comment on table OB_DATABASE_CONFIG
  is '数据库连接配置表';
comment on column OB_DATABASE_CONFIG.suit_id
  is '数据库的SUIT_ID（对应 cbsset 中的 SUIT_ID）';
comment on column OB_DATABASE_CONFIG.database_id
  is '逻辑数据库ID，取值为1（计费）、2（帐务）、3（客服）；';
comment on column OB_DATABASE_CONFIG.conn_id
  is '连接ID';
comment on column OB_DATABASE_CONFIG.remark
  is 'REMARK';
alter table OB_DATABASE_CONFIG
  add constraint PK_OB_DATABASE_CONFIG primary key (CONN_ID, DATABASE_ID, SUIT_ID);

prompt
prompt Creating table OB_SERVER_CONFIG
prompt ===============================
prompt
create table OB_SERVER_CONFIG
(
  conn_id       NUMBER(3) not null,
  database_name VARCHAR2(1024) not null,
  server_name   VARCHAR2(1024) not null,
  user_name     VARCHAR2(32) not null,
  password      VARCHAR2(32) not null,
  remark        VARCHAR2(64)
)
;
comment on table OB_SERVER_CONFIG
  is '数据库连接配置表2';
comment on column OB_SERVER_CONFIG.conn_id
  is '连接ID';
comment on column OB_SERVER_CONFIG.database_name
  is '数据库名称,该字段的值需要和 cbsset 中的 DatabaseName相同';
comment on column OB_SERVER_CONFIG.server_name
  is '数据库TNS名称';
comment on column OB_SERVER_CONFIG.user_name
  is '数据库用户名';
comment on column OB_SERVER_CONFIG.password
  is '加密格式的数据库登录口令';
comment on column OB_SERVER_CONFIG.remark
  is 'REMARK';
alter table OB_SERVER_CONFIG
  add constraint PK_OB_SERVER_CONFIG primary key (CONN_ID);

prompt
prompt Creating table PUB_SYS_PARA
prompt ===========================
prompt
create table PUB_SYS_PARA
(
  area_code       VARCHAR2(16) not null,
  param_code      VARCHAR2(32) not null,
  param_name      VARCHAR2(64) not null,
  param_class     NUMBER(4) not null,
  param_data_type VARCHAR2(2) not null,
  param_value     VARCHAR2(1024) not null,
  param_desc      VARCHAR2(256),
  region_id       VARCHAR2(16)
)
;
comment on table PUB_SYS_PARA
  is '系统参数定义表';
comment on column PUB_SYS_PARA.area_code
  is '系统中对应的地区代码表内容，如果是0表示对所有的地区有效';
comment on column PUB_SYS_PARA.param_code
  is '为字符配置，具有一定含义';
comment on column PUB_SYS_PARA.param_name
  is '0';
comment on column PUB_SYS_PARA.param_class
  is '系统基础参数所属的子系统：1 计费2 帐务处理3 信用控制4帐务管理5综合结算6 统一接口';
comment on column PUB_SYS_PARA.param_data_type
  is '参数的数据类别：(1-Char??2-Number??3-Boolean??4-String 5-Long 6-Date 7-Double';
comment on column PUB_SYS_PARA.param_value
  is '0';
comment on column PUB_SYS_PARA.param_desc
  is '0';
comment on column PUB_SYS_PARA.region_id
  is '区域编码';

prompt
prompt Creating table SETT_AD_DETAIL
prompt =============================
prompt
create table SETT_AD_DETAIL
(
  sett_date             VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_change_no        VARCHAR2(12),
  ori_sett_date         VARCHAR2(8),
  ori_sett_org_no       VARCHAR2(12),
  ori_bill_org_no       VARCHAR2(12),
  ori_bill_deal_date    VARCHAR2(8),
  ori_retriev_no        VARCHAR2(12),
  ori_trade_type        VARCHAR2(4),
  adjust_type           VARCHAR2(1),
  card_no               VARCHAR2(20),
  issue_org_code        VARCHAR2(11),
  recv_org_code1        VARCHAR2(11),
  bill_org_code         VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  err_ori_org_id        VARCHAR2(11),
  err_confirm_org_id    VARCHAR2(11),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  response_code         VARCHAR2(2),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  err_charge            NUMBER(18),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null
)
;
alter table SETT_AD_DETAIL
  add primary key (ID);

prompt
prompt Creating table SETT_BP_DETAIL
prompt =============================
prompt
create table SETT_BP_DETAIL
(
  sett_date             VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  income_charge         NUMBER(18),
  pay_charge            NUMBER(18),
  test_income_charge    NUMBER(18),
  test_pay_charge       NUMBER(18),
  deposit_change_charge NUMBER(18),
  charge_sign           VARCHAR2(10),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CITY_AD_DETAIL
prompt ==================================
prompt
create table SETT_CITY_AD_DETAIL
(
  sett_adjust_org_no    VARCHAR2(15),
  ori_sett_date         VARCHAR2(11),
  ori_sett_org_no       VARCHAR2(15),
  ori_bill_org_no       VARCHAR2(15),
  ori_bill_deal_date    VARCHAR2(11),
  ori_retriev_no        VARCHAR2(15),
  ori_trade_type        VARCHAR2(7),
  adjust_type           VARCHAR2(3),
  card_no               VARCHAR2(23),
  issue_org_code        VARCHAR2(15),
  recv_org_code         VARCHAR2(15),
  bill_org_code         VARCHAR2(15),
  send_org_code         VARCHAR2(15),
  ed_make_code          VARCHAR2(15),
  ed_confirm_code       VARCHAR2(15),
  card_count            NUMBER,
  beforetrade_charge    NUMBER,
  adjusted_trade_type   VARCHAR2(7),
  adjusted_trade_charge NUMBER,
  mcc                   VARCHAR2(7),
  channel_type          VARCHAR2(5),
  trade_date            VARCHAR2(11),
  trade_time            VARCHAR2(9),
  test_flag             VARCHAR2(3),
  reason_code           VARCHAR2(6),
  response_code         VARCHAR2(3),
  error_code            VARCHAR2(8),
  error_info            VARCHAR2(42),
  err_charge            NUMBER,
  sett_charge           NUMBER,
  issue_charge          NUMBER,
  bill_charge           NUMBER,
  process_time          DATE,
  err_type              VARCHAR2(6),
  sett_date             VARCHAR2(11)
)
;

prompt
prompt Creating table SETT_CITY_DAILY
prompt ==============================
prompt
create table SETT_CITY_DAILY
(
  sett_date      VARCHAR2(8),
  sett_object    VARCHAR2(64),
  sett_role      VARCHAR2(32),
  trade_charge   NUMBER(21,7),
  service_charge NUMBER(21,7),
  issue_charge   NUMBER(21,7),
  bill_charge    NUMBER(21,7),
  center_charge  NUMBER(21,7),
  times          NUMBER(10),
  sett_charge    NUMBER(21,7)
)
;

prompt
prompt Creating table SETT_CITY_DETAIL
prompt ===============================
prompt
create table SETT_CITY_DETAIL
(
  sett_date           VARCHAR2(8),
  trade_type          VARCHAR2(3),
  issue_org_code      VARCHAR2(11),
  bill_org_code       VARCHAR2(11),
  card_no             VARCHAR2(20),
  before_trade_charge VARCHAR2(8),
  trade_charge        NUMBER(21,7),
  trade_date          VARCHAR2(8),
  trade_time          VARCHAR2(8),
  service_charge      NUMBER(21,7),
  issue_charge        NUMBER(21,7),
  bill_charge         NUMBER(21,7),
  center_charge       NUMBER(21,7),
  sett_charge         NUMBER(21,7),
  sett_org_code       VARCHAR2(11),
  roam_type           VARCHAR2(11)
)
;
create index SETT_CITY_DETAIL_IDX1 on SETT_CITY_DETAIL (SETT_DATE);

prompt
prompt Creating table SETT_CITY_STAT
prompt =============================
prompt
create table SETT_CITY_STAT
(
  sett_cycle     VARCHAR2(6),
  sett_object    VARCHAR2(64),
  income_charge  NUMBER(21,7),
  outcome_charge NUMBER(21,7),
  sett_charge    NUMBER(21,7)
)
;

prompt
prompt Creating table SETT_CITY_STAT_DETAIL
prompt ====================================
prompt
create table SETT_CITY_STAT_DETAIL
(
  sett_date         VARCHAR2(8),
  sett_org_code     VARCHAR2(32),
  sett_direction    NUMBER(2),
  role_type         NUMBER(2),
  issue_code        VARCHAR2(32),
  issue_org_name    VARCHAR2(64),
  bill_code         VARCHAR2(32),
  bill_org_name     VARCHAR2(64),
  trade_charge      NUMBER(21,7),
  service_fee       NUMBER(21,7),
  issue_charge      NUMBER(21,7),
  bill_charge       NUMBER(21,7),
  center_charge     NUMBER(21,7),
  sett_charge       NUMBER(21,7),
  actual_issue_code VARCHAR2(32),
  actual_issue_name VARCHAR2(128),
  times             NUMBER(12)
)
;
comment on column SETT_CITY_STAT_DETAIL.sett_direction
  is '结算方向 1:省一卡通公司结入 2：省一卡通公司结出';
comment on column SETT_CITY_STAT_DETAIL.role_type
  is '角色 1:发卡 2：收单';

prompt
prompt Creating table SETT_CITY_STAT_DETAIL_20170111
prompt =============================================
prompt
create table SETT_CITY_STAT_DETAIL_20170111
(
  sett_date         VARCHAR2(8),
  sett_org_code     VARCHAR2(32),
  sett_direction    NUMBER(2),
  role_type         NUMBER(2),
  issue_code        VARCHAR2(32),
  issue_org_name    VARCHAR2(64),
  bill_code         VARCHAR2(32),
  bill_org_name     VARCHAR2(64),
  trade_charge      NUMBER(21,7),
  service_fee       NUMBER(21,7),
  issue_charge      NUMBER(21,7),
  bill_charge       NUMBER(21,7),
  center_charge     NUMBER(21,7),
  sett_charge       NUMBER(21,7),
  actual_issue_code VARCHAR2(32),
  actual_issue_name VARCHAR2(128),
  times             NUMBER(12)
)
;

prompt
prompt Creating table SETT_CITY_STAT_DETAIL_20170122
prompt =============================================
prompt
create table SETT_CITY_STAT_DETAIL_20170122
(
  sett_date         VARCHAR2(8),
  sett_org_code     VARCHAR2(32),
  sett_direction    NUMBER(2),
  role_type         NUMBER(2),
  issue_code        VARCHAR2(32),
  issue_org_name    VARCHAR2(64),
  bill_code         VARCHAR2(32),
  bill_org_name     VARCHAR2(64),
  trade_charge      NUMBER(21,7),
  service_fee       NUMBER(21,7),
  issue_charge      NUMBER(21,7),
  bill_charge       NUMBER(21,7),
  center_charge     NUMBER(21,7),
  sett_charge       NUMBER(21,7),
  actual_issue_code VARCHAR2(32),
  actual_issue_name VARCHAR2(128),
  times             NUMBER(12)
)
;

prompt
prompt Creating table SETT_CL_201612
prompt =============================
prompt
create table SETT_CL_201612
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201612
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201701
prompt =============================
prompt
create table SETT_CL_201701
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201701
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201702
prompt =============================
prompt
create table SETT_CL_201702
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201702
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201703
prompt =============================
prompt
create table SETT_CL_201703
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201703
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201704
prompt =============================
prompt
create table SETT_CL_201704
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201704
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201705
prompt =============================
prompt
create table SETT_CL_201705
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201705
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201706
prompt =============================
prompt
create table SETT_CL_201706
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201706
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201707
prompt =============================
prompt
create table SETT_CL_201707
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201707
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201708
prompt =============================
prompt
create table SETT_CL_201708
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201708
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201709
prompt =============================
prompt
create table SETT_CL_201709
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201709
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201710
prompt =============================
prompt
create table SETT_CL_201710
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201710
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201711
prompt =============================
prompt
create table SETT_CL_201711
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201711
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201712
prompt =============================
prompt
create table SETT_CL_201712
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201712
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201801
prompt =============================
prompt
create table SETT_CL_201801
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201801
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201802
prompt =============================
prompt
create table SETT_CL_201802
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201802
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201803
prompt =============================
prompt
create table SETT_CL_201803
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201803
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201804
prompt =============================
prompt
create table SETT_CL_201804
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201804
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201805
prompt =============================
prompt
create table SETT_CL_201805
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201805
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201806
prompt =============================
prompt
create table SETT_CL_201806
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201806
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201807
prompt =============================
prompt
create table SETT_CL_201807
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201807
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201808
prompt =============================
prompt
create table SETT_CL_201808
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201808
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201809
prompt =============================
prompt
create table SETT_CL_201809
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201809
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201810
prompt =============================
prompt
create table SETT_CL_201810
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201810
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201811
prompt =============================
prompt
create table SETT_CL_201811
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201811
  add primary key (ID);

prompt
prompt Creating table SETT_CL_201812
prompt =============================
prompt
create table SETT_CL_201812
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  id                 VARCHAR2(30) not null
)
;
alter table SETT_CL_201812
  add primary key (ID);

prompt
prompt Creating table SETT_CL_YYYYMM
prompt =============================
prompt
create table SETT_CL_YYYYMM
(
  dr_type            VARCHAR2(20),
  sett_date          VARCHAR2(8),
  center_sett_date   VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  bill_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  recv_org_code1     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  offline_trade_no   VARCHAR2(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  balance_type       VARCHAR2(1),
  algorithm_id       VARCHAR2(2),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  reserved           VARCHAR2(28),
  tlv_data           VARCHAR2(1024),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64)
)
;

prompt
prompt Creating table SETT_CM_201612
prompt =============================
prompt
create table SETT_CM_201612
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201701
prompt =============================
prompt
create table SETT_CM_201701
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201702
prompt =============================
prompt
create table SETT_CM_201702
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201703
prompt =============================
prompt
create table SETT_CM_201703
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201704
prompt =============================
prompt
create table SETT_CM_201704
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201705
prompt =============================
prompt
create table SETT_CM_201705
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201706
prompt =============================
prompt
create table SETT_CM_201706
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201707
prompt =============================
prompt
create table SETT_CM_201707
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201708
prompt =============================
prompt
create table SETT_CM_201708
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201709
prompt =============================
prompt
create table SETT_CM_201709
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201710
prompt =============================
prompt
create table SETT_CM_201710
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201711
prompt =============================
prompt
create table SETT_CM_201711
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201712
prompt =============================
prompt
create table SETT_CM_201712
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201801
prompt =============================
prompt
create table SETT_CM_201801
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201802
prompt =============================
prompt
create table SETT_CM_201802
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201803
prompt =============================
prompt
create table SETT_CM_201803
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201804
prompt =============================
prompt
create table SETT_CM_201804
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201805
prompt =============================
prompt
create table SETT_CM_201805
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201806
prompt =============================
prompt
create table SETT_CM_201806
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201807
prompt =============================
prompt
create table SETT_CM_201807
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201808
prompt =============================
prompt
create table SETT_CM_201808
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201809
prompt =============================
prompt
create table SETT_CM_201809
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201810
prompt =============================
prompt
create table SETT_CM_201810
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201811
prompt =============================
prompt
create table SETT_CM_201811
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_201812
prompt =============================
prompt
create table SETT_CM_201812
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CM_YYYYMM
prompt =============================
prompt
create table SETT_CM_YYYYMM
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201607
prompt =============================
prompt
create table SETT_CR_201607
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201612
prompt =============================
prompt
create table SETT_CR_201612
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201701
prompt =============================
prompt
create table SETT_CR_201701
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201702
prompt =============================
prompt
create table SETT_CR_201702
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201703
prompt =============================
prompt
create table SETT_CR_201703
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201704
prompt =============================
prompt
create table SETT_CR_201704
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201705
prompt =============================
prompt
create table SETT_CR_201705
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201706
prompt =============================
prompt
create table SETT_CR_201706
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201707
prompt =============================
prompt
create table SETT_CR_201707
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201708
prompt =============================
prompt
create table SETT_CR_201708
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201709
prompt =============================
prompt
create table SETT_CR_201709
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201710
prompt =============================
prompt
create table SETT_CR_201710
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201711
prompt =============================
prompt
create table SETT_CR_201711
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201712
prompt =============================
prompt
create table SETT_CR_201712
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201801
prompt =============================
prompt
create table SETT_CR_201801
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201802
prompt =============================
prompt
create table SETT_CR_201802
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201803
prompt =============================
prompt
create table SETT_CR_201803
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201804
prompt =============================
prompt
create table SETT_CR_201804
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201805
prompt =============================
prompt
create table SETT_CR_201805
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201806
prompt =============================
prompt
create table SETT_CR_201806
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201807
prompt =============================
prompt
create table SETT_CR_201807
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201808
prompt =============================
prompt
create table SETT_CR_201808
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201809
prompt =============================
prompt
create table SETT_CR_201809
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201810
prompt =============================
prompt
create table SETT_CR_201810
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201811
prompt =============================
prompt
create table SETT_CR_201811
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_201812
prompt =============================
prompt
create table SETT_CR_201812
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_CR_YYYYMM
prompt =============================
prompt
create table SETT_CR_YYYYMM
(
  sett_date        VARCHAR2(8),
  recv_org_code    VARCHAR2(11),
  file_name        VARCHAR2(128),
  bill_org_id      VARCHAR2(11),
  recv_org_id      VARCHAR2(11),
  issue_org_code   VARCHAR2(11),
  send_org_id      VARCHAR2(11),
  service_type     VARCHAR2(4),
  err_adjust_id    VARCHAR2(1),
  err_code         VARCHAR2(6),
  err_info         VARCHAR2(40),
  trade_count      NUMBER(18),
  trade_charge     NUMBER(18),
  sett_org_charge1 NUMBER(18),
  sett_err_charge  NUMBER(18),
  sett_org_charge2 NUMBER(18),
  sett_org_charge  NUMBER(18),
  test_flag        VARCHAR2(1),
  deal_time        VARCHAR2(14),
  indb_time        VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_ED_201612
prompt =============================
prompt
create table SETT_ED_201612
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201612
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201701
prompt =============================
prompt
create table SETT_ED_201701
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201701
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201702
prompt =============================
prompt
create table SETT_ED_201702
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201702
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201703
prompt =============================
prompt
create table SETT_ED_201703
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201703
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201704
prompt =============================
prompt
create table SETT_ED_201704
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201704
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201705
prompt =============================
prompt
create table SETT_ED_201705
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201705
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201706
prompt =============================
prompt
create table SETT_ED_201706
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201706
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201707
prompt =============================
prompt
create table SETT_ED_201707
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201707
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201708
prompt =============================
prompt
create table SETT_ED_201708
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201708
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201709
prompt =============================
prompt
create table SETT_ED_201709
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201709
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201710
prompt =============================
prompt
create table SETT_ED_201710
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201710
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201711
prompt =============================
prompt
create table SETT_ED_201711
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201711
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201712
prompt =============================
prompt
create table SETT_ED_201712
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1) default '0',
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201712
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201801
prompt =============================
prompt
create table SETT_ED_201801
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201801
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201802
prompt =============================
prompt
create table SETT_ED_201802
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201802
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201803
prompt =============================
prompt
create table SETT_ED_201803
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201803
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201804
prompt =============================
prompt
create table SETT_ED_201804
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201804
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201805
prompt =============================
prompt
create table SETT_ED_201805
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201805
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201806
prompt =============================
prompt
create table SETT_ED_201806
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201806
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201807
prompt =============================
prompt
create table SETT_ED_201807
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201807
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201808
prompt =============================
prompt
create table SETT_ED_201808
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201808
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201809
prompt =============================
prompt
create table SETT_ED_201809
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201809
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201810
prompt =============================
prompt
create table SETT_ED_201810
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201810
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201811
prompt =============================
prompt
create table SETT_ED_201811
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201811
  add primary key (ID);

prompt
prompt Creating table SETT_ED_201812
prompt =============================
prompt
create table SETT_ED_201812
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  deal_flag             VARCHAR2(1),
  deal_note             VARCHAR2(512)
)
;
alter table SETT_ED_201812
  add primary key (ID);

prompt
prompt Creating table SETT_ED_YYYYMM
prompt =============================
prompt
create table SETT_ED_YYYYMM
(
  send_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_FB_201612
prompt =============================
prompt
create table SETT_FB_201612
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201612
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201612_20161230
prompt ======================================
prompt
create table SETT_FB_201612_20161230
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30),
  st_down_recv_org_code VARCHAR2(12)
)
;

prompt
prompt Creating table SETT_FB_201612_OLD
prompt =================================
prompt
create table SETT_FB_201612_OLD
(
  sett_date          VARCHAR2(8),
  recv_org_code      VARCHAR2(11),
  file_name          VARCHAR2(128),
  sett_org_no        VARCHAR2(12),
  bill_org_no        VARCHAR2(12),
  bill_deal_date     VARCHAR2(8),
  retriev_no         VARCHAR2(12),
  trade_type         VARCHAR2(4),
  recv_org_id        VARCHAR2(11),
  issue_company_code VARCHAR2(11),
  bill_org_id        VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  mcc                VARCHAR2(4),
  channel_type       VARCHAR2(2),
  card_no            VARCHAR2(20),
  card_count         NUMBER(6),
  beforetrade_charge NUMBER(12),
  trade_charge       NUMBER(12),
  trade_date         VARCHAR2(8),
  trade_time         VARCHAR2(6),
  err_code           VARCHAR2(6),
  err_info           VARCHAR2(40),
  test_flag          VARCHAR2(1),
  sett_charge        NUMBER(21,7),
  issue_charge       NUMBER(21,7),
  bill_charge        NUMBER(21,7),
  deal_time          VARCHAR2(14),
  indb_time          VARCHAR2(14),
  dr_type            VARCHAR2(20),
  center_sett_date   VARCHAR2(8),
  id                 VARCHAR2(30)
)
;

prompt
prompt Creating table SETT_FB_201612_QINGHAI
prompt =====================================
prompt
create table SETT_FB_201612_QINGHAI
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;

prompt
prompt Creating table SETT_FB_201701
prompt =============================
prompt
create table SETT_FB_201701
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201701
  add constraint SETT_FB_201701_ID_PK primary key (ID);

prompt
prompt Creating table SETT_FB_201702
prompt =============================
prompt
create table SETT_FB_201702
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201702
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201703
prompt =============================
prompt
create table SETT_FB_201703
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201703
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201704
prompt =============================
prompt
create table SETT_FB_201704
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201704
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201705
prompt =============================
prompt
create table SETT_FB_201705
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201705
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201706
prompt =============================
prompt
create table SETT_FB_201706
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201706
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201707
prompt =============================
prompt
create table SETT_FB_201707
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201707
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201708
prompt =============================
prompt
create table SETT_FB_201708
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201708
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201709
prompt =============================
prompt
create table SETT_FB_201709
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201709
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201710
prompt =============================
prompt
create table SETT_FB_201710
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201710
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201711
prompt =============================
prompt
create table SETT_FB_201711
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201711
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201712
prompt =============================
prompt
create table SETT_FB_201712
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201712
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201801
prompt =============================
prompt
create table SETT_FB_201801
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201801
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201802
prompt =============================
prompt
create table SETT_FB_201802
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201802
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201803
prompt =============================
prompt
create table SETT_FB_201803
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201803
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201804
prompt =============================
prompt
create table SETT_FB_201804
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201804
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201805
prompt =============================
prompt
create table SETT_FB_201805
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201805
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201806
prompt =============================
prompt
create table SETT_FB_201806
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201806
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201807
prompt =============================
prompt
create table SETT_FB_201807
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201807
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201808
prompt =============================
prompt
create table SETT_FB_201808
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201808
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201809
prompt =============================
prompt
create table SETT_FB_201809
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201809
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201810
prompt =============================
prompt
create table SETT_FB_201810
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201810
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201811
prompt =============================
prompt
create table SETT_FB_201811
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201811
  add primary key (ID);

prompt
prompt Creating table SETT_FB_201812
prompt =============================
prompt
create table SETT_FB_201812
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_201812
  add primary key (ID);

prompt
prompt Creating table SETT_FB_YYYYMM
prompt =============================
prompt
create table SETT_FB_YYYYMM
(
  dr_type               VARCHAR2(20),
  sett_date             VARCHAR2(8),
  center_sett_date      VARCHAR2(8),
  recv_org_code         VARCHAR2(11),
  file_name             VARCHAR2(128),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_deal_date        VARCHAR2(8),
  retriev_no            VARCHAR2(12),
  trade_type            VARCHAR2(4),
  recv_org_id           VARCHAR2(11),
  issue_company_code    VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  send_org_id           VARCHAR2(11),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  offline_trade_no      VARCHAR2(6),
  beforetrade_charge    NUMBER(12),
  trade_charge          NUMBER(12),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  err_code              VARCHAR2(6),
  err_info              VARCHAR2(40),
  test_flag             VARCHAR2(1),
  sett_charge           NUMBER(21,7),
  issue_charge          NUMBER(21,7),
  bill_charge           NUMBER(21,7),
  deal_time             VARCHAR2(14),
  indb_time             VARCHAR2(14),
  id                    VARCHAR2(30) not null,
  st_down_recv_org_code VARCHAR2(12)
)
;
alter table SETT_FB_YYYYMM
  add primary key (ID);

prompt
prompt Creating table SETT_LD_201612
prompt =============================
prompt
create table SETT_LD_201612
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201701
prompt =============================
prompt
create table SETT_LD_201701
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201702
prompt =============================
prompt
create table SETT_LD_201702
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201703
prompt =============================
prompt
create table SETT_LD_201703
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201704
prompt =============================
prompt
create table SETT_LD_201704
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201705
prompt =============================
prompt
create table SETT_LD_201705
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201706
prompt =============================
prompt
create table SETT_LD_201706
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201707
prompt =============================
prompt
create table SETT_LD_201707
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201708
prompt =============================
prompt
create table SETT_LD_201708
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201709
prompt =============================
prompt
create table SETT_LD_201709
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201710
prompt =============================
prompt
create table SETT_LD_201710
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201711
prompt =============================
prompt
create table SETT_LD_201711
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201712
prompt =============================
prompt
create table SETT_LD_201712
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201801
prompt =============================
prompt
create table SETT_LD_201801
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201802
prompt =============================
prompt
create table SETT_LD_201802
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201803
prompt =============================
prompt
create table SETT_LD_201803
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201804
prompt =============================
prompt
create table SETT_LD_201804
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201805
prompt =============================
prompt
create table SETT_LD_201805
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201806
prompt =============================
prompt
create table SETT_LD_201806
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201807
prompt =============================
prompt
create table SETT_LD_201807
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201808
prompt =============================
prompt
create table SETT_LD_201808
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201809
prompt =============================
prompt
create table SETT_LD_201809
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201810
prompt =============================
prompt
create table SETT_LD_201810
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201811
prompt =============================
prompt
create table SETT_LD_201811
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_201812
prompt =============================
prompt
create table SETT_LD_201812
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_LD_YYYYMM
prompt =============================
prompt
create table SETT_LD_YYYYMM
(
  sett_date      VARCHAR2(8),
  recv_org_code  VARCHAR2(11),
  file_name      VARCHAR2(128),
  sett_org_no    NUMBER(12),
  file_list_name VARCHAR2(50),
  err_code       VARCHAR2(6),
  err_info       VARCHAR2(40),
  reserved       VARCHAR2(40),
  deal_time      VARCHAR2(14),
  indb_time      VARCHAR2(14)
)
;

prompt
prompt Creating table SETT_PROC_RESULT
prompt ===============================
prompt
create table SETT_PROC_RESULT
(
  org_code    VARCHAR2(11) not null,
  org_name    VARCHAR2(32) not null,
  sett_date   VARCHAR2(8),
  file_name   VARCHAR2(64),
  file_type   VARCHAR2(6),
  create_time DATE
)
;
comment on column SETT_PROC_RESULT.file_type
  is 'CR|BP|LD';
create unique index SETT_PROC_RESULT_IDX1 on SETT_PROC_RESULT (ORG_CODE, SETT_DATE, FILE_TYPE);

prompt
prompt Creating table SETT_PROC_STAT
prompt =============================
prompt
create table SETT_PROC_STAT
(
  module_id    NUMBER(6),
  module_code  VARCHAR2(32),
  module_name  VARCHAR2(32),
  program_name VARCHAR2(128),
  sett_date    VARCHAR2(8),
  status       VARCHAR2(32),
  start_time   VARCHAR2(14),
  end_time     VARCHAR2(14),
  note         VARCHAR2(256)
)
;

prompt
prompt Creating table SETT_PROV_DAILY
prompt ==============================
prompt
create table SETT_PROV_DAILY
(
  sett_date      VARCHAR2(8),
  sett_object    VARCHAR2(64),
  sett_role      VARCHAR2(32),
  trade_charge   NUMBER(21,7),
  service_charge NUMBER(21,7),
  issue_charge   NUMBER(21,7),
  bill_charge    NUMBER(21,7),
  center_charge  NUMBER(21,7),
  times          NUMBER(10),
  sett_charge    NUMBER(21,7),
  table_month    VARCHAR2(6)
)
;

prompt
prompt Creating table SETT_PROV_DAILY_20180505
prompt =======================================
prompt
create table SETT_PROV_DAILY_20180505
(
  sett_date      VARCHAR2(8),
  sett_object    VARCHAR2(64),
  sett_role      VARCHAR2(32),
  trade_charge   NUMBER(21,7),
  service_charge NUMBER(21,7),
  issue_charge   NUMBER(21,7),
  bill_charge    NUMBER(21,7),
  center_charge  NUMBER(21,7),
  times          NUMBER(10),
  sett_charge    NUMBER(21,7),
  table_month    VARCHAR2(6)
)
;

prompt
prompt Creating table SETT_PROV_DETAIL
prompt ===============================
prompt
create table SETT_PROV_DETAIL
(
  sett_date           VARCHAR2(8),
  trade_type          VARCHAR2(3),
  issue_org_code      VARCHAR2(11),
  bill_org_code       VARCHAR2(11),
  card_no             VARCHAR2(20),
  before_trade_charge VARCHAR2(8),
  trade_charge        NUMBER(21,7),
  trade_date          VARCHAR2(8),
  trade_time          VARCHAR2(8),
  service_charge      NUMBER(21,7),
  issue_charge        NUMBER(21,7),
  bill_charge         NUMBER(21,7),
  center_charge       NUMBER(21,7),
  sett_charge         NUMBER(21,7),
  table_month         VARCHAR2(6)
)
;

prompt
prompt Creating table SETT_PROV_DETAIL_20180505
prompt ========================================
prompt
create table SETT_PROV_DETAIL_20180505
(
  sett_date      VARCHAR2(8),
  sett_object    VARCHAR2(64),
  sett_role      VARCHAR2(32),
  trade_charge   NUMBER(21,7),
  service_charge NUMBER(21,7),
  issue_charge   NUMBER(21,7),
  bill_charge    NUMBER(21,7),
  center_charge  NUMBER(21,7),
  times          NUMBER(10),
  sett_charge    NUMBER(21,7),
  table_month    VARCHAR2(6)
)
;

prompt
prompt Creating table SETT_PROV_STAT
prompt =============================
prompt
create table SETT_PROV_STAT
(
  sett_cycle     VARCHAR2(6),
  sett_object    VARCHAR2(64),
  income_charge  NUMBER(21,7),
  outcome_charge NUMBER(21,7),
  sett_charge    NUMBER(21,7)
)
;

prompt
prompt Creating table SETT_PROV_STAT_BAK
prompt =================================
prompt
create table SETT_PROV_STAT_BAK
(
  sett_cycle     VARCHAR2(6),
  sett_object    VARCHAR2(64),
  income_charge  NUMBER(21,7),
  outcome_charge NUMBER(21,7),
  sett_charge    NUMBER(21,7)
)
;

prompt
prompt Creating table SETT_PROV_STAT_DETAIL
prompt ====================================
prompt
create table SETT_PROV_STAT_DETAIL
(
  sett_date      VARCHAR2(8),
  sett_org_code  VARCHAR2(32),
  sett_direction NUMBER(2),
  role_type      NUMBER(2),
  issue_code     VARCHAR2(32),
  issue_org_name VARCHAR2(64),
  bill_code      VARCHAR2(32),
  bill_org_name  VARCHAR2(64),
  trade_charge   NUMBER(21,7),
  service_fee    NUMBER(21,7),
  issue_charge   NUMBER(21,7),
  bill_charge    NUMBER(21,7),
  center_charge  NUMBER(21,7),
  sett_charge    NUMBER(21,7),
  times          NUMBER(12)
)
;
comment on column SETT_PROV_STAT_DETAIL.sett_direction
  is '结算方向 1:省一卡通公司结入 2：省一卡通公司结出';
comment on column SETT_PROV_STAT_DETAIL.role_type
  is '角色 1:发卡 2：收单';

prompt
prompt Creating table SETT_PROV_STAT_DETAIL_20170111
prompt =============================================
prompt
create table SETT_PROV_STAT_DETAIL_20170111
(
  sett_date         VARCHAR2(8),
  sett_org_code     VARCHAR2(32),
  sett_direction    NUMBER(2),
  role_type         NUMBER(2),
  issue_code        VARCHAR2(32),
  issue_org_name    VARCHAR2(64),
  bill_code         VARCHAR2(32),
  bill_org_name     VARCHAR2(64),
  trade_charge      NUMBER(21,7),
  service_fee       NUMBER(21,7),
  issue_charge      NUMBER(21,7),
  bill_charge       NUMBER(21,7),
  center_charge     NUMBER(21,7),
  sett_charge       NUMBER(21,7),
  actual_issue_code VARCHAR2(32),
  actual_issue_name VARCHAR2(128),
  times             NUMBER(12)
)
;

prompt
prompt Creating table SETT_PROV_STAT_DETAIL_20170122
prompt =============================================
prompt
create table SETT_PROV_STAT_DETAIL_20170122
(
  sett_date      VARCHAR2(8),
  sett_org_code  VARCHAR2(32),
  sett_direction NUMBER(2),
  role_type      NUMBER(2),
  issue_code     VARCHAR2(32),
  issue_org_name VARCHAR2(64),
  bill_code      VARCHAR2(32),
  bill_org_name  VARCHAR2(64),
  trade_charge   NUMBER(21,7),
  service_fee    NUMBER(21,7),
  issue_charge   NUMBER(21,7),
  bill_charge    NUMBER(21,7),
  center_charge  NUMBER(21,7),
  sett_charge    NUMBER(21,7),
  times          NUMBER(12)
)
;

prompt
prompt Creating table SETT_STAT_CYCLE_RESULT
prompt =====================================
prompt
create table SETT_STAT_CYCLE_RESULT
(
  sett_date  VARCHAR2(8),
  sts        VARCHAR2(64),
  start_time DATE,
  end_time   DATE,
  note       VARCHAR2(1024)
)
;

prompt
prompt Creating table SETT_STAT_DAILY_AD
prompt =================================
prompt
create table SETT_STAT_DAILY_AD
(
  record_type           NUMBER(2),
  record_context        VARCHAR2(1024),
  org_code              VARCHAR2(16),
  sett_date             VARCHAR2(11),
  total_count           NUMBER,
  sett_adjust_org_no    VARCHAR2(15),
  ori_sett_date         VARCHAR2(11),
  ori_sett_org_no       VARCHAR2(15),
  ori_bill_org_no       VARCHAR2(15),
  ori_bill_deal_date    VARCHAR2(11),
  ori_retriev_no        VARCHAR2(15),
  ori_trade_type        VARCHAR2(7),
  adjust_type           VARCHAR2(3),
  card_no               VARCHAR2(23),
  issue_org_code        VARCHAR2(15),
  recv_org_code         VARCHAR2(15),
  bill_org_code         VARCHAR2(15),
  send_org_code         VARCHAR2(15),
  ed_make_code          VARCHAR2(15),
  ed_confirm_code       VARCHAR2(15),
  card_count            NUMBER,
  beforetrade_charge    NUMBER,
  adjusted_trade_type   VARCHAR2(7),
  adjusted_trade_charge NUMBER,
  mcc                   VARCHAR2(7),
  channel_type          VARCHAR2(5),
  trade_date            VARCHAR2(11),
  trade_time            VARCHAR2(9),
  test_flag             VARCHAR2(3),
  reason_code           VARCHAR2(6),
  response_code         VARCHAR2(3),
  error_code            VARCHAR2(8),
  error_info            VARCHAR2(42),
  err_charge            NUMBER,
  sett_charge           NUMBER,
  issue_charge          NUMBER,
  bill_charge           NUMBER,
  process_time          DATE,
  err_type              VARCHAR2(6)
)
;

prompt
prompt Creating table SETT_STAT_DAILY_AD_HIS
prompt =====================================
prompt
create table SETT_STAT_DAILY_AD_HIS
(
  record_type           NUMBER(2),
  record_context        VARCHAR2(1024),
  org_code              VARCHAR2(16),
  sett_date             VARCHAR2(11),
  total_count           NUMBER,
  sett_adjust_org_no    VARCHAR2(15),
  ori_sett_date         VARCHAR2(11),
  ori_sett_org_no       VARCHAR2(15),
  ori_bill_org_no       VARCHAR2(15),
  ori_bill_deal_date    VARCHAR2(11),
  ori_retriev_no        VARCHAR2(15),
  ori_trade_type        VARCHAR2(7),
  adjust_type           VARCHAR2(3),
  card_no               VARCHAR2(23),
  issue_org_code        VARCHAR2(15),
  recv_org_code         VARCHAR2(15),
  bill_org_code         VARCHAR2(15),
  send_org_code         VARCHAR2(15),
  ed_make_code          VARCHAR2(15),
  ed_confirm_code       VARCHAR2(15),
  card_count            NUMBER,
  beforetrade_charge    NUMBER,
  adjusted_trade_type   VARCHAR2(7),
  adjusted_trade_charge NUMBER,
  mcc                   VARCHAR2(7),
  channel_type          VARCHAR2(5),
  trade_date            VARCHAR2(11),
  trade_time            VARCHAR2(9),
  test_flag             VARCHAR2(3),
  reason_code           VARCHAR2(6),
  response_code         VARCHAR2(3),
  error_code            VARCHAR2(8),
  error_info            VARCHAR2(42),
  err_charge            NUMBER,
  sett_charge           NUMBER,
  issue_charge          NUMBER,
  bill_charge           NUMBER,
  process_time          DATE,
  err_type              VARCHAR2(6)
)
;

prompt
prompt Creating table SETT_STAT_DAILY_BP
prompt =================================
prompt
create table SETT_STAT_DAILY_BP
(
  record_type    NUMBER(2),
  record_context VARCHAR2(1024),
  sett_date      VARCHAR2(14),
  org_code       VARCHAR2(16),
  income_charge  NUMBER(21,7),
  outcome_charge NUMBER(21,7),
  process_time   DATE
)
;

prompt
prompt Creating table SETT_STAT_DAILY_BP_HIS
prompt =====================================
prompt
create table SETT_STAT_DAILY_BP_HIS
(
  record_type    NUMBER(2),
  record_context VARCHAR2(1024),
  sett_date      VARCHAR2(14),
  org_code       VARCHAR2(16),
  income_charge  NUMBER(21,7),
  outcome_charge NUMBER(21,7),
  process_time   DATE
)
;

prompt
prompt Creating table SETT_STAT_DAILY_CM
prompt =================================
prompt
create table SETT_STAT_DAILY_CM
(
  record_type           NUMBER(2),
  record_context        VARCHAR2(1024),
  org_code              VARCHAR2(16),
  total_count           NUMBER,
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  process_time          DATE
)
;

prompt
prompt Creating table SETT_STAT_DAILY_CM_HIS
prompt =====================================
prompt
create table SETT_STAT_DAILY_CM_HIS
(
  record_type           NUMBER(2),
  record_context        VARCHAR2(1024),
  org_code              VARCHAR2(16),
  total_count           NUMBER,
  sett_date             VARCHAR2(8),
  sett_org_no           VARCHAR2(12),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  response_code         VARCHAR2(2),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  ori_org_code          VARCHAR2(11),
  confirm_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  recv_org_code         VARCHAR2(11),
  process_time          DATE
)
;

prompt
prompt Creating table SETT_STAT_DAILY_CR
prompt =================================
prompt
create table SETT_STAT_DAILY_CR
(
  record_type        NUMBER(2),
  record_context     VARCHAR2(1024),
  sett_date          VARCHAR2(14),
  org_code           VARCHAR2(16),
  recv_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_org_code     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  busi_type          VARCHAR2(4),
  adjust_flag        NUMBER,
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  total_count        NUMBER,
  total_trade_charge NUMBER,
  recv_org_fee       NUMBER,
  err_fee            NUMBER,
  issue_org_fee      NUMBER,
  prov_org_fee       NUMBER,
  test_flag          NUMBER,
  process_time       DATE
)
;
comment on column SETT_STAT_DAILY_CR.record_type
  is '0: 文件名 1：头记录 2：交易体';
comment on column SETT_STAT_DAILY_CR.recv_org_id
  is '收单机构标识-交易的发生地';
comment on column SETT_STAT_DAILY_CR.bill_org_code
  is '接收清算机构标识-发卡地的顶级单位';
comment on column SETT_STAT_DAILY_CR.issue_org_code
  is '发卡机构代码-发卡地';
comment on column SETT_STAT_DAILY_CR.send_org_id
  is '发送机构标识码-交易发生地的顶级单位';
comment on column SETT_STAT_DAILY_CR.busi_type
  is '业务类型';
comment on column SETT_STAT_DAILY_CR.adjust_flag
  is '差错调整标识';
comment on column SETT_STAT_DAILY_CR.total_count
  is '总条数';
comment on column SETT_STAT_DAILY_CR.total_trade_charge
  is '总交易金额';
comment on column SETT_STAT_DAILY_CR.recv_org_fee
  is '交易地手续费';
comment on column SETT_STAT_DAILY_CR.err_fee
  is '差错手续费';
comment on column SETT_STAT_DAILY_CR.issue_org_fee
  is '卡属地手续费';
comment on column SETT_STAT_DAILY_CR.prov_org_fee
  is '清分结算机构手续费';

prompt
prompt Creating table SETT_STAT_DAILY_CR_HIS
prompt =====================================
prompt
create table SETT_STAT_DAILY_CR_HIS
(
  record_type        NUMBER(2),
  record_context     VARCHAR2(1024),
  sett_date          VARCHAR2(14),
  org_code           VARCHAR2(16),
  recv_org_id        VARCHAR2(11),
  bill_org_code      VARCHAR2(11),
  issue_org_code     VARCHAR2(11),
  send_org_id        VARCHAR2(11),
  busi_type          VARCHAR2(4),
  adjust_flag        NUMBER,
  sys_error_code     VARCHAR2(6),
  sys_error_msg      VARCHAR2(64),
  total_count        NUMBER,
  total_trade_charge NUMBER,
  recv_org_fee       NUMBER,
  err_fee            NUMBER,
  issue_org_fee      NUMBER,
  prov_org_fee       NUMBER,
  test_flag          NUMBER,
  process_time       DATE
)
;

prompt
prompt Creating table SETT_STAT_DAILY_ED
prompt =================================
prompt
create table SETT_STAT_DAILY_ED
(
  record_type           NUMBER(2),
  record_context        VARCHAR2(1024),
  org_code              VARCHAR2(16),
  total_count           NUMBER,
  sett_date             VARCHAR2(11),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  process_time          DATE
)
;

prompt
prompt Creating table SETT_STAT_DAILY_ED_HIS
prompt =====================================
prompt
create table SETT_STAT_DAILY_ED_HIS
(
  record_type           NUMBER(2),
  record_context        VARCHAR2(1024),
  org_code              VARCHAR2(16),
  total_count           NUMBER,
  sett_date             VARCHAR2(11),
  sett_org_no           VARCHAR2(12),
  bill_org_no           VARCHAR2(12),
  bill_org_deal_date    VARCHAR2(8),
  trade_retriev_no      VARCHAR2(12),
  adjust_type           VARCHAR2(1),
  err_type              VARCHAR2(4),
  card_no               VARCHAR2(20),
  card_count            NUMBER(6),
  beforetrade_charge    NUMBER(12),
  adjusted_trade_type   VARCHAR2(4),
  adjusted_trade_charge NUMBER(12),
  mcc                   VARCHAR2(4),
  channel_type          VARCHAR2(2),
  trade_date            VARCHAR2(8),
  trade_time            VARCHAR2(6),
  test_flag             VARCHAR2(1),
  cause_code            VARCHAR2(4),
  err_ori_org_code      VARCHAR2(11),
  issue_org_code        VARCHAR2(11),
  bill_org_id           VARCHAR2(11),
  process_time          DATE
)
;

prompt
prompt Creating table SETT_STAT_DAILY_LD
prompt =================================
prompt
create table SETT_STAT_DAILY_LD
(
  record_type    NUMBER(2),
  record_context VARCHAR2(1024),
  module_id      NUMBER(6),
  sett_date      VARCHAR2(14),
  file_name      VARCHAR2(256),
  org_code       VARCHAR2(16),
  process_time   DATE
)
;
comment on column SETT_STAT_DAILY_LD.record_type
  is '0: 文件名 1：头记录 2：交易体';

prompt
prompt Creating table SETT_STAT_DAILY_LD_HIS
prompt =====================================
prompt
create table SETT_STAT_DAILY_LD_HIS
(
  record_type    NUMBER(2),
  record_context VARCHAR2(1024),
  module_id      NUMBER(6),
  sett_date      VARCHAR2(14),
  file_name      VARCHAR2(256),
  org_code       VARCHAR2(16),
  process_time   DATE
)
;

prompt
prompt Creating table SETT_STAT_FILE_LIST
prompt ==================================
prompt
create table SETT_STAT_FILE_LIST
(
  module_id NUMBER(6),
  sett_date VARCHAR2(14),
  file_name VARCHAR2(256),
  org_code  VARCHAR2(16)
)
;

prompt
prompt Creating table SETT_STAT_FILE_LIST_HIS
prompt ======================================
prompt
create table SETT_STAT_FILE_LIST_HIS
(
  module_id NUMBER(6),
  sett_date VARCHAR2(14),
  file_name VARCHAR2(256),
  org_code  VARCHAR2(16)
)
;

prompt
prompt Creating table SETT_STAT_LOG
prompt ============================
prompt
create table SETT_STAT_LOG
(
  sett_type    VARCHAR2(32),
  sett_date    VARCHAR2(8),
  sts          VARCHAR2(32),
  process_time DATE,
  end_date     DATE,
  note         VARCHAR2(3072)
)
;

prompt
prompt Creating table SETT_STAT_REPORT
prompt ===============================
prompt
create table SETT_STAT_REPORT
(
  sett_type      VARCHAR2(32) not null,
  sett_date      VARCHAR2(8) not null,
  org_code       VARCHAR2(32),
  org_name       VARCHAR2(64),
  income_charge  NUMBER(21,7),
  outcome_charge NUMBER(21,7),
  note           VARCHAR2(1024),
  offset_balance NUMBER(21,7)
)
;

prompt
prompt Creating table SETT_STAT_REPORT_20170122
prompt ========================================
prompt
create table SETT_STAT_REPORT_20170122
(
  sett_type      VARCHAR2(32) not null,
  sett_date      VARCHAR2(8) not null,
  org_code       VARCHAR2(32),
  org_name       VARCHAR2(64),
  income_charge  NUMBER(21,7),
  outcome_charge NUMBER(21,7),
  note           VARCHAR2(1024),
  offset_balance NUMBER(21,7)
)
;

prompt
prompt Creating table SN_DATA
prompt ======================
prompt
create table SN_DATA
(
  sn     VARCHAR2(30),
  cuid   VARCHAR2(20),
  serial VARCHAR2(30),
  state  VARCHAR2(30)
)
;

prompt
prompt Creating table SN_RESULT
prompt ========================
prompt
create table SN_RESULT
(
  sn           VARCHAR2(30),
  cuid         VARCHAR2(20),
  cuid_dec     VARCHAR2(20),
  serial       VARCHAR2(30),
  create_date  VARCHAR2(30),
  card_type    VARCHAR2(10),
  card_flag    VARCHAR2(10),
  city_code    VARCHAR2(10),
  product_code VARCHAR2(20)
)
;

prompt
prompt Creating table STAT_PROC_RESULT
prompt ===============================
prompt
create table STAT_PROC_RESULT
(
  org_code  VARCHAR2(11) not null,
  org_name  VARCHAR2(32) not null,
  sett_date VARCHAR2(8),
  file_name VARCHAR2(64),
  tol_num   NUMBER(6),
  charge1   NUMBER(21,7),
  charge2   NUMBER(21,7),
  charge3   NUMBER(21,7),
  charge4   NUMBER(21,7),
  charge5   NUMBER(21,7)
)
;

prompt
prompt Creating table STAT_PROC_RESULT_HIS
prompt ===================================
prompt
create table STAT_PROC_RESULT_HIS
(
  org_code     VARCHAR2(11) not null,
  org_name     VARCHAR2(32) not null,
  sett_date    VARCHAR2(8),
  file_name    VARCHAR2(64),
  tol_num      NUMBER(6),
  charge1      NUMBER(21,7),
  charge2      NUMBER(21,7),
  charge3      NUMBER(21,7),
  charge4      NUMBER(21,7),
  charge5      NUMBER(21,7),
  process_time DATE
)
;

prompt
prompt Creating table SYS_AREA
prompt =======================
prompt
create table SYS_AREA
(
  id          VARCHAR2(64) not null,
  parent_id   VARCHAR2(64) not null,
  parent_ids  VARCHAR2(2000) not null,
  name        NVARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  code        VARCHAR2(100),
  type        CHAR(1),
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on column SYS_AREA.parent_id
  is '父节点id';
create index SYS_AREA_DEL_FLAG on SYS_AREA (DEL_FLAG);
create index SYS_AREA_PARENT_ID on SYS_AREA (PARENT_ID);
create index SYS_AREA_PARENT_IDS on SYS_AREA (PARENT_IDS);
alter table SYS_AREA
  add primary key (ID);

prompt
prompt Creating table SYS_AUDIT_TRAIL
prompt ==============================
prompt
create table SYS_AUDIT_TRAIL
(
  aud_user      VARCHAR2(100) not null,
  aud_client_ip VARCHAR2(15) not null,
  aud_server_ip VARCHAR2(15) not null,
  aud_resource  VARCHAR2(100) not null,
  aud_action    VARCHAR2(100) not null,
  applic_cd     VARCHAR2(5) not null,
  aud_date      TIMESTAMP(6) not null
)
;
create index SYS_AUDIT_TRAIL_ACTION_DATE_I on SYS_AUDIT_TRAIL (AUD_ACTION, AUD_DATE);
create index SYS_AUDIT_TRAIL_CLIENT_DATE_I on SYS_AUDIT_TRAIL (AUD_CLIENT_IP, AUD_DATE);
create index SYS_AUDIT_TRAIL_DATE_I on SYS_AUDIT_TRAIL (AUD_DATE);
create index SYS_AUDIT_TRAIL_USER_DATE_I on SYS_AUDIT_TRAIL (AUD_USER, AUD_DATE);

prompt
prompt Creating table SYS_DICT
prompt =======================
prompt
create table SYS_DICT
(
  id          VARCHAR2(64) not null,
  value       VARCHAR2(100) not null,
  label       VARCHAR2(100) not null,
  type        VARCHAR2(100) not null,
  description NVARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  parent_id   VARCHAR2(64) default '0',
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
create index SYS_DICT_DEL_FLAG on SYS_DICT (DEL_FLAG);
create index SYS_DICT_LABEL on SYS_DICT (LABEL);
create index SYS_DICT_VALUE on SYS_DICT (VALUE);
alter table SYS_DICT
  add primary key (ID);

prompt
prompt Creating table SYS_LOG
prompt ======================
prompt
create table SYS_LOG
(
  id          VARCHAR2(64) not null,
  type        CHAR(1) default '1',
  title       NVARCHAR2(500),
  create_by   VARCHAR2(64),
  create_date TIMESTAMP(6),
  remote_addr VARCHAR2(255),
  user_agent  VARCHAR2(255),
  request_uri VARCHAR2(255),
  method      VARCHAR2(5),
  params      CLOB,
  exception   CLOB
)
;
create index SYS_LOG_CREATE_BY on SYS_LOG (CREATE_BY);
create index SYS_LOG_CREATE_DATE on SYS_LOG (CREATE_DATE);
create index SYS_LOG_REQUEST_URI on SYS_LOG (REQUEST_URI);
create index SYS_LOG_TYPE on SYS_LOG (TYPE);
alter table SYS_LOG
  add primary key (ID);

prompt
prompt Creating table SYS_MDICT
prompt ========================
prompt
create table SYS_MDICT
(
  id          VARCHAR2(64) not null,
  parent_id   VARCHAR2(64) not null,
  parent_ids  VARCHAR2(2000) not null,
  name        NVARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  description NVARCHAR2(100),
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
create index SYS_MDICT_DEL_FLAG on SYS_MDICT (DEL_FLAG);
create index SYS_MDICT_PARENT_ID on SYS_MDICT (PARENT_ID);
create index SYS_MDICT_PARENT_IDS on SYS_MDICT (PARENT_IDS);
alter table SYS_MDICT
  add primary key (ID);

prompt
prompt Creating table SYS_MENU
prompt =======================
prompt
create table SYS_MENU
(
  id          VARCHAR2(64) not null,
  parent_id   VARCHAR2(64) not null,
  parent_ids  VARCHAR2(2000) not null,
  name        NVARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  href        VARCHAR2(2000),
  target      VARCHAR2(20),
  icon        VARCHAR2(100),
  is_show     CHAR(1) not null,
  permission  VARCHAR2(200),
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
create index SYS_MENU_DEL_FLAG on SYS_MENU (DEL_FLAG);
create index SYS_MENU_PARENT_ID on SYS_MENU (PARENT_ID);
create index SYS_MENU_PARENT_IDS on SYS_MENU (PARENT_IDS);
alter table SYS_MENU
  add primary key (ID);

prompt
prompt Creating table SYS_OFFICE
prompt =========================
prompt
create table SYS_OFFICE
(
  id             VARCHAR2(64) not null,
  parent_id      VARCHAR2(64) not null,
  parent_ids     VARCHAR2(2000) not null,
  name           NVARCHAR2(100) not null,
  sort           NUMBER(10) not null,
  area_id        VARCHAR2(64) not null,
  code           VARCHAR2(100),
  type           CHAR(1) not null,
  grade          CHAR(1) not null,
  address        NVARCHAR2(255),
  zip_code       VARCHAR2(100),
  master         NVARCHAR2(100),
  phone          NVARCHAR2(200),
  fax            NVARCHAR2(200),
  email          NVARCHAR2(200),
  useable        VARCHAR2(64),
  primary_person VARCHAR2(64),
  deputy_person  VARCHAR2(64),
  create_by      VARCHAR2(64) not null,
  create_date    TIMESTAMP(6) not null,
  update_by      VARCHAR2(64) not null,
  update_date    TIMESTAMP(6) not null,
  remarks        NVARCHAR2(255),
  del_flag       CHAR(1) default '0' not null
)
;
create index SYS_OFFICE_DEL_FLAG on SYS_OFFICE (DEL_FLAG);
create index SYS_OFFICE_PARENT_ID on SYS_OFFICE (PARENT_ID);
create index SYS_OFFICE_PARENT_IDS on SYS_OFFICE (PARENT_IDS);
create index SYS_OFFICE_TYPE on SYS_OFFICE (TYPE);
alter table SYS_OFFICE
  add primary key (ID);

prompt
prompt Creating table SYS_ROLE
prompt =======================
prompt
create table SYS_ROLE
(
  id          VARCHAR2(64) not null,
  office_id   VARCHAR2(64),
  name        NVARCHAR2(100) not null,
  enname      VARCHAR2(255),
  role_type   VARCHAR2(255),
  data_scope  CHAR(1),
  is_sys      VARCHAR2(64),
  useable     VARCHAR2(64),
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
create index SYS_ROLE_DEL_FLAG on SYS_ROLE (DEL_FLAG);
create index SYS_ROLE_ENNAME on SYS_ROLE (ENNAME);
alter table SYS_ROLE
  add primary key (ID);

prompt
prompt Creating table SYS_ROLE_MENU
prompt ============================
prompt
create table SYS_ROLE_MENU
(
  role_id VARCHAR2(64) not null,
  menu_id VARCHAR2(64) not null
)
;
alter table SYS_ROLE_MENU
  add primary key (ROLE_ID, MENU_ID);

prompt
prompt Creating table SYS_ROLE_OFFICE
prompt ==============================
prompt
create table SYS_ROLE_OFFICE
(
  role_id   VARCHAR2(64) not null,
  office_id VARCHAR2(64) not null
)
;
alter table SYS_ROLE_OFFICE
  add primary key (ROLE_ID, OFFICE_ID);

prompt
prompt Creating table SYS_TIMETASK
prompt ===========================
prompt
create table SYS_TIMETASK
(
  id              NVARCHAR2(32) not null,
  create_by       NVARCHAR2(32),
  create_date     DATE,
  create_name     NVARCHAR2(32),
  cron_expression NVARCHAR2(100) not null,
  is_effect       VARCHAR2(1) not null,
  is_start        VARCHAR2(1) not null,
  task_describe   NVARCHAR2(50) not null,
  task_id         NVARCHAR2(100) not null,
  update_by       NVARCHAR2(32),
  update_date     DATE,
  update_name     NVARCHAR2(32),
  inst_id         NVARCHAR2(100),
  impl_class      NVARCHAR2(100)
)
;
alter table SYS_TIMETASK
  add primary key (ID);

prompt
prompt Creating table SYS_TIMETASK_LOG
prompt ===============================
prompt
create table SYS_TIMETASK_LOG
(
  id            NVARCHAR2(32) not null,
  task_id       NVARCHAR2(100),
  task_describe NVARCHAR2(50),
  inst_id       NVARCHAR2(100),
  begin_date    DATE,
  end_date      DATE,
  run_state     VARCHAR2(1),
  run_remarks   NVARCHAR2(2000),
  busi_state    VARCHAR2(1),
  busi_remarks  NVARCHAR2(2000)
)
;
alter table SYS_TIMETASK_LOG
  add primary key (ID);

prompt
prompt Creating table SYS_USER
prompt =======================
prompt
create table SYS_USER
(
  id          VARCHAR2(64) not null,
  company_id  VARCHAR2(64) not null,
  office_id   VARCHAR2(64) not null,
  login_name  VARCHAR2(100) not null,
  password    VARCHAR2(100) not null,
  no          VARCHAR2(100),
  name        NVARCHAR2(100) not null,
  email       NVARCHAR2(200),
  phone       VARCHAR2(200),
  mobile      VARCHAR2(200),
  user_type   CHAR(1),
  photo       VARCHAR2(1000),
  login_ip    VARCHAR2(100),
  login_date  TIMESTAMP(6),
  login_flag  VARCHAR2(64),
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
create index SYS_USER_COMPANY_ID on SYS_USER (COMPANY_ID);
create index SYS_USER_DEL_FLAG on SYS_USER (DEL_FLAG);
create index SYS_USER_LOGIN_NAME on SYS_USER (LOGIN_NAME);
create index SYS_USER_OFFICE_ID on SYS_USER (OFFICE_ID);
create index SYS_USER_UPDATE_DATE on SYS_USER (UPDATE_DATE);
alter table SYS_USER
  add primary key (ID);

prompt
prompt Creating table SYS_USER_ROLE
prompt ============================
prompt
create table SYS_USER_ROLE
(
  user_id VARCHAR2(64) not null,
  role_id VARCHAR2(64) not null
)
;
alter table SYS_USER_ROLE
  add primary key (USER_ID, ROLE_ID);

prompt
prompt Creating table TEST_DATA
prompt ========================
prompt
create table TEST_DATA
(
  id          VARCHAR2(64) not null,
  user_id     VARCHAR2(64),
  office_id   VARCHAR2(64),
  area_id     NVARCHAR2(64),
  name        NVARCHAR2(100),
  sex         CHAR(1),
  in_date     DATE,
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table TEST_DATA
  is '业务数据表';
comment on column TEST_DATA.id
  is '编号';
comment on column TEST_DATA.user_id
  is '归属用户';
comment on column TEST_DATA.office_id
  is '归属部门';
comment on column TEST_DATA.area_id
  is '归属区域';
comment on column TEST_DATA.name
  is '名称';
comment on column TEST_DATA.sex
  is '性别';
comment on column TEST_DATA.in_date
  is '加入日期';
comment on column TEST_DATA.create_by
  is '创建者';
comment on column TEST_DATA.create_date
  is '创建时间';
comment on column TEST_DATA.update_by
  is '更新者';
comment on column TEST_DATA.update_date
  is '更新时间';
comment on column TEST_DATA.remarks
  is '备注信息';
comment on column TEST_DATA.del_flag
  is '删除标记';
create index TEST_DATA_DEL_FLAG on TEST_DATA (DEL_FLAG);
alter table TEST_DATA
  add primary key (ID);

prompt
prompt Creating table TEST_DATA_CHILD
prompt ==============================
prompt
create table TEST_DATA_CHILD
(
  id                VARCHAR2(64) not null,
  test_data_main_id VARCHAR2(64),
  name              NVARCHAR2(100),
  create_by         VARCHAR2(64) not null,
  create_date       TIMESTAMP(6) not null,
  update_by         VARCHAR2(64) not null,
  update_date       TIMESTAMP(6) not null,
  remarks           NVARCHAR2(255),
  del_flag          CHAR(1) default '0' not null
)
;
comment on table TEST_DATA_CHILD
  is '业务数据子表';
comment on column TEST_DATA_CHILD.id
  is '编号';
comment on column TEST_DATA_CHILD.test_data_main_id
  is '业务主表ID';
comment on column TEST_DATA_CHILD.name
  is '名称';
comment on column TEST_DATA_CHILD.create_by
  is '创建者';
comment on column TEST_DATA_CHILD.create_date
  is '创建时间';
comment on column TEST_DATA_CHILD.update_by
  is '更新者';
comment on column TEST_DATA_CHILD.update_date
  is '更新时间';
comment on column TEST_DATA_CHILD.remarks
  is '备注信息';
comment on column TEST_DATA_CHILD.del_flag
  is '删除标记';
create index TEST_DATA_CHILD_DEL_FLAG on TEST_DATA_CHILD (DEL_FLAG);
alter table TEST_DATA_CHILD
  add primary key (ID);

prompt
prompt Creating table TEST_DATA_MAIN
prompt =============================
prompt
create table TEST_DATA_MAIN
(
  id          VARCHAR2(64) not null,
  user_id     VARCHAR2(64),
  office_id   VARCHAR2(64),
  area_id     NVARCHAR2(64),
  name        NVARCHAR2(100),
  sex         CHAR(1),
  in_date     DATE,
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table TEST_DATA_MAIN
  is '业务数据表';
comment on column TEST_DATA_MAIN.id
  is '编号';
comment on column TEST_DATA_MAIN.user_id
  is '归属用户';
comment on column TEST_DATA_MAIN.office_id
  is '归属部门';
comment on column TEST_DATA_MAIN.area_id
  is '归属区域';
comment on column TEST_DATA_MAIN.name
  is '名称';
comment on column TEST_DATA_MAIN.sex
  is '性别';
comment on column TEST_DATA_MAIN.in_date
  is '加入日期';
comment on column TEST_DATA_MAIN.create_by
  is '创建者';
comment on column TEST_DATA_MAIN.create_date
  is '创建时间';
comment on column TEST_DATA_MAIN.update_by
  is '更新者';
comment on column TEST_DATA_MAIN.update_date
  is '更新时间';
comment on column TEST_DATA_MAIN.remarks
  is '备注信息';
comment on column TEST_DATA_MAIN.del_flag
  is '删除标记';
create index TEST_DATA_MAIN_DEL_FLAG on TEST_DATA_MAIN (DEL_FLAG);
alter table TEST_DATA_MAIN
  add primary key (ID);

prompt
prompt Creating table TEST_TREE
prompt ========================
prompt
create table TEST_TREE
(
  id          VARCHAR2(64) not null,
  parent_id   VARCHAR2(64) not null,
  parent_ids  VARCHAR2(2000) not null,
  name        NVARCHAR2(100) not null,
  sort        NUMBER(10) not null,
  create_by   VARCHAR2(64) not null,
  create_date TIMESTAMP(6) not null,
  update_by   VARCHAR2(64) not null,
  update_date TIMESTAMP(6) not null,
  remarks     NVARCHAR2(255),
  del_flag    CHAR(1) default '0' not null
)
;
comment on table TEST_TREE
  is '树结构表';
comment on column TEST_TREE.id
  is '编号';
comment on column TEST_TREE.parent_id
  is '父级编号';
comment on column TEST_TREE.parent_ids
  is '所有父级编号';
comment on column TEST_TREE.name
  is '名称';
comment on column TEST_TREE.sort
  is '排序';
comment on column TEST_TREE.create_by
  is '创建者';
comment on column TEST_TREE.create_date
  is '创建时间';
comment on column TEST_TREE.update_by
  is '更新者';
comment on column TEST_TREE.update_date
  is '更新时间';
comment on column TEST_TREE.remarks
  is '备注信息';
comment on column TEST_TREE.del_flag
  is '删除标记';
create index TEST_DATA_PARENT_ID on TEST_TREE (PARENT_ID);
create index TEST_DATA_PARENT_IDS on TEST_TREE (PARENT_IDS);
create index TEST_TREE_DEL_FLAG on TEST_TREE (DEL_FLAG);
alter table TEST_TREE
  add primary key (ID);

prompt
prompt Creating table TEST_USER
prompt ========================
prompt
create table TEST_USER
(
  username VARCHAR2(30),
  password VARCHAR2(30)
)
;

prompt
prompt Creating sequence ACT_EVT_LOG_SEQ
prompt =================================
prompt
create sequence ACT_EVT_LOG_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence AD_FILE_SEQ
prompt =============================
prompt
create sequence AD_FILE_SEQ
minvalue 1
maxvalue 99999999
start with 21
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence BUSINESS_TYPE_ID_SEQ
prompt ======================================
prompt
create sequence BUSINESS_TYPE_ID_SEQ
minvalue 1
maxvalue 9999999999999999999
start with 41
increment by 1
cache 20
order;

prompt
prompt Creating sequence CASH_PAY_PERIOD_ID_SEQ
prompt ========================================
prompt
create sequence CASH_PAY_PERIOD_ID_SEQ
minvalue 1
maxvalue 9999999999999
start with 41
increment by 1
cache 20
order;

prompt
prompt Creating sequence CASH_PROV_ID_SEQ
prompt ==================================
prompt
create sequence CASH_PROV_ID_SEQ
minvalue 1
maxvalue 99999999999999
start with 41
increment by 1
cache 20
order;

prompt
prompt Creating sequence CASH_WITHDRAW_RECORD_ID_SEQ
prompt =============================================
prompt
create sequence CASH_WITHDRAW_RECORD_ID_SEQ
minvalue 1
maxvalue 999999999999999
start with 43
increment by 1
cache 20
order;

prompt
prompt Creating sequence CD_FILE_SEQ
prompt =============================
prompt
create sequence CD_FILE_SEQ
minvalue 1
maxvalue 99999
start with 67
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence CITY_AD_FILE_SEQ
prompt ==================================
prompt
create sequence CITY_AD_FILE_SEQ
minvalue 1
maxvalue 99999999
start with 21
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence CITY_AD_SEQ
prompt =============================
prompt
create sequence CITY_AD_SEQ
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence CITY_BP_FILE_SEQ
prompt ==================================
prompt
create sequence CITY_BP_FILE_SEQ
minvalue 1
maxvalue 99999999
start with 81
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence CITY_CL_FILE_SEQ
prompt ==================================
prompt
create sequence CITY_CL_FILE_SEQ
minvalue 1
maxvalue 99999999
start with 2441
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence CITY_CR_FILE_SEQ
prompt ==================================
prompt
create sequence CITY_CR_FILE_SEQ
minvalue 1
maxvalue 99999999
start with 81
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence CITY_FB_FILE_SEQ
prompt ==================================
prompt
create sequence CITY_FB_FILE_SEQ
minvalue 1
maxvalue 99999999
start with 61
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence CITY_LD_FILE_SEQ
prompt ==================================
prompt
create sequence CITY_LD_FILE_SEQ
minvalue 1
maxvalue 99999999
start with 101
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence CM_FILE_SEQ
prompt =============================
prompt
create sequence CM_FILE_SEQ
minvalue 1
maxvalue 99999999
start with 1
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence ED_FILE_SEQ
prompt =============================
prompt
create sequence ED_FILE_SEQ
minvalue 1
maxvalue 99999999
start with 2
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence INFOERCONF
prompt ============================
prompt
create sequence INFOERCONF
minvalue 1
maxvalue 9999999999999999999999
start with 161
increment by 1
cache 20
order;

prompt
prompt Creating sequence ORG_INFO_ID_SEQ
prompt =================================
prompt
create sequence ORG_INFO_ID_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20
order;

prompt
prompt Creating sequence SETTED201612_ID_SEQ
prompt =====================================
prompt
create sequence SETTED201612_ID_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating package SETT_STAT
prompt ==========================
prompt
create or replace package sett_stat is

  -- Author  : ZHOUHONG
  -- Created : 2016/12/15 17:47:28
  -- Purpose :

  -- Public type declarations

  ERR_MSG_LEN  constant integer := 3000;
  
  procedure excuteProc(v_module_id in varchar2,bill_month in varchar2);
  
  ----省一卡通和部平台结算
  procedure SETL_PROV_STAT(v_bill_month in varchar2);
  
  ----省一卡通和地市结算
  procedure SETL_CITY_STAT(v_bill_month in varchar2);
  
  ----省一卡通和部平台按日结算明细
  procedure SETL_PROV_DAILY(v_bill_month in varchar2);
  
  ----省一卡通和地市按日结算明细
  procedure SETL_CITY_DAILY(v_bill_month in varchar2);
  
  ----省一卡通和部平台跨省详单展示
  procedure SETL_PROV_DETAIL(v_bill_month in varchar2);
  
  ----省一卡通和地市结算详单展示
  procedure SETL_CITY_DETAIL(v_bill_month in varchar2);
    
  
  

  ----部跨省统计
  procedure SETL_DEPARTMENT_STAT(v_bill_date in varchar2);

  ----省内跨省统计
  procedure SETL_DEPARTMENT_PROV_STAT(v_bill_date in varchar2);

  --跨地市西宁和省一卡通公司结算
  procedure SETL_PROV_OUTER_STAT(v_bill_date in varchar2);

  --本地卡本地市消费和省一卡通公司结算
  procedure SETL_PROV_INNER_STAT(v_bill_date in varchar2);

  --统计详单
  --procedure SETL_DETAIL_STAT(v_bill_date in varchar2);

  --统计省内详单
  procedure SETL_CITY_DETAIL_STAT(v_bill_date in varchar2);

  --统计跨省详单
  procedure SETL_PROV_DETAIL_STAT(v_bill_date in varchar2);

  --生成每日LD
  procedure gen_city_ld_file(v_bill_date in varchar2);

  --生成每日BP文件
  procedure gen_city_bp_file(v_bill_date in varchar2);

  --生成每日CR文件
  procedure gen_city_cr_file(v_bill_date in varchar2);

  --生成省内AD详单
  procedure GEN_CITY_AD_DETAIL(v_bill_date in varchar2);
  
  --生成每日AD文件
  procedure gen_city_ad_file(v_bill_date in varchar2);
 
  --生成每日ED文件
  procedure gen_city_ed_file(v_bill_date in varchar2);
  
  --生成每日CM文件
  procedure gen_city_cm_file(v_bill_date in varchar2);

  ----跨省AD账单调整
  procedure ADJUST_SETT_AD_DETAIL(v_bill_date in varchar2);

  ----省内AD账单调整
  procedure ADJUST_SETT_CITY_AD_DETAIL(v_bill_date in varchar2);
  
  ----白名单入库处理
  procedure PRO_BN_RECORD;
  
  ----错单入库处理
  procedure PRO_ER_RECORD;
  
  ----黑名单入库处理
  procedure PRO_UC_RECORD;
  
end sett_stat;
/

prompt
prompt Creating package body SETT_STAT
prompt ===============================
prompt
create or replace package body sett_stat is

  procedure excuteProc(v_module_id in varchar2,bill_month in varchar2) is
  begin
  if(v_module_id='910001') then
    SETL_PROV_STAT(bill_month);
  end if;
  if(v_module_id='910002') then
    SETL_CITY_STAT(bill_month);
  end if;
  if(v_module_id='910003') then
    SETL_PROV_DAILY(bill_month);
  end if;
  if(v_module_id='910004') then
    SETL_CITY_DAILY(bill_month);
  end if;
  if(v_module_id='910005') then
    SETL_PROV_DETAIL(bill_month);
  end if;
  if(v_module_id='910006') then
    SETL_CITY_DETAIL(bill_month);
  end if;
  
  if(v_module_id='0') then
    /*SETL_CITY_STAT(bill_month);
    SETL_CITY_DAILY(bill_month);
    SETL_CITY_DETAIL(bill_month);*/
    SETL_PROV_DETAIL(bill_month);
    SETL_PROV_DAILY(bill_month);
    --- SETL_PROV_STAT must be execute last. depended the daily date
    SETL_PROV_STAT(bill_month);
  end if;
  end excuteProc;



----省一卡通和部平台结算
  /*procedure SETL_PROV_STAT(v_bill_month in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    --v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_STAT', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_STAT', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_prov_stat where  sett_cycle=' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 部跨省统计
    v_sql := 'insert into sett_prov_stat(sett_cycle,sett_object,income_charge,outcome_charge,sett_charge)
              select sett_cycle,
                     sett_object,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     sum(sett_charge)/100
             from
             (
                  \*收入=FB消费-发卡分润-清算分润*\
                  select '||v_bill_month||' sett_cycle,
                         ''青海省一卡通公司'' sett_object ,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) income_charge,
                         0 outcome_charge,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) sett_charge
                  from sett_fb_' || v_bill_month || ' a where  a.err_code = ''000000''
                  union all
                  \*支出=CL消费-发卡分润*\
                  select '||v_bill_month||' sett_cycle,
                         ''青海省一卡通公司'' sett_object ,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.issue_charge),0) outcome_charge,
                         -nvl(sum(a.trade_charge-a.issue_charge),0) sett_charge
                  from sett_cl_' || v_bill_month || ' a where a.err_code = ''000000'')
              group by sett_cycle,sett_object';
    execute immediate v_sql;
    --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省一卡通和部平台结算统计完成'
    where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('部跨省统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_STAT;*/
  
  procedure SETL_PROV_STAT(v_bill_month in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    proc_time date;
    v_last_month varchar2(6);
  begin
    select to_char(add_months(to_date(v_bill_month,'yyyymm'),-1),'yyyymm') into v_last_month from dual;
    --dbms_output.put_line(v_bill_date);

    --v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_STAT', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_STAT', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    --v_sql:='delete from sett_prov_stat where  sett_cycle=' || v_bill_month;
    v_sql:='delete from sett_prov_stat ';
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 部跨省统计
    /*v_sql := 'insert into sett_prov_stat(sett_cycle,sett_object,income_charge,outcome_charge,sett_charge)
              select sett_cycle,
                     sett_object,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     sum(sett_charge)/100
             from
             (
                  \*收入=FB消费-发卡分润-清算分润*\
                  select '||v_bill_month||' sett_cycle,
                         ''青海省一卡通公司'' sett_object ,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) income_charge,
                         0 outcome_charge,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) sett_charge
                  from (select * from sett_fb_' || v_bill_month || ' union all 
                        select * from sett_fb_' || v_last_month || '
                        ) a where  a.err_code = ''000000'' and a.center_sett_date like '''||v_bill_month||'%'' 
                  union all
                  \*支出=CL消费-发卡分润*\
                  select '||v_bill_month||' sett_cycle,
                         ''青海省一卡通公司'' sett_object ,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.issue_charge),0) outcome_charge,
                         -nvl(sum(a.trade_charge-a.issue_charge),0) sett_charge
                  from (select * from sett_cl_' || v_bill_month || ' union all 
                        select * from sett_cl_' || v_last_month || '
                        )a where a.err_code = ''000000'' and a.center_sett_date like '''||v_bill_month||'%'') 
              group by sett_cycle,sett_object';*/
    
    v_sql := 'insert into sett_prov_stat(sett_cycle,sett_object,income_charge,outcome_charge,sett_charge)
              select sett_cycle,
                     sett_object,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     sum(sett_charge)/100
              from
              (
                    select substr(sett_date,0,6) sett_cycle, 
                           a.sett_object sett_object,
                           sum(a.trade_charge-a.service_charge+a.bill_charge) income_charge,
                           0 outcome_charge,
                           sum(a.trade_charge-a.service_charge+a.bill_charge) sett_charge 
                    from SETT_PROV_DAILY a 
                    where sett_object=''青海省一卡通公司'' and sett_role=''收单'' 
                    group by substr(sett_date,0,6),sett_object
                    union all
                    select substr(sett_date,0,6) sett_cycle, 
                           a.sett_object sett_object,
                           0 income_charge,
                           sum(a.trade_charge-a.issue_charge) outcome_charge,
                           -sum(a.trade_charge-a.issue_charge) sett_charge from SETT_PROV_DAILY a 
                    where sett_object=''青海省一卡通公司'' and sett_role=''发卡'' 
                    group by substr(sett_date,0,6),sett_object 
             
              ) group by sett_cycle,sett_object
             ';
    execute immediate v_sql;
    dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省一卡通和部平台结算统计完成'
    where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('部跨省统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_STAT;


----省一卡通和地市结算
  procedure SETL_CITY_STAT(v_bill_month in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    --v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_STAT', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_STAT', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_city_stat where  sett_cycle=' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 省一卡通平台和地市结算
    v_sql := 'insert into sett_city_stat(sett_cycle,sett_object,income_charge,outcome_charge,sett_charge)
              select sett_cycle,
                     sett_object,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     sum(sett_charge)/100
             from
             (
                  /*收入=FB消费-发卡分润-清算分润 CD本地消费*/
                  select '||v_bill_month||' sett_cycle,
                         b.org_name sett_object ,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) income_charge,
                         0 outcome_charge,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) sett_charge
                  from dr_bill_detail_' || v_bill_month || ' a,bps_sys_org_info b
                  where substr(a.recv_org_id,2,7) = b.org_code and a.sys_error_code = ''000000'' and a.file_type in (''1'',''2'') group by b.org_name
                  union all
                  /*西宁支出=CL消费-发卡分润*/
                  select '||v_bill_month||' sett_cycle,
                         ''西宁通卡公司'' sett_object ,
                         0 income_charge,
                         round(nvl(sum(a.trade_charge-a.issue_fee),0)) outcome_charge,
                         -round(nvl(sum(a.trade_charge-a.issue_fee),0)) sett_charge
                  from dr_bill_detail_' || v_bill_month || ' a where a.sys_error_code = ''000000'' and a.issue_org_code = ''04558510'')
              group by sett_cycle,sett_object'; -- a.file_type = ''3'' and
    execute immediate v_sql;
    --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省一卡通和部平台结算统计完成'
    where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('部跨省统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_CITY_STAT;

----省一卡通和部平台按日结算明细
  /*procedure SETL_PROV_DAILY(v_bill_month in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    --v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DAILY', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DAILY', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_prov_daily where  substr(sett_date,1,6) =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 部跨省统计
    v_sql := 'insert into sett_prov_daily(sett_date ,sett_object ,sett_role,trade_charge,service_charge,issue_charge,bill_charge,center_charge,times,sett_charge)
              select sett_date,
                         sett_object ,
                         sett_role,
                         sum(trade_charge),
                         sum(service_charge),
                         sum(issue_charge),
                         sum(bill_charge),
                         sum(center_charge),
                         sum(times),
                         sum(sett_charge)
                  from 
                  ( 
                      \*收入=FB消费-发卡分润-清算分润*\
                      select 
                             --a.sett_date sett_date,
                             a.center_sett_date  sett_date,
                             ''青海省一卡通公司'' sett_object ,
                             ''收单'' sett_role,
                             recv_org_id opp_org_id,
                              round(nvl(sum(a.trade_charge),0)) trade_charge,
                             round(nvl(sum(a.sett_charge),0))  service_charge,
                             round(nvl(sum(a.issue_charge),0)) issue_charge,
                             round(nvl(sum(a.bill_charge),0))  bill_charge,
                             (round(nvl(sum(a.sett_charge),0)) - round(nvl(sum(a.issue_charge),0)) - round(nvl(sum(a.bill_charge),0))) center_charge, 
                             --round(nvl(sum(a.sett_charge-a.issue_charge-a.bill_charge),0)) center_charge,
                             count(*) times,
                             --round(nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0)) sett_charge
                            (round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.sett_charge),0)) + round(nvl(sum(a.bill_charge),0))) sett_charge
                            from sett_fb_' || v_bill_month || ' a where a.err_code = ''000000'' 
                            group by a.sett_date,recv_org_id
                      union all
                      \*支出=CL消费-发卡分润*\
                      select 
                           --a.sett_date sett_date,
                           a.center_sett_date  sett_date,
                             ''青海省一卡通公司'' sett_object ,
                              ''发卡'' sett_role,
                              bill_org_code opp_org_id,
                            round(nvl(sum(a.trade_charge),0)) trade_charge,
                            round(nvl(sum(a.sett_charge),0))  service_charge,
                            round(nvl(sum(a.issue_charge),0)) issue_charge,
                            round(nvl(sum(a.bill_charge),0))  bill_charge,
                            --round(nvl(sum(a.sett_charge-a.issue_charge-a.bill_charge),0)) center_charge,
                            (round(nvl(sum(a.sett_charge),0)) - round(nvl(sum(a.issue_charge),0)) - round(nvl(sum(a.bill_charge),0))) center_charge,
                            count(*) times,
                           -- -round(nvl(sum(a.trade_charge-a.issue_charge),0)) sett_charge
                           -(round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.issue_charge),0))) sett_charge
                      from sett_cl_' || v_bill_month || ' a where a.err_code = ''000000'' 
                      group by a.sett_date, a.bill_org_code
                  ) group by sett_date,sett_role, sett_object ';
    execute immediate v_sql;
    --dbms_output.put_line('v_sql='||v_sql);
    
      v_sql := 'insert into sett_prov_daily(sett_date ,sett_object ,sett_role,trade_charge,service_charge,issue_charge,bill_charge,center_charge,times,sett_charge)
                      \*收入=FB消费-发卡分润-清算分润*\
                      select sett_date,
                             sett_object ,
                             sett_role,
                             sum(trade_charge),
                             sum(service_charge),
                             sum(issue_charge),
                             sum(bill_charge),
                             sum(center_charge),
                             sum(times),
                             sum(sett_charge)
                      from 
                      (  select a.center_sett_date  sett_date, --a.sett_date sett_date,
                               b.org_name sett_object ,
                               ''收单'' sett_role,
                               recv_org_id opp_org_id,
                               round(nvl(sum(a.trade_charge),0)) trade_charge,
                               round(nvl(sum(a.sett_charge),0))  service_charge,
                               round(nvl(sum(a.issue_charge),0)) issue_charge,
                               round(nvl(sum(a.bill_charge),0))  bill_charge,
                               (round(nvl(sum(a.sett_charge),0)) - round(nvl(sum(a.issue_charge),0)) - round(nvl(sum(a.bill_charge),0))) center_charge, 
                               --round(nvl(sum(a.sett_charge-a.issue_charge-a.bill_charge),0)) center_charge,
                               count(*) times,
                               --round(nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0)) sett_charge
                              (round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.sett_charge),0)) + round(nvl(sum(a.bill_charge),0))) sett_charge
                        from sett_fb_' || v_bill_month || ' a,bps_sys_org_info b where a.err_code = ''000000''
                        and substr(a.bill_org_id,2,7) = b.org_code
                        group by a.sett_date,b.org_name,recv_org_id
                       
                      union all
                      
                        \*支出=CL消费-发卡分润*\
                        select a.center_sett_date  sett_date, -- a.sett_date sett_date,
                               b.org_name sett_object ,
                               ''发卡'' sett_role,
                               bill_org_code opp_org_id,
                              round(nvl(sum(a.trade_charge),0)) trade_charge,
                              round(nvl(sum(a.sett_charge),0))  service_charge,
                              round(nvl(sum(a.issue_charge),0)) issue_charge,
                              round(nvl(sum(a.bill_charge),0))  bill_charge,
                              --round(nvl(sum(a.sett_charge-a.issue_charge-a.bill_charge),0)) center_charge,
                              (round(nvl(sum(a.sett_charge),0)) - round(nvl(sum(a.issue_charge),0)) - round(nvl(sum(a.bill_charge),0))) center_charge,
                              count(*) times,
                             -- -round(nvl(sum(a.trade_charge-a.issue_charge),0)) sett_charge
                             -(round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.issue_charge),0))) sett_charge 
                        from sett_cl_' || v_bill_month || ' a,bps_sys_org_info b  where a.err_code = ''000000''
                        and substr(a.issue_company_code,2,7) = b.org_code
                        group by a.sett_date,b.org_name,bill_org_code
                    ) group by sett_date,sett_role, sett_object
                        ';
    --dbms_output.put_line('v_sql='||v_sql);
    execute immediate v_sql;
    --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省一卡通和部平台结算统计完成'
    where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('部跨省统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_DAILY;*/

procedure SETL_PROV_DAILY(v_bill_month in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    --v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DAILY', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DAILY', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_prov_daily where  table_month =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 部跨省统计
    v_sql := 'insert into sett_prov_daily(sett_date ,sett_object ,sett_role,trade_charge,service_charge,issue_charge,bill_charge,center_charge,times,sett_charge,table_month)
              select sett_date,
                         sett_object ,
                         sett_role,
                         sum(trade_charge),
                         sum(service_charge),
                         sum(issue_charge),
                         sum(bill_charge),
                         sum(center_charge),
                         sum(times),
                         sum(sett_charge), ''' || v_bill_month || ''' as table_month
                  from 
                  ( 
                      /*收入=FB消费-发卡分润-清算分润*/
                      select a.center_sett_date sett_date, -- a.sett_date sett_date,
                             ''青海省一卡通公司'' sett_object ,
                             ''收单'' sett_role,
                             recv_org_id opp_org_id,
                              round(nvl(sum(a.trade_charge),0)) trade_charge,
                             round(nvl(sum(a.sett_charge),0))  service_charge,
                             round(nvl(sum(a.issue_charge),0)) issue_charge,
                             round(nvl(sum(a.bill_charge),0))  bill_charge,
                             (round(nvl(sum(a.sett_charge),0)) - round(nvl(sum(a.issue_charge),0)) - round(nvl(sum(a.bill_charge),0))) center_charge, 
                             --round(nvl(sum(a.sett_charge-a.issue_charge-a.bill_charge),0)) center_charge,
                             count(*) times,
                             --round(nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0)) sett_charge
                            (round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.sett_charge),0)) + round(nvl(sum(a.bill_charge),0))) sett_charge
                            from sett_fb_' || v_bill_month || ' a where a.err_code = ''000000'' 
                            group by a.center_sett_date,recv_org_id
                      union all
                      /*支出=CL消费-发卡分润*/
                      select a.center_sett_date sett_date, -- a.sett_date sett_date,
                             ''青海省一卡通公司'' sett_object ,
                              ''发卡'' sett_role,
                              bill_org_code opp_org_id,
                            round(nvl(sum(a.trade_charge),0)) trade_charge,
                            round(nvl(sum(a.sett_charge),0))  service_charge,
                            round(nvl(sum(a.issue_charge),0)) issue_charge,
                            round(nvl(sum(a.bill_charge),0))  bill_charge,
                            --round(nvl(sum(a.sett_charge-a.issue_charge-a.bill_charge),0)) center_charge,
                            (round(nvl(sum(a.sett_charge),0)) - round(nvl(sum(a.issue_charge),0)) - round(nvl(sum(a.bill_charge),0))) center_charge,
                            count(*) times,
                           -- -round(nvl(sum(a.trade_charge-a.issue_charge),0)) sett_charge
                           -(round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.issue_charge),0))) sett_charge
                      from sett_cl_' || v_bill_month || ' a where a.err_code = ''000000'' 
                      group by a.center_sett_date, a.bill_org_code
                  ) group by sett_date,sett_role, sett_object ';
    execute immediate v_sql;
    --dbms_output.put_line('v_sql='||v_sql);
    
      v_sql := 'insert into sett_prov_daily(sett_date ,sett_object ,sett_role,trade_charge,service_charge,issue_charge,bill_charge,center_charge,times,sett_charge,table_month)
                      /*收入=FB消费-发卡分润-清算分润*/
                      select sett_date,
                             sett_object ,
                             sett_role,
                             sum(trade_charge),
                             sum(service_charge),
                             sum(issue_charge),
                             sum(bill_charge),
                             sum(center_charge),
                             sum(times),
                             sum(sett_charge), ''' || v_bill_month || ''' as table_month
                      from 
                      (  select a.center_sett_date sett_date, -- a.sett_date sett_date,
                               b.org_name sett_object ,
                               ''收单'' sett_role,
                               recv_org_id opp_org_id,
                               round(nvl(sum(a.trade_charge),0)) trade_charge,
                               round(nvl(sum(a.sett_charge),0))  service_charge,
                               round(nvl(sum(a.issue_charge),0)) issue_charge,
                               round(nvl(sum(a.bill_charge),0))  bill_charge,
                               (round(nvl(sum(a.sett_charge),0)) - round(nvl(sum(a.issue_charge),0)) - round(nvl(sum(a.bill_charge),0))) center_charge, 
                               --round(nvl(sum(a.sett_charge-a.issue_charge-a.bill_charge),0)) center_charge,
                               count(*) times,
                               --round(nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0)) sett_charge
                              (round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.sett_charge),0)) + round(nvl(sum(a.bill_charge),0))) sett_charge
                        from sett_fb_' || v_bill_month || ' a,bps_sys_org_info b where a.err_code = ''000000''
                        and substr(a.bill_org_id,2,7) = b.org_code
                        group by a.center_sett_date,b.org_name,recv_org_id
                       
                      union all
                      
                        /*支出=CL消费-发卡分润*/
                        select a.center_sett_date sett_date, -- a.sett_date sett_date,
                               b.org_name sett_object ,
                               ''发卡'' sett_role,
                               bill_org_code opp_org_id,
                              round(nvl(sum(a.trade_charge),0)) trade_charge,
                              round(nvl(sum(a.sett_charge),0))  service_charge,
                              round(nvl(sum(a.issue_charge),0)) issue_charge,
                              round(nvl(sum(a.bill_charge),0))  bill_charge,
                              --round(nvl(sum(a.sett_charge-a.issue_charge-a.bill_charge),0)) center_charge,
                              (round(nvl(sum(a.sett_charge),0)) - round(nvl(sum(a.issue_charge),0)) - round(nvl(sum(a.bill_charge),0))) center_charge,
                              count(*) times,
                             -- -round(nvl(sum(a.trade_charge-a.issue_charge),0)) sett_charge
                             -(round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.issue_charge),0))) sett_charge 
                        from sett_cl_' || v_bill_month || ' a,bps_sys_org_info b  where a.err_code = ''000000''
                        and substr(a.issue_company_code,2,7) = b.org_code
                        group by a.center_sett_date,b.org_name,bill_org_code
                    ) group by sett_date,sett_role, sett_object
                        ';
    --dbms_output.put_line('v_sql='||v_sql);
    execute immediate v_sql;

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省一卡通和部平台结算统计完成'
    where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('部跨省统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_DAILY;

----省一卡通和地市按日结算明细
  procedure SETL_CITY_DAILY(v_bill_month in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    --v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台结算已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DAILY', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DAILY', v_bill_month, 2, proc_time, '省一卡通和部平台结算统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_city_daily where  substr(sett_date,1,6) =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 省一卡通平台和地市按日统计
    v_sql := 'insert into sett_city_daily(sett_date ,sett_object ,sett_role,trade_charge,service_charge,issue_charge,bill_charge,center_charge,times,sett_charge)
              /*收入=FB消费-发卡分润-清算分润 CD本地消费*/
              select sett_date,
                     sett_object,
                     sett_role,
                     sum(trade_charge),
                     sum(service_charge),
                     sum(issue_charge),
                     sum(bill_charge),
                     sum(center_charge),
                     sum(times),
                     sum(sett_charge)
              from
              (    select a.sett_date sett_date,
                         b.org_name sett_object ,
                         ''收单'' sett_role,
                         recv_org_id opp_org_id,
                         round(nvl(sum(a.trade_charge),0)) trade_charge,
                         round(nvl(sum(a.service_fee),0))  service_charge, 
                         round(nvl(sum(a.issue_fee),0)) issue_charge,
                         round(nvl(sum(a.bill_fee),0))  bill_charge,
                         --nvl(sum(a.service_fee-a.issue_fee-a.bill_fee),0) center_charge,
                         ( round(nvl(sum(a.service_fee),0)) - round(nvl(sum(a.issue_fee),0)) - round(nvl(sum(a.bill_fee),0))) center_charge,
                         count(*) times,
                         --nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) sett_charge
                         (round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.service_fee),0)) + round(nvl(sum(a.bill_fee),0)) ) sett_charge
                  from dr_bill_detail_' || v_bill_month || ' a,bps_sys_org_info b
                  where substr(a.recv_org_id,2,7) = b.org_code and a.sys_error_code = ''000000'' and a.file_type in (''1'',''2'') 
                  group by a.sett_date,b.org_name,recv_org_id
               union all
                  /*西宁支出=CL消费-发卡分润*/
                  select a.sett_date sett_date,
                         ''西宁通卡公司'' sett_object ,
                          ''发卡'' sett_role,
                         issue_org_code opp_org_id,
                         round(nvl(sum(a.trade_charge),0)) trade_charge,
                         round(nvl(sum(a.service_fee),0))  service_charge, 
                         round(nvl(sum(a.issue_fee),0)) issue_charge,
                         round(nvl(sum(a.bill_fee),0))  bill_charge,
                         --nvl(sum(a.service_fee-a.issue_fee-a.bill_fee),0) center_charge,
                         (round(nvl(sum(a.service_fee),0)) -  round(nvl(sum(a.issue_fee),0)) - round(nvl(sum(a.bill_fee),0))) center_charge ,
                         count(*) times,
                         -- -nvl(sum(a.trade_charge-a.issue_fee),0) sett_charge
                         - (round(nvl(sum(a.trade_charge),0)) - round(nvl(sum(a.issue_fee),0))) sett_charge
                  from dr_bill_detail_' || v_bill_month || ' a where a.sys_error_code = ''000000'' and a.issue_org_code = ''04558510''
              group by sett_date,issue_org_code
              )group by  sett_date,sett_object, sett_role';--a.file_type = ''3'' and
    execute immediate v_sql;
        --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省一卡通和部平台结算统计完成'
    where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('部跨省统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_CITY_DAILY;

----省一卡通和部平台跨省详单展示
  /*procedure SETL_PROV_DETAIL(v_bill_month in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    --v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台跨省详单展示正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台跨省详单展示已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_month, 2, proc_time, '省一卡通和部平台跨省详单展示重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_month, 2, proc_time, '省一卡通和部平台跨省详单展示开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_prov_detail where  substr(sett_date,1,6) =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 部跨省统计
    v_sql := 'insert into sett_prov_detail(sett_date,trade_type,issue_org_code ,bill_org_code ,card_no,before_trade_charge,trade_charge,trade_date,
                                           trade_time,service_charge,issue_charge,bill_charge ,center_charge,sett_charge)
                  \*收入=FB消费-发卡分润-清算分润*\
                  select a.center_sett_date  sett_date, -- a.sett_date sett_date,
                         a.trade_type trade_type ,
                         a.issue_company_code issue_org_code,
                         a.bill_org_id bill_org_code,
                         a.card_no card_no,
                         a.beforetrade_charge before_trade_charge,
                         a.trade_charge trade_charge,
                         a.trade_date trade_date,
                         a.trade_time trade_time,
                         a.sett_charge  service_charge,
                         a.issue_charge issue_charge,
                         a.bill_charge  bill_charge,
                         a.sett_charge-a.issue_charge-a.bill_charge center_charge,
                         a.trade_charge-a.sett_charge+a.bill_charge sett_charge
                  from sett_fb_' || v_bill_month || ' a where a.err_code = ''000000''
                  union all
                  \*支出=CL消费-发卡分润*\
                  select a.center_sett_date  sett_date, -- a.sett_date sett_date,
                         a.trade_type trade_type ,
                         a.issue_company_code issue_org_code,
                         a.bill_org_id bill_org_code,
                         a.card_no card_no,
                         a.beforetrade_charge before_trade_charge,
                         a.trade_charge trade_charge,
                         a.trade_date trade_date,
                         a.trade_time trade_time,
                         a.sett_charge  service_charge,
                         a.issue_charge issue_charge,
                         a.bill_charge  bill_charge,
                         a.sett_charge-a.issue_charge-a.bill_charge center_charge,
                         -(a.trade_charge-a.issue_charge) sett_charge
                  from sett_cl_' || v_bill_month || ' a where a.err_code = ''000000'' ';
    execute immediate v_sql;
    --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省一卡通和部平台跨省详单展示完成'
    where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('省一卡通和部平台跨省详单展示完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_DETAIL;*/

procedure SETL_PROV_DETAIL(v_bill_month in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    --v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台跨省详单展示正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台跨省详单展示已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_month, 2, proc_time, '省一卡通和部平台跨省详单展示重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_month, 2, proc_time, '省一卡通和部平台跨省详单展示开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_prov_detail where  table_month =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 部跨省统计
    v_sql := 'insert into sett_prov_detail(sett_date,trade_type,issue_org_code ,bill_org_code ,card_no,before_trade_charge,trade_charge,trade_date,
                                           trade_time,service_charge,issue_charge,bill_charge ,center_charge,sett_charge,table_month) 
                  /*收入=FB消费-发卡分润-清算分润*/
                  select a.center_sett_date sett_date, -- a.sett_date sett_date,
                         a.trade_type trade_type ,
                         a.issue_company_code issue_org_code,
                         a.bill_org_id bill_org_code,
                         a.card_no card_no,
                         a.beforetrade_charge before_trade_charge,
                         a.trade_charge trade_charge,
                         a.trade_date trade_date,
                         a.trade_time trade_time,
                         a.sett_charge  service_charge, 
                         a.issue_charge issue_charge,
                         a.bill_charge  bill_charge,
                         a.sett_charge-a.issue_charge-a.bill_charge center_charge,
                         a.trade_charge-a.sett_charge+a.bill_charge sett_charge, ''' || v_bill_month || ''' as table_month
                  from sett_fb_' || v_bill_month || ' a where a.err_code = ''000000''
                  union all
                  /*支出=CL消费-发卡分润*/
                  select a.center_sett_date sett_date, -- a.sett_date sett_date,
                         a.trade_type trade_type ,
                         a.issue_company_code issue_org_code,
                         a.bill_org_id bill_org_code,
                         a.card_no card_no,
                         a.beforetrade_charge before_trade_charge,
                         a.trade_charge trade_charge,
                         a.trade_date trade_date,
                         a.trade_time trade_time,
                         a.sett_charge  service_charge, 
                         a.issue_charge issue_charge,
                         a.bill_charge  bill_charge,
                         a.sett_charge-a.issue_charge-a.bill_charge center_charge,
                         -(a.trade_charge-a.issue_charge) sett_charge, ''' || v_bill_month || ''' as table_month
                  from sett_cl_' || v_bill_month || ' a where a.err_code = ''000000'' ';
    execute immediate v_sql;
    --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省一卡通和部平台跨省详单展示完成'
    where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('省一卡通和部平台跨省详单展示完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_DETAIL;




----省一卡通和地市结算详单展示
  procedure SETL_CITY_DETAIL(v_bill_month in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    --v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台跨省详单展示正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省一卡通和部平台跨省详单展示已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DETAIL', v_bill_month, 2, proc_time, '省一卡通和部平台跨省详单展示重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DETAIL', v_bill_month, 2, proc_time, '省一卡通和部平台跨省详单展示开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_city_detail where  substr(sett_date,1,6) =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 省一卡通平台和地市结算详单明细
    v_sql := 'insert into sett_city_detail(sett_date,trade_type,issue_org_code ,bill_org_code ,card_no,before_trade_charge,trade_charge,trade_date,
                                           trade_time,service_charge,issue_charge,bill_charge ,center_charge,sett_charge,SETT_ORG_CODE,roam_type)
              /*收入=FB消费-发卡分润-清算分润 CD本地消费*/
                  select a.sett_date sett_date,
                         a.trade_code trade_type ,
                         a.ISSUE_ORG_CODE issue_org_code,
                         a.RECV_ORG_ID bill_org_code,
                         a.card_no card_no,
                         a.beforetrade_charge_dec before_trade_charge,
                         a.trade_charge trade_charge,
                         a.trade_date trade_date,
                         a.trade_time trade_time,
                         a.service_fee  service_charge,
                         a.issue_fee issue_charge,
                         a.bill_fee  bill_charge,
                         a.service_fee-a.issue_fee-a.bill_fee center_charge,
                         a.trade_charge-a.service_fee+a.bill_fee sett_charge,
                         RECV_ORG_ID sett_org_code,
                         a.roam_type roam_type
                  from dr_bill_detail_' || v_bill_month || ' a,bps_sys_org_info b
                  where substr(a.recv_org_id,2,7) = b.org_code and a.sys_error_code = ''000000'' and a.file_type in (''1'',''2'')
                  union all
                  /*西宁支出=CL消费-发卡分润*/
                  select a.sett_date sett_date,
                         a.trade_code trade_type ,
                         a.ISSUE_ORG_CODE issue_org_code,
                         a.RECV_ORG_ID bill_org_code,
                         a.card_no card_no,
                         a.beforetrade_charge_dec before_trade_charge,
                         a.trade_charge trade_charge,
                         a.trade_date trade_date,
                         a.trade_time trade_time,
                         a.service_fee  service_charge,
                         a.issue_fee issue_charge,
                         a.bill_fee  bill_charge,
                         a.service_fee-a.issue_fee-a.bill_fee center_charge,
                         -(a.trade_charge-a.issue_fee) sett_charge,
                         ISSUE_ORG_CODE sett_org_code,
                         a.roam_type roam_type
                  from dr_bill_detail_' || v_bill_month || ' a where a.sys_error_code = ''000000'' and a.issue_org_code = ''04558510''  ';
    execute immediate v_sql; -- a.file_type = ''3'' and
    --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省一卡通和部平台跨省详单展示完成'
    where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('省一卡通和部平台跨省详单展示完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_CITY_DETAIL;










  ----部跨省统计  （不再使用）
  procedure SETL_DEPARTMENT_STAT(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='01' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('部跨省统计业务统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='01' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('部跨省统计已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='01' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('01', v_bill_date, 2, proc_time, '部跨省统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('01', v_bill_date, 2, proc_time, '部跨省统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_stat_report where sett_type=''01'' and sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 部跨省统计
    v_sql := 'insert into sett_stat_report(SETT_TYPE,SETT_DATE,ORG_CODE,ORG_NAME,INCOME_CHARGE,OUTCOME_CHARGE,NOTE,OFFSET_BALANCE)
              select sett_type,
                     sett_date,
                     org_code,
                     org_name,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     note,
                     sum(offset_balance)/100
             from
             (
                  /*收入=FB消费-发卡分润-清算分润*/
                  select ''01'' sett_type ,
                         a.sett_date sett_date,
                         ''00000000'' org_code ,
                         ''部清算中心'' org_name ,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) income_charge,
                         0 outcome_charge,
                         ''跨省省和部结算'' note,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) offset_balance
                  from sett_fb_' || v_month || ' a where a.sett_date = ' || v_bill_date || ' and a.err_code = ''000000'' group by a.sett_date
                  union all
                  /*支出=CL消费-发卡分润*/
                  select ''01'' sett_type,
                         a.sett_date sett_date,
                         ''00000000'' org_code,
                         ''部清算中心'' org_name,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.issue_charge),0) outcome_charge,
                         ''跨省省和部结算'' note,
                         -nvl(sum(a.trade_charge-a.issue_charge),0) offset_balance
                  from sett_cl_' || v_month || ' a where a.sett_date = ' || v_bill_date || '  and a.err_code = ''000000''
                  group by a.sett_date)
              group by sett_type,sett_date,org_code,org_name,note';
    execute immediate v_sql;
    dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='部跨省统计完成'
    where sett_type='01' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('部跨省统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='01' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_DEPARTMENT_STAT;

  --跨省省内统计 （不再使用）
  procedure SETL_DEPARTMENT_PROV_STAT(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，跨省省内统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='02' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('跨省省内统计业务统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，跨省省内统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='02' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('跨省省内统计已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='02' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('02', v_bill_date, 2, proc_time, '跨省省内统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('02', v_bill_date, 2, proc_time, '跨省省内统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_stat_report where sett_type=''02'' and sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 跨省省内统计
    v_sql := 'insert into sett_stat_report (SETT_TYPE,SETT_DATE,ORG_CODE,ORG_NAME,INCOME_CHARGE,OUTCOME_CHARGE,NOTE,OFFSET_BALANCE)
              select sett_type,
                     sett_date,
                     org_code,
                     org_name,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     note,
                     sum(offset_balance)/100
             from
             (
                 /*地市收入=FB消费-手续费*/
                 select ''02'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.recv_org_id,2,7) org_code ,
                         '''' org_name ,
                         nvl(sum(a.trade_charge-a.service_fee),0) income_charge,
                         0 outcome_charge,
                         ''跨省省和省内结算'' note,
                         nvl(sum(a.trade_charge-a.service_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.file_type = 2 and a.sys_error_code = ''000000'' and
                  a.sett_date = ' || v_bill_date|| ' group by a.sett_date,a.recv_org_id
                  union all
                  /*西宁支出=CL消费*/
                  select ''02'' sett_type,
                         a.sett_date sett_date,
                         substr(a.issue_org_code,2,7) org_code,
                         '''' org_name,
                         0 income_charge,
                         nvl(sum(a.trade_charge),0) outcome_charge,
                         ''跨省省和省内结算'' note,
                         -nvl(sum(a.trade_charge),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.file_type = 3 and
                  a.sett_date = ' || v_bill_date|| ' and a.issue_org_code = ''04558510'' and a.sys_error_code = ''000000''
                  group by a.sett_date ,a.issue_org_code
                  union all
                  /*省平台收入=FB消费收单分润*/
                  select ''02'' sett_type ,
                         a.sett_date sett_date,
                         ''30138500'' org_code ,
                         ''青海省一卡通公司'' org_name ,
                         nvl(sum(a.other_fee),0) income_charge,
                         0 outcome_charge,
                         ''跨省省和省内结算'' note,
                         nvl(sum(a.other_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where  a.file_type = 2 and a.sys_error_code = ''000000'' and
                  a.sett_date = ' || v_bill_date|| ' group by a.sett_date
                  union all
                  /*省平台收入=西宁CL发卡分润*/
                  select ''02'' sett_type,
                         a.sett_date sett_date,
                         ''30138500'' org_code ,
                         ''青海省一卡通公司'' org_name ,
                         nvl(sum(a.other_fee),0) income_charge,
                         0 outcome_charge,
                         ''跨省省和省内结算'' note,
                         nvl(sum(a.other_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.file_type = 3 and
                  a.sett_date = ' || v_bill_date|| ' and a.issue_org_code = ''04558510'' and a.sys_error_code = ''000000''
                  group by a.sett_date
                  union all
                  /*省平台支出=除开西宁CL消费-收单分润-清算中心分润*/
                  select ''02'' sett_type,
                         a.sett_date sett_date,
                         ''30138500'' org_code ,
                         ''青海省一卡通公司'' org_name ,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.service_fee+a.issue_fee),0) outcome_charge,
                         ''跨省省和省内结算'' note,
                         -nvl(sum(a.trade_charge-a.service_fee+a.issue_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.file_type = 3 and
                  a.sett_date = ' || v_bill_date|| ' and a.issue_org_code != ''04558510'' and a.sys_error_code = ''000000''
                  group by a.sett_date
             )
             group by sett_type,sett_date,org_code,org_name,note';
    execute immediate v_sql;

    dbms_output.put_line('v_sql='||v_sql);
    update sett_stat_report a set a.org_name = (select b.org_name from bps_sys_org_info b where  a.org_code  = b.org_code) where a.sett_type = '02';
    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='跨省省内统计完成'
    where sett_type='02' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('跨省省内统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='02' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_DEPARTMENT_PROV_STAT;

  --跨地市西宁和省、其他地市和省一卡通公司结算  （不再使用）
  procedure SETL_PROV_OUTER_STAT(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，跨省省内统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='03' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('跨省省内统计业务统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，跨省省内统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='03' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('跨省省内统计已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='03' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('03', v_bill_date, 2, proc_time, '跨省省内统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('03', v_bill_date, 2, proc_time, '跨省省内统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_stat_report where sett_type=''03'' and sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 跨地市西宁和省、其他地市和省一卡通公司结算
    v_sql := 'insert into sett_stat_report(SETT_TYPE,SETT_DATE,ORG_CODE,ORG_NAME,INCOME_CHARGE,OUTCOME_CHARGE,NOTE,OFFSET_BALANCE)
              select sett_type,
                     sett_date,
                     org_code,
                     org_name,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     note,
                     sum(offset_balance)/100
             from
             (
                 /*西宁支出=dr_bill消费-发卡分润*/
                 select ''03'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.issue_org_code,2,7) org_code ,
                        '''' org_name ,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.issue_fee),0) outcome_charge,
                         ''跨地市省和地市结算'' note,
                         -nvl(sum(a.trade_charge-a.issue_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where
                  a.sett_date = ' || v_bill_date || ' and
                  a.issue_org_code = ''04558510'' and a.sys_error_code = ''000000'' and a.file_type = ''1''
                  group by a.sett_date,a.issue_org_code
                  union all
                  /*西宁收入=dr_bill消费-手续费+收单分润*/
                  select ''03'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.recv_org_id,2,7) org_code ,
                         '''' org_name ,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) income_charge,
                         0 outcome_charge,
                         ''跨地市省和地市结算'' note,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where
                  a.sett_date = ' || v_bill_date || ' and
                  a.recv_org_id = ''14558510'' and a.sys_error_code = ''000000'' and a.file_type = ''1''
                  group by a.sett_date,a.recv_org_id
                  union all
                  /*西宁发卡，各地市收入=FB消费收单分润*/
                  select ''03'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.recv_org_id,2,7) org_code ,
                         '''' org_name ,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) outcome_charge,
                         ''跨地市省和地市结算'' note,
                         -nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.sett_date = ' || v_bill_date || ' and
                  a.issue_org_code = ''04558510'' and a.sys_error_code = ''000000'' and a.file_type = ''1''
                  group by a.sett_date,a.recv_org_id
             )
             group by sett_type,sett_date,org_code,org_name,note';
    execute immediate v_sql;

    dbms_output.put_line('v_sql='||v_sql);

    update sett_stat_report a set a.org_name = (select b.org_name from bps_sys_org_info b where a.org_code = b.org_code) where a.sett_type = '03';


    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='跨省省内统计完成'
    where sett_type='03' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('跨省省内统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='03' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_OUTER_STAT;

  --本地卡本地市消费和省一卡通公司结算 （不再使用）
  procedure SETL_PROV_INNER_STAT(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，本地卡本地市消费和省一卡通公司结算 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='04' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('本地卡本地市消费和省一卡通公司结算正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，本地卡本地市消费和省一卡通公司结算 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='04' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('本地卡本地市消费和省一卡通公司结算已经统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='04' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('04', v_bill_date, 2, proc_time, '本地卡本地市消费和省一卡通公司结算重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('04', v_bill_date, 2, proc_time, '本地卡本地市消费和省一卡通公司结算开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_stat_report where sett_type=''04'' and sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- 本地卡本地市消费和省一卡通公司结算
    v_sql := 'insert into sett_stat_report(SETT_TYPE,SETT_DATE,ORG_CODE,ORG_NAME,INCOME_CHARGE,OUTCOME_CHARGE,NOTE,OFFSET_BALANCE)
              select ''04'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.recv_org_id,2,7) org_code ,
                         '''' org_name ,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0)/100 income_charge,
                         0 outcome_charge,
                         ''本省省和地市结算'' note,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0)/100 offset_balance
                  from dr_bill_detail_'||v_month||' a
                  where a.sett_date = '||v_bill_date||' and
                        a.file_type = ''1'' and
                        a.issue_org_code != ''04558510'' and
                        a.recv_org_id != ''14558510'' and
                        a.sys_error_code = ''000000''
                  group by a.sett_date,a.recv_org_id';
    execute immediate v_sql;

    dbms_output.put_line('v_sql='||v_sql);
    update sett_stat_report a set a.org_name = (select b.org_name from bps_sys_org_info b where a.org_code = b.org_code) where a.sett_type = '04';

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='本地卡本地市消费和省一卡通公司结算完成'
    where sett_type='04' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('本地卡本地市消费和省一卡通公司结算完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='04' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_INNER_STAT;


 --统计详单
 /*
  procedure SETL_DETAIL_STAT(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，详单统计是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='05' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('详单统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，详单统计是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='05' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('详单统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='05' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('05', v_bill_date, 2, proc_time, '详单统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('05', v_bill_date, 2, proc_time, '详单统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_stat_detail where sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---
    v_sql := 'insert into sett_stat_detail
              -----跨省FB
              (select ''01'',
                      a.center_sett_date,
                      a.issue_company_code,
                      '''',
                      a.bill_org_id,
                      '''',
                      sum(a.trade_charge),
                      sum(a.sett_charge),
                      sum(a.issue_charge),
                      sum(a.bill_charge),
                      sum(a.sett_charge-a.issue_charge-a.bill_charge)
               from sett_fb_'|| v_month ||' a
               where  a.err_code = ''000000''  and
               a.center_sett_date = ' || v_bill_date || '
               group by a.center_sett_date,a.issue_company_code,a.bill_org_id
               union all
               -----跨省CL
               select ''01'',
                      a.center_sett_date,
                      a.issue_company_code,
                      '''',
                      a.bill_org_id,
                      '''',
                      sum(a.trade_charge),
                      sum(a.sett_charge),
                      sum(a.issue_charge),
                      sum(a.bill_charge),
                      sum(a.sett_charge-a.issue_charge-a.bill_charge)
               from sett_cl_'|| v_month ||' a
               where a.err_code = ''000000''  and
               a.center_sett_date = ' || v_bill_date || '
               group by a.sett_date,a.issue_company_code,a.bill_org_id
               -----省内（包含跨省、跨地市、本地市）
               union all
               select ''02'',
                      a.sett_date,
                      a.issue_org_code,
                      '''',
                      a.recv_org_id,
                      '''',
                      sum(a.trade_charge),
                      sum(a.service_fee),
                      sum(a.issue_fee),
                      sum(a.bill_fee),
                      sum(a.service_fee-a.issue_fee-a.bill_fee)
               from dr_bill_detail_'|| v_month ||' a
               where a.sett_date = ' || v_bill_date || ' and
               a.sys_error_code = ''000000''
               group by a.sett_date,a.issue_org_code,a.recv_org_id)';

    v_sql := 'insert into sett_stat_detail
              (SETT_TYPE,SETT_DATE,ISSUE_CODE,ISSUE_ORG_NAME,BILL_CODE,BILL_ORG_NAME,TRADE_CHARGE,SETT_CHARGE,ISSUE_CHARGE,
               BILL_CHARGE,CENTER_CHARGE,SERVICE_FEE,SETT_ORG_CODE,sett_direction,role_type)
               select ''02'',
                      a.sett_date,
                      a.issue_org_code,
                      '''',
                      a.recv_org_id,
                      '''',
                      sum(a.trade_charge),
                      sum(a.service_fee),
                      sum(a.issue_fee),
                      sum(a.bill_fee),
                      sum(a.service_fee-a.issue_fee-a.bill_fee)
               from dr_bill_detail_'|| v_month ||' a
               where a.sett_date = ' || v_bill_date || ' and
               a.sys_error_code = ''000000''
               group by a.sett_date,a.issue_org_code,a.recv_org_id)';
    execute immediate v_sql;

    ---update sett_stat_detail a set a.issue_org_name =

    dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='详单统计完成'
    where sett_type='05' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('详单统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='05' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_DETAIL_STAT;
 */

 /*统计所有省内详单 （不再使用）*/
  procedure SETL_CITY_DETAIL_STAT(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(6000);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，省内详单统计是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省内详单统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，省内详单统计是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省内详单统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DETAIL', v_bill_date, 2, proc_time, '省内详单统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DETAIL', v_bill_date, 2, proc_time, '省内详单统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_city_stat_detail where sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---

    v_sql := 'insert into sett_city_stat_detail
              (SETT_DATE,
               SETT_ORG_CODE  ,
               SETT_DIRECTION,
               ROLE_TYPE,
               ISSUE_CODE,
               ISSUE_ORG_NAME,
               ACTUAL_ISSUE_CODE,
               ACTUAL_ISSUE_NAME,
               BILL_CODE,
               BILL_ORG_NAME  ,
               TRADE_CHARGE ,
               SETT_CHARGE,
               ISSUE_CHARGE ,
               BILL_CHARGE,
               CENTER_CHARGE  ,
               SERVICE_FEE,
               TIMES)
               --FB省内收单，各收单机构收入
              select a.sett_date,
                     substr(a.recv_org_id,2,7),
                     ''2'',
                     ''2'',
                     substr(a.issue_org_code,2,7),
                     '''',
                     decode(a.actual_issue_org_code, ''30138500'',a.actual_issue_org_code, substr(a.actual_issue_org_code,2,7) ),
                     '''',
                     substr(a.recv_org_id,2,7),
                     '''',
                     sum(a.trade_charge)/100,
                     sum(a.trade_charge-a.service_fee)/100,
                     sum(a.issue_fee)/100,
                     sum(a.bill_fee)/100,
                     sum(a.service_fee-a.issue_fee-a.bill_fee)/100,
                     sum(a.service_fee)/100,
                     count(*)
                     from dr_bill_detail_'|| v_month ||' a
               where a.sett_date = ' || v_bill_date || ' and a.file_type = ''2'' and
                     a.sys_error_code = ''000000''
               group by a.sett_date,substr(a.recv_org_id,2,7),substr(a.issue_org_code,2,7),substr(a.recv_org_id,2,7),decode(a.actual_issue_org_code, ''30138500'',a.actual_issue_org_code, substr(a.actual_issue_org_code,2,7) )
               union all
               --CL各发卡机构支出
               select a.sett_date,
                      decode(a.actual_issue_org_code, ''30138500'',a.actual_issue_org_code, substr(a.actual_issue_org_code,2,7) ),
                      ''1'',
                      ''1'',
                       substr(a.issue_org_code,2,7),
                       '''',
                       decode(a.actual_issue_org_code, ''30138500'',a.actual_issue_org_code, substr(a.actual_issue_org_code,2,7) ),
                       '''',
                       substr(a.recv_org_id,2,7),
                       '''',
                       sum(a.trade_charge)/100,
                       sum(a.trade_charge-a.service_fee+a.issue_fee)/100,
                       sum(a.issue_fee)/100,
                       sum(a.bill_fee)/100,
                       sum(a.service_fee-a.issue_fee-a.bill_fee)/100,
                       sum(a.service_fee)/100,
                       count(*)
               from dr_bill_detail_'|| v_month ||' a
               where a.sett_date = ' || v_bill_date || ' and a.file_type = ''3'' and a.sys_error_code = ''000000''
               group by a.sett_date,decode(a.actual_issue_org_code, ''30138500'',a.actual_issue_org_code, substr(a.actual_issue_org_code,2,7) ),substr(a.issue_org_code,2,7),substr(a.recv_org_id,2,7)
               union all
               --省内发卡西宁 西宁支出
               select a.sett_date,
                      substr(a.issue_org_code,2,7),
                      ''1'',
                      ''1'',
                      substr(a.issue_org_code,2,7),
                      '''',
                      decode(a.actual_issue_org_code, ''30138500'',a.actual_issue_org_code, substr(a.actual_issue_org_code,2,7) ),
                      '''',
                      substr(a.recv_org_id,2,7),
                      '''',
                      sum(a.trade_charge),
                      sum(a.service_fee),
                      sum(a.issue_fee),
                      sum(a.bill_fee),
                      sum(a.service_fee-a.issue_fee-a.bill_fee),
                      sum(a.trade_charge-a.service_fee+a.issue_fee),
                      count(*)
               from dr_bill_detail_'|| v_month ||' a
               where a.sett_date = ' || v_bill_date || ' and a.file_type = ''1'' and a.issue_org_code = ''04558510'' and a.sys_error_code = ''000000''
               group by a.sett_date,substr(a.issue_org_code,2,7),substr(a.recv_org_id,2,7),substr(a.issue_org_code,2,7),decode(a.actual_issue_org_code, ''30138500'',a.actual_issue_org_code, substr(a.actual_issue_org_code,2,7) )
               --省内发卡非西宁，各收单机构收入
               union all
               select a.sett_date,
                      substr(a.recv_org_id,2,7),
                      ''2'',
                      ''2'',
                      substr(a.issue_org_code,2,7),
                      '''',
                      decode(a.actual_issue_org_code, ''30138500'',a.actual_issue_org_code, substr(a.actual_issue_org_code,2,7) ),
                       '''',
                      substr(a.recv_org_id,2,7),
                      '''',
                      sum(a.trade_charge)/100,
                      sum(a.trade_charge-a.service_fee+a.bill_fee)/100,
                      sum(a.issue_fee)/100,
                      sum(a.bill_fee)/100,
                      sum(a.service_fee-a.issue_fee-a.bill_fee)/100,
                      sum(a.service_fee)/100,
                      count(*)
               from dr_bill_detail_'|| v_month ||' a
               where a.sett_date = ' || v_bill_date || ' and a.file_type = ''1'' and a.issue_org_code != ''04558510'' and a.sys_error_code = ''000000''
               group by a.sett_date,substr(a.issue_org_code,2,7),substr(a.recv_org_id,2,7),substr(a.recv_org_id,2,7),decode(a.actual_issue_org_code, ''30138500'',a.actual_issue_org_code, substr(a.actual_issue_org_code,2,7) )
              ';
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    update sett_city_stat_detail a set a.issue_org_name = (select b.org_name from bps_sys_org_info b where a.issue_code = b.org_code) where a.sett_date = v_bill_date;
    update sett_city_stat_detail a set a.actual_issue_name = (select b.org_name from bps_sys_org_info b where a.actual_issue_code = b.org_code) where a.sett_date = v_bill_date;
    update sett_city_stat_detail a set a.bill_org_name = (select b.org_name from bps_sys_org_info b where a.bill_code = b.org_code) where a.sett_date = v_bill_date;
    update sett_city_stat_detail a set a.issue_org_name = a.issue_code where a.issue_org_name is null;
    update sett_city_stat_detail a set a.actual_issue_name = a.actual_issue_code where a.actual_issue_name is null;
    update sett_city_stat_detail a set a.bill_org_name = a.bill_code where a.bill_org_name is null;

    --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='省内详单统计完成'
    where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('省内详单统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_CITY_DETAIL_STAT;

  --跨省详单 （不再使用）
  procedure SETL_PROV_DETAIL_STAT(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(4096);
    proc_time date;
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，跨省详单统计是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('跨省详单统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，跨省详单统计是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('跨省详单统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_date, 2, proc_time, '跨省详单统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_date, 2, proc_time, '跨省详单统计开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    -----
    v_sql:='delete from sett_prov_stat_detail where sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---

    v_sql := 'insert into sett_prov_stat_detail
              (SETT_DATE,
               SETT_ORG_CODE  ,
               SETT_DIRECTION,
               ROLE_TYPE,
               ISSUE_CODE,
               ISSUE_ORG_NAME,
               BILL_CODE,
               BILL_ORG_NAME  ,
               TRADE_CHARGE ,
               SETT_CHARGE,
               ISSUE_CHARGE ,
               BILL_CHARGE,
               CENTER_CHARGE  ,
               SERVICE_FEE,
               TIMES)
               --FB
               select a.sett_date,
                      ''00000000'', -- substr(a.bill_org_id,2,7), --- 收单机构代码
                      ''1'',
                      ''2'',
                      substr(a.issue_company_code,2,7),
                      '''',
                      substr(a.bill_org_id,2,7),
                      '''',
                      sum(a.trade_charge)/100,
                      sum(a.trade_charge-a.sett_charge+a.bill_charge)/100,
                      sum(a.issue_charge)/100,
                      sum(a.bill_charge)/100,
                      sum(a.sett_charge-a.issue_charge-a.bill_charge)/100,
                      sum(a.sett_charge)/100,
                      count(*)
               from sett_fb_'|| v_month ||' a
               where a.sett_date = '|| v_bill_date ||' and
                     a.err_code = ''000000''
               group by a.sett_date,substr(a.bill_org_id,2,7),substr(a.issue_company_code,2,7)
               union all
               --CL
               select a.sett_date,
                      ''00000000'', -- substr(a.bill_org_id,2,7)
                      ''2'',
                      ''1'',
                      substr(a.issue_company_code,2,7),
                      '''',
                      substr(a.bill_org_id,2,7),
                      '''',
                      sum(a.trade_charge)/100,
                      sum(a.trade_charge-a.sett_charge+a.issue_charge)/100,
                      sum(a.issue_charge)/100,
                      sum(a.bill_charge)/100,
                      sum(a.sett_charge-a.issue_charge-a.bill_charge)/100,
                      sum(a.sett_charge)/100,
                      count(*)
               from sett_cl_'|| v_month ||' a
               where a.sett_date = '|| v_bill_date ||' and
                     a.err_code = ''000000''
               group by a.sett_date,substr(a.bill_org_id,2,7),substr(a.issue_company_code,2,7)';
    execute immediate v_sql;

    update sett_prov_stat_detail a set a.issue_org_name = (select b.org_name from bps_sys_org_info b where a.issue_code = b.org_code) where a.sett_date = v_bill_date;
    update sett_prov_stat_detail a set a.bill_org_name = (select b.org_name from bps_sys_org_info b where a.bill_code = b.org_code) where a.sett_date = v_bill_date;
    update sett_prov_stat_detail a set a.issue_org_name = issue_code where issue_org_name is null;
    update sett_prov_stat_detail a set a.bill_org_name = bill_code where bill_org_name is null;

    dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='跨省详单统计完成'
    where sett_type='PROV_DETAIL' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('跨省详单统计完成');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_DETAIL' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_DETAIL_STAT;

  procedure gen_city_ld_file(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    v_org_sql varchar2(1024);
    v_seqence number(12);
    proc_time date;
    --type BPS_MODULE_LOG is table of bps_module_log_yyyymm%rowtype;
    --v_log BPS_MODULE_LOG;
    TYPE cursor IS REF CURSOR;
    cur_module_log cursor;
    cur_org_list   cursor;

    v_module_id number(10);
    v_filename  varchar2(256);
    v_org_code  varchar2(16);
    v_sett_date varchar2(15);
    v_record    varchar2(1024);
    v_index     number(10);
    v_ld_filename varchar2(64);
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ld' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计LD文件数据正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ld' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计LD文件数据完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='gen_ld' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ld', v_bill_date, 2, proc_time, '地市统计LD文件数据处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ld', v_bill_date, 2, proc_time, '地市统计LD文件数据开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    delete from SETT_STAT_DAILY_LD where sett_date=v_bill_date;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---- 2. 获取文件序列号
    select CITY_LD_FILE_SEQ.Nextval into v_seqence from dual;

    ---- 3. 生成文件记录体数据

    v_org_sql:= 'select org_code from bps_sys_org_info where area_type in (''02'',''03'')';
    open cur_org_list for
             v_org_sql;
    loop
    FETCH cur_org_list
    INTO  v_org_code ;
    EXIT WHEN cur_org_list%NOTFOUND;
           v_sql := 'select distinct
                         module_id,
                         sett_date,
                         reserve1 file_name
                      from bps_module_log_'|| v_month || ' a
                      where module_id in (''111003'', ''210003'', ''210005'')
                            and sett_date=''' ||v_bill_date|| '''
                            and substr(reserve1,16,7)='''|| v_org_code || '''';
            ---- 如果查询账期是当月最后一天， 需要查询下个月的日志表（待补充这部分逻辑）
              v_index := 0;
              open cur_module_log for
                   v_sql;
              LOOP
                   FETCH cur_module_log
                   INTO v_module_id,
                        v_sett_date,
                        v_filename;
                   EXIT WHEN cur_module_log%NOTFOUND;

                   v_index := v_index + 1;
                   v_record := lpad(v_seqence,8,'0') || lpad(v_index,4,'0') ||
                               rpad(v_filename,50,' ')                      ||
                               '000000'                                     ||
                               rpad('SUCCESS',40,' ')                      ||
                               rpad('F',40,'F')                             ||
                               chr(13) ||chr(10);

                   insert into SETT_STAT_DAILY_LD
                   (record_type, record_context, module_id, sett_date,file_name,org_code, process_time)
                   values
                   ('2', v_record,v_module_id, v_sett_date, v_filename, v_org_code, sysdate);
              end loop;
              close cur_module_log;

              ---- 5. 生成文件名substr(v_bill_date,1,6)
              v_ld_filename := 'LD' || substr(v_bill_date, 3,6) || '000000'
                               || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'A';
              insert into SETT_STAT_DAILY_LD
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('0', v_ld_filename, v_bill_date, sysdate, v_org_code);

              ---- 文件头


              v_record := '01'||chr(13)||chr(10);
              insert into SETT_STAT_DAILY_LD
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('1', v_record, v_bill_date, sysdate, v_org_code);

              v_record :=
                          lpad(v_index,6,'0')||
                          v_bill_date||
                          rpad('1'||v_org_code,11,' ')||
                          '0150FFFFFFFFFFFFFFFFFFFF'||chr(13) || chr(10);
              insert into SETT_STAT_DAILY_LD
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('1', v_record, v_bill_date, sysdate, v_org_code);
    end loop;
    close cur_org_list ;


    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='地市统计LD文件数据统计完成'
    where sett_type='gen_ld' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('地市统计LD文件数据统计完成');

  EXCEPTION when others then
    rollback;
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='gen_ld' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
  end gen_city_ld_file;

  procedure gen_city_bp_file(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    v_org_sql varchar2(1024);
    v_seqence number(12);
    proc_time date;
    --type BPS_MODULE_LOG is table of bps_module_log_yyyymm%rowtype;
    --v_log BPS_MODULE_LOG;
    TYPE cursor IS REF CURSOR;
    cur_module_log cursor;
    cur_org_list   cursor;

    v_income_charge number(21,7);
    v_outcome_charge  number(21,7);
    v_balance_charge    number(21,7);
    v_org_code  varchar2(16);
    v_sett_date varchar2(15);
    v_record    varchar2(1024);
    v_index     number(10);
    v_bp_filename varchar2(64);
    v_flag      varchar2(1);
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_bp' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计BP文件数据正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_bp' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计BP文件数据完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='gen_bp' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_bp', v_bill_date, 2, proc_time, '地市统计BP文件数据处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_bp', v_bill_date, 2, proc_time, '地市统计BP文件数据开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    delete from SETT_STAT_DAILY_BP where sett_date=v_bill_date;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---- 2. 获取文件序列号
    select CITY_BP_FILE_SEQ.Nextval into v_seqence from dual;

    ---- 3. 生成文件记录体数据

    v_org_sql:= 'select org_code from bps_sys_org_info where area_type in (''02'',''03'')';
    open cur_org_list for
             v_org_sql;
    loop
    FETCH cur_org_list
    INTO  v_org_code ;
    EXIT WHEN cur_org_list%NOTFOUND;
           v_sql := 'select sett_date,
                            org_code,
                            sum(income_charge),
                            sum(outcome_charge),
                            abs(sum(income_charge-outcome_charge))
                     from (
                          select  a.sett_date  sett_date,
                                  substr(a.issue_org_code,2,7) org_code,
                                  0 income_charge,
                                  sum(a.trade_charge-a.issue_fee) outcome_charge
                          from dr_bill_detail_'|| v_month || ' a
                          where a.sett_date = '''|| v_bill_date || ''' and
                                substr(a.issue_org_code,2,7) = '''|| v_org_code || ''' and
                                a.sys_error_code = ''000000''
                          group by a.sett_date,a.issue_org_code
                          union all
                          select a.sett_date sett_date,
                                 substr(a.recv_org_id,2,7) org_code,
                                 sum(a.trade_charge-a.service_fee+a.bill_fee) income_charge,
                                 0 outcome_charge
                          from dr_bill_detail_'|| v_month || ' a
                          where a.sett_date = '''|| v_bill_date || ''' and
                                substr(a.recv_org_id,2,7) = '''|| v_org_code || ''' and
                                a.sys_error_code = ''000000''
                          group by a.sett_date,a.recv_org_id)
                      group by sett_date,org_code';
              v_index := 0;
              open cur_module_log for
                   v_sql;
              LOOP
                   FETCH cur_module_log
                   INTO v_sett_date,
                        v_org_code,
                        v_income_charge,
                        v_outcome_charge,
                        v_balance_charge;
                   EXIT WHEN cur_module_log%NOTFOUND;

                   v_index := v_index + 1;
                   -----金额符号位没做判断
                   if((v_income_charge-v_outcome_charge)>=0 ) then
                     v_flag :=0;
                   else
                     v_flag:=1;
                     end if;
                   v_record := lpad(round(v_income_charge),18,'0') || lpad(round(v_outcome_charge),18,'0') ||
                               '000000000000000000000000000000000000'       ||
                               lpad(round(v_balance_charge),18,'0') ||
                               '0000' ||
                               v_flag ||
                               'FFFFF'||
                               rpad('F',80,'F')||
                               chr(13) ||chr(10);

                   insert into SETT_STAT_DAILY_BP
                   (record_type,record_context,sett_date,org_code,INCOME_CHARGE,OUTCOME_CHARGE,process_time)
                   values
                   ('2', v_record,v_sett_date, v_org_code, v_income_charge, v_outcome_charge, sysdate);
              end loop;
              close cur_module_log;

              if(v_index=0) then
              insert into SETT_STAT_DAILY_BP
              (record_type,record_context,sett_date,org_code,INCOME_CHARGE,OUTCOME_CHARGE,process_time)
              values
              ('2', '00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF', v_bill_date, v_org_code,null,null,sysdate);
              v_index:=1;
              end if;


              ---- 5. 生成文件名 substr(to_char(sysdate,'yyyymmddhh24miss'), 3,12)
              v_bp_filename := 'BP' || substr(v_bill_date, 3,6) || '000000'
                               || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'A';
              insert into SETT_STAT_DAILY_BP
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('0', v_bp_filename, v_bill_date, sysdate, v_org_code);

              ---- 文件头


              v_record := '01'||chr(13)||chr(10);
              insert into SETT_STAT_DAILY_BP
              (record_type,record_context,sett_date,org_code,INCOME_CHARGE,OUTCOME_CHARGE,process_time)
              values
              ('1', v_record, v_bill_date, v_org_code,null,null,sysdate);


              v_record :=
                          lpad(v_index,6,'0')||
                          v_bill_date||
                          rpad('1'||v_org_code,11,' ')||
                          '0180FFFFFFFFFFFFFFFFFFFF'||chr(13) || chr(10);
              insert into SETT_STAT_DAILY_BP
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('1', v_record, v_bill_date, sysdate, v_org_code);
    end loop;
    close cur_org_list ;


    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='地市统计BP文件数据统计完成'
    where sett_type='gen_bp' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('地市统计BP文件数据统计完成');

  EXCEPTION when others then
    rollback;
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='gen_bp' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
  end gen_city_bp_file;

  procedure gen_city_cr_file(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(3096);
    v_org_sql varchar2(1024);
    v_seqence number(12);
    proc_time date;
    --type BPS_MODULE_LOG is table of bps_module_log_yyyymm%rowtype;
    --v_log BPS_MODULE_LOG;
    TYPE cursor IS REF CURSOR;
    cur_module_log cursor;
    cur_org_list   cursor;

    v_module_id number(10);
    v_filename  varchar2(256);
    v_org_code  varchar2(16);
    v_sett_date varchar2(15);
    v_record    varchar2(1024);
    v_rowcount  number(10);
    v_CR_filename varchar2(64);
  begin
    --dbms_output.put_line(v_bill_date);

    v_month:=substr(v_bill_date,1,6);
    --dbms_output.put_line('v_month='||v_month);

    --- 检查当前账期，部跨省统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_cr' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计CR文件数据正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，部跨省统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_cr' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计CR文件数据完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='gen_cr' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_cr', v_bill_date, 2, proc_time, '地市统计CR文件数据处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_cr', v_bill_date, 2, proc_time, '地市统计CR文件数据开始处理....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.清理上次的中间表数据
    delete from SETT_STAT_DAILY_CR where sett_date=v_bill_date;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---- 2. 获取文件序列号
    select CITY_CR_FILE_SEQ.Nextval into v_seqence from dual;

    ---- 3. 生成文件记录体数据

    v_org_sql:= 'select org_code from bps_sys_org_info where area_type in (''02'',''03'')';
    open cur_org_list for
             v_org_sql;
    loop
    FETCH cur_org_list
    INTO  v_org_code ;
    EXIT WHEN cur_org_list%NOTFOUND;
            v_sql := '
              insert into SETT_STAT_DAILY_CR
          (record_type, record_context, sett_date, org_code,
           recv_org_id, bill_org_code, issue_org_code, send_org_id, busi_type, adjust_flag, sys_error_code, sys_error_msg, total_count,
           total_trade_charge, recv_org_fee, err_fee, issue_org_fee, prov_org_fee, test_flag, process_time)
           select ''2'' record_type,
                  '''' record_context,
                  ''' || v_bill_date || ''' sett_date,
                  ''' || v_org_code  || ''' org_code,
                  b.recv_org_id,
                  b.bill_org_code,
                  issue_org_code,
                  send_org_id, busi_type,adjust_flag,sys_error_code,sys_error_msg,total_count,total_trade_charge,recv_org_fee,
                  err_fee,issue_org_fee,prov_org_fee,test_flag, sysdate
           from (
          select a.recv_org_id     ,-- "收单机构标识"     交易的发生地
                 a.bill_org_code   ,-- "接收清算机构标识" 发卡地的顶级单位
                 a.issue_org_code  ,-- "发卡机构代码"     发卡地
                 a.recv_org_id     send_org_id,-- "发送机构标识码"   交易发生地的顶级单位
                 decode(a.trade_code,''362'',''8451'', ''300'', ''8451'', ''368'', ''8460'', ''370'', ''8460'', ''401'', ''8401'') busi_type, --"业务类型"
                 0 adjust_flag     ,-- "差错调整标识"
                 ''000000'' sys_error_code  ,
                 ''SUCESS'' sys_error_msg   ,
                 count(*) total_count,
                 sum(a.trade_charge) total_trade_charge,
                 sum(a.bill_fee) recv_org_fee, --- 交易地手续费
                 0 err_fee, --- 差错手续费
                 sum(a.issue_fee) issue_org_fee, -- 卡属地手续费
                 sum(a.service_fee-a.bill_fee-a.issue_fee) prov_org_fee, -- 清分结算机构手续费
                 0 test_flag  -- 测试标志
          from dr_bill_detail_' || v_month || ' a where a.issue_org_code=''0' || v_org_code ||''' or a.recv_org_id=''1' || v_org_code ||'''
          group by recv_org_id, bill_org_code,issue_org_code,recv_org_id,
                   decode(a.trade_code,''362'',''8451'', ''300'', ''8451'', ''368'', ''8460'', ''370'', ''8460'', ''401'', ''8401''),
                   sys_error_code, sys_error_msg
                   ) b
            ';
            execute immediate v_sql;

            ---- 1. 生成记录体数据
            update SETT_STAT_DAILY_CR a
            set record_context =  rpad(a.recv_org_id,11,' ')    ||
                        rpad(nvl(a.bill_org_code,' '),11,' ') ||
                        rpad(a.issue_org_code,11,' ') ||
                        rpad(a.send_org_id,11,' ')    ||
                        rpad(a.busi_type,4,' ')     ||
                        adjust_flag           ||
                        lpad(a.sys_error_code,6,'0')  ||
                        rpad(a.sys_error_msg,40,' ')  ||
                        lpad(a.total_count,18,'0')    ||
                        lpad(round(a.total_trade_charge),18,'0')  ||
                        lpad(round(a.recv_org_fee),18,'0')        ||
                        lpad(round(a.err_fee),18,'0')             ||
                        lpad(round(a.issue_org_fee),18,'0')       ||
                        lpad(round(a.prov_org_fee),18,'0')        ||
                        test_flag                                 ||
                        '00000FFFFF'                              ||
                        chr(13) || chr(10)
            where a.sett_date = v_bill_date and a.org_code = v_org_code and a.record_type = '2';
            v_rowcount := sql%rowcount; -- 获得数据记录条数


            ---- 2. 生成头记录
            v_record := '02'||chr(13)||chr(10);
            insert into SETT_STAT_DAILY_CR
            ( record_type, record_context, sett_date, process_time, org_code )
            values
            ('1', v_record, v_bill_date, sysdate, v_org_code);

              v_record :=
                          lpad(v_rowcount,6,'0')||
                          v_bill_date||
                          rpad('1'||v_org_code,11,' ')||
                          '0216FFFFFFFFFFFFFFFFFFFF'||chr(13) || chr(10);
              insert into SETT_STAT_DAILY_CR
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('1', v_record, v_bill_date, sysdate, v_org_code);



              ---- 3. 生成文件名substr(to_char(sysdate,'yyyymmddhh24miss'), 3,12)
              v_CR_filename := 'CR' || substr(v_bill_date, 3,6) || '000000'
                               || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'A';
              insert into SETT_STAT_DAILY_CR
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('0', v_CR_filename, v_bill_date, sysdate, v_org_code);



    end loop;
    close cur_org_list ;


    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='地市统计CR文件数据统计完成'
    where sett_type='gen_cr' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('地市统计CR文件数据统计完成');

  EXCEPTION when others then
    rollback;
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='gen_cr' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
  end gen_city_cr_file;

 procedure GEN_CITY_AD_DETAIL(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(6000);
    proc_time date;

    v_seqence number(12);
    v_sett_adjust_org_no  varchar2(15);
    v_ori_bill_org_no  varchar2(15);
    v_issue_org_code varchar2(15);
    v_bill_org_code varchar2(15);
    v_adjusted_trade_charge number;
    v_error_code  varchar2(8);
    v_error_info  varchar2(42);
    v_err_charge number;
    v_sett_charge number;
    v_issue_charge number;
    v_bill_charge number;

    v_charge_base number;
    v_recv_base number;
    v_issue_base number;

    v_charge_rate number;
    v_recv_rate number;
    v_issue_rate number;

    cursor ad_cursor is
    select sett_adjust_org_no,ori_bill_org_no,adjusted_trade_charge,issue_org_code,bill_org_code,error_code,error_info,err_charge,sett_charge,issue_charge,bill_charge
    from SETT_CITY_AD_DETAIL where ori_sett_date = '|| v_bill_date || ' for update;

  begin
    v_month:=substr(v_bill_date,1,6);

    --- 检查当前账期，省内详单统计是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_AD_DETAIL' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省内AD详单统计正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，省内详单统计是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_AD_DETAIL' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('省内AD详单统计完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='CITY_AD_DETAIL' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_AD_DETAIL', v_bill_date, 2, proc_time, '省内AD详单统计重处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_AD_DETAIL', v_bill_date, 2, proc_time, '省内AD详单统计开始处理....');
        commit;
    end if;

    ---- 1.清理上次的中间表数据
    v_sql:='delete from sett_city_ad_detail where sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;

   ---- 2.生成数据表
    v_sql := 'insert into SETT_CITY_AD_DETAIL
   (sett_date,ori_sett_date,ori_sett_org_no,ori_bill_org_no,ori_bill_deal_date,ori_retriev_no,ori_trade_type,adjust_type,card_no,issue_org_code,
   recv_org_code,bill_org_code,send_org_code,ed_make_code,ed_confirm_code,card_count,beforetrade_charge,adjusted_trade_type,adjusted_trade_charge,
   mcc,channel_type,trade_date,trade_time,test_flag,reason_code,response_code,err_type)
   select substr( a.deal_time,1,8), a.sett_date, a.sett_org_no,b.bill_org_no,b.bill_org_deal_date,a.trade_retriev_no,c.trade_type,
   a.adjust_type,a.card_no,a.issue_org_code,c.recv_org_id,a.recv_org_code,c.send_org_id,a.ori_org_code,a.confirm_org_code,
   a.card_count,a.beforetrade_charge,a.adjusted_trade_type,a.adjusted_trade_charge,a.mcc,a.channel_type,a.trade_date,
   a.trade_time,a.test_flag,b.cause_code,a.response_code,b.err_type
   from sett_cm_' || v_month || ' a
   left join sett_ed_' || v_month || ' b
   on a.sett_org_no = b.sett_org_no
   left join sett_fb_' || v_month || ' c
   on a.sett_org_no = c.sett_org_no
   where substr( a.deal_time,1,8) = '''|| v_bill_date ||'''
   and substr(a.ori_org_code,2,length(a.ori_org_code)-1) in(select org_code from bps_sys_org_info where area_type in (''02'',''03''))
   and substr(a.confirm_org_code,2,length(a.confirm_org_code)-1) in(select org_code from bps_sys_org_info where area_type in (''02'',''03''))
   ';
   execute immediate v_sql;

   ---- 2.生成流水号，计算费用
   select charge_rate,recv_rate,issue_rate
   into v_charge_base,v_recv_base,v_issue_base
   from bps_sys_sett_rate
   where business_type =1 and service_type =3
   and recv_org_code =-1 and issue_org_code =-1
   and to_date(v_bill_date,'yyyymmdd') between  eff_date and exp_date;

   open ad_cursor;
   loop
   FETCH ad_cursor
   INTO v_sett_adjust_org_no, v_ori_bill_org_no, v_issue_org_code,v_bill_org_code,v_adjusted_trade_charge, v_error_code,
   v_error_info,v_err_charge, v_sett_charge,v_issue_charge,v_bill_charge;
   EXIT WHEN ad_cursor%NOTFOUND;

   if v_ori_bill_org_no is null then
     update SETT_CITY_AD_DETAIL set error_code='20008', error_info ='与原交易信息不相符', err_charge =0,
     sett_charge =0, issue_charge =0, bill_charge =0
     where current of ad_cursor;
   else
     begin
       select charge_rate,recv_rate,issue_rate
       into v_charge_rate,v_recv_rate,v_issue_rate
       from bps_sys_sett_rate
       where business_type =1 and service_type =3
       and recv_org_code =v_bill_org_code and issue_org_code = v_issue_org_code
       and to_date(v_bill_date,'yyyymmdd') between  eff_date and exp_date;
       exception
       when no_data_found then
         v_charge_rate := v_charge_base;
         v_recv_rate := v_recv_base;
         v_issue_rate := v_issue_base;
     end ;
     v_issue_charge := v_adjusted_trade_charge*v_charge_rate*v_issue_rate;
     v_bill_charge := v_adjusted_trade_charge*v_charge_rate*v_recv_rate;
     v_sett_charge := v_adjusted_trade_charge*v_charge_rate*(1-v_issue_rate-v_recv_rate);

     select CITY_AD_SEQ.Nextval into v_seqence from dual;
     update SETT_CITY_AD_DETAIL
     set sett_adjust_org_no= v_seqence,error_code='0', error_info ='成功交易', err_charge = v_adjusted_trade_charge*0.01,
     sett_charge =  v_sett_charge,  issue_charge =  v_issue_charge, bill_charge =  v_bill_charge
     where current of ad_cursor;
   end if;

   end loop;
   close ad_cursor;--关闭游标

  EXCEPTION when others then
    rollback;
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='CITY_AD_DETAIL' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
  end GEN_CITY_AD_DETAIL;

  procedure gen_city_ad_file(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_sql     varchar2(2048);
    v_org_sql varchar2(1024);
    v_seqence number(12);
    proc_time date;
    TYPE cursor IS REF CURSOR;
    cur_org_list   cursor;

    v_org_code  varchar2(16);
    v_record    varchar2(1024);
    v_rowcount  number(10);
    v_AD_filename varchar2(64);
  begin

    --- 检查当前账期，AD统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ad' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计AD文件数据正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，AD统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ad' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计AD文件数据完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='gen_ad' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ad', v_bill_date, 2, proc_time, '地市统计AD文件数据处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ad', v_bill_date, 2, proc_time, '地市统计AD文件数据开始处理....');
        commit;
    end if;

    ---- 1.清理上次的中间表数据
    delete from SETT_STAT_DAILY_AD where sett_date=v_bill_date;
    commit;

    ---- 2. 获取文件序列号
    select CITY_AD_FILE_SEQ.Nextval into v_seqence from dual;

    v_org_sql:= 'select org_code from bps_sys_org_info where area_type in (''02'',''03'')';
    open cur_org_list for
             v_org_sql;
    loop
    FETCH cur_org_list
    INTO  v_org_code ;
    EXIT WHEN cur_org_list%NOTFOUND;

    v_sql := '
          insert into SETT_STAT_DAILY_AD
          (record_type, record_context, sett_date, org_code,
          sett_adjust_org_no,ori_sett_date,ori_sett_org_no,ori_bill_org_no,ori_bill_deal_date,ori_retriev_no,
          ori_trade_type,adjust_type,card_no,issue_org_code,recv_org_code,bill_org_code,send_org_code,ed_make_code,
          ed_confirm_code,card_count,beforetrade_charge,adjusted_trade_type,adjusted_trade_charge,mcc,channel_type,
          trade_date,trade_time,test_flag,reason_code,response_code,error_code,error_info,err_charge,sett_charge,
          issue_charge,bill_charge,process_time,err_type)
          select ''2'' record_type,
                  '''' record_context,
                  ''' || v_bill_date || ''' sett_date,
                  ''' || v_org_code  || ''' org_code,
                  sett_adjust_org_no,ori_sett_date,ori_sett_org_no,ori_bill_org_no,ori_bill_deal_date,ori_retriev_no,
                  ori_trade_type,adjust_type,card_no,issue_org_code,recv_org_code,bill_org_code,send_org_code,ed_make_code,
                  ed_confirm_code,card_count,beforetrade_charge,adjusted_trade_type,adjusted_trade_charge,mcc,channel_type,
                  trade_date,trade_time,test_flag,reason_code,response_code,error_code,error_info,err_charge,sett_charge,
                  issue_charge,bill_charge,process_time,err_type
          from(
          select sett_adjust_org_no,ori_sett_date,ori_sett_org_no,ori_bill_org_no,ori_bill_deal_date,ori_retriev_no,
                 ori_trade_type,adjust_type,card_no,issue_org_code,recv_org_code,bill_org_code,send_org_code,ed_make_code,
                 ed_confirm_code,card_count,beforetrade_charge,adjusted_trade_type,adjusted_trade_charge,mcc,channel_type,
                 trade_date,trade_time,test_flag,reason_code,response_code,error_code,error_info,err_charge,sett_charge,
                 issue_charge,bill_charge,process_time,err_type
          from SETT_CITY_AD_DETAIL
          where  sett_date =  ''' || v_bill_date || '''
          and (issue_org_code=''0' || v_org_code ||''' or bill_org_code=''1' || v_org_code ||''')
          ) a';

    execute immediate v_sql;
    ---- 1. 生成记录体数据
    update SETT_STAT_DAILY_AD a
    set record_context = lpad(nvl(a.sett_adjust_org_no,'            '),12,'0')    ||
                      a.ori_sett_date                 ||
                      lpad(a.ori_sett_org_no,12,'0') ||
                      lpad(nvl(a.ori_bill_org_no,'            '),12,'0')    ||
                      nvl(a.ori_bill_deal_date,'        ')     ||
                      lpad(a.ori_retriev_no,12,'0')   ||
                      rpad(a.ori_trade_type,4,' ')    ||
                      a.adjust_type                   ||
                      rpad(a.card_no,20,' ')          ||
                      rpad(nvl(a.issue_org_code,' '),11,' ')        ||
                      rpad(nvl(a.recv_org_code,' '),11,' ')        ||
                      rpad(nvl(a.bill_org_code,' '),11,' ')        ||
                      rpad(a.send_org_code,11,' ')        ||
                      rpad(nvl(a.ed_make_code,' '),11,' ')        ||
                      rpad(nvl(a.ed_confirm_code,' '),11,' ')     ||
                      lpad(round(a.card_count),6,'0')              ||
                      lpad(round(a.beforetrade_charge),12,'0')     ||
                      rpad(nvl(a.adjusted_trade_type,' '),4,' ')   ||
                      lpad(round(a.adjusted_trade_charge),12,'0')   ||
                      a.mcc                   ||
                      a.channel_type          ||
                      a.trade_date            ||
                      a.trade_time            ||
                      a.test_flag             ||
                      nvl(a.reason_code,'    ')   ||
                      nvl(a.response_code,'  ')   ||
                      lpad(a.error_code,6,' ')               ||
                      rpad(a.error_info,40,' ')              ||
                      rpad(round(a.err_charge,6),18,' ')     ||
                      rpad(round(a.sett_charge,7),28,' ')     ||
                      rpad(round(a.issue_charge,7),28,' ')     ||
                      rpad(round(a.bill_charge,7),28,' ')     ||
                      rpad(a.err_type,32,' ')              ||
                      chr(13) || chr(10)
          where a.sett_date = v_bill_date and a.org_code = v_org_code and a.record_type = '2';
          v_rowcount := sql%rowcount; -- 获得数据记录条数

    ---- 2. 生成头记录
    v_record := '02'||chr(13)||chr(10);
    insert into SETT_STAT_DAILY_AD
    ( record_type, record_context, sett_date, process_time, org_code )
    values
    ('1', v_record, v_bill_date, sysdate, v_org_code);

    v_record :=
                lpad(v_rowcount,6,'0')||
                v_bill_date||
                rpad('1'||v_org_code,11,' ')||
                '0398FFFFFFFFFFFFFFFFFFFF'||chr(13) || chr(10);
    insert into SETT_STAT_DAILY_AD
    ( record_type, record_context, sett_date, process_time, org_code )
    values
    ('1', v_record, v_bill_date, sysdate, v_org_code);

    ---- 3. 生成文件名
    v_AD_filename := 'AD' || substr(v_bill_date, 3,6) || '000000'
                     || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'A';
    insert into SETT_STAT_DAILY_AD
    ( record_type, record_context, sett_date, process_time, org_code )
    values
    ('0', v_AD_filename, v_bill_date, sysdate, v_org_code);

    end loop;
    close cur_org_list ;

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='地市统计AD文件数据统计完成'
    where sett_type='gen_ad' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('地市统计AD文件数据统计完成');

  EXCEPTION when others then
    rollback;
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='gen_ad' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
  end gen_city_ad_file;

  procedure gen_city_ed_file(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    v_org_sql varchar2(1024);
    v_seqence number(12);
    proc_time date;
    TYPE cursor IS REF CURSOR;
    cur_org_list   cursor;

    v_org_code  varchar2(16);
    v_record    varchar2(1024);
    v_rowcount  number(10);
    v_ED_filename varchar2(64);
  begin
    v_month:=substr(v_bill_date,1,6);

    --- 检查当前账期，ED统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ed' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计ED文件数据正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，ED统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ed' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计ED文件数据完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='gen_ed' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ed', v_bill_date, 2, proc_time, '地市统计ED文件数据处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ed', v_bill_date, 2, proc_time, '地市统计ED文件数据开始处理....');
        commit;
    end if;

    ---- 1.清理上次的中间表数据
    delete from SETT_STAT_DAILY_ED where sett_date=v_bill_date;
    commit;

    ---- 2. 获取文件序列号
    select ED_FILE_SEQ.Nextval into v_seqence from dual;

    v_org_sql:= 'select org_code from bps_sys_org_info where area_type in (''02'',''03'')';
    open cur_org_list for v_org_sql;
    loop
    FETCH cur_org_list
    INTO  v_org_code ;
    EXIT WHEN cur_org_list%NOTFOUND;

    v_sql := '
            insert into SETT_STAT_DAILY_ED
            (record_type, record_context, org_code, sett_date,
            sett_org_no,bill_org_no,bill_org_deal_date,trade_retriev_no,adjust_type,err_type,card_no,card_count,
            beforetrade_charge,adjusted_trade_type,adjusted_trade_charge,mcc,channel_type,trade_date,trade_time,
            test_flag,cause_code,err_ori_org_code,issue_org_code,bill_org_id,process_time)
            select ''2'' record_type,
                    '''' record_context,
                    ''' || v_org_code  || ''' org_code,
                    ''' || v_bill_date || ''' sett_date,
                    sett_org_no,bill_org_no,bill_org_deal_date,trade_retriev_no,adjust_type,err_type,card_no,card_count,
                    beforetrade_charge,adjusted_trade_type,adjusted_trade_charge,mcc,channel_type,trade_date,trade_time,
                    test_flag,cause_code,err_ori_org_code,issue_org_code,bill_org_id,'||proc_time||' process_time
            from(
            select  sett_org_no,bill_org_no,bill_org_deal_date,trade_retriev_no,adjust_type,err_type,card_no,card_count,
                    beforetrade_charge,adjusted_trade_type,adjusted_trade_charge,mcc,channel_type,trade_date,trade_time,
                    test_flag,cause_code,err_ori_org_code,issue_org_code,bill_org_id
            from SETT_ED_' || v_month || '
            where sett_date =  ''' || v_bill_date || '''
            and (issue_org_code=''0' || v_org_code ||''' or bill_org_id=''1' || v_org_code ||''')
            and err_ori_org_code != ''0' || v_org_code ||'''
            and err_ori_org_code != ''1' || v_org_code ||'''
            and file_name is null
            ) a';

      execute immediate v_sql;

      ---- 1. 生成记录体数据
      update SETT_STAT_DAILY_ED a
      set record_context = a.sett_date    ||
                      lpad(a.sett_org_no,12,'0')           ||
                      lpad(a.bill_org_no,12,'0')           ||
                      a.bill_org_deal_date            ||
                      lpad(a.trade_retriev_no,12,'0')        ||
                      a.adjust_type            ||
                      a.err_type            ||
                      rpad(a.card_no,20,' ')          ||
                      lpad(a.card_count,6,'0')        ||
                      lpad(a.beforetrade_charge,12,'0')        ||
                      a.adjusted_trade_type            ||
                      lpad(a.adjusted_trade_charge,12,'0')        ||
                      a.mcc                   ||
                      a.channel_type          ||
                      a.trade_date            ||
                      a.trade_time            ||
                      a.test_flag             ||
                      a.cause_code             ||
                      rpad(a.err_ori_org_code,11,' ')          ||
                      rpad(a.issue_org_code,11,' ')          ||
                      rpad(a.bill_org_id,11,' ')          ||
                      chr(13) || chr(10)
        where a.sett_date = v_bill_date and a.org_code = v_org_code and a.record_type = '2';
        v_rowcount := sql%rowcount; -- 获得数据记录条数

        ---- 2. 生成头记录
        v_record := '02'||chr(13)||chr(10);
        insert into SETT_STAT_DAILY_ED
        ( record_type, record_context, sett_date, process_time, org_code )
        values
        ('1', v_record, v_bill_date, sysdate, v_org_code);

        v_record :=
                lpad(v_rowcount,6,'0')||
                 rpad('1'||v_org_code,11,' ')||
                '0171FFFFFFFFFFFFFFFFFFFF'||chr(13) || chr(10);
        insert into SETT_STAT_DAILY_AD
        ( record_type, record_context, sett_date, process_time, org_code )
        values
        ('1', v_record, v_bill_date, sysdate, v_org_code);

        ---- 3. 生成文件名
        v_ED_filename := 'ED' || substr(v_bill_date, 3,6) || '000000'
                         || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'H';
        insert into SETT_STAT_DAILY_ED
        ( record_type, record_context, sett_date, process_time, org_code )
        values
        ('0', v_ED_filename, v_bill_date, sysdate, v_org_code);

    end loop;
    close cur_org_list ;

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='地市统计ED文件数据统计完成'
    where sett_type='gen_ed' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('地市统计ED文件数据统计完成');

  EXCEPTION when others then
    rollback;
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='gen_ed' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
  end gen_city_ed_file;

  procedure gen_city_cm_file(v_bill_date in varchar2) is
    v_sqlerrm varchar2(2000);
    v_cnt     number(10);
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    v_org_sql varchar2(1024);
    v_seqence number(12);
    proc_time date;
    TYPE cursor IS REF CURSOR;
    cur_org_list   cursor;

    v_org_code  varchar2(16);
    v_record    varchar2(1024);
    v_rowcount  number(10);
    v_CM_filename varchar2(64);
  begin
    v_month:=substr(v_bill_date,1,6);
    v_org_code := '00000000'; --- 跨省的数据需要发到部里，其他的不用外发

    --- 检查当前账期，CM统计 业务是否正在处理中
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_cm' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计cm文件数据正在处理中');
        return;
    end if;

    proc_time := sysdate;

    --- 检查当前账期，cm统计 业务是否已经统计完成
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_cm' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('地市统计CM文件数据完成，开始重处理...');

        delete from SETT_STAT_LOG where sett_type='gen_cm' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_cm', v_bill_date, 2, proc_time, '地市统计CM文件数据处理中..., 请等待.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_cm', v_bill_date, 2, proc_time, '地市统计CM文件数据开始处理....');
        commit;
    end if;

    ---- 1.清理上次的中间表数据
    delete from SETT_STAT_DAILY_CM where sett_date=v_bill_date;
    commit;

    ---- 2. 获取文件序列号
    select CM_FILE_SEQ.Nextval into v_seqence from dual;

    v_sql := '
        insert into SETT_STAT_DAILY_CM
        (record_type, record_context, org_code, sett_date,
        sett_org_no, trade_retriev_no,adjust_type,err_type,response_code,card_no,card_count,beforetrade_charge,
        adjusted_trade_type,adjusted_trade_charge,mcc,channel_type,trade_date,trade_time,test_flag,ori_org_code,
        confirm_org_code,issue_org_code,recv_org_code,process_time)
        select ''2'' record_type,
                '''' record_context,
                ''' || v_org_code  || ''' org_code,
                ''' || v_bill_date || ''' sett_date,
                sett_org_no, trade_retriev_no,adjust_type,err_type,response_code,card_no,card_count,beforetrade_charge,
                adjusted_trade_type,adjusted_trade_charge,mcc,channel_type,trade_date,trade_time,test_flag,ori_org_code,
                confirm_org_code,issue_org_code,recv_org_code,'||proc_time||' process_time
        from(
        select  sett_org_no, trade_retriev_no,adjust_type,err_type,response_code,card_no,card_count,beforetrade_charge,
                adjusted_trade_type,adjusted_trade_charge,mcc,channel_type,trade_date,trade_time,test_flag,ori_org_code,
                confirm_org_code,issue_org_code,recv_org_code
        from SETT_CM_' || v_month || '
        where sett_date =  ''' || v_bill_date || '''
        and substr(ori_org_code,2,length(a.ori_org_code)-1) in(select org_code from bps_sys_org_info where area_type in (''02'',''03''))
        ) a';

    execute immediate v_sql;

    ---- 1. 生成记录体数据
    update SETT_STAT_DAILY_CM a
    set record_context = a.sett_date    ||
                    lpad(a.sett_org_no,12,'0')           ||
                    lpad(a.trade_retriev_no,12,'0')           ||
                    a.adjust_type            ||
                    a.err_type            ||
                    a.response_code            ||
                    rpad(a.card_no,20,' ')          ||
                    lpad(a.card_count,6,'0')        ||
                    lpad(a.beforetrade_charge,12,'0')        ||
                    a.adjusted_trade_type            ||
                    lpad(a.adjusted_trade_charge,12,'0')        ||
                    a.mcc                   ||
                    a.channel_type          ||
                    a.trade_date            ||
                    a.trade_time            ||
                    a.test_flag             ||
                    rpad(a.ori_org_code,11,' ')          ||
                    rpad(a.confirm_org_code,11,' ')          ||
                    rpad(a.issue_org_code,11,' ')          ||
                    rpad(a.recv_org_code,11,' ')          ||
                    chr(13) || chr(10)
      where a.sett_date = v_bill_date and a.org_code = v_org_code and a.record_type = '2';
      v_rowcount := sql%rowcount; -- 获得数据记录条数

        ---- 2. 生成头记录
        v_record := '01'||chr(13)||chr(10);
        insert into SETT_STAT_DAILY_CM
        ( record_type, record_context, sett_date, process_time, org_code )
        values
        ('1', v_record, v_bill_date, sysdate, v_org_code);

        v_record :=
                lpad(v_rowcount,6,'0')||
                 rpad(v_org_code,11,' ')||
                '0160FFFFFFFFFFFFFFFFFFFF'||chr(13) || chr(10);
        insert into SETT_STAT_DAILY_CM
        ( record_type, record_context, sett_date, process_time, org_code )
        values
        ('1', v_record, v_bill_date, sysdate, v_org_code);

        ---- 3. 生成文件名
        v_CM_filename := 'CM' || substr(v_bill_date, 3,6) || '000000'
                         ||v_org_code || lpad(v_seqence,10,'0') || 'H';
        insert into SETT_STAT_DAILY_CM
        ( record_type, record_context, sett_date, process_time, org_code )
        values
        ('0', v_CM_filename, v_bill_date, sysdate, v_org_code);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='地市统计CM文件数据统计完成'
    where sett_type='gen_cm' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('地市统计CM文件数据统计完成');

  EXCEPTION when others then
    rollback;
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='gen_cm' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
  end gen_city_cm_file;

  procedure ADJUST_SETT_AD_DETAIL(v_bill_date in varchar2) is
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    v_sett_change_no varchar2(12);
    v_ori_sett_org_no varchar2(12);
    proc_time date;

    cursor ad_cursor is
    select sett_change_no,ori_sett_org_no
    from SETT_AD_DETAIL
    where sett_date = '|| v_bill_date || ' and err_code ='0';

    begin
      v_month:=substr(v_bill_date,1,6);
      proc_time := sysdate;

    open ad_cursor;
    loop
    FETCH ad_cursor
    INTO v_sett_change_no, v_ori_sett_org_no;
    EXIT WHEN ad_cursor%NOTFOUND;
     v_sql := '
        insert into DR_BILL_DETAIL_' || v_month || '
        (dr_type, file_type, send_org_code, send_date,sett_date,file_name,trade_code,block_mark,main_account_id,trade_charge,
        currency_code,trans_time,trace_no,response_code,grant_date,retriev_no,recv_org_id,send_org_id,seller_type,terminal_id,
        acquirer_id,acquirer_addr,ori_trade_info,message_code,info_code,sett_org_no,bill_org_code,issue_org_code,sett_notice,
        trade_channel,trade_sign,settle_stand,condition_code,own_charge,trade_area_id,etc_flag,special_charge_id,special_charge_level,
        trade_mode,card_no,trade_charge1,trade_type,terminal_num,terminal_trade_no,trade_date,trade_time,tac_code,key_version,
        key_index,offline_trade_no,trade_balance,issue_org_id,random_num,cardholder_name,certificates_type,certificates_num,
        cardholder_type,recv_org_code,recv_org_no,recv_date,sett_org_no1,discount_type,beforetrade_charge,receivable_charge,
        trade_state,algorithm_flag,card_org_id,tlv_data,actual_issue_org_code,roam_type,rate_id,service_fee,issue_fee,bill_fee,
        sys_error_code,sys_error_msg,deal_time,indb_time,other_fee,beforetrade_charge_dec,balance_type,test_flag
        )
        select dr_type, file_type, send_org_code, send_date,sett_date,file_name,trade_code,block_mark,main_account_id,trade_charge,
        currency_code,trans_time,trace_no,response_code,grant_date,retriev_no,recv_org_id,send_org_id,seller_type,terminal_id,
        acquirer_id,acquirer_addr,ori_trade_info,message_code,info_code,sett_org_no,bill_org_code,issue_org_code,sett_notice,
        trade_channel,trade_sign,settle_stand,condition_code,own_charge,trade_area_id,etc_flag,special_charge_id,special_charge_level,
        trade_mode,card_no,trade_charge1,trade_type,terminal_num,terminal_trade_no,trade_date,trade_time,tac_code,key_version,
        key_index,offline_trade_no,trade_balance,issue_org_id,random_num,cardholder_name,certificates_type,certificates_num,
        cardholder_type,recv_org_code,recv_org_no,recv_date,sett_org_no1,discount_type,beforetrade_charge,receivable_charge,
        trade_state,algorithm_flag,card_org_id,tlv_data,actual_issue_org_code,roam_type,rate_id,-service_fee,-issue_fee,-bill_fee,
        sys_error_code,sys_error_msg,deal_time,'||proc_time||',-other_fee,beforetrade_charge_dec,balance_type,test_flag
        from DR_BILL_DETAIL_' || v_month || '
        where sett_org_no = '''||v_ori_sett_org_no||'''
     ';
     execute immediate v_sql;

     v_sql := '
     insert into DR_BILL_DETAIL_' || v_month || '
     (dr_type,sett_date,file_name,recv_org_code,sett_org_no,sett_org_no1,retriev_no,card_no,
     issue_org_code,recv_org_id,send_org_id,beforetrade_charge,trade_type,trade_charge,
     trade_date,trade_time,test_flag,service_fee,issue_fee,bill_fee,other_fee,deal_time,indb_time
     )
     select ''dr_bill'' dr_type,sett_date,file_name,recv_org_code,ori_sett_org_no,sett_change_no,ori_retriev_no,card_no,
     issue_org_code,recv_org_code1,send_org_id,beforetrade_charge,adjusted_trade_type,adjusted_trade_charge,
     trade_date,trade_time,test_flag,sett_charge,issue_charge,bill_charge,err_charge,deal_time,'||proc_time||'
     from SETT_AD_DETAIL
     where ori_sett_org_no = '''||v_ori_sett_org_no||'''
     ';
     execute immediate v_sql;

    end loop;
    close ad_cursor;--关闭游标

    commit;

  EXCEPTION when others then
    rollback;
  end ADJUST_SETT_AD_DETAIL;

  procedure ADJUST_SETT_CITY_AD_DETAIL(v_bill_date in varchar2) is
    v_month   varchar2(6);
    v_sql     varchar2(2048);
    v_sett_adjust_org_no varchar2(12);
    v_ori_sett_org_no varchar2(12);
    proc_time date;

    cursor ad_cursor is
    select sett_adjust_org_no,ori_sett_org_no
    from SETT_CITY_AD_DETAIL
    where ori_sett_date = '|| v_bill_date || ' and error_code ='0';

    begin
      v_month:=substr(v_bill_date,1,6);
      open ad_cursor;
      loop
      FETCH ad_cursor
      INTO v_sett_adjust_org_no, v_ori_sett_org_no;
      EXIT WHEN ad_cursor%NOTFOUND;

      v_sql := '
          insert into DR_BILL_DETAIL_' || v_month || '
          (dr_type, file_type, send_org_code, send_date,sett_date,file_name,trade_code,block_mark,main_account_id,trade_charge,
          currency_code,trans_time,trace_no,response_code,grant_date,retriev_no,recv_org_id,send_org_id,seller_type,terminal_id,
          acquirer_id,acquirer_addr,ori_trade_info,message_code,info_code,sett_org_no,bill_org_code,issue_org_code,sett_notice,
          trade_channel,trade_sign,settle_stand,condition_code,own_charge,trade_area_id,etc_flag,special_charge_id,special_charge_level,
          trade_mode,card_no,trade_charge1,trade_type,terminal_num,terminal_trade_no,trade_date,trade_time,tac_code,key_version,
          key_index,offline_trade_no,trade_balance,issue_org_id,random_num,cardholder_name,certificates_type,certificates_num,
          cardholder_type,recv_org_code,recv_org_no,recv_date,sett_org_no1,discount_type,beforetrade_charge,receivable_charge,
          trade_state,algorithm_flag,card_org_id,tlv_data,actual_issue_org_code,roam_type,rate_id,service_fee,issue_fee,bill_fee,
          sys_error_code,sys_error_msg,deal_time,indb_time,other_fee,beforetrade_charge_dec,balance_type,test_flag
          )
          select dr_type, file_type, send_org_code, send_date,sett_date,file_name,trade_code,block_mark,main_account_id,trade_charge,
          currency_code,trans_time,trace_no,response_code,grant_date,retriev_no,recv_org_id,send_org_id,seller_type,terminal_id,
          acquirer_id,acquirer_addr,ori_trade_info,message_code,info_code,sett_org_no,bill_org_code,issue_org_code,sett_notice,
          trade_channel,trade_sign,settle_stand,condition_code,own_charge,trade_area_id,etc_flag,special_charge_id,special_charge_level,
          trade_mode,card_no,trade_charge1,trade_type,terminal_num,terminal_trade_no,trade_date,trade_time,tac_code,key_version,
          key_index,offline_trade_no,trade_balance,issue_org_id,random_num,cardholder_name,certificates_type,certificates_num,
          cardholder_type,recv_org_code,recv_org_no,recv_date,sett_org_no1,discount_type,beforetrade_charge,receivable_charge,
          trade_state,algorithm_flag,card_org_id,tlv_data,actual_issue_org_code,roam_type,rate_id,-service_fee,-issue_fee,-bill_fee,
          sys_error_code,sys_error_msg,deal_time,'||proc_time||',-other_fee,beforetrade_charge_dec,balance_type,test_flag
          from DR_BILL_DETAIL_' || v_month || '
          where sett_org_no = '''||v_ori_sett_org_no||'''
       ';
       execute immediate v_sql;

       v_sql := '
       insert into DR_BILL_DETAIL_' || v_month || '
       (dr_type,sett_date,sett_org_no,sett_org_no1,retriev_no,card_no,
       issue_org_code,recv_org_id,send_org_id,beforetrade_charge,trade_type,trade_charge,
       trade_date,trade_time,test_flag,service_fee,issue_fee,bill_fee,other_fee,deal_time,indb_time
       )
       select ''dr_bill'' dr_type,sett_date,ori_sett_org_no,sett_adjust_org_no,ori_retriev_no,card_no,
       issue_org_code,recv_org_code,send_org_code,beforetrade_charge,adjusted_trade_type,adjusted_trade_charge,
       trade_date,trade_time,test_flag,sett_charge,issue_charge,bill_charge,err_charge,to_char(deal_time,'||'yyyy-MM-dd HH24:mi:ss'||') ,'||proc_time||'
       from SETT_CITY_AD_DETAIL
       where ori_sett_org_no = '''||v_ori_sett_org_no||'''
       ';
       execute immediate v_sql;

      end loop;
    close ad_cursor;--关闭游标

    commit;

  EXCEPTION when others then
    rollback;
  end ADJUST_SETT_CITY_AD_DETAIL;

  procedure PRO_BN_RECORD  is
     v_issue_org_code varchar2(12);
     v_card_bin_no varchar2(12);
     v_sql     varchar2(2048);

     cursor bn_cursor is
     select a.issue_org_code,a.card_bin_no
     from info_bn_conf a
     left join info_bn_conf_temp b
     on a.issue_org_code = b.issue_org_code
     and a.card_bin_no = b.card_bin_no
     where b.issue_org_code is null;

     begin

      open bn_cursor;
      dbms_output.put_line('打开游标');
      loop
      FETCH bn_cursor
      INTO v_issue_org_code, v_card_bin_no;
      EXIT WHEN bn_cursor%NOTFOUND;

      v_sql := 'update info_bn_conf set exp_date=to_char(sysdate,''yyyymmdd'')
      where issue_org_code = '''||v_issue_org_code||'''
      and card_bin_no ='''||v_card_bin_no||'''';
      dbms_output.put_line(v_sql);
      execute immediate v_sql;
      dbms_output.put_line('execute immediate v_sql');
      end loop;
      close bn_cursor;--关闭游标
     dbms_output.put_line('关闭游标');
      v_sql := '
          insert into info_bn_conf
          (issue_org_code,card_bin_no,eff_date,exp_date)
          select
          issue_org_code,
          card_bin_no,
          to_char(sysdate,''yyyymmdd'') eff_date,
          ''20991231'' exp_date
          from
          (select a.issue_org_code, a.card_bin_no
          from info_bn_conf_temp a
          left join info_bn_conf b
          on a.issue_org_code = b.issue_org_code
          and a.card_bin_no = b.card_bin_no
          where b.issue_org_code is null) d
          ';
     dbms_output.put_line(v_sql);

     execute immediate v_sql;

     v_sql := 'delete from info_bn_conf_temp';
     dbms_output.put_line(v_sql);
     execute immediate v_sql;

     commit;

     EXCEPTION when others then
     rollback;
  end PRO_BN_RECORD;

  procedure PRO_ER_RECORD  is
     v_err_code varchar2(12);
     v_err_info varchar2(50);
     v_sql     varchar2(2048);

     cursor er_cursor is
     select a.err_code,a.err_info
     from info_er_conf a
     left join info_er_conf_temp b
     on a.err_code = b.err_code
     and a.err_info = b.err_info
     where b.err_code is null;

     begin

      open er_cursor;
      loop
      FETCH er_cursor
      INTO v_err_code, v_err_info;
      EXIT WHEN er_cursor%NOTFOUND;

      v_sql := 'update info_er_conf set exp_date=to_char(sysdate,''yyyymmdd'')
      where err_code = '''||v_err_code||'''
      and err_info ='''||v_err_info||'''';

      execute immediate v_sql;
      end loop;

     close er_cursor;--关闭游标

      v_sql := '
          insert into info_er_conf
          (err_code,err_info,eff_date,exp_date)
          select
          err_code,
          err_info,
          to_char(sysdate,''yyyymmdd'') eff_date,
          ''20991231'' exp_date
          from
          (select a.err_code, a.err_info
          from info_er_conf_temp a
          left join info_er_conf b
          on a.err_code = b.err_code
          and a.err_info = b.err_info
          where b.err_code is null) d
          ';
     execute immediate v_sql;

     v_sql := 'delete from info_er_conf_temp';
     dbms_output.put_line(v_sql);
     execute immediate v_sql;

     commit;

     EXCEPTION when others then
     rollback;
  end PRO_ER_RECORD;

  procedure PRO_UC_RECORD  is
     v_sql     varchar2(2048);

     begin
     v_sql := '
     insert into info_uc_conf
     (send_org_code,issue_org_code,card_no,eff_date,exp_date)
     select
     send_org_code,
     issue_org_code,
     card_no,
     to_char(sysdate,''yyyymmdd'') eff_date,
     ''20991231'' exp_date
     from
     (select a.send_org_code, a.issue_org_code, a.card_no
     from info_uc_conf_temp a
     left join info_uc_conf b
     on a.send_org_code = b.send_org_code
     and a.issue_org_code = b.issue_org_code
     and a.card_no = b.card_no
     where b.card_no is null) d
     ';
     execute immediate v_sql;

     v_sql := 'delete from info_uc_conf_temp';
     dbms_output.put_line(v_sql);
     execute immediate v_sql;

     commit;

     EXCEPTION when others then
     rollback;

  end PRO_UC_RECORD;

end sett_stat;
/


spool off
