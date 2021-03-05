@echo off
color F0
mode con cols=58 lines=30
title=TWRP一键移植工具:By:Coolapk@SKDushow
:home
echo Coolapk@SKDushow
echo 版本V2,这是第二个版本
echo TWRP一键移植工具,仅支持高通联发科
echo 请把你机型的RECOVERY命名为官方recovery.img
echo 把你要移植的TWRP命名为移植recovery.img
echo 把这两个文件放置到文件根目录
echo 确保两个TWRP是同SOC
echo 输入1，开始自动移植
echo 输入2，开机状态刷入移植后的TWRP
echo 输入3，fastboot状态刷入移植后的TWRP
echo 输入4，twrp部分bug修复
set /p twrp=输入数字选择对应的操作:
if "%twrp%"=="1" goto auto_port
if "%twrp%"=="2" goto flash_power
if "%twrp%"=="3" goto flash_fb
if "%twrp%"=="4" goto twrp_fix
goto home
pause
:auto_port
if not exist 官方recovery.img (echo.
echo 未发现官方recovery.img,即将返回主菜单
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist 官方recovery (rd /s /q 官方recovery)
echo 正在解包recovery.img......
md 官方recovery
copy 官方recovery.img 官方recovery\boot.img>NUL
cd 官方recovery
..\tools\bootimg.exe --unpack-bootimg
cd ..
if not exist 移植recovery.img (echo.
echo 未发现移植recovery.img,即将返回主菜单
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist 移植recovery (rd /s /q 移植recovery)
echo 正在解包recovery.img......
md 移植recovery
copy 移植recovery.img 移植recovery\boot.img>NUL
cd 移植recovery
..\tools\bootimg.exe --unpack-bootimg
cd ..
del 移植recovery\kernel
del 移植recovery\kernel.gz
del 移植recovery\initrd\default.prop
del 移植recovery\initrd\etc\recovery.fstab
del 移植recovery\initrd\res\keys
copy 官方recovery\kernel 移植recovery
copy 官方recovery\kernel.gz 移植recovery
copy 官方recovery\initrd\default.prop 移植recovery\initrd\
copy 官方recovery\initrd\etc\recovery.fstab 移植recovery\initrd\etc\
copy 官方recovery\initrd\res\keys 移植recovery\initrd\res\
cd 移植recovery
..\tools\bootimg.exe --repack-bootimg
rename boot-new.img twrp.img
cd ..
copy 移植recovery\twrp.img 移植完成
copy 官方recovery.img recovery备份
copy 移植recovery.img recovery备份
del 移植recovery.img
del 官方recovery.img
rd/s/q 移植recovery
rd/s/q 官方recovery
echo 移植完成，移植完成目录下是移植好的twrp
echo 备份recovery文件夹是刚才移植前REC的备份
pause
goto home

:flash_power
echo 请确保设备已经打开USB调试
pause
cd 移植完成
..\tools\platform-tools\adb.exe reboot bootloader
..\tools\platform-tools\fastboot.exe flash recovery twrp.img
..\tools\platform-tools\fastboot.exe reboot
echo 成功刷入，正在开机，开机后可以尝试进入REC来测试
pause
goto home

:flash_fb
echo 请确保设备已经进入FB
pause
cd 移植完成
..\tools\platform-tools\fastboot.exe flash recovery twrp.img
..\tools\platform-tools\fastboot.exe reboot
echo 成功刷入，正在开机，开机后可以尝试进入REC来测试
pause
goto home

:twrp_fix
echo 如果你的twrp没有致命bug
echo 此功能慎用，可能会导致TWRP无法进入
echo 在前之前的移植过程，已经集成部分修复
echo 请把你机型的RECOVERY命名为官方recovery.img
echo 把你已经移植好要修复的TWRP命名为移植recovery.img
echo 把这两个文件放置到文件根目录
echo 输入A，回到主界面
echo 输入B，修复MTP，就是与电脑连接（高危）
echo 输入C，修复进入TWRP黑屏（低危）
echo 输入D，修复TWRP解密功能，可能无效（低危）
set /p twrp_fix=输入数字选择对应的操作:
if "%twrp_fix%"=="A" goto home
if "%twrp_fix%"=="B" goto fix_mtp
if "%twrp_fix%"=="C" goto fix_black
if "%twrp_fix%"=="D" goto fix_unlock

:fix_mtp
echo 正在修复MTP
if not exist 官方recovery.img (echo.
echo 未发现官方recovery.img,即将返回主菜单
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP (rd /s /q MTP)
echo 正在解包recovery.img......
md MTP
copy 官方recovery.img MTP\boot.img>NUL
cd MTP
..\tools\bootimg.exe --unpack-bootimg
cd ..
if not exist 移植recovery.img (echo.
echo 未发现移植recovery.img,即将返回主菜单
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP修复 (rd /s /q MTP修复)
echo 正在解包recovery.img......
md MTP修复
copy 移植recovery.img MTP修复\boot.img>NUL
cd MTP修复
..\tools\bootimg.exe --unpack-bootimg
cd ..
del MTP修复\initrd\init.recovery.usb.rc
copy MTP\initrd\init.qcom.usb.sh MTP修复\initrd\init.recovery.usb.rc
cd MTP修复
..\tools\bootimg.exe --repack-bootimg
rename boot-new.img twrp.img
cd ..
copy MTP修复\twrp.img 移植完成
copy 官方recovery.img recovery备份
copy 移植recovery.img recovery备份
del 移植recovery.img

del 官方recovery.img
rd/s/q MTP修复
rd/s/q MTP
echo 修复完成，移植完成目录下是修复好的twrp
echo 备份recovery文件夹是刚才移植前REC的备份
pause
goto twrp_fix
:fix_black
echo 正在修复黑屏
if not exist 官方recovery.img (echo.
echo 未发现官方recovery.img,即将返回主菜单
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP (rd /s /q MTP)
echo 正在解包recovery.img......
md MTP
copy 官方recovery.img MTP\boot.img>NUL
cd MTP
..\tools\bootimg.exe --unpack-bootimg
cd ..
if not exist 移植recovery.img (echo.
echo 未发现移植recovery.img,即将返回主菜单
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP修复 (rd /s /q MTP修复)
echo 正在解包recovery.img......
md MTP修复
copy 移植recovery.img MTP修复\boot.img>NUL
cd MTP修复
..\tools\bootimg.exe --unpack-bootimg
cd ..
del MTP修复\initrd\res\keys
copy MTP\initrd\res\keys MTP修复\initrd\
cd MTP修复
..\tools\bootimg.exe --repack-bootimg
rename boot-new.img twrp.img
cd ..
copy MTP修复\twrp.img 移植完成
copy 官方recovery.img recovery备份
copy 移植recovery.img recovery备份
del 移植recovery.img
del 官方recovery.img
rd/s/q MTP修复
rd/s/q MTP
echo 修复完成，移植完成目录下是修复好的twrp
echo 备份recovery文件夹是刚才移植前REC的备份
pause
goto twrp_fix
:fix_unlock
echo 正在修复解密
if not exist 官方recovery.img (echo.
echo 未发现官方recovery.img,即将返回主菜单
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP (rd /s /q MTP)
echo 正在解包recovery.img......
md MTP
copy 官方recovery.img MTP\boot.img>NUL
cd MTP
..\tools\bootimg.exe --unpack-bootimg
cd ..
if not exist 移植recovery.img (echo.
echo 未发现移植recovery.img,即将返回主菜单
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP修复 (rd /s /q MTP修复)
echo 正在解包recovery.img......
md MTP修复
copy 移植recovery.img MTP修复\boot.img>NUL
cd MTP修复
..\tools\bootimg.exe --unpack-bootimg
cd ..
del MTP修复\initrd\fstab.qcom
copy MTP\initrd\fstab.qcom MTP修复\initrd\
cd MTP修复
..\tools\bootimg.exe --repack-bootimg
rename boot-new.img twrp.img
cd ..
copy MTP修复\twrp.img 移植完成
copy 官方recovery.img recovery备份
copy 移植recovery.img recovery备份
del 移植recovery.img
del 官方recovery.img
rd/s/q MTP修复
rd/s/q MTP
echo 修复完成，移植完成目录下是修复好的twrp
echo 备份recovery文件夹是刚才移植前REC的备份
pause
goto twrp_fix