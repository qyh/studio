@echo off &setlocal enabledelayedexpansion
title 局域网空闲IP查询@bbs.bathome.cn
Rem '/*========获取本机的IP地址(局域网)=========*/
echo 正在获取本机的IP地址，请稍等...
for /f "tokens=3 skip=2 delims=: " %%i in ('nbtstat -n') do (
     set "IP_addr=%%i"
     set IP_addr=!IP_addr:~1,-1!
     echo 本机IP为：!IP_addr!
     goto :next
)

:next
for /f "delims=. tokens=1,2,3,4" %%i in ("%IP_addr%") do set IP_fd=%%i.%%j.%%k
Rem '/*========获取计算机名============*/
echo.&echo 正在获取局域网内计算机名，请稍等...
echo 处于网段 %IP_fd%.* 的计算机有：&echo.
for /f "delims=" %%i in ('net view') do (
     set "var=%%i"
     rem ----------获取计算机名称------------
     if "!var:~0,2!"=="\\" (
          set "var=!var:~2!"
          echo !var!
          Rem ----------ping计算机名--------------
          ping -n 1 !var!>nul
    )
)
echo.&echo -----------------------------
Rem '/*========提取arp缓存=========*/
echo.&echo 正在获取局域网内计算机IP，请稍等...& echo.
for /f "skip=3 tokens=1,* delims= " %%i in ('arp -a') do echo IP： %%i 已经使用

echo.&echo -----------------------------
echo 程序完成,谢谢使用!
pause>nul