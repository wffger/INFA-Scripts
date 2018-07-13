--当天任务异常
SELECT t.subject_area
      ,t.workflow_name
      ,t.task_name
      ,decode(t.run_status_code, 1, 'Succeeded', 2, 'Disabled', 3, 'Failed', 4, 'Stopped', 5, 'Aborted', 6, 'Running', 15, 'Terminated') AS run_status
      ,t.start_time
      ,t.run_err_code
      ,t.run_err_msg
FROM   rep_task_inst_run t
WHERE  1 = 1
       AND t.start_time >= trunc(SYSDATE, 'DD')
       AND t.run_status_code <> 1;
