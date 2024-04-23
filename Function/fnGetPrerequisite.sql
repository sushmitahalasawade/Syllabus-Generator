USE SyllabusGenerator;
GO

CREATE or ALTER FUNCTION fnGetPrerequisite
      (@SyllabusID int
       )

RETURNS table
RETURN
(

select CourseID,CourseCode,CourseName from Course where CourseID in (select * from STRING_SPLIT((select prerequisite from Syllabus where SyllabusID = @SyllabusID), ','))
)


--select * from dbo.fnGetPrerequisite(1)
