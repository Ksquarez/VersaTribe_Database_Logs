SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPersonSkillCreate]
(
	@Person_Id int,
	@Skill_Id int,
	@Experience tinyint,
	@Status int,
	@TStamp datetime2,
	@TOwner nvarchar(256)
)
AS 
Begin Try
	SET NOCOUNT OFF;
		INSERT INTO [PersonSkill] ([Person_Id], [Skill_Id], [Experience], [Status] , [TStamp], [TOwner]) VALUES (@Person_Id, @Skill_Id, @Experience,@Status, @TStamp, @TOwner);
	
	SELECT PerSk_Id, Person_Id, Skill_Id, Experience,Status, TStamp, TOwner FROM PersonSkill WHERE (PerSk_Id = SCOPE_IDENTITY())
End Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO