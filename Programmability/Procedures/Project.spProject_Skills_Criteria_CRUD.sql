SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE PROC [Project].[spProject_Skills_Criteria_CRUD]
(
  @Proj_Skill_Cri_Id INT = NULL,
  @Project_Id INT = NULL,
  @Skill_Id INT = NULL,
  @Experience INT = NULL,
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
        FROM Project_Skills_Criteria
        WHERE (@Proj_Skill_Cri_Id IS NULL OR Proj_Skill_Cri_Id = @Proj_Skill_Cri_Id)
            AND (@Project_Id IS NULL OR Project_Id = @Project_Id)
            AND (@Skill_Id IS NULL OR Skill_Id = @Skill_Id)
			AND (@Experience IS NULL OR Experience = @Experience)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
            AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Project_Skills_Criteria (Project_Id, Skill_Id,Experience, Status, TStamp, TOwner, Mandatory)
        VALUES (@Project_Id, @Skill_Id,@Experience, @Status, @TStamp, @TOwner, @Mandatory)

        SELECT * FROM Project_Skills_Criteria WHERE Proj_Skill_Cri_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Project_Skills_Criteria
        SET Project_Id = ISNULL(@Project_Id, Project_Id),
            Skill_Id = ISNULL(@Skill_Id, Skill_Id),
			Experience = ISNULL(@Experience,Experience),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner,
            Mandatory = ISNULL(@Mandatory, Mandatory)
        WHERE Proj_Skill_Cri_Id = @Proj_Skill_Cri_Id;

        SELECT * FROM Project_Skills_Criteria WHERE Proj_Skill_Cri_Id = @Proj_Skill_Cri_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Project_Skills_Criteria
        WHERE Proj_Skill_Cri_Id = @Proj_Skill_Cri_Id;

        SELECT * FROM Project_Skills_Criteria WHERE Proj_Skill_Cri_Id = @Proj_Skill_Cri_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO