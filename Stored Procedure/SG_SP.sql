use SyllabusGenerator
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.spFetchSyllabusDetails'))
   drop proc spFetchSyllabusDetails
GO

Create proc spFetchSyllabusDetails 
    @ProfessorID Int ,
    @SyllabusID Int
AS
BEGIN

Select c.CourseName + '('+  ss.Semester + ')' as CourseName,ss.LearningObjective,ss.TextBookID,ss.prerequisite,cs.[Module],cs.CourseContents,cs.StartDate,cs.EndDate
from SyllabusGenerator..syllabus ss with (nolock) inner join SyllabusGenerator..CourseSchedule cs with (nolock) on ss.SyllabusID = cs.SyllabusID
inner join SyllabusGenerator..course c with (nolock) on  c.CourseID = ss.CourseID
where ss.SyllabusID = @SyllabusID and ss.ProfessorID = @ProfessorID


END

--
--exec spFetchSyllabusDetails 1, 1















