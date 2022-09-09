docker run --name mssql -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=password' -e 'TZ=Asia/Bangkok' -p 1433:1433 -d mcr.microsoft.com/mssql/server:latest
