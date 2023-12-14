SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROC [dbo].[spProjectHobbyCriteria_CRUD]
(
  @Proj_Hobby_Cri_Id INT = NULL,
  @Project_Id INT = NULL,
  @Hobby_Id INT = NULL,
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
        FROM Project_Hobby_Criteria
        WHERE (@Proj_Hobby_Cri_Id IS NULL OR Proj_Hobby_Cri_Id = @Proj_Hobby_Cri_Id)
            AND (@Project_Id IS NULL OR Project_Id = @Project_Id)
            AND (@Hobby_Id IS NULL OR Hobby_Id = @Hobby_Id)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
            AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Project_Hobby_Criteria (Project_Id, Hobby_Id, Status, TStamp, TOwner, Mandatory)
        VALUES (@Project_Id, @Hobby_Id, @Status, @TStamp, @TOwner, @Mandatory)

        SELECT * FROM Project_Hobby_Criteria WHERE Proj_Hobby_Cri_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Project_Hobby_Criteria
        SET Project_Id = ISNULL(@Project_Id, Project_Id),
            Hobby_Id = ISNULL(@Hobby_Id, Hobby_Id),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner,
            Mandatory = ISNULL(@Mandatory, Mandatory)
        WHERE Proj_Hobby_Cri_Id = @Proj_Hobby_Cri_Id;

        SELECT * FROM Project_Hobby_Criteria WHERE Proj_Hobby_Cri_Id = @Proj_Hobby_Cri_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Project_Hobby_Criteria
        WHERE Proj_Hobby_Cri_Id = @Proj_Hobby_Cri_Id;

        SELECT * FROM Project_Hobby_Criteria WHERE Proj_Hobby_Cri_Id = @Proj_Hobby_Cri_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH



GO