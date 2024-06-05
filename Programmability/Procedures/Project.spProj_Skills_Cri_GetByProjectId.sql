SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Project].[spProj_Skills_Cri_GetByProjectId]
    @ProjectId INT
AS
BEGIN TRY
    SELECT
        SC.Proj_Skill_Cri_Id,
        --SC.Project_Id,
        SC.Skill_Id,
        S.Skill_Name,
        SC.Experience,
        SC.Status,
        SC.TStamp,
        SC.TOwner,
        SC.Mandatory
    FROM
        Project_Skills_Criteria SC
    INNER JOIN
        Skills S ON SC.Skill_Id = S.Skill_Id
    WHERE
        SC.Project_Id = @ProjectId;

END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO