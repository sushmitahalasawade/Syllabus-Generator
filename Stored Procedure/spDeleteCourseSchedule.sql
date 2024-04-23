use SyllabusGenerator
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.spDeleteCourseSchedule'))
   drop proc spDeleteCourseSchedule
GO

Create proc spDeleteCourseSchedule 
    @SyllabusID Int
    ,@CourseScheduleID int 
AS
BEGIN

if(@CourseScheduleID != Null)
BEGIN
delete from SyllabusGenerator..CourseSchedule where SyllabusID = @SyllabusID and CourseScheduleID = @CourseScheduleID
end
ELSE
BEGIN
delete from SyllabusGenerator..CourseSchedule where SyllabusID = @SyllabusID
end


END





