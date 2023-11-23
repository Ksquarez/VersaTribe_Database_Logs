SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spRefreshTokenUpdate]
(
	@TOwner nvarchar(256),
	@RefreshToken varchar(MAX),
	@RT_Expiry datetime,
	@Expire_in_sec int,
	@Issue datetime,
	@AT_Expiry datetime,
	@Status int,
	@Id int
)
AS
BEGIN TRY
	SET NOCOUNT OFF;
UPDATE [Refresh_Tokens] SET [TOwner] = @TOwner, [RefreshToken] = @RefreshToken, [RT_Expiry] = @RT_Expiry, [Expire_in_sec] = @Expire_in_sec, [Issue] = @Issue, [AT_Expiry] = @AT_Expiry, [Status] = @Status WHERE (([Id] = @Id));
	
SELECT Id, TOwner, RefreshToken, RT_Expiry, Expire_in_sec, Issue, AT_Expiry, Status FROM Refresh_Tokens WHERE (Id = @Id)
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO