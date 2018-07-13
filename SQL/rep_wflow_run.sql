--当天调度时长
SELECT to_char(t.start_time, 'YY-MM-DD') AS "日期"
       ,t.subject_area AS "主题区域"
       ,to_char(MIN(t.start_time), 'HH24:MI:SS') AS "最早启动"
       ,to_char(MAX(t.end_time), 'HH24:MI:SS') AS "最迟结束" 
       ,lpad(to_char(trunc((MAX(t.end_time) - MIN(t.start_time)) * 24, 0)),2 ,'0') || 'h' ||
       lpad(to_char(round(MOD((MAX(t.end_time) - MIN(t.start_time)) * 24 * 60, 60))), 2, '0') ||
       'min' AS "持续时间"
FROM   rep_wflow_run t
WHERE  1 = 1
       AND t.start_time >= trunc(SYSDATE, 'DD')
       AND t.user_name = 'Administrator'
GROUP  BY to_char(t.start_time, 'YY-MM-DD'), t.subject_area
ORDER  BY 1, 2;

--当天工作流异常
SELECT t.subject_area
      ,t.workflow_name
      ,t.user_name
      ,t.start_time
      ,t.end_time
      ,decode(t.run_status_code, 1, 'Succeeded', 2, 'Disabled', 3, 'Failed', 4, 'Stopped', 5, 'Aborted', 6, 'Running', 15, 'Terminated') AS run_status
      ,decode(t.run_type, 1, 'Scheduler', 2, 'User request', 3, 'Debug session', 4, 'Server initialization', 5, 'Remote task', 6, 'Remote debug session') AS run_type
FROM   rep_wflow_run t
WHERE  1 = 1
       AND t.start_time >= trunc(SYSDATE, 'DD')
       AND t.run_status_code <> 1;
