SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgCreate]
(
	@Org_Name nvarchar(50),
	@TStamp datetime2,
	@TOwner nvarchar(256),
	@OrgAdmin_Id nvarchar(256)
)
AS
BEGIN TRY

	SET NOCOUNT OFF;
INSERT INTO [Org] ([Org_Name], [OrgAdmin_Id], [TStamp] , [TOwner]) VALUES (@Org_Name, @OrgAdmin_Id, @TStamp, @TOwner);
	
SELECT Org_Id, Org_Name, OrgAdmin_Id, TStamp, TOwner FROM Org WHERE (Org_Id = SCOPE_IDENTITY())

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO