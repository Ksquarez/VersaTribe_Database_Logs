SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Recruitment].[sp_GetCandidateHobbies_ByCandidateId]
    @Candidate_Id INT
AS
BEGIN TRY
SET NOCOUNT ON;
    SELECT 
        ch.Candidate_Hobby_Id,
        ch.Candidate_Id,
        ch.Hobby_Id,
        h.Name AS Hobby_Name,  -- Joining with Hobby table to get Name
        ch.Status,
        ch.TStamp,
        ch.TOwner
    FROM 
        [Recruitment].[Candidate_Hobby] ch
    INNER JOIN 
        [dbo].[Hobby] h ON ch.Hobby_Id = h.Hobby_Id
    WHERE 
        ch.Candidate_Id = @Candidate_Id;
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO