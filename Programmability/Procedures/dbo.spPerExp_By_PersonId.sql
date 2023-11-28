SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPerExp_By_PersonId]
(
	@Person_Id int
)
AS
Begin Try
	SET NOCOUNT ON;
	SELECT      PersonExperience.Person_Id, PersonExperience.Exp_Id,Experience.Company_Name,Experience.Industry_Field_Name,
				PersonExperience.Exp_months,PersonExperience.Job_Title,PersonExperience.Status, PersonExperience.TOwner, 
				PersonExperience.TStamp
	FROM  Experience INNER JOIN	 
		  PersonExperience ON PersonExperience.Exp_Id = Experience.Exp_Id
	WHERE        (PersonExperience.Person_Id = @Person_Id)
End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO