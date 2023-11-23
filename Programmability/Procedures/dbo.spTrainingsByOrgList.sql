SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spTrainingsByOrgList]

@Org_Id INT

AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT Training.Training_Id,
	       Training.Org_Id,
		   Org.Org_Name,
	       Training.Trainer_Id,
		   Training.Training_Name,
		   Training.Description,
		   Training.Start_Date,
		   Training.End_Date,
		   Training.PersonLimit
    FROM Training 
	INNER JOIN ORG ON ORG.Org_Id = Training.Org_Id
	WHERE ORG.Org_Id = @Org_Id

End TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO