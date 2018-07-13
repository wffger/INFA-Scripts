--会话异常
SELECT t.subject_area AS "主题区域"
      ,t.workflow_name AS "工作流"
      ,t.mapping_name AS "映射"
      ,t.session_name AS "会话"
      ,t.first_error_msg AS "首个错误"
      ,decode(t.run_status_code, 1, 'Suceeded', 2, 'Disabled', 3, 'Failed', 4, 'Stopped', 5, 'Aborted', 
      6, 'Running', 7, 'Suspending', 8, 'Suspended', 9, 'Stopping', 10, 'Aborting', 11, 'Waiting', 
      12, 'Scheduled', 13, 'Unscheduled', 14, 'Unknown', 15, 'Terminated') AS "运行状态"
      ,t.actual_start AS "实际开始实际"
      ,t.session_timestamp AS "会话时间戳"
      ,t.total_err AS "错误总数"
FROM   rep_sess_log t
WHERE  1 = 1
       AND t.actual_start >= trunc(SYSDATE, 'DD')
       AND t.first_error_code <> 0
