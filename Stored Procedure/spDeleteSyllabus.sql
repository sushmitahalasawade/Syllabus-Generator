use SyllabusGenerator
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.spDeleteSyllabus'))
   drop proc spDeleteSyllabus
GO

Create proc spDeleteSyllabus 
    @SyllabusID Int
AS
BEGIN

if exists(select * from SyllabusGenerator..CourseSchedule where SyllabusID = @SyllabusID)
begin
delete from SyllabusGenerator..CourseSchedule where SyllabusID = @SyllabusID
end
delete from SyllabusGenerator..Syllabus where SyllabusID = @SyllabusID

END

--exec spDeleteSyllabus 4
-- select * from Syllabus where SyllabusID = 4
--select * from SyllabusAudit where SyllabusID = 4
-- select * from CourseSchedule where SyllabusID = 4





