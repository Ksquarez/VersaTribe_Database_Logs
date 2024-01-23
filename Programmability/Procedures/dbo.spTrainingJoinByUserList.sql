SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spTrainingJoinByUserList]

@Person_TOwner NVARCHAR(256),
@Is_Join bit,
@Org_Id int
AS
BEGIN TRY
	SET NOCOUNT ON;

	SELECT Training.Training_Id,
		   Training.Training_Name,
		   Training_Join.Is_Join
   FROM dbo.Org INNER JOIN
    dbo.Training ON dbo.Org.Org_Id = dbo.Training.Org_Id INNER JOIN
    dbo.Training_Join ON dbo.Training.Training_Id = dbo.Training_Join.Training_Id INNER JOIN
    dbo.Person ON dbo.Training_Join.Person_Id = dbo.Person.Person_Id
	WHERE Person.TOwner = @Person_TOwner AND Training_Join.Is_Join = @Is_Join AND Training.Org_Id = @Org_Id
	


End TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO