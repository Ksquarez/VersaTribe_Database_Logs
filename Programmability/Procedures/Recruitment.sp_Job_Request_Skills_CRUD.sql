SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create PROCEDURE [Recruitment].[sp_Job_Request_Skills_CRUD]
(
  @Job_Request_Skill_Id INT = NULL,
  @Job_Request_Id INT = NULL,
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
        FROM Recruitment.Job_Request_Skills
        WHERE (@Job_Request_Skill_Id IS NULL OR Job_Request_Skill_Id = @Job_Request_Skill_Id)
            AND (@Job_Request_Id IS NULL OR Job_Request_Id = @Job_Request_Id)
            AND (@Skill_Id IS NULL OR Skill_Id = @Skill_Id)
            AND (@Experience IS NULL OR Experience = @Experience)
            AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
            AND (@Status IS NULL OR Status = @Status)
            AND (@TStamp IS NULL OR TStamp = @TStamp)
            AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Recruitment.Job_Request_Skills (Job_Request_Id, Skill_Id, Experience, Mandatory, Status, TStamp, TOwner)
        VALUES (@Job_Request_Id, @Skill_Id, @Experience, @Mandatory, @Status, @TStamp, @TOwner)

        SELECT * FROM Recruitment.Job_Request_Skills WHERE Job_Request_Skill_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Recruitment.Job_Request_Skills
        SET Job_Request_Id = ISNULL(@Job_Request_Id, Job_Request_Id),
            Skill_Id = ISNULL(@Skill_Id, Skill_Id),
            Experience = ISNULL(@Experience, Experience),
            Mandatory = ISNULL(@Mandatory, Mandatory),
            Status = ISNULL(@Status, Status),
            TStamp = @TStamp,
            TOwner = @TOwner
        WHERE Job_Request_Skill_Id = @Job_Request_Skill_Id;

        SELECT * FROM Recruitment.Job_Request_Skills WHERE Job_Request_Skill_Id = @Job_Request_Skill_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Recruitment.Job_Request_Skills
        WHERE Job_Request_Skill_Id = @Job_Request_Skill_Id;

        SELECT * FROM Recruitment.Job_Request_Skills WHERE Job_Request_Skill_Id = @Job_Request_Skill_Id;
    END
END TRY
BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO