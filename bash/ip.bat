@echo off
mode con cols=80 lines=30
rem ���ù��ñ���
set net_interface="��������"
 
:CHOICE
color b
cls
echo *********************IP�����л�����********************
echo ----��IP���ù��ܡ�---------------
echo -----1.�޸ġ��������ӡ���IP-----------
echo -----2.�޸ġ���������1����IP----------
echo -----3.�޸ı�������ΪHOME_IP------
echo -----4.�޸�Ϊ�Զ���ȡ-----
echo -----��ϵͳ���ܡ�----------
echo -----r.��������-----------
echo -----X.�˳�����-----------
echo.
echo *********************Tools By WLH**********************
echo.ע�⡰��������1���������ھӵ��������ƣ�����
 
:mu
set /p choice= ����������ѡ��
IF NOT "%choice%"=="" SET choice=%choice:~0,1%
if /i "%choice%"=="1" goto home1_ip
if /i "%choice%"=="2" goto home2_ip
if /i "%choice%"=="3" goto home3_ip
if /i "%choice%"=="4" goto DHCP
if /i "%choice%"=="r" goto reboot
if /i "%choice%"=="X" goto END
echo.
echo.
echo �����ѡ����ȷ�����������룡
echo.
echo.
GOTO CHOICE
pause
 
:home1_ip
cls
echo.
echo ����Ϊ������������IP,��ȴ�...
echo.
echo ����IP��...
set net_interface="��������"
 
:CHOICE1
set /p ip1= ������IP�����һ�����Σ�
IF NOT "%ip1%"=="" set /p yes1= ��ȷ��IP��ȷ������1�س���ʾȷ��������
IF  "%yes1%"=="" SET yes1="1"
IF NOT "%yes1%"=="" SET yes1=%yes1:~0,1%
if /i "%yes1%"=="1" goto ip111
if /i "%yes1%"==1 goto ip111
 
GOTO CHOICE1
 
:ip111
cls
netsh interface ip set address "%net_interface%" source=static addr=192.168.1.%ip1% mask=255.255.255.0
echo ����IP�ɹ�...����������...
netsh interface ip set address name="%net_interface%" gateway=192.168.1.1 gwmetric=1
echo ������ɡ�
ipconfig
set /p q1= ��0���˳�
IF NOT "%q1%"=="0" GOTO CHOICE
GOTO CHOICE8
 
:home2_ip
cls
echo.
echo ����Ϊ��������1����IP,��ȴ�...
echo.
echo ����IP��...
set net_interface="��������1"
 
:CHOICE2
set /p ip2= ������IP�����һ�����Σ�
IF NOT "%ip2%"=="" set /p yes2= ��ȷ��IP��ȷ������1�س���ʾȷ��������
IF  "%yes2%"=="" SET yes2="1"
IF NOT "%yes2%"=="" SET yes2=%yes2:~0,1%
if /i "%yes2%"=="1" goto ip222
GOTO CHOICE2
 
:ip222
cls
netsh interface ip set address "%net_interface%" source=static addr=192.168.1.%ip2% mask=255.255.255.0
echo ����IP�ɹ�...����������...
netsh interface ip set address name="%net_interface%" gateway=192.168.1.1 gwmetric=1
echo ������ɡ�
ipconfig
set /p q2= ��0���˳�
IF NOT "%q2%"=="0" GOTO CHOICE
GOTO CHOICE8
 
:home3_ip
cls
echo.
echo ��������IPΪhome_ip��ȴ�...
echo.
set net_interface="��������"
echo ����IP��...
netsh interface ip set address "%net_interface%" source=static addr=192.168.1.111 mask=255.255.255.0
echo ����IP�ɹ�...����������...
netsh interface ip set address name="%net_interface%" gateway=192.168.1.1 gwmetric=1
echo �������سɹ�...����DNS��...
netsh interface ip set dns "%net_interface%" static 218.85.152.99
netsh interface ip add dns "%net_interface%" 218.85.157.99 index=2
pause |echo �������,�����������ѡ��˵���
GOTO CHOICE8
 
:DHCP
echo.
echo ��������IPΪ�Զ���ȡ,��ȴ�...
echo.
echo ����IP��...
netsh interface ip set address name="%net_interface%" source=dhcp
echo �������سɹ�...����DNS��...
netsh interface ip set dns "%net_interface%" source=dhcp
pause |echo �������,�����������ѡ��˵���
GOTO CHOICE8
 
:reboot
echo ����������...���Ե�...
netsh interface set interface "%net_interface%" disabled
netsh interface set interface "%net_interface%" enable
pause |echo �������,�����������ѡ��˵���
GOTO CHOICE
 
:CHOICE8
:end
exit