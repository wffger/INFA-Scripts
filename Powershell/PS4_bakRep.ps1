############################### 
# (C) 2017 wffger 
# https://github.com/wffger
# 此脚本每天备份存储库
# 
############################### 
Write-Host "配置参数..."
##
$today = Get-date 
$trgFldr = "/u01/app/Informatica/10.1.0/server/infa_shared/Backup/"
$fileNm = "INFA_"+$today.ToString('yyyyMMdd')+".rep"
$fileNm = $trgFldr+$fileNm
$Desc   = "备份由主机"+$env:computername+"上的脚本创建"
##使用环境变量连接
##密码已加密并赋值系统环境变量PMPASS
pmrep connect -r Dsl_BI_DW_Base_Prod -n Administrator -X PMPASS -d Domain_BIDW_Prod
pmrep backup -f -b -j -q -o $fileNm -d $Desc

$null = [System.Console]::ReadKey()