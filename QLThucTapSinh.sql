﻿CREATE DATABASE SQLThucTapSinh;

CREATE TABLE Role(
	RoleID INT IDENTITY (1,1) NOT NULL,
	NameRole NVARCHAR(250) NULL,
	PRIMARY KEY (RoleID)
);

CREATE TABLE Menu(
	Id INT IDENTITY (1,1) NOT NULL,
	TextMenu NVARCHAR(250) NULL,
	Link VARCHAR(250) NULL,
	RoleID INT NULL,
	PRIMARY KEY(Id),
	CONSTRAINT FK_Menu_Role FOREIGN KEY (RoleID) REFERENCES dbo.Role(RoleID)
);

--Thêm Ngày gia hạn, hạn sử dụng, status--
CREATE TABLE Organization(
	ID VARCHAR(8) NOT NULL,
	Name NVARCHAR(500) NULL,
	Address NVARCHAR(500) NULL,
	Phone VARCHAR(11) NULL,
	Fax VARCHAR(11) NULL,
	Image VARCHAR(250) NULL,
	Logo VARCHAR(250) NULL,
	Note NVARCHAR(500) NULL,
	Email VARCHAR(250) NULL,
	StartDay DATETIME NULL,
	ExpiryDate INT NULL,
	Status BIT DEFAULT (0) NULL,
	SendEmail BIT NULL,
	PRIMARY KEY(ID)
);

CREATE TABLE Person(
	PersonID VARCHAR(8)  NOT NULL,
	LastName NVARCHAR(50) NULL,
	FirstName NVARCHAR(50) NULL,
	Birthday DATE NULL,
	Gender BIT NULL,
	Address NVARCHAR(500) NULL,
	Phone VARCHAR(10) NULL,
	Email VARCHAR(250) NULL,
	Image VARCHAR(250) NULL,
	RoleID INT NULL,
	CompanyID VARCHAR(8) NULL,
	SchoolID VARCHAR(8) NULL,
	PRIMARY KEY(PersonID),
	CONSTRAINT FK_Person_Role FOREIGN KEY (RoleID) REFERENCES dbo.Role(RoleID),
	CONSTRAINT FK_Person_Company FOREIGN KEY (CompanyID) REFERENCES dbo.Organization(ID),
	CONSTRAINT FK_Person_School FOREIGN KEY (SchoolID) REFERENCES dbo.Organization(ID)
);

CREATE TABLE Users(
	UserName Varchar(50) NOT NULL,
	PersonID VARCHAR(8) UNIQUE FOREIGN KEY REFERENCES dbo.Person(PersonID),
	PassWord VARCHAR(50) NULL,
	Status BIT DEFAULT (0) NULL,
	PRIMARY KEY(UserName),
	
);

CREATE TABLE InternShip(
	InternshipID INT NOT NULL,
	CourseName NVARCHAR(250) NULL,
	Note NVARCHAR(500) NULL,
	PersonID VARCHAR(8) NULL,
	CompanyID VARCHAR(8) NULL,
	StartDay DATETIME NULL,
	ExpiryDate INT NULL,
	Status BIT DEFAULT (0) NULL,
	PRIMARY KEY (InternshipID),
	CONSTRAINT FK_InternShip_Person FOREIGN KEY (PersonID) REFERENCES dbo.Person(PersonID),
	CONSTRAINT FK_InternShip_Company FOREIGN KEY (CompanyID) REFERENCES dbo.Organization(ID)

);

CREATE TABLE Task(
	TaskID INT NOT NULL,
	TaskName NVARCHAR(250) NULL,
	Note NVARCHAR(500) NULL,
	Video VARCHAR(250) NULL,
	PersonID VARCHAR(8) NULL,
	NumberOfQuestions INT NULL,
	Result INT NULL,
	PRIMARY KEY (TaskID),
	CONSTRAINT FK_Task_Person FOREIGN KEY (PersonID) REFERENCES dbo.Person(PersonID)
);

CREATE TABLE IntershipWithTask(
	ID INT NOT NULL,
	InternshipID INT NULL,
	TaskID INT NULL,
	Sort INT NULL,
	PRIMARY KEY (ID),
	CONSTRAINT FK_IntershipWithTask_Task FOREIGN KEY (TaskID) REFERENCES dbo.Task(TaskID),
	CONSTRAINT FK_IntershipWithTask_Internship FOREIGN KEY (InternshipID) REFERENCES dbo.InternShip(InternshipID)
);

CREATE TABLE Question(
	QuestionID INT NOT NULL,
	TaskID INT NULL,
	Content NVARCHAR(500) NULL,
	Answer VARCHAR(10) NULL,
	A NVARCHAR(300) NULL,
	B NVARCHAR(300) NULL,
	C NVARCHAR(300) NULL,
	D NVARCHAR(300) NULL,
	PRIMARY KEY(QuestionID),
	CONSTRAINT FK_Question_Task FOREIGN KEY (TaskID) REFERENCES dbo.Task(TaskID)
);

--Thêm mã sinh viên--
CREATE TABLE Intern(
	PersonID VARCHAR(8) UNIQUE FOREIGN KEY (PersonID) REFERENCES dbo.Person(PersonID),
	StudentCode VARCHAR(15) NULL,
	InternshipID INT NULL,
	Result INT NULL,
	PRIMARY KEY (PersonID),
	CONSTRAINT FK_Intern_InternShip FOREIGN KEY (InternshipID) REFERENCES dbo.InternShip(InternshipID),
);

CREATE TABLE TestResults(
	ID INT NOT NULL,
	PersonID VARCHAR(8) NULL,
	TaskID INT NULL,
	Answer INT NULL,
	PRIMARY KEY(ID),
	CONSTRAINT FK_TestResults_Task FOREIGN KEY (TaskID) REFERENCES dbo.Task(TaskID),
	CONSTRAINT FK_TestResults_Intern FOREIGN KEY (PersonID) REFERENCES dbo.Intern(PersonID)
	
);



						