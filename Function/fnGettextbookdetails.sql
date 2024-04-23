USE SyllabusGenerator;
GO

CREATE or ALTER FUNCTION fnGettextbookdetails
      (@SyllabusID int
       )

RETURNS table
RETURN
(

select TextBookName,TextBookID from TextBook where textbookid in (select * from STRING_SPLIT((select TextBookID from Syllabus where SyllabusID = @SyllabusID), ','))
)


--select * from dbo.fnGettextbookdetails(1)
