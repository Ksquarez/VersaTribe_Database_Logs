SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create Proc [dbo].[spSkills_CRUD]
(
  @Skill_Id INT = NULL,
  @Skill_Field NVARCHAR(50) = NULL,
  @Skill_Name NVARCHAR(50) = NULL,
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
        FROM Skills
        WHERE   (@Skill_Id IS NULL OR Skill_Id = @Skill_Id)
				AND (@Skill_Field IS NULL OR Skill_Field = @Skill_Field)
				AND (@Skill_Name IS NULL OR Skill_Name = @Skill_Name)
				AND (@TStamp IS NULL OR TStamp = @TStamp)
				AND (@TOwner IS NULL OR TOwner = @TOwner)
				AND (@Status IS NULL OR Status = @Status)
		END
	ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Skills (Skill_Field,Skill_Name, Status,TStamp,TOwner)
        VALUES (@Skill_Field,@Skill_Name, @Status, @TStamp, @TOwner)

		SELECT * FROM Skills WHERE Skill_Id = SCOPE_IDENTITY();
    END

	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Skills
        SET Skill_Field = ISNULL(@Skill_Field,Skill_Field),
			Skill_Name = ISNULL(@Skill_Name,Skill_Name),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Skill_Id = @Skill_Id

		SELECT * FROM Skills WHERE Skill_Id = @Skill_Id;
	END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Skills
        WHERE Skill_Id = @Skill_Id
		SELECT * FROM Skills
        WHERE Skill_Id = @Skill_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO