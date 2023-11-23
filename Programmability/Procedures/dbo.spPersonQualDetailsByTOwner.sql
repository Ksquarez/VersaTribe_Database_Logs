SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPersonQualDetailsByTOwner]
(
	@TOwner nvarchar(256)
)
AS
Begin Try
	SET NOCOUNT ON;
	SELECT        PersonQualification.PQ_Id, Person.FirstName, Person.LastName, Course.Cou_Name, CourseType.Ctyp_Name, Institutes.Inst_Name, PersonQualification.YOP, PersonQualification.Grade,Institutes.City,
                         Person.TOwner, PersonQualification.TStamp, PersonQualification.Status
	FROM                 Institutes INNER JOIN
                         Course INNER JOIN
                         CourseType ON Course.CTyp_Id = CourseType.CTyp_Id INNER JOIN
                         PersonQualification INNER JOIN
                         Person ON PersonQualification.Person_Id = Person.Person_Id INNER JOIN
                         Qualification ON PersonQualification.QI_Id = Qualification.QI_Id ON Course.Cou_Id = Qualification.Cou_Id ON Institutes.Inst_Id = Qualification.Inst_Id
	WHERE        (PersonQualification.TOwner = @TOwner)

End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO