SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Recruitment].[sp_GetCandidateExp_ByCandidateId]
    @Candidate_Id INT
AS
BEGIN TRY
SET NOCOUNT ON;
    SELECT 
        ce.Candidate_Experience_Id,
        ce.Candidate_Id,
        ce.Exp_Id,
        e.Company_Name,
        e.Industry_Field_Name,
        ce.Exp_Months,
        ce.Job_Title,
        ce.Start_Date,
        ce.End_Date,
        ce.Status,
        ce.TStamp,
        ce.TOwner
    FROM 
        [Recruitment].[Candidate_Experience] ce
    INNER JOIN 
        [dbo].[Experience] e ON ce.Exp_Id = e.Exp_Id
    WHERE 
        ce.Candidate_Id = @Candidate_Id;
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO