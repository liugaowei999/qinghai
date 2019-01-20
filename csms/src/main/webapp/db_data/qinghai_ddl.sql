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
  is '����ID';
comment on column BPS_BN_CONF.down_date
  is '�·�����';
comment on column BPS_BN_CONF.file_name
  is '�ļ�����';
comment on column BPS_BN_CONF.issue_org_code
  is '������������';
comment on column BPS_BN_CONF.card_bin_no
  is '��BIN';
comment on column BPS_BN_CONF.deal_time
  is '����ʱ��';
comment on column BPS_BN_CONF.indb_time
  is '���ʱ��';
comment on column BPS_BN_CONF.create_by
  is '������';
comment on column BPS_BN_CONF.create_date
  is '����ʱ��';
comment on column BPS_BN_CONF.update_by
  is '�޸���';
comment on column BPS_BN_CONF.update_date
  is '�޸�ʱ��';
comment on column BPS_BN_CONF.remarks
  is '��ע';
comment on column BPS_BN_CONF.del_flag
  is 'ɾ����־';
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
  is '����ID';
comment on column BPS_DC_CONF.down_date
  is '�·�����';
comment on column BPS_DC_CONF.file_name
  is '�ļ�����';
comment on column BPS_DC_CONF.issue_org_code
  is '������������';
comment on column BPS_DC_CONF.card_no
  is '����';
comment on column BPS_DC_CONF.deal_time
  is '����ʱ��';
comment on column BPS_DC_CONF.indb_time
  is '���ʱ��';
comment on column BPS_DC_CONF.create_by
  is '������';
comment on column BPS_DC_CONF.create_date
  is '����ʱ��';
comment on column BPS_DC_CONF.update_by
  is '�޸���';
comment on column BPS_DC_CONF.update_date
  is '�޸�ʱ��';
comment on column BPS_DC_CONF.remarks
  is '��ע';
comment on column BPS_DC_CONF.del_flag
  is 'ɾ����־';
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
  is '����ID';
comment on column BPS_ER_CONF.down_date
  is '�·�����';
comment on column BPS_ER_CONF.file_name
  is '�ļ�����';
comment on column BPS_ER_CONF.err_code
  is '�������';
comment on column BPS_ER_CONF.err_info
  is '�����������';
comment on column BPS_ER_CONF.deal_time
  is '����ʱ��';
comment on column BPS_ER_CONF.indb_time
  is '���ʱ��';
comment on column BPS_ER_CONF.create_by
  is '������';
comment on column BPS_ER_CONF.create_date
  is '����ʱ��';
comment on column BPS_ER_CONF.update_by
  is '�޸���';
comment on column BPS_ER_CONF.update_date
  is '�޸�ʱ��';
comment on column BPS_ER_CONF.remarks
  is '��ע';
comment on column BPS_ER_CONF.del_flag
  is 'ɾ����־';
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
  is 'ģ��ID';
comment on column BPS_FILETRANS_LOG_201612.file_name
  is '�ļ���';
comment on column BPS_FILETRANS_LOG_201612.file_size
  is 'ԭʼ�ļ���С�� ��λ�ֽ�';
comment on column BPS_FILETRANS_LOG_201612.is_sucess
  is '�Ƿ�ɹ�';
comment on column BPS_FILETRANS_LOG_201612.process_time
  is '�ϴ�������ʱ�� yyyymmddhh24miss';
comment on column BPS_FILETRANS_LOG_201612.isup
  is '1: �ϴ� 0������';
comment on column BPS_FILETRANS_LOG_201612.trans_size
  is '�Ѵ�����ļ����ݴ�С�� ��λ�ֽ�';
comment on column BPS_FILETRANS_LOG_201612.remark
  is '��ע';

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
  is 'ģ��ID';
comment on column BPS_FILETRANS_LOG_YYYYMM.file_name
  is '�ļ���';
comment on column BPS_FILETRANS_LOG_YYYYMM.file_size
  is 'ԭʼ�ļ���С�� ��λ�ֽ�';
comment on column BPS_FILETRANS_LOG_YYYYMM.is_sucess
  is '�Ƿ�ɹ�';
comment on column BPS_FILETRANS_LOG_YYYYMM.process_time
  is '�ϴ�������ʱ�� yyyymmddhh24miss';
comment on column BPS_FILETRANS_LOG_YYYYMM.isup
  is '1: �ϴ� 0������';
comment on column BPS_FILETRANS_LOG_YYYYMM.trans_size
  is '�Ѵ�����ļ����ݴ�С�� ��λ�ֽ�';
comment on column BPS_FILETRANS_LOG_YYYYMM.remark
  is '��ע';

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
  is '���ս��㣺YYYYMMDD�� ���ս��㣺YYYYMM ---��ʱ����';
comment on column BPS_SETL_CYCLE.setl_mode
  is '���㷽ʽ�� 1�����ս��� 2�����ս���';
comment on column BPS_SETL_CYCLE.end_time
  is 'HHMISS��ʱ���룩������ʱ���������ʱ��';
comment on column BPS_SETL_CYCLE.create_by
  is '������';
comment on column BPS_SETL_CYCLE.create_date
  is '����ʱ��';
comment on column BPS_SETL_CYCLE.update_by
  is '���²�����';
comment on column BPS_SETL_CYCLE.update_date
  is '����ʱ��';
comment on column BPS_SETL_CYCLE.remark
  is '��ע';
comment on column BPS_SETL_CYCLE.del_flag
  is 'ɾ�����';

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
  is 'ģ�鶨���';
comment on column BPS_SYS_MODULE.module_id
  is 'ģ���ʶ';
comment on column BPS_SYS_MODULE.module_code
  is 'ģ�����';
comment on column BPS_SYS_MODULE.module_name
  is 'ģ������';
comment on column BPS_SYS_MODULE.program_name
  is '��������';
comment on column BPS_SYS_MODULE.note
  is '��ע';
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
  is 'ģ�������ϸ��';
comment on column BPS_SYS_MODULE_PARAM.module_id
  is 'ģ���ʶ';
comment on column BPS_SYS_MODULE_PARAM.section_code
  is '�������';
comment on column BPS_SYS_MODULE_PARAM.param_code
  is '��������';
comment on column BPS_SYS_MODULE_PARAM.param_value
  is '����ȡֵ';
comment on column BPS_SYS_MODULE_PARAM.note
  is '��ע';

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
  is '01��ʡ��
02��ʡ��
03����˾��';
comment on column BPS_SYS_ORG_INFO.org_attr
  is '������������, 01: ���� 02:�յ� 03:�����յ�';

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
  is '-1��������ҵ
1����ͨ��ҵ
2��������ҵ';
comment on column BPS_SYS_SETT_RATE.service_type
  is '01: ������
02: ����
03: ���г�����
04�����⳵
-1������ҵ�񣨲�����ҵ�����ͣ�';
comment on column BPS_SYS_SETT_RATE.recv_org_code
  is '�յ����������롣
-1���������յ������յ�������������������յ�����';
comment on column BPS_SYS_SETT_RATE.issue_org_code
  is '�������������롣
-1�������ַ���������������������������з�������';
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
  is '����ID';
comment on column BPS_UC_CONF.send_date
  is '��������';
comment on column BPS_UC_CONF.send_org_code
  is '���ͻ�������';
comment on column BPS_UC_CONF.file_name
  is '�ļ�����';
comment on column BPS_UC_CONF.issue_org_code
  is '������������';
comment on column BPS_UC_CONF.card_no
  is '����';
comment on column BPS_UC_CONF.deal_time
  is '����ʱ��';
comment on column BPS_UC_CONF.indb_time
  is '���ʱ��';
comment on column BPS_UC_CONF.create_by
  is '������';
comment on column BPS_UC_CONF.create_date
  is '����ʱ��';
comment on column BPS_UC_CONF.update_by
  is '�޸���';
comment on column BPS_UC_CONF.update_date
  is '�޸�ʱ��';
comment on column BPS_UC_CONF.remarks
  is '��ע';
comment on column BPS_UC_CONF.del_flag
  is 'ɾ����־';
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
  is '�������ʺű���';
comment on column CASH_PROVISIONS.provisions_no
  is '�������ʺ�';
comment on column CASH_PROVISIONS.bankcard_no
  is '���п���';
comment on column CASH_PROVISIONS.pay_period
  is '�ɴ�����';
comment on column CASH_PROVISIONS.deposite
  is 'Ѻ��';
comment on column CASH_PROVISIONS.total_amount
  is '�ܶ�';
comment on column CASH_PROVISIONS.remaining_sum
  is '�������';
comment on column CASH_PROVISIONS.withdraw_deposite
  is '�����ֽ��';
comment on column CASH_PROVISIONS.need_pay
  is 'Ӧ��������';
comment on column CASH_PROVISIONS.user_id
  is '������ϵͳ�û�';
comment on column CASH_PROVISIONS.create_by
  is '������';
comment on column CASH_PROVISIONS.create_date
  is '����ʱ��';
comment on column CASH_PROVISIONS.update_by
  is '������';
comment on column CASH_PROVISIONS.update_date
  is '����ʱ��';
comment on column CASH_PROVISIONS.remarks
  is '��ע��Ϣ';
comment on column CASH_PROVISIONS.del_flag
  is 'ɾ�����';
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
  is '���';
comment on column CASH_ADVICE_INFO.provisions_id
  is '�������ʺű���';
comment on column CASH_ADVICE_INFO.need_pay
  is '�ɴ���';
comment on column CASH_ADVICE_INFO.reason
  is '�ɴ�״̬';
comment on column CASH_ADVICE_INFO.deal_state
  is '����״̬��0:δ����1:�Ѵ���';
comment on column CASH_ADVICE_INFO.advice_type
  is '֪ͨ���ͣ�0:�澯֪ͨ��1:�������֪ͨ��2:��������֪ͨ,3:���ڱ��֪ͨ��4�����ֽ��֪ͨ��';
comment on column CASH_ADVICE_INFO.create_by
  is '������';
comment on column CASH_ADVICE_INFO.create_date
  is '����ʱ��';
comment on column CASH_ADVICE_INFO.update_by
  is '������';
comment on column CASH_ADVICE_INFO.update_date
  is '����ʱ��';
comment on column CASH_ADVICE_INFO.remarks
  is '��ע��Ϣ';
comment on column CASH_ADVICE_INFO.del_flag
  is 'ɾ�����';
comment on column CASH_ADVICE_INFO.message
  is '֪ͨ����';
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
  is '�������ʺű���';
comment on column CASH_PAY_PERIOD_RECORD.provisions_id
  is '�������ʺű���';
comment on column CASH_PAY_PERIOD_RECORD.ori_pay_period
  is 'ԭ�ɴ�����';
comment on column CASH_PAY_PERIOD_RECORD.cur_pay_period
  is '�ֽɴ�����';
comment on column CASH_PAY_PERIOD_RECORD.create_by
  is '������';
comment on column CASH_PAY_PERIOD_RECORD.create_date
  is '����ʱ��';
comment on column CASH_PAY_PERIOD_RECORD.update_by
  is '������';
comment on column CASH_PAY_PERIOD_RECORD.update_date
  is '����ʱ��';
comment on column CASH_PAY_PERIOD_RECORD.remarks
  is '��ע��Ϣ';
comment on column CASH_PAY_PERIOD_RECORD.del_flag
  is 'ɾ�����';
comment on column CASH_PAY_PERIOD_RECORD.modify_status
  is '���״̬';
comment on column CASH_PAY_PERIOD_RECORD.nee_pay_money
  is '��ɴ���';
comment on column CASH_PAY_PERIOD_RECORD.pay_period_flag
  is '�Ƿ�ɴ�';
comment on column CASH_PAY_PERIOD_RECORD.examine_status
  is '���״̬';
comment on column CASH_PAY_PERIOD_RECORD.period_status
  is '����״̬';
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
  is '���';
comment on column CASH_PAY_RECORD.provisions_id
  is '�������ʺű���';
comment on column CASH_PAY_RECORD.pay_money
  is '�ɴ���';
comment on column CASH_PAY_RECORD.pay_state
  is '�ɴ�״̬';
comment on column CASH_PAY_RECORD.create_by
  is '������';
comment on column CASH_PAY_RECORD.create_date
  is '����ʱ��';
comment on column CASH_PAY_RECORD.update_by
  is '������';
comment on column CASH_PAY_RECORD.update_date
  is '����ʱ��';
comment on column CASH_PAY_RECORD.remarks
  is '��ע��Ϣ';
comment on column CASH_PAY_RECORD.del_flag
  is 'ɾ�����';
comment on column CASH_PAY_RECORD.office_name
  is '������֯����';
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
  is '�������ʺű���';
comment on column CASH_WARN_PARA.pay_period
  is '�ɴ�����';
comment on column CASH_WARN_PARA.warn_val
  is '�澯ֵ';
comment on column CASH_WARN_PARA.create_by
  is '������';
comment on column CASH_WARN_PARA.create_date
  is '����ʱ��';
comment on column CASH_WARN_PARA.update_by
  is '������';
comment on column CASH_WARN_PARA.update_date
  is '����ʱ��';
comment on column CASH_WARN_PARA.remarks
  is '��ע��Ϣ';
comment on column CASH_WARN_PARA.del_flag
  is 'ɾ�����';
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
  is '�������ʺű���';
comment on column CASH_WITHDRAW_RECORD.provisions_id
  is '�������ʺű���';
comment on column CASH_WITHDRAW_RECORD.withdraw_deposite
  is '���ֽ��';
comment on column CASH_WITHDRAW_RECORD.pre_withdraw_deposite
  is '����ǰ���';
comment on column CASH_WITHDRAW_RECORD.next_withdraw_deposite
  is '���ֺ���';
comment on column CASH_WITHDRAW_RECORD.withdraw_type
  is '�������ͣ�0:�Զ�������1:�������֣�';
comment on column CASH_WITHDRAW_RECORD.withdraw_state
  is '����״̬��0:�������֣�1:�����֣�2:����ʧ�ܣ�';
comment on column CASH_WITHDRAW_RECORD.create_by
  is '������';
comment on column CASH_WITHDRAW_RECORD.create_date
  is '����ʱ��';
comment on column CASH_WITHDRAW_RECORD.update_by
  is '������';
comment on column CASH_WITHDRAW_RECORD.update_date
  is '����ʱ��';
comment on column CASH_WITHDRAW_RECORD.remarks
  is '��ע��Ϣ';
comment on column CASH_WITHDRAW_RECORD.del_flag
  is 'ɾ�����';
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
  is '���±�';
comment on column CMS_ARTICLE.id
  is '���';
comment on column CMS_ARTICLE.category_id
  is '��Ŀ���';
comment on column CMS_ARTICLE.title
  is '����';
comment on column CMS_ARTICLE.link
  is '��������';
comment on column CMS_ARTICLE.color
  is '������ɫ';
comment on column CMS_ARTICLE.image
  is '����ͼƬ';
comment on column CMS_ARTICLE.keywords
  is '�ؼ���';
comment on column CMS_ARTICLE.description
  is '������ժҪ';
comment on column CMS_ARTICLE.weight
  is 'Ȩ�أ�Խ��Խ��ǰ';
comment on column CMS_ARTICLE.weight_date
  is 'Ȩ������';
comment on column CMS_ARTICLE.hits
  is '�����';
comment on column CMS_ARTICLE.posid
  is '�Ƽ�λ����ѡ';
comment on column CMS_ARTICLE.custom_content_view
  is '�Զ���������ͼ';
comment on column CMS_ARTICLE.view_config
  is '��ͼ����';
comment on column CMS_ARTICLE.create_by
  is '������';
comment on column CMS_ARTICLE.create_date
  is '����ʱ��';
comment on column CMS_ARTICLE.update_by
  is '������';
comment on column CMS_ARTICLE.update_date
  is '����ʱ��';
comment on column CMS_ARTICLE.remarks
  is '��ע��Ϣ';
comment on column CMS_ARTICLE.del_flag
  is 'ɾ�����';
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
  is '�������';
comment on column CMS_ARTICLE_DATA.id
  is '���';
comment on column CMS_ARTICLE_DATA.content
  is '��������';
comment on column CMS_ARTICLE_DATA.copyfrom
  is '������Դ';
comment on column CMS_ARTICLE_DATA.relation
  is '�������';
comment on column CMS_ARTICLE_DATA.allow_comment
  is '�Ƿ���������';
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
  is '��Ŀ��';
comment on column CMS_CATEGORY.id
  is '���';
comment on column CMS_CATEGORY.parent_id
  is '�������';
comment on column CMS_CATEGORY.parent_ids
  is '���и������';
comment on column CMS_CATEGORY.site_id
  is 'վ����';
comment on column CMS_CATEGORY.office_id
  is '��������';
comment on column CMS_CATEGORY.module
  is '��Ŀģ��';
comment on column CMS_CATEGORY.name
  is '��Ŀ����';
comment on column CMS_CATEGORY.image
  is '��ĿͼƬ';
comment on column CMS_CATEGORY.href
  is '����';
comment on column CMS_CATEGORY.target
  is 'Ŀ��';
comment on column CMS_CATEGORY.description
  is '����';
comment on column CMS_CATEGORY.keywords
  is '�ؼ���';
comment on column CMS_CATEGORY.sort
  is '��������';
comment on column CMS_CATEGORY.in_menu
  is '�Ƿ��ڵ�������ʾ';
comment on column CMS_CATEGORY.in_list
  is '�Ƿ��ڷ���ҳ����ʾ�б�';
comment on column CMS_CATEGORY.show_modes
  is 'չ�ַ�ʽ';
comment on column CMS_CATEGORY.allow_comment
  is '�Ƿ���������';
comment on column CMS_CATEGORY.is_audit
  is '�Ƿ���Ҫ���';
comment on column CMS_CATEGORY.custom_list_view
  is '�Զ����б���ͼ';
comment on column CMS_CATEGORY.custom_content_view
  is '�Զ���������ͼ';
comment on column CMS_CATEGORY.view_config
  is '��ͼ����';
comment on column CMS_CATEGORY.create_by
  is '������';
comment on column CMS_CATEGORY.create_date
  is '����ʱ��';
comment on column CMS_CATEGORY.update_by
  is '������';
comment on column CMS_CATEGORY.update_date
  is '����ʱ��';
comment on column CMS_CATEGORY.remarks
  is '��ע��Ϣ';
comment on column CMS_CATEGORY.del_flag
  is 'ɾ�����';
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
  is '���۱�';
comment on column CMS_COMMENT.id
  is '���';
comment on column CMS_COMMENT.category_id
  is '��Ŀ���';
comment on column CMS_COMMENT.content_id
  is '��Ŀ���ݵı��';
comment on column CMS_COMMENT.title
  is '��Ŀ���ݵı���';
comment on column CMS_COMMENT.content
  is '��������';
comment on column CMS_COMMENT.name
  is '��������';
comment on column CMS_COMMENT.ip
  is '����IP';
comment on column CMS_COMMENT.create_date
  is '����ʱ��';
comment on column CMS_COMMENT.audit_user_id
  is '�����';
comment on column CMS_COMMENT.audit_date
  is '���ʱ��';
comment on column CMS_COMMENT.del_flag
  is 'ɾ�����';
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
  is '���԰�';
comment on column CMS_GUESTBOOK.id
  is '���';
comment on column CMS_GUESTBOOK.type
  is '���Է���';
comment on column CMS_GUESTBOOK.content
  is '��������';
comment on column CMS_GUESTBOOK.name
  is '����';
comment on column CMS_GUESTBOOK.email
  is '����';
comment on column CMS_GUESTBOOK.phone
  is '�绰';
comment on column CMS_GUESTBOOK.workunit
  is '��λ';
comment on column CMS_GUESTBOOK.ip
  is 'IP';
comment on column CMS_GUESTBOOK.create_date
  is '����ʱ��';
comment on column CMS_GUESTBOOK.re_user_id
  is '�ظ���';
comment on column CMS_GUESTBOOK.re_date
  is '�ظ�ʱ��';
comment on column CMS_GUESTBOOK.re_content
  is '�ظ�����';
comment on column CMS_GUESTBOOK.del_flag
  is 'ɾ�����';
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
  is '��������';
comment on column CMS_LINK.id
  is '���';
comment on column CMS_LINK.category_id
  is '��Ŀ���';
comment on column CMS_LINK.title
  is '��������';
comment on column CMS_LINK.color
  is '������ɫ';
comment on column CMS_LINK.image
  is '����ͼƬ';
comment on column CMS_LINK.href
  is '���ӵ�ַ';
comment on column CMS_LINK.weight
  is 'Ȩ�أ�Խ��Խ��ǰ';
comment on column CMS_LINK.weight_date
  is 'Ȩ������';
comment on column CMS_LINK.create_by
  is '������';
comment on column CMS_LINK.create_date
  is '����ʱ��';
comment on column CMS_LINK.update_by
  is '������';
comment on column CMS_LINK.update_date
  is '����ʱ��';
comment on column CMS_LINK.remarks
  is '��ע��Ϣ';
comment on column CMS_LINK.del_flag
  is 'ɾ�����';
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
  is 'վ���';
comment on column CMS_SITE.id
  is '���';
comment on column CMS_SITE.name
  is 'վ������';
comment on column CMS_SITE.title
  is 'վ�����';
comment on column CMS_SITE.logo
  is 'վ��Logo';
comment on column CMS_SITE.domain
  is 'վ������';
comment on column CMS_SITE.description
  is '����';
comment on column CMS_SITE.keywords
  is '�ؼ���';
comment on column CMS_SITE.theme
  is '����';
comment on column CMS_SITE.copyright
  is '��Ȩ��Ϣ';
comment on column CMS_SITE.custom_index_view
  is '�Զ���վ����ҳ��ͼ';
comment on column CMS_SITE.create_by
  is '������';
comment on column CMS_SITE.create_date
  is '����ʱ��';
comment on column CMS_SITE.update_by
  is '������';
comment on column CMS_SITE.update_date
  is '����ʱ��';
comment on column CMS_SITE.remarks
  is '��ע��Ϣ';
comment on column CMS_SITE.del_flag
  is 'ɾ�����';
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
  is '���ɷ���';
comment on column GEN_SCHEME.id
  is '���';
comment on column GEN_SCHEME.name
  is '����';
comment on column GEN_SCHEME.category
  is '����';
comment on column GEN_SCHEME.package_name
  is '���ɰ�·��';
comment on column GEN_SCHEME.module_name
  is '����ģ����';
comment on column GEN_SCHEME.sub_module_name
  is '������ģ����';
comment on column GEN_SCHEME.function_name
  is '���ɹ�����';
comment on column GEN_SCHEME.function_name_simple
  is '���ɹ���������д��';
comment on column GEN_SCHEME.function_author
  is '���ɹ�������';
comment on column GEN_SCHEME.gen_table_id
  is '���ɱ���';
comment on column GEN_SCHEME.create_by
  is '������';
comment on column GEN_SCHEME.create_date
  is '����ʱ��';
comment on column GEN_SCHEME.update_by
  is '������';
comment on column GEN_SCHEME.update_date
  is '����ʱ��';
comment on column GEN_SCHEME.remarks
  is '��ע��Ϣ';
comment on column GEN_SCHEME.del_flag
  is 'ɾ����ǣ�0��������1��ɾ����';
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
  is 'ҵ���';
comment on column GEN_TABLE.id
  is '���';
comment on column GEN_TABLE.name
  is '����';
comment on column GEN_TABLE.comments
  is '����';
comment on column GEN_TABLE.class_name
  is 'ʵ��������';
comment on column GEN_TABLE.parent_table
  is '��������';
comment on column GEN_TABLE.parent_table_fk
  is '�����������';
comment on column GEN_TABLE.create_by
  is '������';
comment on column GEN_TABLE.create_date
  is '����ʱ��';
comment on column GEN_TABLE.update_by
  is '������';
comment on column GEN_TABLE.update_date
  is '����ʱ��';
comment on column GEN_TABLE.remarks
  is '��ע��Ϣ';
comment on column GEN_TABLE.del_flag
  is 'ɾ����ǣ�0��������1��ɾ����';
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
  is 'ҵ����ֶ�';
comment on column GEN_TABLE_COLUMN.id
  is '���';
comment on column GEN_TABLE_COLUMN.gen_table_id
  is '��������';
comment on column GEN_TABLE_COLUMN.name
  is '����';
comment on column GEN_TABLE_COLUMN.comments
  is '����';
comment on column GEN_TABLE_COLUMN.jdbc_type
  is '�е��������͵��ֽڳ���';
comment on column GEN_TABLE_COLUMN.java_type
  is 'JAVA����';
comment on column GEN_TABLE_COLUMN.java_field
  is 'JAVA�ֶ���';
comment on column GEN_TABLE_COLUMN.is_pk
  is '�Ƿ�����';
comment on column GEN_TABLE_COLUMN.is_null
  is '�Ƿ��Ϊ��';
comment on column GEN_TABLE_COLUMN.is_insert
  is '�Ƿ�Ϊ�����ֶ�';
comment on column GEN_TABLE_COLUMN.is_edit
  is '�Ƿ�༭�ֶ�';
comment on column GEN_TABLE_COLUMN.is_list
  is '�Ƿ��б��ֶ�';
comment on column GEN_TABLE_COLUMN.is_query
  is '�Ƿ��ѯ�ֶ�';
comment on column GEN_TABLE_COLUMN.query_type
  is '��ѯ��ʽ�����ڡ������ڡ����ڡ�С�ڡ���Χ����LIKE����LIKE������LIKE��';
comment on column GEN_TABLE_COLUMN.show_type
  is '�ֶ����ɷ������ı����ı��������򡢸�ѡ�򡢵�ѡ���ֵ�ѡ����Աѡ�񡢲���ѡ������ѡ��';
comment on column GEN_TABLE_COLUMN.dict_type
  is '�ֵ�����';
comment on column GEN_TABLE_COLUMN.settings
  is '�������ã���չ�ֶ�JSON��';
comment on column GEN_TABLE_COLUMN.sort
  is '��������';
comment on column GEN_TABLE_COLUMN.create_by
  is '������';
comment on column GEN_TABLE_COLUMN.create_date
  is '����ʱ��';
comment on column GEN_TABLE_COLUMN.update_by
  is '������';
comment on column GEN_TABLE_COLUMN.update_date
  is '����ʱ��';
comment on column GEN_TABLE_COLUMN.remarks
  is '��ע��Ϣ';
comment on column GEN_TABLE_COLUMN.del_flag
  is 'ɾ����ǣ�0��������1��ɾ����';
comment on column GEN_TABLE_COLUMN.is_list_order
  is '�ֶ��Ƿ�����';
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
  is '����ģ���';
comment on column GEN_TEMPLATE.id
  is '���';
comment on column GEN_TEMPLATE.name
  is '����';
comment on column GEN_TEMPLATE.category
  is '����';
comment on column GEN_TEMPLATE.file_path
  is '�����ļ�·��';
comment on column GEN_TEMPLATE.file_name
  is '�����ļ���';
comment on column GEN_TEMPLATE.content
  is '����';
comment on column GEN_TEMPLATE.create_by
  is '������';
comment on column GEN_TEMPLATE.create_date
  is '����ʱ��';
comment on column GEN_TEMPLATE.update_by
  is '������';
comment on column GEN_TEMPLATE.update_date
  is '����ʱ��';
comment on column GEN_TEMPLATE.remarks
  is '��ע��Ϣ';
comment on column GEN_TEMPLATE.del_flag
  is 'ɾ����ǣ�0��������1��ɾ����';
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
  is '������̱�';
comment on column OA_LEAVE.id
  is '���';
comment on column OA_LEAVE.process_instance_id
  is '����ʵ�����';
comment on column OA_LEAVE.start_time
  is '��ʼʱ��';
comment on column OA_LEAVE.end_time
  is '����ʱ��';
comment on column OA_LEAVE.leave_type
  is '�������';
comment on column OA_LEAVE.reason
  is '�������';
comment on column OA_LEAVE.apply_time
  is '����ʱ��';
comment on column OA_LEAVE.reality_start_time
  is 'ʵ�ʿ�ʼʱ��';
comment on column OA_LEAVE.reality_end_time
  is 'ʵ�ʽ���ʱ��';
comment on column OA_LEAVE.create_by
  is '������';
comment on column OA_LEAVE.create_date
  is '����ʱ��';
comment on column OA_LEAVE.update_by
  is '������';
comment on column OA_LEAVE.update_date
  is '����ʱ��';
comment on column OA_LEAVE.remarks
  is '��ע��Ϣ';
comment on column OA_LEAVE.del_flag
  is 'ɾ�����';
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
  is '֪ͨͨ��';
comment on column OA_NOTIFY.id
  is '���';
comment on column OA_NOTIFY.type
  is '����';
comment on column OA_NOTIFY.title
  is '����';
comment on column OA_NOTIFY.content
  is '����';
comment on column OA_NOTIFY.files
  is '����';
comment on column OA_NOTIFY.status
  is '״̬';
comment on column OA_NOTIFY.create_by
  is '������';
comment on column OA_NOTIFY.create_date
  is '����ʱ��';
comment on column OA_NOTIFY.update_by
  is '������';
comment on column OA_NOTIFY.update_date
  is '����ʱ��';
comment on column OA_NOTIFY.remarks
  is '��ע��Ϣ';
comment on column OA_NOTIFY.del_flag
  is 'ɾ�����';
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
  is '֪ͨͨ�淢�ͼ�¼';
comment on column OA_NOTIFY_RECORD.id
  is '���';
comment on column OA_NOTIFY_RECORD.oa_notify_id
  is '֪ͨͨ��ID';
comment on column OA_NOTIFY_RECORD.user_id
  is '������';
comment on column OA_NOTIFY_RECORD.read_flag
  is '�Ķ����';
comment on column OA_NOTIFY_RECORD.read_date
  is '�Ķ�ʱ��';
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
  is '�������̲��Ա�';
comment on column OA_TEST_AUDIT.id
  is '���';
comment on column OA_TEST_AUDIT.proc_ins_id
  is '����ʵ��ID';
comment on column OA_TEST_AUDIT.user_id
  is '�䶯�û�';
comment on column OA_TEST_AUDIT.office_id
  is '��������';
comment on column OA_TEST_AUDIT.post
  is '��λ';
comment on column OA_TEST_AUDIT.age
  is '�Ա�';
comment on column OA_TEST_AUDIT.edu
  is 'ѧ��';
comment on column OA_TEST_AUDIT.content
  is '����ԭ��';
comment on column OA_TEST_AUDIT.olda
  is '���б�׼ н�굵��';
comment on column OA_TEST_AUDIT.oldb
  is '���б�׼ �¹��ʶ�';
comment on column OA_TEST_AUDIT.oldc
  is '���б�׼ ��н�ܶ�';
comment on column OA_TEST_AUDIT.newa
  is '�������׼ н�굵��';
comment on column OA_TEST_AUDIT.newb
  is '�������׼ �¹��ʶ�';
comment on column OA_TEST_AUDIT.newc
  is '�������׼ ��н�ܶ�';
comment on column OA_TEST_AUDIT.add_num
  is '������';
comment on column OA_TEST_AUDIT.exe_date
  is 'ִ��ʱ��';
comment on column OA_TEST_AUDIT.hr_text
  is '������Դ�������';
comment on column OA_TEST_AUDIT.lead_text
  is '�ֹ��쵼���';
comment on column OA_TEST_AUDIT.main_lead_text
  is '������Ҫ�쵼���';
comment on column OA_TEST_AUDIT.create_by
  is '������';
comment on column OA_TEST_AUDIT.create_date
  is '����ʱ��';
comment on column OA_TEST_AUDIT.update_by
  is '������';
comment on column OA_TEST_AUDIT.update_date
  is '����ʱ��';
comment on column OA_TEST_AUDIT.remarks
  is '��ע��Ϣ';
comment on column OA_TEST_AUDIT.del_flag
  is 'ɾ�����';
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
  is '���ݿ��������ñ�';
comment on column OB_DATABASE_CONFIG.suit_id
  is '���ݿ��SUIT_ID����Ӧ cbsset �е� SUIT_ID��';
comment on column OB_DATABASE_CONFIG.database_id
  is '�߼����ݿ�ID��ȡֵΪ1���Ʒѣ���2�����񣩡�3���ͷ�����';
comment on column OB_DATABASE_CONFIG.conn_id
  is '����ID';
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
  is '���ݿ��������ñ�2';
comment on column OB_SERVER_CONFIG.conn_id
  is '����ID';
comment on column OB_SERVER_CONFIG.database_name
  is '���ݿ�����,���ֶε�ֵ��Ҫ�� cbsset �е� DatabaseName��ͬ';
comment on column OB_SERVER_CONFIG.server_name
  is '���ݿ�TNS����';
comment on column OB_SERVER_CONFIG.user_name
  is '���ݿ��û���';
comment on column OB_SERVER_CONFIG.password
  is '���ܸ�ʽ�����ݿ��¼����';
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
  is 'ϵͳ���������';
comment on column PUB_SYS_PARA.area_code
  is 'ϵͳ�ж�Ӧ�ĵ�����������ݣ������0��ʾ�����еĵ�����Ч';
comment on column PUB_SYS_PARA.param_code
  is 'Ϊ�ַ����ã�����һ������';
comment on column PUB_SYS_PARA.param_name
  is '0';
comment on column PUB_SYS_PARA.param_class
  is 'ϵͳ����������������ϵͳ��1 �Ʒ�2 ������3 ���ÿ���4�������5�ۺϽ���6 ͳһ�ӿ�';
comment on column PUB_SYS_PARA.param_data_type
  is '�������������(1-Char??2-Number??3-Boolean??4-String 5-Long 6-Date 7-Double';
comment on column PUB_SYS_PARA.param_value
  is '0';
comment on column PUB_SYS_PARA.param_desc
  is '0';
comment on column PUB_SYS_PARA.region_id
  is '�������';

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
  is '���㷽�� 1:ʡһ��ͨ��˾���� 2��ʡһ��ͨ��˾���';
comment on column SETT_CITY_STAT_DETAIL.role_type
  is '��ɫ 1:���� 2���յ�';

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
  is '���㷽�� 1:ʡһ��ͨ��˾���� 2��ʡһ��ͨ��˾���';
comment on column SETT_PROV_STAT_DETAIL.role_type
  is '��ɫ 1:���� 2���յ�';

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
  is '0: �ļ��� 1��ͷ��¼ 2��������';
comment on column SETT_STAT_DAILY_CR.recv_org_id
  is '�յ�������ʶ-���׵ķ�����';
comment on column SETT_STAT_DAILY_CR.bill_org_code
  is '�������������ʶ-�����صĶ�����λ';
comment on column SETT_STAT_DAILY_CR.issue_org_code
  is '������������-������';
comment on column SETT_STAT_DAILY_CR.send_org_id
  is '���ͻ�����ʶ��-���׷����صĶ�����λ';
comment on column SETT_STAT_DAILY_CR.busi_type
  is 'ҵ������';
comment on column SETT_STAT_DAILY_CR.adjust_flag
  is '��������ʶ';
comment on column SETT_STAT_DAILY_CR.total_count
  is '������';
comment on column SETT_STAT_DAILY_CR.total_trade_charge
  is '�ܽ��׽��';
comment on column SETT_STAT_DAILY_CR.recv_org_fee
  is '���׵�������';
comment on column SETT_STAT_DAILY_CR.err_fee
  is '���������';
comment on column SETT_STAT_DAILY_CR.issue_org_fee
  is '������������';
comment on column SETT_STAT_DAILY_CR.prov_org_fee
  is '��ֽ������������';

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
  is '0: �ļ��� 1��ͷ��¼ 2��������';

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
  is '���ڵ�id';
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
  is 'ҵ�����ݱ�';
comment on column TEST_DATA.id
  is '���';
comment on column TEST_DATA.user_id
  is '�����û�';
comment on column TEST_DATA.office_id
  is '��������';
comment on column TEST_DATA.area_id
  is '��������';
comment on column TEST_DATA.name
  is '����';
comment on column TEST_DATA.sex
  is '�Ա�';
comment on column TEST_DATA.in_date
  is '��������';
comment on column TEST_DATA.create_by
  is '������';
comment on column TEST_DATA.create_date
  is '����ʱ��';
comment on column TEST_DATA.update_by
  is '������';
comment on column TEST_DATA.update_date
  is '����ʱ��';
comment on column TEST_DATA.remarks
  is '��ע��Ϣ';
comment on column TEST_DATA.del_flag
  is 'ɾ�����';
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
  is 'ҵ�������ӱ�';
comment on column TEST_DATA_CHILD.id
  is '���';
comment on column TEST_DATA_CHILD.test_data_main_id
  is 'ҵ������ID';
comment on column TEST_DATA_CHILD.name
  is '����';
comment on column TEST_DATA_CHILD.create_by
  is '������';
comment on column TEST_DATA_CHILD.create_date
  is '����ʱ��';
comment on column TEST_DATA_CHILD.update_by
  is '������';
comment on column TEST_DATA_CHILD.update_date
  is '����ʱ��';
comment on column TEST_DATA_CHILD.remarks
  is '��ע��Ϣ';
comment on column TEST_DATA_CHILD.del_flag
  is 'ɾ�����';
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
  is 'ҵ�����ݱ�';
comment on column TEST_DATA_MAIN.id
  is '���';
comment on column TEST_DATA_MAIN.user_id
  is '�����û�';
comment on column TEST_DATA_MAIN.office_id
  is '��������';
comment on column TEST_DATA_MAIN.area_id
  is '��������';
comment on column TEST_DATA_MAIN.name
  is '����';
comment on column TEST_DATA_MAIN.sex
  is '�Ա�';
comment on column TEST_DATA_MAIN.in_date
  is '��������';
comment on column TEST_DATA_MAIN.create_by
  is '������';
comment on column TEST_DATA_MAIN.create_date
  is '����ʱ��';
comment on column TEST_DATA_MAIN.update_by
  is '������';
comment on column TEST_DATA_MAIN.update_date
  is '����ʱ��';
comment on column TEST_DATA_MAIN.remarks
  is '��ע��Ϣ';
comment on column TEST_DATA_MAIN.del_flag
  is 'ɾ�����';
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
  is '���ṹ��';
comment on column TEST_TREE.id
  is '���';
comment on column TEST_TREE.parent_id
  is '�������';
comment on column TEST_TREE.parent_ids
  is '���и������';
comment on column TEST_TREE.name
  is '����';
comment on column TEST_TREE.sort
  is '����';
comment on column TEST_TREE.create_by
  is '������';
comment on column TEST_TREE.create_date
  is '����ʱ��';
comment on column TEST_TREE.update_by
  is '������';
comment on column TEST_TREE.update_date
  is '����ʱ��';
comment on column TEST_TREE.remarks
  is '��ע��Ϣ';
comment on column TEST_TREE.del_flag
  is 'ɾ�����';
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
  
  ----ʡһ��ͨ�Ͳ�ƽ̨����
  procedure SETL_PROV_STAT(v_bill_month in varchar2);
  
  ----ʡһ��ͨ�͵��н���
  procedure SETL_CITY_STAT(v_bill_month in varchar2);
  
  ----ʡһ��ͨ�Ͳ�ƽ̨���ս�����ϸ
  procedure SETL_PROV_DAILY(v_bill_month in varchar2);
  
  ----ʡһ��ͨ�͵��а��ս�����ϸ
  procedure SETL_CITY_DAILY(v_bill_month in varchar2);
  
  ----ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ
  procedure SETL_PROV_DETAIL(v_bill_month in varchar2);
  
  ----ʡһ��ͨ�͵��н����굥չʾ
  procedure SETL_CITY_DETAIL(v_bill_month in varchar2);
    
  
  

  ----����ʡͳ��
  procedure SETL_DEPARTMENT_STAT(v_bill_date in varchar2);

  ----ʡ�ڿ�ʡͳ��
  procedure SETL_DEPARTMENT_PROV_STAT(v_bill_date in varchar2);

  --�����������ʡһ��ͨ��˾����
  procedure SETL_PROV_OUTER_STAT(v_bill_date in varchar2);

  --���ؿ����������Ѻ�ʡһ��ͨ��˾����
  procedure SETL_PROV_INNER_STAT(v_bill_date in varchar2);

  --ͳ���굥
  --procedure SETL_DETAIL_STAT(v_bill_date in varchar2);

  --ͳ��ʡ���굥
  procedure SETL_CITY_DETAIL_STAT(v_bill_date in varchar2);

  --ͳ�ƿ�ʡ�굥
  procedure SETL_PROV_DETAIL_STAT(v_bill_date in varchar2);

  --����ÿ��LD
  procedure gen_city_ld_file(v_bill_date in varchar2);

  --����ÿ��BP�ļ�
  procedure gen_city_bp_file(v_bill_date in varchar2);

  --����ÿ��CR�ļ�
  procedure gen_city_cr_file(v_bill_date in varchar2);

  --����ʡ��AD�굥
  procedure GEN_CITY_AD_DETAIL(v_bill_date in varchar2);
  
  --����ÿ��AD�ļ�
  procedure gen_city_ad_file(v_bill_date in varchar2);
 
  --����ÿ��ED�ļ�
  procedure gen_city_ed_file(v_bill_date in varchar2);
  
  --����ÿ��CM�ļ�
  procedure gen_city_cm_file(v_bill_date in varchar2);

  ----��ʡAD�˵�����
  procedure ADJUST_SETT_AD_DETAIL(v_bill_date in varchar2);

  ----ʡ��AD�˵�����
  procedure ADJUST_SETT_CITY_AD_DETAIL(v_bill_date in varchar2);
  
  ----��������⴦��
  procedure PRO_BN_RECORD;
  
  ----����⴦��
  procedure PRO_ER_RECORD;
  
  ----��������⴦��
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



----ʡһ��ͨ�Ͳ�ƽ̨����
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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨�����Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_STAT', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_STAT', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_prov_stat where  sett_cycle=' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ����ʡͳ��
    v_sql := 'insert into sett_prov_stat(sett_cycle,sett_object,income_charge,outcome_charge,sett_charge)
              select sett_cycle,
                     sett_object,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     sum(sett_charge)/100
             from
             (
                  \*����=FB����-��������-�������*\
                  select '||v_bill_month||' sett_cycle,
                         ''�ຣʡһ��ͨ��˾'' sett_object ,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) income_charge,
                         0 outcome_charge,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) sett_charge
                  from sett_fb_' || v_bill_month || ' a where  a.err_code = ''000000''
                  union all
                  \*֧��=CL����-��������*\
                  select '||v_bill_month||' sett_cycle,
                         ''�ຣʡһ��ͨ��˾'' sett_object ,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.issue_charge),0) outcome_charge,
                         -nvl(sum(a.trade_charge-a.issue_charge),0) sett_charge
                  from sett_cl_' || v_bill_month || ' a where a.err_code = ''000000'')
              group by sett_cycle,sett_object';
    execute immediate v_sql;
    --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����'
    where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ʡͳ�����');

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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨�����Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_STAT', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_STAT', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    --v_sql:='delete from sett_prov_stat where  sett_cycle=' || v_bill_month;
    v_sql:='delete from sett_prov_stat ';
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ����ʡͳ��
    /*v_sql := 'insert into sett_prov_stat(sett_cycle,sett_object,income_charge,outcome_charge,sett_charge)
              select sett_cycle,
                     sett_object,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     sum(sett_charge)/100
             from
             (
                  \*����=FB����-��������-�������*\
                  select '||v_bill_month||' sett_cycle,
                         ''�ຣʡһ��ͨ��˾'' sett_object ,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) income_charge,
                         0 outcome_charge,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) sett_charge
                  from (select * from sett_fb_' || v_bill_month || ' union all 
                        select * from sett_fb_' || v_last_month || '
                        ) a where  a.err_code = ''000000'' and a.center_sett_date like '''||v_bill_month||'%'' 
                  union all
                  \*֧��=CL����-��������*\
                  select '||v_bill_month||' sett_cycle,
                         ''�ຣʡһ��ͨ��˾'' sett_object ,
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
                    where sett_object=''�ຣʡһ��ͨ��˾'' and sett_role=''�յ�'' 
                    group by substr(sett_date,0,6),sett_object
                    union all
                    select substr(sett_date,0,6) sett_cycle, 
                           a.sett_object sett_object,
                           0 income_charge,
                           sum(a.trade_charge-a.issue_charge) outcome_charge,
                           -sum(a.trade_charge-a.issue_charge) sett_charge from SETT_PROV_DAILY a 
                    where sett_object=''�ຣʡһ��ͨ��˾'' and sett_role=''����'' 
                    group by substr(sett_date,0,6),sett_object 
             
              ) group by sett_cycle,sett_object
             ';
    execute immediate v_sql;
    dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����'
    where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ʡͳ�����');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_STAT' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_STAT;


----ʡһ��ͨ�͵��н���
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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨�����Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_STAT', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_STAT', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_city_stat where  sett_cycle=' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ʡһ��ͨƽ̨�͵��н���
    v_sql := 'insert into sett_city_stat(sett_cycle,sett_object,income_charge,outcome_charge,sett_charge)
              select sett_cycle,
                     sett_object,
                     sum(income_charge)/100,
                     sum(outcome_charge)/100,
                     sum(sett_charge)/100
             from
             (
                  /*����=FB����-��������-������� CD��������*/
                  select '||v_bill_month||' sett_cycle,
                         b.org_name sett_object ,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) income_charge,
                         0 outcome_charge,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) sett_charge
                  from dr_bill_detail_' || v_bill_month || ' a,bps_sys_org_info b
                  where substr(a.recv_org_id,2,7) = b.org_code and a.sys_error_code = ''000000'' and a.file_type in (''1'',''2'') group by b.org_name
                  union all
                  /*����֧��=CL����-��������*/
                  select '||v_bill_month||' sett_cycle,
                         ''����ͨ����˾'' sett_object ,
                         0 income_charge,
                         round(nvl(sum(a.trade_charge-a.issue_fee),0)) outcome_charge,
                         -round(nvl(sum(a.trade_charge-a.issue_fee),0)) sett_charge
                  from dr_bill_detail_' || v_bill_month || ' a where a.sys_error_code = ''000000'' and a.issue_org_code = ''04558510'')
              group by sett_cycle,sett_object'; -- a.file_type = ''3'' and
    execute immediate v_sql;
    --dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����'
    where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ʡͳ�����');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='CITY_STAT' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_CITY_STAT;

----ʡһ��ͨ�Ͳ�ƽ̨���ս�����ϸ
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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨�����Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DAILY', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DAILY', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_prov_daily where  substr(sett_date,1,6) =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ����ʡͳ��
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
                      \*����=FB����-��������-�������*\
                      select 
                             --a.sett_date sett_date,
                             a.center_sett_date  sett_date,
                             ''�ຣʡһ��ͨ��˾'' sett_object ,
                             ''�յ�'' sett_role,
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
                      \*֧��=CL����-��������*\
                      select 
                           --a.sett_date sett_date,
                           a.center_sett_date  sett_date,
                             ''�ຣʡһ��ͨ��˾'' sett_object ,
                              ''����'' sett_role,
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
                      \*����=FB����-��������-�������*\
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
                               ''�յ�'' sett_role,
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
                      
                        \*֧��=CL����-��������*\
                        select a.center_sett_date  sett_date, -- a.sett_date sett_date,
                               b.org_name sett_object ,
                               ''����'' sett_role,
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����'
    where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ʡͳ�����');

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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨�����Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DAILY', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DAILY', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_prov_daily where  table_month =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ����ʡͳ��
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
                      /*����=FB����-��������-�������*/
                      select a.center_sett_date sett_date, -- a.sett_date sett_date,
                             ''�ຣʡһ��ͨ��˾'' sett_object ,
                             ''�յ�'' sett_role,
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
                      /*֧��=CL����-��������*/
                      select a.center_sett_date sett_date, -- a.sett_date sett_date,
                             ''�ຣʡһ��ͨ��˾'' sett_object ,
                              ''����'' sett_role,
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
                      /*����=FB����-��������-�������*/
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
                               ''�յ�'' sett_role,
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
                      
                        /*֧��=CL����-��������*/
                        select a.center_sett_date sett_date, -- a.sett_date sett_date,
                               b.org_name sett_object ,
                               ''����'' sett_role,
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����'
    where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ʡͳ�����');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_DAILY' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_DAILY;

----ʡһ��ͨ�͵��а��ս�����ϸ
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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨�����Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DAILY', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DAILY', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨����ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_city_daily where  substr(sett_date,1,6) =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ʡһ��ͨƽ̨�͵��а���ͳ��
    v_sql := 'insert into sett_city_daily(sett_date ,sett_object ,sett_role,trade_charge,service_charge,issue_charge,bill_charge,center_charge,times,sett_charge)
              /*����=FB����-��������-������� CD��������*/
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
                         ''�յ�'' sett_role,
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
                  /*����֧��=CL����-��������*/
                  select a.sett_date sett_date,
                         ''����ͨ����˾'' sett_object ,
                          ''����'' sett_role,
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡһ��ͨ�Ͳ�ƽ̨����ͳ�����'
    where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ʡͳ�����');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='CITY_DAILY' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_CITY_DAILY;

----ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ
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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ���ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ�Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ�ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ��ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_prov_detail where  substr(sett_date,1,6) =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ����ʡͳ��
    v_sql := 'insert into sett_prov_detail(sett_date,trade_type,issue_org_code ,bill_org_code ,card_no,before_trade_charge,trade_charge,trade_date,
                                           trade_time,service_charge,issue_charge,bill_charge ,center_charge,sett_charge)
                  \*����=FB����-��������-�������*\
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
                  \*֧��=CL����-��������*\
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ���'
    where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ���');

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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ���ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ�Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ�ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ��ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_prov_detail where  table_month =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ����ʡͳ��
    v_sql := 'insert into sett_prov_detail(sett_date,trade_type,issue_org_code ,bill_org_code ,card_no,before_trade_charge,trade_charge,trade_date,
                                           trade_time,service_charge,issue_charge,bill_charge ,center_charge,sett_charge,table_month) 
                  /*����=FB����-��������-�������*/
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
                  /*֧��=CL����-��������*/
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ���'
    where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ���');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='PROV_DETAIL' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_DETAIL;




----ʡһ��ͨ�͵��н����굥չʾ
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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ���ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ�Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DETAIL', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ�ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DETAIL', v_bill_month, 2, proc_time, 'ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ��ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_city_detail where  substr(sett_date,1,6) =' || v_bill_month;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ʡһ��ͨƽ̨�͵��н����굥��ϸ
    v_sql := 'insert into sett_city_detail(sett_date,trade_type,issue_org_code ,bill_org_code ,card_no,before_trade_charge,trade_charge,trade_date,
                                           trade_time,service_charge,issue_charge,bill_charge ,center_charge,sett_charge,SETT_ORG_CODE,roam_type)
              /*����=FB����-��������-������� CD��������*/
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
                  /*����֧��=CL����-��������*/
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ���'
    where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('ʡһ��ͨ�Ͳ�ƽ̨��ʡ�굥չʾ���');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='CITY_DETAIL' and sett_date=v_bill_month and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_CITY_DETAIL;










  ----����ʡͳ��  ������ʹ�ã�
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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='01' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ʡͳ��ҵ��ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='01' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ʡͳ���Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='01' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('01', v_bill_date, 2, proc_time, '����ʡͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('01', v_bill_date, 2, proc_time, '����ʡͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_stat_report where sett_type=''01'' and sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ����ʡͳ��
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
                  /*����=FB����-��������-�������*/
                  select ''01'' sett_type ,
                         a.sett_date sett_date,
                         ''00000000'' org_code ,
                         ''����������'' org_name ,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) income_charge,
                         0 outcome_charge,
                         ''��ʡʡ�Ͳ�����'' note,
                         nvl(sum(a.trade_charge-a.sett_charge+a.bill_charge),0) offset_balance
                  from sett_fb_' || v_month || ' a where a.sett_date = ' || v_bill_date || ' and a.err_code = ''000000'' group by a.sett_date
                  union all
                  /*֧��=CL����-��������*/
                  select ''01'' sett_type,
                         a.sett_date sett_date,
                         ''00000000'' org_code,
                         ''����������'' org_name,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.issue_charge),0) outcome_charge,
                         ''��ʡʡ�Ͳ�����'' note,
                         -nvl(sum(a.trade_charge-a.issue_charge),0) offset_balance
                  from sett_cl_' || v_month || ' a where a.sett_date = ' || v_bill_date || '  and a.err_code = ''000000''
                  group by a.sett_date)
              group by sett_type,sett_date,org_code,org_name,note';
    execute immediate v_sql;
    dbms_output.put_line('v_sql='||v_sql);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='����ʡͳ�����'
    where sett_type='01' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ʡͳ�����');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='01' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_DEPARTMENT_STAT;

  --��ʡʡ��ͳ�� ������ʹ�ã�
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

    --- ��鵱ǰ���ڣ���ʡʡ��ͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='02' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('��ʡʡ��ͳ��ҵ��ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ���ʡʡ��ͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='02' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('��ʡʡ��ͳ���Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='02' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('02', v_bill_date, 2, proc_time, '��ʡʡ��ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('02', v_bill_date, 2, proc_time, '��ʡʡ��ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_stat_report where sett_type=''02'' and sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ��ʡʡ��ͳ��
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
                 /*��������=FB����-������*/
                 select ''02'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.recv_org_id,2,7) org_code ,
                         '''' org_name ,
                         nvl(sum(a.trade_charge-a.service_fee),0) income_charge,
                         0 outcome_charge,
                         ''��ʡʡ��ʡ�ڽ���'' note,
                         nvl(sum(a.trade_charge-a.service_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.file_type = 2 and a.sys_error_code = ''000000'' and
                  a.sett_date = ' || v_bill_date|| ' group by a.sett_date,a.recv_org_id
                  union all
                  /*����֧��=CL����*/
                  select ''02'' sett_type,
                         a.sett_date sett_date,
                         substr(a.issue_org_code,2,7) org_code,
                         '''' org_name,
                         0 income_charge,
                         nvl(sum(a.trade_charge),0) outcome_charge,
                         ''��ʡʡ��ʡ�ڽ���'' note,
                         -nvl(sum(a.trade_charge),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.file_type = 3 and
                  a.sett_date = ' || v_bill_date|| ' and a.issue_org_code = ''04558510'' and a.sys_error_code = ''000000''
                  group by a.sett_date ,a.issue_org_code
                  union all
                  /*ʡƽ̨����=FB�����յ�����*/
                  select ''02'' sett_type ,
                         a.sett_date sett_date,
                         ''30138500'' org_code ,
                         ''�ຣʡһ��ͨ��˾'' org_name ,
                         nvl(sum(a.other_fee),0) income_charge,
                         0 outcome_charge,
                         ''��ʡʡ��ʡ�ڽ���'' note,
                         nvl(sum(a.other_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where  a.file_type = 2 and a.sys_error_code = ''000000'' and
                  a.sett_date = ' || v_bill_date|| ' group by a.sett_date
                  union all
                  /*ʡƽ̨����=����CL��������*/
                  select ''02'' sett_type,
                         a.sett_date sett_date,
                         ''30138500'' org_code ,
                         ''�ຣʡһ��ͨ��˾'' org_name ,
                         nvl(sum(a.other_fee),0) income_charge,
                         0 outcome_charge,
                         ''��ʡʡ��ʡ�ڽ���'' note,
                         nvl(sum(a.other_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.file_type = 3 and
                  a.sett_date = ' || v_bill_date|| ' and a.issue_org_code = ''04558510'' and a.sys_error_code = ''000000''
                  group by a.sett_date
                  union all
                  /*ʡƽ̨֧��=��������CL����-�յ�����-�������ķ���*/
                  select ''02'' sett_type,
                         a.sett_date sett_date,
                         ''30138500'' org_code ,
                         ''�ຣʡһ��ͨ��˾'' org_name ,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.service_fee+a.issue_fee),0) outcome_charge,
                         ''��ʡʡ��ʡ�ڽ���'' note,
                         -nvl(sum(a.trade_charge-a.service_fee+a.issue_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.file_type = 3 and
                  a.sett_date = ' || v_bill_date|| ' and a.issue_org_code != ''04558510'' and a.sys_error_code = ''000000''
                  group by a.sett_date
             )
             group by sett_type,sett_date,org_code,org_name,note';
    execute immediate v_sql;

    dbms_output.put_line('v_sql='||v_sql);
    update sett_stat_report a set a.org_name = (select b.org_name from bps_sys_org_info b where  a.org_code  = b.org_code) where a.sett_type = '02';
    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='��ʡʡ��ͳ�����'
    where sett_type='02' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('��ʡʡ��ͳ�����');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='02' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_DEPARTMENT_PROV_STAT;

  --�����������ʡ���������к�ʡһ��ͨ��˾����  ������ʹ�ã�
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

    --- ��鵱ǰ���ڣ���ʡʡ��ͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='03' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('��ʡʡ��ͳ��ҵ��ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ���ʡʡ��ͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='03' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('��ʡʡ��ͳ���Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='03' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('03', v_bill_date, 2, proc_time, '��ʡʡ��ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('03', v_bill_date, 2, proc_time, '��ʡʡ��ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_stat_report where sett_type=''03'' and sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- �����������ʡ���������к�ʡһ��ͨ��˾����
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
                 /*����֧��=dr_bill����-��������*/
                 select ''03'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.issue_org_code,2,7) org_code ,
                        '''' org_name ,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.issue_fee),0) outcome_charge,
                         ''�����ʡ�͵��н���'' note,
                         -nvl(sum(a.trade_charge-a.issue_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where
                  a.sett_date = ' || v_bill_date || ' and
                  a.issue_org_code = ''04558510'' and a.sys_error_code = ''000000'' and a.file_type = ''1''
                  group by a.sett_date,a.issue_org_code
                  union all
                  /*��������=dr_bill����-������+�յ�����*/
                  select ''03'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.recv_org_id,2,7) org_code ,
                         '''' org_name ,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) income_charge,
                         0 outcome_charge,
                         ''�����ʡ�͵��н���'' note,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where
                  a.sett_date = ' || v_bill_date || ' and
                  a.recv_org_id = ''14558510'' and a.sys_error_code = ''000000'' and a.file_type = ''1''
                  group by a.sett_date,a.recv_org_id
                  union all
                  /*��������������������=FB�����յ�����*/
                  select ''03'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.recv_org_id,2,7) org_code ,
                         '''' org_name ,
                         0 income_charge,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) outcome_charge,
                         ''�����ʡ�͵��н���'' note,
                         -nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0) offset_balance
                  from dr_bill_detail_' || v_month|| ' a where a.sett_date = ' || v_bill_date || ' and
                  a.issue_org_code = ''04558510'' and a.sys_error_code = ''000000'' and a.file_type = ''1''
                  group by a.sett_date,a.recv_org_id
             )
             group by sett_type,sett_date,org_code,org_name,note';
    execute immediate v_sql;

    dbms_output.put_line('v_sql='||v_sql);

    update sett_stat_report a set a.org_name = (select b.org_name from bps_sys_org_info b where a.org_code = b.org_code) where a.sett_type = '03';


    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='��ʡʡ��ͳ�����'
    where sett_type='03' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('��ʡʡ��ͳ�����');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='03' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_OUTER_STAT;

  --���ؿ����������Ѻ�ʡһ��ͨ��˾���� ������ʹ�ã�
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

    --- ��鵱ǰ���ڣ����ؿ����������Ѻ�ʡһ��ͨ��˾���� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='04' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('���ؿ����������Ѻ�ʡһ��ͨ��˾�������ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ����ؿ����������Ѻ�ʡһ��ͨ��˾���� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='04' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('���ؿ����������Ѻ�ʡһ��ͨ��˾�����Ѿ�ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='04' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('04', v_bill_date, 2, proc_time, '���ؿ����������Ѻ�ʡһ��ͨ��˾�����ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('04', v_bill_date, 2, proc_time, '���ؿ����������Ѻ�ʡһ��ͨ��˾���㿪ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_stat_report where sett_type=''04'' and sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    --- ���ؿ����������Ѻ�ʡһ��ͨ��˾����
    v_sql := 'insert into sett_stat_report(SETT_TYPE,SETT_DATE,ORG_CODE,ORG_NAME,INCOME_CHARGE,OUTCOME_CHARGE,NOTE,OFFSET_BALANCE)
              select ''04'' sett_type ,
                         a.sett_date sett_date,
                         substr(a.recv_org_id,2,7) org_code ,
                         '''' org_name ,
                         nvl(sum(a.trade_charge-a.service_fee+a.bill_fee),0)/100 income_charge,
                         0 outcome_charge,
                         ''��ʡʡ�͵��н���'' note,
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='���ؿ����������Ѻ�ʡһ��ͨ��˾�������'
    where sett_type='04' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('���ؿ����������Ѻ�ʡһ��ͨ��˾�������');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='04' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_PROV_INNER_STAT;


 --ͳ���굥
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

    --- ��鵱ǰ���ڣ��굥ͳ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='05' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('�굥ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ��굥ͳ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='05' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('�굥ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='05' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('05', v_bill_date, 2, proc_time, '�굥ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('05', v_bill_date, 2, proc_time, '�굥ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    -----
    v_sql:='delete from sett_stat_detail where sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---
    v_sql := 'insert into sett_stat_detail
              -----��ʡFB
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
               -----��ʡCL
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
               -----ʡ�ڣ�������ʡ������С������У�
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='�굥ͳ�����'
    where sett_type='05' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('�굥ͳ�����');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='05' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_DETAIL_STAT;
 */

 /*ͳ������ʡ���굥 ������ʹ�ã�*/
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

    --- ��鵱ǰ���ڣ�ʡ���굥ͳ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡ���굥ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�ʡ���굥ͳ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡ���굥ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DETAIL', v_bill_date, 2, proc_time, 'ʡ���굥ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_DETAIL', v_bill_date, 2, proc_time, 'ʡ���굥ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
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
               --FBʡ���յ������յ���������
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
               --CL����������֧��
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
               --ʡ�ڷ������� ����֧��
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
               --ʡ�ڷ��������������յ���������
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='ʡ���굥ͳ�����'
    where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('ʡ���굥ͳ�����');

  EXCEPTION when others then
    v_sqlerrm := SQLERRM;
    update SETT_STAT_LOG set sts = 3,END_DATE=sysdate, note=substr(v_sqlerrm || '['||v_sql||']',0,ERR_MSG_LEN)
    where sett_type='CITY_DETAIL' and sett_date=v_bill_date and sts=2 and process_time=proc_time;
    commit;
    dbms_output.put_line(v_sqlerrm || '['||v_sql||']' );
    rollback;
  end SETL_CITY_DETAIL_STAT;

  --��ʡ�굥 ������ʹ�ã�
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

    --- ��鵱ǰ���ڣ���ʡ�굥ͳ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('��ʡ�굥ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ���ʡ�굥ͳ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('��ʡ�굥ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='PROV_DETAIL' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_date, 2, proc_time, '��ʡ�굥ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('PROV_DETAIL', v_bill_date, 2, proc_time, '��ʡ�굥ͳ�ƿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
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
                      ''00000000'', -- substr(a.bill_org_id,2,7), --- �յ���������
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

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='��ʡ�굥ͳ�����'
    where sett_type='PROV_DETAIL' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('��ʡ�굥ͳ�����');

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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ld' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��LD�ļ��������ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ld' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��LD�ļ�������ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='gen_ld' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ld', v_bill_date, 2, proc_time, '����ͳ��LD�ļ����ݴ�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ld', v_bill_date, 2, proc_time, '����ͳ��LD�ļ����ݿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    delete from SETT_STAT_DAILY_LD where sett_date=v_bill_date;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---- 2. ��ȡ�ļ����к�
    select CITY_LD_FILE_SEQ.Nextval into v_seqence from dual;

    ---- 3. �����ļ���¼������

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
            ---- �����ѯ�����ǵ������һ�죬 ��Ҫ��ѯ�¸��µ���־���������ⲿ���߼���
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

              ---- 5. �����ļ���substr(v_bill_date,1,6)
              v_ld_filename := 'LD' || substr(v_bill_date, 3,6) || '000000'
                               || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'A';
              insert into SETT_STAT_DAILY_LD
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('0', v_ld_filename, v_bill_date, sysdate, v_org_code);

              ---- �ļ�ͷ


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


    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='����ͳ��LD�ļ�����ͳ�����'
    where sett_type='gen_ld' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ͳ��LD�ļ�����ͳ�����');

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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_bp' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��BP�ļ��������ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_bp' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��BP�ļ�������ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='gen_bp' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_bp', v_bill_date, 2, proc_time, '����ͳ��BP�ļ����ݴ�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_bp', v_bill_date, 2, proc_time, '����ͳ��BP�ļ����ݿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    delete from SETT_STAT_DAILY_BP where sett_date=v_bill_date;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---- 2. ��ȡ�ļ����к�
    select CITY_BP_FILE_SEQ.Nextval into v_seqence from dual;

    ---- 3. �����ļ���¼������

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
                   -----������λû���ж�
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


              ---- 5. �����ļ��� substr(to_char(sysdate,'yyyymmddhh24miss'), 3,12)
              v_bp_filename := 'BP' || substr(v_bill_date, 3,6) || '000000'
                               || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'A';
              insert into SETT_STAT_DAILY_BP
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('0', v_bp_filename, v_bill_date, sysdate, v_org_code);

              ---- �ļ�ͷ


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


    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='����ͳ��BP�ļ�����ͳ�����'
    where sett_type='gen_bp' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ͳ��BP�ļ�����ͳ�����');

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

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_cr' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��CR�ļ��������ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�����ʡͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_cr' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��CR�ļ�������ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='gen_cr' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_cr', v_bill_date, 2, proc_time, '����ͳ��CR�ļ����ݴ�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_cr', v_bill_date, 2, proc_time, '����ͳ��CR�ļ����ݿ�ʼ����....');
        commit;
    end if;


    --dbms_output.put_line('v_month='||v_month);
    ---- 1.�����ϴε��м������
    delete from SETT_STAT_DAILY_CR where sett_date=v_bill_date;
    commit;
    --dbms_output.put_line('v_sql='||v_sql);

    ---- 2. ��ȡ�ļ����к�
    select CITY_CR_FILE_SEQ.Nextval into v_seqence from dual;

    ---- 3. �����ļ���¼������

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
          select a.recv_org_id     ,-- "�յ�������ʶ"     ���׵ķ�����
                 a.bill_org_code   ,-- "�������������ʶ" �����صĶ�����λ
                 a.issue_org_code  ,-- "������������"     ������
                 a.recv_org_id     send_org_id,-- "���ͻ�����ʶ��"   ���׷����صĶ�����λ
                 decode(a.trade_code,''362'',''8451'', ''300'', ''8451'', ''368'', ''8460'', ''370'', ''8460'', ''401'', ''8401'') busi_type, --"ҵ������"
                 0 adjust_flag     ,-- "��������ʶ"
                 ''000000'' sys_error_code  ,
                 ''SUCESS'' sys_error_msg   ,
                 count(*) total_count,
                 sum(a.trade_charge) total_trade_charge,
                 sum(a.bill_fee) recv_org_fee, --- ���׵�������
                 0 err_fee, --- ���������
                 sum(a.issue_fee) issue_org_fee, -- ������������
                 sum(a.service_fee-a.bill_fee-a.issue_fee) prov_org_fee, -- ��ֽ������������
                 0 test_flag  -- ���Ա�־
          from dr_bill_detail_' || v_month || ' a where a.issue_org_code=''0' || v_org_code ||''' or a.recv_org_id=''1' || v_org_code ||'''
          group by recv_org_id, bill_org_code,issue_org_code,recv_org_id,
                   decode(a.trade_code,''362'',''8451'', ''300'', ''8451'', ''368'', ''8460'', ''370'', ''8460'', ''401'', ''8401''),
                   sys_error_code, sys_error_msg
                   ) b
            ';
            execute immediate v_sql;

            ---- 1. ���ɼ�¼������
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
            v_rowcount := sql%rowcount; -- ������ݼ�¼����


            ---- 2. ����ͷ��¼
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



              ---- 3. �����ļ���substr(to_char(sysdate,'yyyymmddhh24miss'), 3,12)
              v_CR_filename := 'CR' || substr(v_bill_date, 3,6) || '000000'
                               || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'A';
              insert into SETT_STAT_DAILY_CR
              ( record_type, record_context, sett_date, process_time, org_code )
              values
              ('0', v_CR_filename, v_bill_date, sysdate, v_org_code);



    end loop;
    close cur_org_list ;


    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='����ͳ��CR�ļ�����ͳ�����'
    where sett_type='gen_cr' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ͳ��CR�ļ�����ͳ�����');

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

    --- ��鵱ǰ���ڣ�ʡ���굥ͳ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_AD_DETAIL' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡ��AD�굥ͳ�����ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�ʡ���굥ͳ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='CITY_AD_DETAIL' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('ʡ��AD�굥ͳ����ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='CITY_AD_DETAIL' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_AD_DETAIL', v_bill_date, 2, proc_time, 'ʡ��AD�굥ͳ���ش�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('CITY_AD_DETAIL', v_bill_date, 2, proc_time, 'ʡ��AD�굥ͳ�ƿ�ʼ����....');
        commit;
    end if;

    ---- 1.�����ϴε��м������
    v_sql:='delete from sett_city_ad_detail where sett_date=' || v_bill_date;
    execute immediate v_sql;
    commit;

   ---- 2.�������ݱ�
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

   ---- 2.������ˮ�ţ��������
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
     update SETT_CITY_AD_DETAIL set error_code='20008', error_info ='��ԭ������Ϣ�����', err_charge =0,
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
     set sett_adjust_org_no= v_seqence,error_code='0', error_info ='�ɹ�����', err_charge = v_adjusted_trade_charge*0.01,
     sett_charge =  v_sett_charge,  issue_charge =  v_issue_charge, bill_charge =  v_bill_charge
     where current of ad_cursor;
   end if;

   end loop;
   close ad_cursor;--�ر��α�

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

    --- ��鵱ǰ���ڣ�ADͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ad' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��AD�ļ��������ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�ADͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ad' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��AD�ļ�������ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='gen_ad' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ad', v_bill_date, 2, proc_time, '����ͳ��AD�ļ����ݴ�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ad', v_bill_date, 2, proc_time, '����ͳ��AD�ļ����ݿ�ʼ����....');
        commit;
    end if;

    ---- 1.�����ϴε��м������
    delete from SETT_STAT_DAILY_AD where sett_date=v_bill_date;
    commit;

    ---- 2. ��ȡ�ļ����к�
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
    ---- 1. ���ɼ�¼������
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
          v_rowcount := sql%rowcount; -- ������ݼ�¼����

    ---- 2. ����ͷ��¼
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

    ---- 3. �����ļ���
    v_AD_filename := 'AD' || substr(v_bill_date, 3,6) || '000000'
                     || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'A';
    insert into SETT_STAT_DAILY_AD
    ( record_type, record_context, sett_date, process_time, org_code )
    values
    ('0', v_AD_filename, v_bill_date, sysdate, v_org_code);

    end loop;
    close cur_org_list ;

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='����ͳ��AD�ļ�����ͳ�����'
    where sett_type='gen_ad' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ͳ��AD�ļ�����ͳ�����');

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

    --- ��鵱ǰ���ڣ�EDͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ed' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��ED�ļ��������ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�EDͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_ed' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��ED�ļ�������ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='gen_ed' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ed', v_bill_date, 2, proc_time, '����ͳ��ED�ļ����ݴ�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_ed', v_bill_date, 2, proc_time, '����ͳ��ED�ļ����ݿ�ʼ����....');
        commit;
    end if;

    ---- 1.�����ϴε��м������
    delete from SETT_STAT_DAILY_ED where sett_date=v_bill_date;
    commit;

    ---- 2. ��ȡ�ļ����к�
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

      ---- 1. ���ɼ�¼������
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
        v_rowcount := sql%rowcount; -- ������ݼ�¼����

        ---- 2. ����ͷ��¼
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

        ---- 3. �����ļ���
        v_ED_filename := 'ED' || substr(v_bill_date, 3,6) || '000000'
                         || '1' ||v_org_code || lpad(v_seqence,10,'0') || 'H';
        insert into SETT_STAT_DAILY_ED
        ( record_type, record_context, sett_date, process_time, org_code )
        values
        ('0', v_ED_filename, v_bill_date, sysdate, v_org_code);

    end loop;
    close cur_org_list ;

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='����ͳ��ED�ļ�����ͳ�����'
    where sett_type='gen_ed' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ͳ��ED�ļ�����ͳ�����');

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
    v_org_code := '00000000'; --- ��ʡ��������Ҫ������������Ĳ����ⷢ

    --- ��鵱ǰ���ڣ�CMͳ�� ҵ���Ƿ����ڴ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_cm' and sett_date=v_bill_date and sts=2;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��cm�ļ��������ڴ�����');
        return;
    end if;

    proc_time := sysdate;

    --- ��鵱ǰ���ڣ�cmͳ�� ҵ���Ƿ��Ѿ�ͳ�����
    select count(*) into v_cnt from SETT_STAT_LOG where sett_type='gen_cm' and sett_date=v_bill_date and sts=1;
    if( v_cnt > 0 ) then
        dbms_output.put_line('����ͳ��CM�ļ�������ɣ���ʼ�ش���...');

        delete from SETT_STAT_LOG where sett_type='gen_cm' and sett_date=v_bill_date and sts=1;
        commit;

        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_cm', v_bill_date, 2, proc_time, '����ͳ��CM�ļ����ݴ�����..., ��ȴ�.');
        commit;
    else
        insert into SETT_STAT_LOG (sett_type,sett_date,STS,PROCESS_TIME,NOTE)
        values ('gen_cm', v_bill_date, 2, proc_time, '����ͳ��CM�ļ����ݿ�ʼ����....');
        commit;
    end if;

    ---- 1.�����ϴε��м������
    delete from SETT_STAT_DAILY_CM where sett_date=v_bill_date;
    commit;

    ---- 2. ��ȡ�ļ����к�
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

    ---- 1. ���ɼ�¼������
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
      v_rowcount := sql%rowcount; -- ������ݼ�¼����

        ---- 2. ����ͷ��¼
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

        ---- 3. �����ļ���
        v_CM_filename := 'CM' || substr(v_bill_date, 3,6) || '000000'
                         ||v_org_code || lpad(v_seqence,10,'0') || 'H';
        insert into SETT_STAT_DAILY_CM
        ( record_type, record_context, sett_date, process_time, org_code )
        values
        ('0', v_CM_filename, v_bill_date, sysdate, v_org_code);

    update SETT_STAT_LOG set sts = 1, END_DATE=sysdate , note='����ͳ��CM�ļ�����ͳ�����'
    where sett_type='gen_cm' and sett_date=v_bill_date and sts=2 and PROCESS_TIME=proc_time;
    commit;
    dbms_output.put_line('����ͳ��CM�ļ�����ͳ�����');

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
    close ad_cursor;--�ر��α�

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
    close ad_cursor;--�ر��α�

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
      dbms_output.put_line('���α�');
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
      close bn_cursor;--�ر��α�
     dbms_output.put_line('�ر��α�');
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

     close er_cursor;--�ر��α�

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
