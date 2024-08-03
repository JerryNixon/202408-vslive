@echo off

cd..

REM Define solution and project names
set solutionName=VSLiveDemo
set databaseProjectName=Database
set apiProjectName=Api
REM set sqlConnection=Data Source=(localdb)\\MSSQLLocalDB;Database=HR;Integrated Security=True;
set sqlConnection=Data Source=127.0.0.1,1234;Database=HR;User id=AppUser;Password=P@ssw0rd!;

REM Create the solution 
dotnet new sln -n %solutionName%
dotnet new gitignore

REM Create the Database project
dotnet new install Microsoft.Build.Sql.Templates
dotnet new sqlproj -n %databaseProjectName% -tp SqlAzureV12 -o %databaseProjectName%
dotnet restore %databaseProjectName%/%databaseProjectName%.sqlproj
dotnet sln %solutionName%.sln add %databaseProjectName%\%databaseProjectName%.sqlproj

REM Create the API project
dotnet new webapi -n %apiProjectName% -o %apiProjectName%
dotnet add %apiProjectName%\%apiProjectName%.csproj package HotChocolate.AspNetCore
dotnet add %apiProjectName%\%apiProjectName%.csproj package HotChocolate.AspNetCore.Subscriptions
dotnet add %apiProjectName%\%apiProjectName%.csproj package Microsoft.EntityFrameworkCore
dotnet add %apiProjectName%\%apiProjectName%.csproj package Microsoft.EntityFrameworkCore.SqlServer
dotnet restore %apiProjectName%/%apiProjectName%.csproj
dotnet sln %solutionName%.sln add %apiProjectName%\%apiProjectName%.csproj

REM Create directories and files
REM mkdir %databaseProjectName%\Tables
REM call :CreateDepartmentTable
REM call :CreateEmployeeTable
REM mkdir %databaseProjectName%\Procedures
REM call :CreateReorgEmployeeProcedure
REM call :CreatePostDeploymentScript

mkdir %apiProjectName%\Repository
call :CreateHrContext
call :CreateDepartmentClass
call :CreateEmployeeClass

REM start devenv.exe "%solutionName%.sln"

echo Demo setup complete!
exit /b

:CreateDepartmentTable
> %databaseProjectName%\Tables\Department.sql (
    echo CREATE TABLE Department (
    echo     Id INT,
    echo     Name VARCHAR(50^)
    echo ^)
)
exit /b

:CreateEmployeeTable
> %databaseProjectName%\Tables\Employee.sql (
    echo CREATE TABLE Employee (
    echo     Id INT,
    echo     Name VARCHAR(50^),
    echo     DepartmentId INT
    echo ^)
)
exit /b

:CreateReorgEmployeeProcedure
> %databaseProjectName%\Procedures\ReorgEmployee.sql (
    echo CREATE PROCEDURE ReorgEmployee 
    echo    @EmployeeId INT,
    echo    @DepartmentId INT
    echo AS
    echo UPDATE Employee
    echo SET DepartmentId = @DepartmentId
    echo WHERE Id = @EmployeeId;
)
exit /b

:CreatePostDeploymentScript
> %databaseProjectName%\Script.PostDeployment.sql (
    echo -- seed departments
    echo INSERT INTO [dbo].Department 
    echo (Id, [Name]^) 
    echo VALUES 
    echo (1, 'HR'^),
    echo (2, 'IT'^),
    echo (3, 'Finance'^);
    echo.
    echo -- seed employees
    echo INSERT INTO [dbo].[Employee] 
    echo ([Id], [First], [Last], [DepartmentId]^) 
    echo VALUES
    echo (1, 'John', 'Smith', 1^),
    echo (2, 'Jane', 'Doe', 2^),
    echo (3, 'Michael', 'Johnson', 3^),
    echo (4, 'Emily', 'Davis', 1^),
    echo (5, 'Daniel', 'Miller', 2^),
    echo (6, 'Sophia', 'Wilson', 3^),
    echo (7, 'James', 'Brown', 1^),
    echo (8, 'Olivia', 'Anderson', 2^),
    echo (9, 'David', 'Jones', 3^),
    echo (10, 'Emma', 'Garcia', 1^);
)
exit /b

:CreateHrContext
> %apiProjectName%\Repository\HrContext.cs (
    echo using Microsoft.EntityFrameworkCore;
    echo.
    echo public class HrContext : DbContext
    echo {
    echo     private const string connectionString = "%sqlConnection%";
    echo     protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder^)
    echo     ^{
    echo         optionsBuilder.UseSqlServer(connectionString^);
    echo     ^}
    echo     public DbSet^<Department^> Departments { get; set; }
    echo     public DbSet^<Employee^> Employees { get; set; }
    echo ^}
)
exit /b

:CreateDepartmentClass
> %apiProjectName%\Repository\Department.cs (
    echo using System.ComponentModel.DataAnnotations.Schema;
    echo.
    echo [Table("Department"^)]
    echo public record class Department(int Id, string Name^);
)
exit /b

:CreateEmployeeClass
> %apiProjectName%\Repository\Employee.cs (
    echo using System.ComponentModel.DataAnnotations.Schema;
    echo.
    echo [Table("Employee"^)]
    echo public record class Employee(int Id, string Name, int DepartmentId^);
)
exit /b
