SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPersonHobbyUpdate]
(
	@Person_Id int,
	@Hobby_Id int,
	@Status int,
	@TOwner nvarchar(256),
	@TStamp datetime2
)
AS
Begin Try

	SET NOCOUNT OFF;
UPDATE [PersonHobby] 
		SET [Person_Id] = ISNULL(@Person_Id,Person_Id), 
			[Hobby_Id] = ISNULL(@Hobby_Id,Hobby_Id), 
			[Status] = ISNULL(@Status,Status), 
			[TOwner] = @TOwner, [TStamp] = @TStamp 
			WHERE (([Person_Id] = @Person_Id) AND ([Hobby_Id] = @Hobby_Id));
	
SELECT Person_Id, Hobby_Id, Status, TOwner, TStamp FROM PersonHobby WHERE (Hobby_Id = @Hobby_Id) AND (Person_Id = @Person_Id)

End try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO