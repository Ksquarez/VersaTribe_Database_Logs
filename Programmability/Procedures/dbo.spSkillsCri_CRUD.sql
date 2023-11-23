SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spSkillsCri_CRUD]
(
  @Id INT = NULL,
  @Training_Id INT = NULL,
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
        FROM Skills_Criteria
        WHERE (@Id IS NULL OR Id = @Id)
		    AND (@Training_Id IS NULL OR Training_Id = @Training_Id)
            AND (@Skill_Id IS NULL OR Skill_Id = @Skill_Id)
			AND (@Experience IS NULL OR Experience = @Experience)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Mandatory IS NULL OR Mandatory = @Mandatory)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Skills_Criteria(Training_Id,Skill_Id, Experience, Status,TStamp, TOwner, Mandatory)
        VALUES (@Training_Id, @Skill_Id,@Experience , @Status,@TStamp, @TOwner, @Mandatory)

		SELECT * FROM Skills_Criteria WHERE Id = SCOPE_IDENTITY()

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Skills_Criteria
        SET Training_Id = ISNULL(@Training_Id, Training_Id),
			Skill_Id = ISNULL(@Skill_Id, Skill_Id),
			Experience = ISNULL(@Experience,Experience),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Mandatory = ISNULL(@Mandatory,Mandatory)
        WHERE Id = @Id

		SELECT * FROM Skills_Criteria  WHERE Id = @Id

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Skills_Criteria
        WHERE Id = @Id

		Select * FROM Skills_Criteria Where Id = @Id

    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO