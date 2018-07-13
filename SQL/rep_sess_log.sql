--会话异常
SELECT t.subject_area
      ,t.workflow_name
      ,t.mapping_name
      ,t.session_name 
      ,t.first_error_msg
      ,t.run_status_code
      ,t.actual_start
      ,t.session_timestamp
      ,t.total_err
FROM   rep_sess_log t
WHERE  1 = 1
       AND t.actual_start >= trunc(SYSDATE, 'DD')
       AND t.first_error_code <> 0
