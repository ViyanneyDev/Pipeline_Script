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

REM Robocopy exit codes: 0–7 are OK, >=8 are failures
set RC=%errorlevel%
if %RC% GEQ 8 (
  echo Robocopy reported a failure (errorlevel %RC%)
  exit /b %RC%
) else (
  echo Robocopy completed successfully (exit code %RC%)
  exit /b 0
)
