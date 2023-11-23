SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPersonSkillUpdate]
(
	@Skill_Id int,
	@Experience tinyint,
	@Status int,
	@TStamp datetime2,
	@TOwner nvarchar(256),
	@PerSk_Id int
)
AS
Begin Try
	SET NOCOUNT OFF;
	UPDATE [PersonSkill] SET [Skill_Id] = ISNULL(@Skill_Id,Skill_Id), [Experience] = ISNULL(@Experience,Experience), [Status] = ISNULL(@Status,Status), [TStamp] = @TStamp, [TOwner] = @TOwner WHERE (([PerSk_Id] = @PerSk_Id));
	
	SELECT PerSk_Id, Person_Id, Skill_Id, Experience, Status , TStamp, TOwner FROM PersonSkill WHERE (PerSk_Id = @PerSk_Id)
End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO