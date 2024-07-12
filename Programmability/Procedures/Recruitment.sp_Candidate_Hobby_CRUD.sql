SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [Recruitment].[sp_Candidate_Hobby_CRUD]
(
  @Candidate_Hobby_Id INT = NULL,
  @Candidate_Id INT = NULL,
  @Hobby_Id INT = NULL,
  --@Mandatory BIT = NULL,
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
        FROM Recruitment.Candidate_Hobby
        WHERE (@Candidate_Hobby_Id IS NULL OR Candidate_Hobby_Id = @Candidate_Hobby_Id)
            AND (@Candidate_Id IS NULL OR Candidate_Id = @Candidate_Id)
            AND (@Hobby_Id IS NULL OR Hobby_Id = @Hobby_Id)
            --AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Recruitment.Candidate_Hobby (Candidate_Id, Hobby_Id,  Status, TStamp, TOwner)
        VALUES (@Candidate_Id, @Hobby_Id, @Status, @TStamp, @TOwner)

        SELECT * FROM Recruitment.Candidate_Hobby WHERE Candidate_Hobby_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Recruitment.Candidate_Hobby
        SET Candidate_Id = ISNULL(@Candidate_Id, Candidate_Id),
            Hobby_Id = ISNULL(@Hobby_Id, Hobby_Id),
            --Mandatory = ISNULL(@Mandatory, Mandatory),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner
        WHERE Candidate_Hobby_Id = @Candidate_Hobby_Id;

        SELECT * FROM Recruitment.Candidate_Hobby WHERE Candidate_Hobby_Id = @Candidate_Hobby_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Recruitment.Candidate_Hobby
        WHERE Candidate_Hobby_Id = @Candidate_Hobby_Id;

        SELECT * FROM Recruitment.Candidate_Hobby WHERE Candidate_Hobby_Id = @Candidate_Hobby_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO