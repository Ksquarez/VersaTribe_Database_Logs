SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Training].[spTrainingsListPaging]

 @PageSize INT,
 @PageNumber INT

AS
BEGIN TRY
	SET NOCOUNT ON;

	DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
		SELECT 
		   Training.Training_Id,
	       Training.Org_Id,
		   Org.Org_Name,
	       Training.Trainer_Id,
		   Training.Training_Name,
		   Training.Description,
		   Training.Start_Date,
		   Training.End_Date,
		   Training.PersonLimit
		FROM
		Training
		LEFT JOIN ORG ON ORG.Org_Id = Training.Org_Id
		ORDER BY Training.Training_Name
		OFFSET @Offset ROWS
		FETCH NEXT @PageSize ROWS ONLY

End TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO