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
