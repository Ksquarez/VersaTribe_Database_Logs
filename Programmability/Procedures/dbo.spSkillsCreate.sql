SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spSkillsCreate]
(
	@Skill_Field nvarchar(50),
	@Skill_Name nvarchar(50),
	@TStamp datetime2,
	@TOwner nvarchar(256)
)
AS
Begin Try
	SET NOCOUNT OFF;
	INSERT INTO [Skills] ([Skill_Field], [Skill_Name], [TStamp], [TOwner]) VALUES (@Skill_Field, @Skill_Name, @TStamp, @TOwner);
	
	SELECT Skill_Id, Skill_Field, Skill_Name, TStamp, TOwner FROM Skills WHERE (Skill_Id = SCOPE_IDENTITY())
End Try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO