SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPersonQualDetails]
AS
BEGIN TRY
	SET NOCOUNT ON;
	SELECT        PersonQualification.PQ_Id, Person.TOwner,Person.FirstName, Person.LastName, Course.Cou_Name, CourseType.Ctyp_Name, Institutes.Inst_Name, PersonQualification.YOP, PersonQualification.Grade,PersonQualification.Status,PersonQualification.TStamp
	FROM            Person INNER JOIN
							 PersonQualification ON Person.Person_Id = PersonQualification.Person_Id INNER JOIN
							 Qualification ON PersonQualification.QI_Id = Qualification.QI_Id INNER JOIN
							 Course ON Qualification.Cou_Id = Course.Cou_Id INNER JOIN
							 Institutes ON Qualification.Inst_Id = Institutes.Inst_Id INNER JOIN
							 CourseType ON Course.CTyp_Id = CourseType.CTyp_Id
End TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO