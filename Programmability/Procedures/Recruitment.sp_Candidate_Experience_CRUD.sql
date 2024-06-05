SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


Create PROC [Recruitment].[sp_Candidate_Experience_CRUD]
(
  @Candidate_Experience_Id INT = NULL,
  @Candidate_Id INT = NULL,
  @Exp_Id INT = NULL,
  @Exp_Months INT = NULL,
  @Job_Title NVARCHAR(50) = NULL,
  @Start_Date DATE = NULL,
  @End_Date DATE = NULL,
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
        FROM [Recruitment].[Candidate_Experience]
        WHERE (@Candidate_Experience_Id IS NULL OR Candidate_Experience_Id = @Candidate_Experience_Id)
            AND (@Candidate_Id IS NULL OR Candidate_Id = @Candidate_Id)
            AND (@Exp_Id IS NULL OR Exp_Id = @Exp_Id)
            AND (@Exp_Months IS NULL OR Exp_Months = @Exp_Months)
            AND (@Job_Title IS NULL OR Job_Title = @Job_Title)
            AND (@Start_Date IS NULL OR Start_Date = @Start_Date)
            AND (@End_Date IS NULL OR End_Date = @End_Date)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO [Recruitment].[Candidate_Experience] (Candidate_Id, Exp_Id, Exp_Months, Job_Title, Start_Date, End_Date, Status, TStamp, TOwner)
        VALUES (@Candidate_Id, @Exp_Id, @Exp_Months, @Job_Title, @Start_Date, @End_Date, @Status, @TStamp, @TOwner)

        SELECT * FROM [Recruitment].[Candidate_Experience] WHERE Candidate_Experience_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE [Recruitment].[Candidate_Experience]
        SET Candidate_Id = ISNULL(@Candidate_Id, Candidate_Id),
            Exp_Id = ISNULL(@Exp_Id, Exp_Id),
            Exp_Months = ISNULL(@Exp_Months, Exp_Months),
            Job_Title = ISNULL(@Job_Title, Job_Title),
            Start_Date = ISNULL(@Start_Date, Start_Date),
            End_Date = ISNULL(@End_Date, End_Date),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner
        WHERE Candidate_Experience_Id = @Candidate_Experience_Id;

        SELECT * FROM [Recruitment].[Candidate_Experience] WHERE Candidate_Experience_Id = @Candidate_Experience_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM [Recruitment].[Candidate_Experience]
        WHERE Candidate_Experience_Id = @Candidate_Experience_Id;

        SELECT * FROM [Recruitment].[Candidate_Experience] WHERE Candidate_Experience_Id = @Candidate_Experience_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO