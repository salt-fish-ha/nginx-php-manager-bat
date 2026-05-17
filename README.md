# nginx-php-manager-bat
### Win11 PHP环境控制命令行

## 功能介绍

```batch
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
```

## 注意事项

使用时需要修改
```batch
REM ========== 配置区域 ==========
set NGINX_PATH=C:\Users\admin\Server\nginx-1.30.0
set PHP_PATH=C:\Users\admin\Server\php-8.5.3-nts-Win32-vs17-x64
REM ==============================
```