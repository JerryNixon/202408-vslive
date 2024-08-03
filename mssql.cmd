SET SQLCMD_ACCEPT_EULA=YES
SET SQLCMDPASSWORD=P@ssw0rd!
sqlcmd.exe create mssql --using mssql.sql --name sql-container --port 1234 --tag 2022-latest --user-database HR --accept-eula Y --cached --context-name SQL-context --hostname SQL-hostname