############################### 
# (C) 2017 wffger 
# https://github.com/wffger
# 此脚本根据传入文件路径参数
# 批量创建INFA用户
############################### 

#读入配置文件，源文件
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
$cmd="& infacmd isp CreateUser -dn $dn -un $un -pd $pd -sdn $sdn "
 
for ($i=0;$i -le $data_csv.length-1;$i++){
    $user_name= $data_csv.new_user_name[$i]
    $user_password= $data_csv.new_user_password[$i]
    $user_full_name= $data_csv.new_user_full_name[$i]
    $user_description= $data_csv.new_user_description[$i]
    $user_email_address= $data_csv.new_user_email_address[$i]
    $user_phone_number= $data_csv.new_user_phone_number[$i]

    $cl=" "

    if (![string]::IsNullOrEmpty($user_name)) {$cl=$cl+"-nu $user_name "}
    if (![string]::IsNullOrEmpty($user_password)) {$cl=$cl+"-np $user_password "}
    if (![string]::IsNullOrEmpty($user_full_name)) {$cl=$cl+"-nf $user_full_name "}
    if (![string]::IsNullOrEmpty($user_description)) {$cl=$cl+"-ds $user_description "}
    if (![string]::IsNullOrEmpty($user_email_address)) {$cl=$cl+"-em $user_email_address "}
    if (![string]::IsNullOrEmpty($user_phone_number)) {$cl=$cl+"-pn $user_phone_number "}

    $cl = $cmd + $cl
    Invoke-Expression $cl
    Write-Host "${user_name} 用户已创建。" 
}

###############################
Write-Host "完成，按任意键结束..."
$null = [System.Console]::ReadKey()