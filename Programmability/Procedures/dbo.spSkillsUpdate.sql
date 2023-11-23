SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spSkillsUpdate]
(
	@Skill_Field nvarchar(50),
	@Skill_Name nvarchar(50),
	@TStamp datetime2,
	@TOwner nvarchar(256),
	@Skill_Id int,
	@Status int
)
AS
Begin Try
	SET NOCOUNT OFF;
	UPDATE [Skills] 
		SET [Skill_Field] = ISNULL(@Skill_Field,Skill_Field),
			[Skill_Name] = ISNULL(@Skill_Name,Skill_Name), 
			[TStamp] = @TStamp, [TOwner] = @TOwner, 
			[Status]=ISNULL(@Status,Status) 
		WHERE (([Skill_Id] = @Skill_Id));
	
	SELECT Skill_Id, Skill_Field, Skill_Name, TStamp, TOwner,Status FROM Skills WHERE (Skill_Id = @Skill_Id)
End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO