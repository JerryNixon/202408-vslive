USE MASTER

GO
IF NOT EXISTS(SELECT 1 FROM sys.databases WHERE name = 'HR')
CREATE DATABASE HR;

GO
USE HR;

GO
CREATE TABLE [dbo].[Department] (
    [Id]   INT           NOT NULL,
    [Name] NVARCHAR (50) NOT NULL
);

GO
CREATE TABLE [dbo].[Employee] (
    [Id]           INT           NOT NULL,
    [First]        NVARCHAR (50) NOT NULL,
    [Last]         NVARCHAR (50) NOT NULL,
    [DepartmentId] INT           NOT NULL
);

GO
CREATE PROCEDURE [dbo].[ReorgEmployee]
	@EmployeeId int,
	@DepartmentId int
AS
	UPDATE dbo.Employee
	SET DepartmentId = @DepartmentId
	WHERE Id = @EmployeeId

GO
INSERT INTO [dbo].Department 
(Id, [Name]) 
VALUES 
(1, 'HR'), 
(2, 'IT'), 
(3, 'Finance');

INSERT INTO [dbo].[Employee] 
([Id], [First], [Last], [DepartmentId]) 
VALUES
(1, 'John', 'Smith', 1),
(2, 'Jane', 'Doe', 2),
(3, 'Michael', 'Johnson', 3),
(4, 'Emily', 'Davis', 1),
(5, 'Daniel', 'Miller', 2),
(6, 'Sophia', 'Wilson', 3),
(7, 'James', 'Brown', 1),
(8, 'Olivia', 'Anderson', 2),
(9, 'David', 'Jones', 3),
(10, 'Emma', 'Garcia', 1),
(11, 'Matthew', 'Martinez', 2),
(12, 'Ava', 'Rodriguez', 3),
(13, 'Christopher', 'Lee', 1),
(14, 'Isabella', 'Hernandez', 2),
(15, 'Anthony', 'Walker', 3),
(16, 'Mia', 'Lopez', 1),
(17, 'Alexander', 'Gonzalez', 2),
(18, 'Amelia', 'Clark', 3),
(19, 'William', 'Lewis', 1),
(20, 'Abigail', 'Robinson', 2),
(21, 'Andrew', 'Hall', 3),
(22, 'Charlotte', 'Young', 1),
(23, 'Joseph', 'King', 2),
(24, 'Harper', 'Scott', 3),
(25, 'Joshua', 'Green', 1),
(26, 'Ella', 'Baker', 2),
(27, 'Ryan', 'Adams', 3),
(28, 'Lily', 'Nelson', 1),
(29, 'Noah', 'Hill', 2),
(30, 'Grace', 'Ramirez', 3),
(31, 'Samuel', 'Campbell', 1),
(32, 'Chloe', 'Mitchell', 2),
(33, 'Ethan', 'Perez', 3),
(34, 'Zoe', 'Roberts', 1),
(35, 'Liam', 'Turner', 2),
(36, 'Victoria', 'Phillips', 3),
(37, 'Mason', 'Parker', 1),
(38, 'Scarlett', 'Evans', 2),
(39, 'Benjamin', 'Edwards', 3),
(40, 'Aria', 'Collins', 1),
(41, 'Logan', 'Stewart', 2),
(42, 'Madison', 'Sanchez', 3),
(43, 'Jacob', 'Morris', 1),
(44, 'Evelyn', 'Rogers', 2),
(45, 'Henry', 'Reed', 3),
(46, 'Layla', 'Cook', 1),
(47, 'Jackson', 'Morgan', 2),
(48, 'Sofia', 'Bell', 3),
(49, 'Aiden', 'Murphy', 1),
(50, 'Avery', 'Bailey', 2);
GO
