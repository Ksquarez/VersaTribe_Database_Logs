SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spSkillsCri_GetByTrainingId]
    @TrainingId INT
AS
BEGIN TRY
    SELECT
        SC.Id AS Skills_Criteria_Id,
        --SC.Training_Id,
        SC.Skill_Id,
        S.Skill_Name,
        SC.Experience,
        SC.Status,
        SC.TStamp,
        SC.TOwner,
        SC.Mandatory
    FROM
        Skills_Criteria SC
    INNER JOIN
        Skills S ON SC.Skill_Id = S.Skill_Id
    WHERE
        SC.Training_Id = @TrainingId;

END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO