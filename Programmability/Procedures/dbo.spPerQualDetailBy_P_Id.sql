SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPerQualDetailBy_P_Id]
(
	@Person_Id int
)
AS
BEGIN TRY
	SET NOCOUNT ON;
SELECT        PersonQualification.PQ_Id,PersonQualification.Person_Id, CourseType.Ctyp_Name, Course.Cou_Name, Institutes.Inst_Name, Institutes.Inst_Type, Institutes.City, PersonQualification.YOP, PersonQualification.Grade, PersonQualification.Status, 
                         PersonQualification.TOwner, PersonQualification.TStamp
FROM            Course INNER JOIN
                         CourseType ON Course.CTyp_Id = CourseType.CTyp_Id INNER JOIN
                         Qualification ON Course.Cou_Id = Qualification.Cou_Id INNER JOIN
                         Institutes ON Qualification.Inst_Id = Institutes.Inst_Id INNER JOIN
                         PersonQualification ON Qualification.QI_Id = PersonQualification.QI_Id
WHERE        (PersonQualification.Person_Id = @Person_Id)

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO