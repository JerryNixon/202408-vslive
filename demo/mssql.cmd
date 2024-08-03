@echo off

sqlcmd delete --force

SET SQLCMD_ACCEPT_EULA=YES
sqlcmd.exe create mssql --use mssql.sql --user-database HR --port 1234 --add-on dab --add-on-use dab-config.json --cached
sqlcmd.exe -i mssql.sql
echo 127.0.0.1,1234