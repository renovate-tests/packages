@echo off

SET mypath=%~dp0%
SET pathWSL=%mypath:\=/%
SET pathWSL=%pathWSL:C:/=/mnt/c/%
echo path is %pathWSL%

echo Launching in_wsl.sh
dir %mypath%
ubuntu.exe run %pathWSL%in_wsl.sh %*
