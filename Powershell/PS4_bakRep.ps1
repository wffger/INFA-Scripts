############################### 
# (C) 2017 wffger 
# https://github.com/wffger
# 此脚本每天备份存储库
# 
############################### 

#读入配置文件
param($a)
$data_xml=[xml](Get-Content $a) 

$dn=$data_xml.server.dn
$un=$data_xml.server.un
$pd=$data_xml.server.pd
$sdn=$data_xml.server.sdn
$rn=$data_xml.server.rn

Write-Host "配置参数..."
##
$today = Get-date 
$trgFldr = "/u01/app/Informatica/10.1.0/server/infa_shared/Backup/"
$fileNm = "INFA_"+$today.ToString('yyyyMMdd')+".rep"
$fileNm = $trgFldr+$fileNm
$Desc   = "备份由主机"+$env:computername+"上的脚本创建"
##创建连接
pmrep connect -r $rn -n $un -x $pd -d $dn
pmrep backup -f -b -j -q -o $fileNm -d $Desc

$null = [System.Console]::ReadKey()