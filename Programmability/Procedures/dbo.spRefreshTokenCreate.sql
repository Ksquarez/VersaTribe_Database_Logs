SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spRefreshTokenCreate]
(
	@TOwner nvarchar(256),
	@RefreshToken varchar(MAX),
	@RT_Expiry datetime,
	@Expire_in_sec int,
	@Issue datetime,
	@AT_Expiry datetime,
	@Status int
)
AS
BEGIN TRY
	SET NOCOUNT OFF;
INSERT INTO [Refresh_Tokens] ([TOwner], [RefreshToken], [RT_Expiry], [Expire_in_sec], [Issue], [AT_Expiry], [Status]) VALUES (@TOwner, @RefreshToken, @RT_Expiry, @Expire_in_sec, @Issue, @AT_Expiry, @Status);
	
SELECT Id, TOwner, RefreshToken, RT_Expiry, Expire_in_sec, Issue, AT_Expiry, Status FROM Refresh_Tokens WHERE (Id = SCOPE_IDENTITY())
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO