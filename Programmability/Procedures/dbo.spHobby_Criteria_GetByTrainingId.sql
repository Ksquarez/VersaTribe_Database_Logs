SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[spHobby_Criteria_GetByTrainingId] 
@TrainingId INT
AS
BEGIN TRY
  SELECT
        HC.Id AS Hobby_Criteria_Id,
        --HC.Training_Id,
        HC.Hobby_Id,
		H.Name AS HobbyName,
        HC.Status,
        HC.TStamp,
        HC.TOwner,
        HC.Mandatory
        
    FROM
        Hobby_Criteria HC
	INNER JOIN
		Hobby H ON HC.Hobby_Id = H.Hobby_Id
    WHERE
        HC.Training_Id = @TrainingId;

END TRY

BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO