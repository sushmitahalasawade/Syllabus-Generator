USE syllabusGenerator
GO

CREATE or alter TRIGGER trInsteadofDeleteSyllabus
on Syllabus
After DELETE
AS


declare @SyllabusID INT
declare @CourseID int
declare @ProfessorID int
declare @textbookid nvarchar(100)
declare @Semester nvarchar(10)
declare @LearningObjective nvarchar(max)
declare @prerequisite nvarchar(50)     


select @SyllabusID= d.SyllabusID from deleted as d;
select @CourseID= d.CourseID from deleted as d;
select @ProfessorID= d.ProfessorID from deleted as d;
select @textbookid= d.TextBookID from deleted as d;
select @Semester= d.Semester from deleted as d;
select @LearningObjective= d.LearningObjective from deleted as d;
select @prerequisite= d.prerequisite from deleted as d;



Insert into SyllabusAudit (SyllabusID, CourseID, ProfessorID,textbookid,Semester,LearningObjective, prerequisite,Audit_action, Action_by, Action_At, Remark)
values(@SyllabusID,@CourseID,@ProfessorID,@textbookid,@Semester,@LearningObjective,@prerequisite,'DELETE',@ProfessorID,GETDATE(),'Deleted Syllabus')
print('Record deleted -Instead of Delete trigger')




-- test
/*

select * from syllabus where syllabusid = 4;
select * from syllabusaudit where syllabusid = 4 ;
*/


