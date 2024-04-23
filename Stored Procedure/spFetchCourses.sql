use SyllabusGenerator
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.spFetchCourses'))
   drop proc spFetchCourses
GO

Create proc spFetchCourses 
    @ProfessorID Int 
AS
BEGIN

Select c.CourseCode as CourseCode
, c.CourseName + '('+  ss.Semester + ')' as CourseName
, c.CourseType as CourseType
, c.CourseID as CourseID
, d.DepartmentName as DepartmentName
, d.DepartmentCode as DepartmentCode
, d.DepartmentID as DepartmentID
, ss.SyllabusID
from SyllabusGenerator..course c with (nolock) inner join SyllabusGenerator..Syllabus ss with (nolock) on c.CourseID = ss.CourseID
inner join SyllabusGenerator..Department d with (nolock) on d.DepartmentID = c.DepartmentID
where  c.ProfessorID =  @ProfessorID




END

--exec spFetchCourses 1