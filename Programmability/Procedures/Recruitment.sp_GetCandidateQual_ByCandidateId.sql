SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Recruitment].[sp_GetCandidateQual_ByCandidateId]
    @Candidate_Id INT
AS
BEGIN TRY
SET NOCOUNT ON;
    SELECT 
        cq.Candidate_Qualification_Id,
        cq.Candidate_Id,
        cq.QI_Id,
        q.Cou_Id,
        c.Cou_Name,
        ct.CTyp_Name,
        i.Inst_Name,
        cq.YOP,
        cq.Grade,
        cq.City,
        cq.Status,
        cq.TStamp,
        cq.TOwner
    FROM 
        [Recruitment].[Candidate_Qualification] cq
    INNER JOIN 
        [dbo].[Qualification] q ON cq.QI_Id = q.QI_Id
    INNER JOIN 
        [dbo].[Course] c ON q.Cou_Id = c.Cou_Id
    INNER JOIN 
        [dbo].[CourseType] ct ON c.CTyp_Id = ct.CTyp_Id
    INNER JOIN 
        [dbo].[Institutes] i ON q.Inst_Id = i.Inst_Id
    WHERE 
        cq.Candidate_Id = @Candidate_Id;
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO