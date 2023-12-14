SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROC [dbo].[spProjectExperienceCriteria_CRUD]
(
  @Proj_Exp_Id INT = NULL,
  @Project_Id INT = NULL,
  @Exp_Id INT = NULL,
  @Exp_months INT = NULL,
  @Job_Title NVARCHAR(50) = NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Mandatory BIT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Project_Experience_Criteria
        WHERE (@Proj_Exp_Id IS NULL OR Proj_Exp_Id = @Proj_Exp_Id)
            AND (@Project_Id IS NULL OR Project_Id = @Project_Id)
            AND (@Exp_Id IS NULL OR Exp_Id = @Exp_Id)
            AND (@Exp_months IS NULL OR Exp_months = @Exp_months)
            AND (@Job_Title IS NULL OR Job_Title = @Job_Title)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
            AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Project_Experience_Criteria (Project_Id, Exp_Id, Exp_months, Job_Title, Status, TStamp, TOwner, Mandatory)
        VALUES (@Project_Id, @Exp_Id, @Exp_months, @Job_Title, @Status, @TStamp, @TOwner, @Mandatory)

        SELECT * FROM Project_Experience_Criteria WHERE Proj_Exp_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Project_Experience_Criteria
        SET Project_Id = ISNULL(@Project_Id, Project_Id),
            Exp_Id = ISNULL(@Exp_Id, Exp_Id),
            Exp_months = ISNULL(@Exp_months, Exp_months),
            Job_Title = ISNULL(@Job_Title, Job_Title),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner,
            Mandatory = ISNULL(@Mandatory, Mandatory)
        WHERE Proj_Exp_Id = @Proj_Exp_Id;

        SELECT * FROM Project_Experience_Criteria WHERE Proj_Exp_Id = @Proj_Exp_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Project_Experience_Criteria
        WHERE Proj_Exp_Id = @Proj_Exp_Id;

        SELECT * FROM Project_Experience_Criteria WHERE Proj_Exp_Id = @Proj_Exp_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO