@echo off
@REM chcp 65001 >nul
title Nginx & PHP-CGI 管理面板
color 0A

REM ========== 配置区域 ==========
set NGINX_PATH=C:\Users\kk\Server\nginx-1.30.0
set PHP_PATH=C:\Users\kk\Server\php-8.5.3-nts-Win32-vs17-x64
REM ==============================

:MENU
cls
echo ========================================
echo        Nginx / PHP-CGI 管理面板
echo ========================================
echo.
echo    1. 启动所有服务
echo    2. 停止所有服务
echo    3. 重启所有服务
echo    4. 重载 Nginx 配置
echo    5. 查看服务状态
echo    6. 检查Nginx 配置语法
echo    7. 查看端口占用情况
echo    8. 打开Application目录
echo    0. 退出
echo.
echo ========================================
set /p choice=请选择操作 [0-8]: 

if "%choice%"=="1" goto START
if "%choice%"=="2" goto STOP
if "%choice%"=="3" goto RESTART
if "%choice%"=="4" goto RELOAD
if "%choice%"=="5" goto STATUS
if "%choice%"=="6" goto CHECKCONFIG
if "%choice%"=="7" goto PORTS
if "%choice%"=="8" goto APP_FOLDER
if "%choice%"=="0" goto MEXIT

echo 无效选项，请重新选择操作
timeout /t 2 /nobreak >NUL
goto MENU

:START
cls
echo 正在启动Nginx服务...
cd /d %NGINX_PATH%
start nginx.exe
if %ERRORLEVEL%==0 (echo [OK] Nginx 启动成功) else (echo [失败] Nginx 启动失败)

cd /d %PHP_PATH%
start /B php-cgi.exe -b 127.0.0.1:9000 -c php.ini
timeout /t 2 /nobreak >NUL
echo [OK] PHP-CGI 启动完成
echo.
echo 按任意键返回菜单...
pause >NUL
goto MENU

:STOP
cls
echo 正在停止Nginx服务...
cd /d %NGINX_PATH%
taskkill /f /im nginx.exe >NUL 2>&1
echo [OK] Nginx 已停止
echo.
echo 正在停止php-CGI服务...
taskkill /F /IM php-cgi.exe >NUL 2>&1
echo [OK] PHP-CGI 已停止
echo.
echo 按任意键返回菜单...
pause >NUL
goto MENU

:RESTART
cls
echo 正在停止服务...
cd /d %NGINX_PATH%
taskkill /f /im nginx.exe >NUL 2>&1
taskkill /F /IM php-cgi.exe >NUL 2>&1
echo [OK] Nginx服务已停止
echo [OK] php-CGI服务已停止
echo.
echo 正在重启服务...
echo 正在启动Nginx服务...
cd /d %NGINX_PATH%
start nginx.exe
echo [OK] Nginx服务已重启
echo.
echo 正在启动php-CGI服务...
cd /d %PHP_PATH%
start /B php-cgi.exe -b 127.0.0.1:9000 -c php.ini
timeout /t 2 /nobreak >NUL
echo [OK] php-CGI服务已重启
echo.
echo 按任意键返回菜单...
pause >NUL
goto MENU

:RELOAD
cls
cd /d %NGINX_PATH%
nginx.exe -s reload
if %ERRORLEVEL%==0 (echo [OK] Nginx 配置重载成功) else (echo [失败] Nginx 配置重载失败)
echo.
echo 按任意键返回菜单...
pause >NUL
goto MENU

:STATUS
cls
echo 服务状态
echo ---------
tasklist /FI "IMAGENAME eq nginx.exe" 2>NUL | findstr /I "nginx.exe">NUL
if "%ERRORLEVEL%"=="0" (echo Nginx: [运行中]) else (echo Nginx: [未运行])

tasklist /FI "IMAGENAME eq php-cgi.exe" 2>NUL | findstr /I "php-cgi.exe">NUL
if "%ERRORLEVEL%"=="0" (echo PHP-CGI: [运行中]) else (echo PHP-CGI: [未运行])
echo.
echo 按任意键返回菜单...
pause >NUL
goto MENU

:CHECKCONFIG
cls
cd /d %NGINX_PATH%
nginx.exe -t
echo.
echo 按任意键返回菜单...
pause >NUL
goto MENU

:PORTS
cls
echo 端口占用情况:
echo -------------
echo 80端口 (Nginx):
netstat -ano | findstr :80 | findstr LISTENING
echo.
echo 9000端口 (PHP-CGI):
netstat -ano | findstr :9000 | findstr LISTENING
echo.
echo 9003端口 (PHP-CGI):
netstat -ano | findstr :9003 | findstr LISTENING
echo.
echo 按任意键返回菜单...
pause >NUL
goto MENU

:APP_FOLDER
cls
echo ========================================
echo          Application 目录选择
echo ========================================
echo.
echo    1. 打开 Nginx 目录
echo    2. 打开 PHP 目录
echo    0. 返回主菜单
echo.
echo ========================================
set /p app_choice=请选择 [0-2]: 

if "%app_choice%"=="1" (
    start "" "%NGINX_PATH%"
    echo [OK] 已打开 Nginx 目录
    timeout /t 1 /nobreak >NUL
    goto MENU
)
if "%app_choice%"=="2" (
    start "" "%PHP_PATH%"
    echo [OK] 已打开 PHP 目录
    timeout /t 1 /nobreak >NUL
    goto MENU
)
if "%app_choice%"=="0" goto MENU

echo 无效选项，请重新选择
timeout /t 1 /nobreak >NUL
goto APP_FOLDER

:MEXIT
exit