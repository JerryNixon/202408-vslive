SET SQLCMD_ACCEPT_EULA=YES
SET "SQLCMD_BAK=https://github.com/JerryNixon/202408-vslive/raw/main/HR.bak"
sqlcmd.exe create mssql --using %SQLCMD_BAK% --port 1234 --cached
sqlcmd.exe query "CREATE LOGIN AppUser WITH PASSWORD = 'P@ssw0rd!';"
sqlcmd.exe query "ALTER SERVER ROLE sysadmin ADD MEMBER AppUser;"
sqlcmd open ads
echo 127.0.0.1,1234