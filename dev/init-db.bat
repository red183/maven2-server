@echo off

cd %~dp0
cd ..

call mvn antrun:run -Pinit-db

pause