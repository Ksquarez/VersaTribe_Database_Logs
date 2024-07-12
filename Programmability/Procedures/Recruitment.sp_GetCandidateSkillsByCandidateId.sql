SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Recruitment].[sp_GetCandidateSkillsByCandidateId]
(
	@Candidate_Id INT
)
AS
BEGIN TRY
	SET NOCOUNT ON;
    SELECT 
        cs.Candidate_Skills_Id,
        cs.Candidate_Id,
        cs.Skill_Id,
        s.Skill_Name,  -- Joining with Skills table to get Skill_Name
        cs.Experience,
        cs.Status,
        cs.TStamp,
        cs.TOwner
    FROM 
        [Recruitment].[Candidate_Skills] cs
    INNER JOIN 
        [dbo].[Skills] s ON cs.Skill_Id = s.Skill_Id
	Where cs.Candidate_Id = @Candidate_Id
END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO