SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spTrainingJoinPerosnList]

@Training_Id INT,
@Is_Join BIT

AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT Training.Training_Id,
		   Training.Training_Name,
		   Person.FirstName,
		   Person.LastName,
		   Person.TOwner,
		   Training_Join.Is_Join
   FROM dbo.Org INNER JOIN
    dbo.Training ON dbo.Org.Org_Id = dbo.Training.Org_Id INNER JOIN
    dbo.Training_Join ON dbo.Training.Training_Id = dbo.Training_Join.Training_Id INNER JOIN
    dbo.Person ON dbo.Training_Join.Person_Id = dbo.Person.Person_Id
	WHERE Training.Training_Id = @Training_Id AND Training_Join.Is_Join = @Is_Join
	


End TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO