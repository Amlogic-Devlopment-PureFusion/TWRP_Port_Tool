@echo off
color F0
mode con cols=58 lines=30
title=TWRPһ����ֲ����:By:Coolapk@SKDushow
:home
echo Coolapk@SKDushow
echo �汾V2,���ǵڶ����汾
echo TWRPһ����ֲ����,��֧�ָ�ͨ������
echo �������͵�RECOVERY����Ϊ�ٷ�recovery.img
echo ����Ҫ��ֲ��TWRP����Ϊ��ֲrecovery.img
echo ���������ļ����õ��ļ���Ŀ¼
echo ȷ������TWRP��ͬSOC
echo ����1����ʼ�Զ���ֲ
echo ����2������״̬ˢ����ֲ���TWRP
echo ����3��fastboot״̬ˢ����ֲ���TWRP
echo ����4��twrp����bug�޸�
set /p twrp=��������ѡ���Ӧ�Ĳ���:
if "%twrp%"=="1" goto auto_port
if "%twrp%"=="2" goto flash_power
if "%twrp%"=="3" goto flash_fb
if "%twrp%"=="4" goto twrp_fix
goto home
pause
:auto_port
if not exist �ٷ�recovery.img (echo.
echo δ���ֹٷ�recovery.img,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist �ٷ�recovery (rd /s /q �ٷ�recovery)
echo ���ڽ��recovery.img......
md �ٷ�recovery
copy �ٷ�recovery.img �ٷ�recovery\boot.img>NUL
cd �ٷ�recovery
..\tools\bootimg.exe --unpack-bootimg
cd ..
if not exist ��ֲrecovery.img (echo.
echo δ������ֲrecovery.img,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist ��ֲrecovery (rd /s /q ��ֲrecovery)
echo ���ڽ��recovery.img......
md ��ֲrecovery
copy ��ֲrecovery.img ��ֲrecovery\boot.img>NUL
cd ��ֲrecovery
..\tools\bootimg.exe --unpack-bootimg
cd ..
del ��ֲrecovery\kernel
del ��ֲrecovery\kernel.gz
del ��ֲrecovery\initrd\default.prop
del ��ֲrecovery\initrd\etc\recovery.fstab
del ��ֲrecovery\initrd\res\keys
copy �ٷ�recovery\kernel ��ֲrecovery
copy �ٷ�recovery\kernel.gz ��ֲrecovery
copy �ٷ�recovery\initrd\default.prop ��ֲrecovery\initrd\
copy �ٷ�recovery\initrd\etc\recovery.fstab ��ֲrecovery\initrd\etc\
copy �ٷ�recovery\initrd\res\keys ��ֲrecovery\initrd\res\
cd ��ֲrecovery
..\tools\bootimg.exe --repack-bootimg
rename boot-new.img twrp.img
cd ..
copy ��ֲrecovery\twrp.img ��ֲ���
copy �ٷ�recovery.img recovery����
copy ��ֲrecovery.img recovery����
del ��ֲrecovery.img
del �ٷ�recovery.img
rd/s/q ��ֲrecovery
rd/s/q �ٷ�recovery
echo ��ֲ��ɣ���ֲ���Ŀ¼������ֲ�õ�twrp
echo ����recovery�ļ����Ǹղ���ֲǰREC�ı���
pause
goto home

:flash_power
echo ��ȷ���豸�Ѿ���USB����
pause
cd ��ֲ���
..\tools\platform-tools\adb.exe reboot bootloader
..\tools\platform-tools\fastboot.exe flash recovery twrp.img
..\tools\platform-tools\fastboot.exe reboot
echo �ɹ�ˢ�룬���ڿ�������������Գ��Խ���REC������
pause
goto home

:flash_fb
echo ��ȷ���豸�Ѿ�����FB
pause
cd ��ֲ���
..\tools\platform-tools\fastboot.exe flash recovery twrp.img
..\tools\platform-tools\fastboot.exe reboot
echo �ɹ�ˢ�룬���ڿ�������������Գ��Խ���REC������
pause
goto home

:twrp_fix
echo ������twrpû������bug
echo �˹������ã����ܻᵼ��TWRP�޷�����
echo ��ǰ֮ǰ����ֲ���̣��Ѿ����ɲ����޸�
echo �������͵�RECOVERY����Ϊ�ٷ�recovery.img
echo �����Ѿ���ֲ��Ҫ�޸���TWRP����Ϊ��ֲrecovery.img
echo ���������ļ����õ��ļ���Ŀ¼
echo ����A���ص�������
echo ����B���޸�MTP��������������ӣ���Σ��
echo ����C���޸�����TWRP��������Σ��
echo ����D���޸�TWRP���ܹ��ܣ�������Ч����Σ��
set /p twrp_fix=��������ѡ���Ӧ�Ĳ���:
if "%twrp_fix%"=="A" goto home
if "%twrp_fix%"=="B" goto fix_mtp
if "%twrp_fix%"=="C" goto fix_black
if "%twrp_fix%"=="D" goto fix_unlock

:fix_mtp
echo �����޸�MTP
if not exist �ٷ�recovery.img (echo.
echo δ���ֹٷ�recovery.img,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP (rd /s /q MTP)
echo ���ڽ��recovery.img......
md MTP
copy �ٷ�recovery.img MTP\boot.img>NUL
cd MTP
..\tools\bootimg.exe --unpack-bootimg
cd ..
if not exist ��ֲrecovery.img (echo.
echo δ������ֲrecovery.img,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP�޸� (rd /s /q MTP�޸�)
echo ���ڽ��recovery.img......
md MTP�޸�
copy ��ֲrecovery.img MTP�޸�\boot.img>NUL
cd MTP�޸�
..\tools\bootimg.exe --unpack-bootimg
cd ..
del MTP�޸�\initrd\init.recovery.usb.rc
copy MTP\initrd\init.qcom.usb.sh MTP�޸�\initrd\init.recovery.usb.rc
cd MTP�޸�
..\tools\bootimg.exe --repack-bootimg
rename boot-new.img twrp.img
cd ..
copy MTP�޸�\twrp.img ��ֲ���
copy �ٷ�recovery.img recovery����
copy ��ֲrecovery.img recovery����
del ��ֲrecovery.img

del �ٷ�recovery.img
rd/s/q MTP�޸�
rd/s/q MTP
echo �޸���ɣ���ֲ���Ŀ¼�����޸��õ�twrp
echo ����recovery�ļ����Ǹղ���ֲǰREC�ı���
pause
goto twrp_fix
:fix_black
echo �����޸�����
if not exist �ٷ�recovery.img (echo.
echo δ���ֹٷ�recovery.img,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP (rd /s /q MTP)
echo ���ڽ��recovery.img......
md MTP
copy �ٷ�recovery.img MTP\boot.img>NUL
cd MTP
..\tools\bootimg.exe --unpack-bootimg
cd ..
if not exist ��ֲrecovery.img (echo.
echo δ������ֲrecovery.img,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP�޸� (rd /s /q MTP�޸�)
echo ���ڽ��recovery.img......
md MTP�޸�
copy ��ֲrecovery.img MTP�޸�\boot.img>NUL
cd MTP�޸�
..\tools\bootimg.exe --unpack-bootimg
cd ..
del MTP�޸�\initrd\res\keys
copy MTP\initrd\res\keys MTP�޸�\initrd\
cd MTP�޸�
..\tools\bootimg.exe --repack-bootimg
rename boot-new.img twrp.img
cd ..
copy MTP�޸�\twrp.img ��ֲ���
copy �ٷ�recovery.img recovery����
copy ��ֲrecovery.img recovery����
del ��ֲrecovery.img
del �ٷ�recovery.img
rd/s/q MTP�޸�
rd/s/q MTP
echo �޸���ɣ���ֲ���Ŀ¼�����޸��õ�twrp
echo ����recovery�ļ����Ǹղ���ֲǰREC�ı���
pause
goto twrp_fix
:fix_unlock
echo �����޸�����
if not exist �ٷ�recovery.img (echo.
echo δ���ֹٷ�recovery.img,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP (rd /s /q MTP)
echo ���ڽ��recovery.img......
md MTP
copy �ٷ�recovery.img MTP\boot.img>NUL
cd MTP
..\tools\bootimg.exe --unpack-bootimg
cd ..
if not exist ��ֲrecovery.img (echo.
echo δ������ֲrecovery.img,�����������˵�
ping 127.0.0.1 -n 2 >NUL
goto home
) 
if exist MTP�޸� (rd /s /q MTP�޸�)
echo ���ڽ��recovery.img......
md MTP�޸�
copy ��ֲrecovery.img MTP�޸�\boot.img>NUL
cd MTP�޸�
..\tools\bootimg.exe --unpack-bootimg
cd ..
del MTP�޸�\initrd\fstab.qcom
copy MTP\initrd\fstab.qcom MTP�޸�\initrd\
cd MTP�޸�
..\tools\bootimg.exe --repack-bootimg
rename boot-new.img twrp.img
cd ..
copy MTP�޸�\twrp.img ��ֲ���
copy �ٷ�recovery.img recovery����
copy ��ֲrecovery.img recovery����
del ��ֲrecovery.img
del �ٷ�recovery.img
rd/s/q MTP�޸�
rd/s/q MTP
echo �޸���ɣ���ֲ���Ŀ¼�����޸��õ�twrp
echo ����recovery�ļ����Ǹղ���ֲǰREC�ı���
pause
goto twrp_fix