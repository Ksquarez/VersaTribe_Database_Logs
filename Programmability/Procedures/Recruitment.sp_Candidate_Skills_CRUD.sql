SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

Create PROCEDURE [Recruitment].[sp_Candidate_Skills_CRUD]
(
  @Candidate_Skills_Id INT = NULL,
  @Candidate_Id INT = NULL,
  @Skill_Id INT = NULL,
  @Experience TINYINT = NULL,
  @Mandatory BIT = NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Recruitment.Candidate_Skills
        WHERE (@Candidate_Skills_Id IS NULL OR Candidate_Skills_Id = @Candidate_Skills_Id)
            AND (@Candidate_Id IS NULL OR Candidate_Id = @Candidate_Id)
            AND (@Skill_Id IS NULL OR Skill_Id = @Skill_Id)
            AND (@Experience IS NULL OR Experience = @Experience)
            AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Recruitment.Candidate_Skills (Candidate_Id, Skill_Id, Experience, Mandatory, Status, TStamp, TOwner)
        VALUES (@Candidate_Id, @Skill_Id, @Experience, @Mandatory, @Status, @TStamp, @TOwner)

        SELECT * FROM Recruitment.Candidate_Skills WHERE Candidate_Skills_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Recruitment.Candidate_Skills
        SET Candidate_Id = ISNULL(@Candidate_Id, Candidate_Id),
            Skill_Id = ISNULL(@Skill_Id, Skill_Id),
            Experience = ISNULL(@Experience, Experience),
            Mandatory = ISNULL(@Mandatory, Mandatory),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner
        WHERE Candidate_Skills_Id = @Candidate_Skills_Id;

        SELECT * FROM Recruitment.Candidate_Skills WHERE Candidate_Skills_Id = @Candidate_Skills_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Recruitment.Candidate_Skills
        WHERE Candidate_Skills_Id = @Candidate_Skills_Id;

        SELECT * FROM Recruitment.Candidate_Skills WHERE Candidate_Skills_Id = @Candidate_Skills_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO