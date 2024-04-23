use SyllabusGenerator
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.spInsertorUpdateSyllabus'))
   drop proc spInsertorUpdateSyllabus
GO

Create proc spInsertorUpdateSyllabus
    @SyllabusID varchar(10),
    @textbookid varchar(100),
    @LearningObjective varchar(max),
    @prerequisite varchar(100),
    @Module varchar(20),
    @CourseContents varchar(max),
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN

update Syllabus with (rowlock) set textbookid = @textbookid, LearningObjective= @LearningObjective, prerequisite= @prerequisite where SyllabusID = @SyllabusID 

if Exists(select * from CourseSchedule where SyllabusID = @SyllabusID and module = @Module)
BEGIN
update CourseSchedule with (rowlock) set CourseContents = @CourseContents, StartDate= @StartDate, EndDate= @EndDate where SyllabusID = @SyllabusID and module = @Module
END
ELSE
BEGIN
INSERT INTO CourseSchedule ( SyllabusID, CourseID,Module,CourseContents,StartDate, EndDate) VALUES
( @SyllabusID, 1,@Module,@CourseContents, @StartDate,@EndDate)
END

END

--
--exec spInsertorUpdateSyllabus 1, '1,2', '1.Understand the principles of conceptual modeling,2.understand the use of scripts when implementing SQL code','3','Module1','Understand the principles of conceptual modeling(ORM).','18 Aug 2022','30 Aug 2022'


--select CourseContents,StartDate,* from CourseSchedule where SyllabusID =1 and module = 'Module1'
