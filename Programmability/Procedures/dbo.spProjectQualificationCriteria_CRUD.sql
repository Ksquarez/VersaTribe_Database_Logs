SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROC [dbo].[spProjectQualificationCriteria_CRUD]
(
  @Proj_Qual_Id INT = NULL,
  @Project_Id INT = NULL,
  @Cou_Id INT = NULL,
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
        FROM Project_Qualification_Criteria
        WHERE (@Proj_Qual_Id IS NULL OR Proj_Qual_Id = @Proj_Qual_Id)
            AND (@Project_Id IS NULL OR Project_Id = @Project_Id)
            AND (@Cou_Id IS NULL OR Cou_Id = @Cou_Id)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
            AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Project_Qualification_Criteria (Project_Id, Cou_Id, Status, TStamp, TOwner, Mandatory)
        VALUES (@Project_Id, @Cou_Id, @Status, @TStamp, @TOwner, @Mandatory)

        SELECT * FROM Project_Qualification_Criteria WHERE Proj_Qual_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Project_Qualification_Criteria
        SET Project_Id = ISNULL(@Project_Id, Project_Id),
            Cou_Id = ISNULL(@Cou_Id, Cou_Id),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner,
            Mandatory = ISNULL(@Mandatory, Mandatory)
        WHERE Proj_Qual_Id = @Proj_Qual_Id;

        SELECT * FROM Project_Qualification_Criteria WHERE Proj_Qual_Id = @Proj_Qual_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Project_Qualification_Criteria
        WHERE Proj_Qual_Id = @Proj_Qual_Id;

        SELECT * FROM Project_Qualification_Criteria WHERE Proj_Qual_Id = @Proj_Qual_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH

GO