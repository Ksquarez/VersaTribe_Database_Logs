SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create PROC [Recruitment].[sp_Job_Request_Experience_CRUD]
(
  @Job_Request_Experience_Id INT = NULL,
  @Job_Request_Id INT = NULL,
  @Exp_Id INT = NULL,
  @Exp_Months INT = NULL,
  @Job_Title NVARCHAR(50) = NULL,
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
        FROM [Recruitment].[Job_Request_Experience]
        WHERE (@Job_Request_Experience_Id IS NULL OR Job_Request_Experience_Id = @Job_Request_Experience_Id)
            AND (@Job_Request_Id IS NULL OR Job_Request_Id = @Job_Request_Id)
            AND (@Exp_Id IS NULL OR Exp_Id = @Exp_Id)
            AND (@Exp_Months IS NULL OR Exp_Months = @Exp_Months)
            AND (@Job_Title IS NULL OR Job_Title = @Job_Title)
            AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO [Recruitment].[Job_Request_Experience] (Job_Request_Id, Exp_Id, Exp_Months, Job_Title, Mandatory, Status, TStamp, TOwner)
        VALUES (@Job_Request_Id, @Exp_Id, @Exp_Months, @Job_Title, @Mandatory, @Status, @TStamp, @TOwner)

        SELECT * FROM [Recruitment].[Job_Request_Experience] WHERE Job_Request_Experience_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE [Recruitment].[Job_Request_Experience]
        SET Job_Request_Id = ISNULL(@Job_Request_Id, Job_Request_Id),
            Exp_Id = ISNULL(@Exp_Id, Exp_Id),
            Exp_Months = ISNULL(@Exp_Months, Exp_Months),
            Job_Title = ISNULL(@Job_Title, Job_Title),
            Mandatory = ISNULL(@Mandatory, Mandatory),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner
        WHERE Job_Request_Experience_Id = @Job_Request_Experience_Id;

        SELECT * FROM [Recruitment].[Job_Request_Experience] WHERE Job_Request_Experience_Id = @Job_Request_Experience_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM [Recruitment].[Job_Request_Experience]
        WHERE Job_Request_Experience_Id = @Job_Request_Experience_Id;

        SELECT * FROM [Recruitment].[Job_Request_Experience] WHERE Job_Request_Experience_Id = @Job_Request_Experience_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO