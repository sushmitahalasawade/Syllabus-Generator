CREATE TRIGGER trAfterUpdateSyllabus
on dbo.Syllabus
For UPDATE
AS

declare @textbookid varchar(100)
declare @LearningObjective varchar(max)
declare @prerequisite varchar(100)
declare @description varchar(50)
declare @SyllabusID int
declare @CourseID int
declare @ProfessorID int
declare @Semester int


select @textbookid= i.textbookid from inserted as i;
select @LearningObjective= i.LearningObjective from inserted as i;
select @prerequisite= i.prerequisite from inserted as i;
select @SyllabusID= i.SyllabusID from inserted as i;
select @CourseID= i.CourseID from inserted as i;
select @ProfessorID= i.ProfessorID from inserted as i;
select @Semester= i.Semester from inserted as i;

IF UPDATE(textbookid)
    SET @description = 'Updated textbookid of the syllabus'
    
IF UPDATE(LearningObjective)
    SET @description = 'Updated LearningObjective of the syllabus'

IF UPDATE(prerequisite)
    SET @description = 'Updated prerequisite of the syllabus'


Insert into SyllabusAudit (SyllabusID, CourseID, ProfessorID,textbookid,Semester,LearningObjective, prerequisite,Audit_action, Action_by, Action_At, Remark)
values(@SyllabusID,@CourseID,@ProfessorID,@textbookid,@Semester,@LearningObjective,@prerequisite,'UPDATE',@ProfessorID,GETDATE(),@description)



-- test
/*

select * from Syllabus;
select * from SyllabusAudit where syllabusid =1;
*/
