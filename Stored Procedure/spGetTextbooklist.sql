use SyllabusGenerator
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.spGetTextbooklist'))
   drop proc spGetTextbooklist
GO

Create proc spGetTextbooklist
    @category varchar(50)
AS
BEGIN



select * from TextBook where Category = @category



END

--
--exec spGetTextbooklist 1, 1

















