@echo off
REM Set source (prioritize build, then dist)
if exist build (
  set SRC=build
) else if exist dist (
  set SRC=dist
) else (
  set SRC=.
)

set DEST=C:\inetpub\wwwroot\MyFrontend

echo Deploying from %SRC% to %DEST%

if not exist "%DEST%" mkdir "%DEST%"
robocopy "%SRC%" "%DEST%" /MIR /XD node_modules .git .github

if %errorlevel% GEQ 8 (
  echo Robocopy reported a failure (errorlevel %errorlevel%)
  exit /b %errorlevel%
)

echo Deploy complete.
