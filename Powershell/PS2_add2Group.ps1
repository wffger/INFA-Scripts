############################### 
# (C) 2017 wffger 
# https://github.com/wffger
# 此脚本根据传入文件路径参数
# 批量添加用户到组
############################### 

#读入文件路径，存储内容
param($a,$b)
$data_xml=[xml](Get-Content $a)
$data_csv=Import-Csv $b

#判断是否已经安装客户端，并设置别名
if (-not (test-path "C:\Informatica\10.1.0\clients\DeveloperClient\infacmd")) 
{throw "C:\Informatica\10.1.0\clients\DeveloperClient\infacmd 找不到，请安装INFA开发客户端！"} 
Set-Alias infacmd "C:\Informatica\10.1.0\clients\DeveloperClient\infacmd\infacmd.bat" 

$dn=$data_xml.server.dn
$un=$data_xml.server.un
$pd=$data_xml.server.pd
$sdn=$data_xml.server.sdn
$cmd="& infacmd isp AddUserToGroup -dn $dn -un $un -pd $pd -sdn $sdn "

infacmd updateGatewayInfo -dn Domain_BIDW -dg biapptst:6005

for ($i=0;$i -le $data_csv.length-1;$i++){
    $existing_user_Name= $data_csv.existing_user_Name[$i]
    $group_name= $data_csv.group_name[$i] 
    $cl=" "
    if (![string]::IsNullOrEmpty($existing_user_Name) -and ![string]::IsNullOrEmpty($group_name)) 
    {
        $cl=$cl+"-eu $existing_user_Name -gn $group_name"
        $cl=$cmd + $cl
        Invoke-Expression $cl
        Write-Host "${existing_user_Name}已添加到${group_name}。" 
    } 
    else {
        "第${i}行数据不完整！"
    }  
}

###############################
Write-Host "完成，按任意键结束..."
$null = [System.Console]::ReadKey()