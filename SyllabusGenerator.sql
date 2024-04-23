USE master;
GO

IF  DB_ID('SyllabusGenerator') IS NOT NULL
DROP DATABASE SyllabusGenerator;
GO

CREATE DATABASE SyllabusGenerator;
GO

USE SyllabusGenerator;

CREATE TABLE Department (
  DepartmentID        INT            PRIMARY KEY   IDENTITY,
  DepartmentName      VARCHAR(255)   NOT NULL,     
  DepartmentCode      VARCHAR(20)    NOT NULL      UNIQUE
);

CREATE TABLE Professor (
  ProfessorID          INT            PRIMARY KEY   IDENTITY,
  DepartmentID         INT            REFERENCES Department (DepartmentID),
  Name                 VARCHAR(100)   NOT NULL,
  EmailID              VARCHAR(100)   NOT NULL UNIQUE,
  ContactNumber        varchar(20)    NOT NULL
);

CREATE TABLE ProgramChair (
  ProgramChairID       INT            PRIMARY KEY   IDENTITY,
  DepartmentID         INT            REFERENCES Department (DepartmentID),
  Name                 VARCHAR(100)   NOT NULL,
  EmailID              VARCHAR(100)   NOT NULL UNIQUE,
  ContactNumber        varchar(20)    NOT NULL
);

CREATE TABLE Course (
  CourseID         INT            PRIMARY KEY   IDENTITY,
  DepartmentID     INT            REFERENCES Department (DepartmentID), 
  ProfessorID      INT            REFERENCES Professor (ProfessorID), 
  CourseCode       VARCHAR(50)    NOT NULL UNIQUE,
  CourseName       VARCHAR(50)    NOT NULL,
  CourseType       VARCHAR(10)    NOT NULL
);


CREATE TABLE TextBook (
  TextBookID        INT            PRIMARY KEY   IDENTITY,
  TextBookName      VARCHAR(255)   NOT NULL,
  Category          VARCHAR(255)   NOT NULL,

);

CREATE TABLE Syllabus (
  SyllabusID           INT            PRIMARY KEY   IDENTITY,
  CourseID             INT            REFERENCES Course (CourseID), 
  ProfessorID          INT            REFERENCES Professor (ProfessorID), 
  TextBookID           varchar(100)   Default Null, 
  Semester             VARCHAR(60)    NOT NULL,
  LearningObjective    VARCHAR(max)   NOT NULL,
  prerequisite         varchar(max)            DEFAULT NULL
);

CREATE TABLE SyllabusAudit (
  SyllabusAuditID      INT            PRIMARY KEY   IDENTITY,
  SyllabusID           INT            ,
  CourseID             INT            , 
  ProfessorID          INT            , 
  TextBookID           varchar(100)   , 
  Semester             VARCHAR(60)    ,
  LearningObjective    VARCHAR(max)   ,
  prerequisite         varchar(max)   ,
  Audit_Action         varchar(10)    ,
  Action_By            INT            ,
  Action_At            DATETIME       ,
  Remark               Varchar(max)   
);

CREATE TABLE CourseSchedule (
  CourseScheduleID      INT            PRIMARY KEY  IDENTITY,
  SyllabusID            INT            REFERENCES Syllabus (SyllabusID),
  CourseID              INT            REFERENCES Course (CourseID),
  Module                Varchar(20)    NOT NULL,
  CourseContents        Varchar(max)   NOT NULL,
  StartDate             Date           NOT NULL,
  EndDate               Date           NOT NULL
);



SET IDENTITY_INSERT Department ON;
INSERT INTO Department (DepartmentID, DepartmentName, DepartmentCode) VALUES
(1, 'Information Technology', 'IFT'),
(2, 'Computer Science','CS'),
(3, 'Software Engineering','SE'), 
(4, 'Computer Engineering', 'CE'),
(5, 'Construction Management', 'CMT');
SET IDENTITY_INSERT Department OFF;

SET IDENTITY_INSERT Professor ON;
INSERT INTO Professor (ProfessorID, DepartmentID, Name,EmailID,ContactNumber) VALUES
(1, 1, 'Robert Rucker','RobertRucker@asu.edu','6022221111'),
(2, 1,'Asmaa Elbadrawy','AsmaaElbadrawy@asu.edu','6023331111'),
(3, 1,'Dinesh Sthapit','DineshSthapit@asu.edu','6024441111'), 
(5, 2, 'Chris Bryan','ChrisBryan@asu.edu','6022222222'),
(6, 2, 'Hasan Davulcu','HasanDavulcu@asu.edu','6023332222'),
(7, 2, 'Samira Ghayekhloo','SamiraGhayekhloo@asu.edu','6024442222');

SET IDENTITY_INSERT Professor OFF;

SET IDENTITY_INSERT ProgramChair ON;
INSERT INTO ProgramChair (ProgramChairID, DepartmentID, Name,EmailID,ContactNumber) VALUES
(1, 1, 'Tatiana Walsh','TatianaWalsh@asu.edu','6021111111'),
(2, 2, 'Dont Know','DontKnow@asu.edu','6021112222'),
(3, 3, 'Srividya Bansal','SrividyaBansal@asu.edu','6021113333'),
(4, 4, 'John Doe','JohnDoe@asu.edu','6021114444'),
(5, 5, 'Abc Xyz','AbcXyz@asu.edu','6021115555');
SET IDENTITY_INSERT ProgramChair OFF;


SET IDENTITY_INSERT course ON;
INSERT INTO course (CourseID, DepartmentID, ProfessorID,CourseCode,CourseName,CourseType) VALUES
(1, 1, 1,'IFT530','Advanced Database Management Systems','In-Person'),
(2, 1,2, 'IFT511','Analyzing Big Data','In-Person'),
(3, 1,1, 'IFT430','Database Management System','In-Person'),
(4, 1,2, 'IFT411','Fundamentals of Python','In-Person'),
(5, 1,3, 'IFT510','Principles of Computer Information and Technology','In-Person');
SET IDENTITY_INSERT course OFF;


SET IDENTITY_INSERT TextBook ON;
INSERT INTO TextBook (TextBookID, TextBookName,Category) VALUES
(1, 'Murachs SQL server for developers','Database'),
(2, 'Halpin, Morgan( 2008) Information Modeling and Relational Databases 2nd edition, Kaufman','Database'),
(3, 'Data Science for Business by F. Provost and T. Fawcett','DataScience'),
(4, 'Mathematical Statistics with Applications, 7th edition, by Wackerly, Mendenhall, and Scheaffer, Brooks/Cole, Cengage Learning, 2008.','DataScience'),
(5, 'Basics of Python','Language');
SET IDENTITY_INSERT TextBook OFF;

SET IDENTITY_INSERT Syllabus ON;
INSERT INTO Syllabus (SyllabusID, CourseID, ProfessorID,textbookid,Semester,LearningObjective, prerequisite) VALUES
(1, 1, 1,'1,2','Fall','1.Understand the principles of conceptual modeling,2.understand the use of scripts when implementing SQL code', '3'),
(2, 1, 1,'1,2','Spring','1.Understand the principles of conceptual modeling,2.understand the use of scripts when implementing SQL code', '3'),
(3, 2, 2,'3,4','Fall','1.Understand how data science can be used as tools to analyze large amounts of data for the purpose of extracting business value.', '4'),
(4, 2, 2,'3,4','Spring','1.Understand how data science can be used as tools to analyze large amounts of data for the purpose of extracting business value.', '4'),
(5, 3, 1,'1','Fall','1.basics of database , ACID properties, CRUD methods, normalization', NULL),
(6, 4, 2,'5','Fall','1.Understand the basics of Python, Python libraries', NULL);

SET IDENTITY_INSERT Syllabus OFF;

SET IDENTITY_INSERT CourseSchedule ON;
INSERT INTO CourseSchedule (CourseScheduleID, SyllabusID, CourseID,Module,CourseContents,StartDate, EndDate) VALUES
(1, 1, 1,'Module1','Understand the principles of conceptual modeling (ORM as an examplar).', '15 Aug 2022','30 Aug 2022'),
(2, 1, 1,'Module2','Basis of Primary keys, Uniqueness/ Mandatory constraints', '1 Sep 2022', '15 Sep 2022'),
(3, 1, 1,'Module3','basis for determining Foreign Keys, value and frequency constraints, dynamic SQL', '16 Sep 2022', '16 Oct 2022'),
(4, 1, 1,'Module4','Window functions, SQL++', '17 Oct 2022', '10 Nov 2022'),
(5, 1, 1,'Module5','Couchbase, Capella-DBaas', '11 Nov 2022', '30 Nov 2022'),
(6, 2, 1,'Module1','Understand the principles of conceptual modeling (ORM as an examplar).', '15 Aug 2022','30 Aug 2022'),
(7, 2, 1,'Module2','Basis of Primary keys, Uniqueness/ Mandatory constraints', '1 Sep 2022', '15 Sep 2022'),
(8, 2, 1,'Module3','basis for determining Foreign Keys, value and frequency constraints, dynamic SQL', '16 Sep 2022', '16 Oct 2022'),
(9, 2, 1,'Module4','Window functions, SQL++', '17 Oct 2022', '10 Nov 2022'),
(10, 2, 1,'Module5','Couchbase, Capella-DBaas', '11 Nov 2022', '30 Nov 2022');
SET IDENTITY_INSERT CourseSchedule OFF;

