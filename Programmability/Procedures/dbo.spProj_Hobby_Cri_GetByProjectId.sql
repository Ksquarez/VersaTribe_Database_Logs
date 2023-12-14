SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[spProj_Hobby_Cri_GetByProjectId] 
@ProjectId INT
AS
BEGIN TRY
  SELECT
        HC.Proj_Hobby_Cri_Id AS Proj_Hobby_Cri_Id,
        --HC.Project_Id,
        HC.Hobby_Id,
		H.Name AS HobbyName,
        HC.Status,
        HC.TStamp,
        HC.TOwner,
        HC.Mandatory
        
    FROM
        Project_Hobby_Criteria HC
	INNER JOIN
		Hobby H ON HC.Hobby_Id = H.Hobby_Id
    WHERE
        HC.Project_Id = @ProjectId;

END TRY

BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO