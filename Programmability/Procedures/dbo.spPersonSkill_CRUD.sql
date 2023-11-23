SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPersonSkill_CRUD]
(
  @PerSk_Id INT = NULL,
  @Person_Id INT = NULL,
  @Skill_Id INT = NULL,
  @Experience INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Status INT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM PersonSkill
        WHERE (@PerSk_Id IS NULL OR PerSk_Id = @PerSk_Id)
            AND (@Person_Id IS NULL OR Person_Id = @Person_Id)
			AND (@Skill_Id IS NULL OR Skill_Id = @Skill_Id)
			AND (@Experience IS NULL OR Experience = @Experience)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO PersonSkill (Person_Id, Skill_Id, Experience, TStamp, TOwner, Status)
        VALUES (@Person_Id, @Skill_Id, @Experience, @TStamp, @TOwner, @Status)

		SELECT * FROM PersonSkill WHERE PerSk_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE PersonSkill
        SET Person_Id = ISNULL(@Person_Id,Person_Id),
            Skill_Id = ISNULL(@Skill_Id,Skill_Id),
			Experience = ISNULL(@Experience,Experience),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
        WHERE PerSk_Id = @PerSk_Id

		SELECT * FROM PersonSkill WHERE PerSk_Id = @PerSk_Id

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM PersonSkill
        WHERE PerSk_Id = @PerSk_Id

		SELECT * FROM PersonSkill
        WHERE PerSk_Id = @PerSk_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO