@echo off
if exist package.json (
  echo Installing npm dependencies...
  call npm install

  echo Running build...
  call npm run build
) else (
  echo No package.json found - skipping npm build
)
