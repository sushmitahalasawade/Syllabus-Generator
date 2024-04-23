use SyllabusGenerator
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.spGetTextbookDetails'))
   drop proc spGetTextbookDetails
GO

Create proc spGetTextbookDetails
    @SyllabusID Int
AS
BEGIN

declare @textbookid varchar(500)
set @textbookid = (select TextBookID from Syllabus where SyllabusID = @SyllabusID)

select TextBookName from TextBook where textbookid in (select * from STRING_SPLIT(@textbookid, ','))



END

--
--exec spFetchSyllabusDetails 1, 1

















