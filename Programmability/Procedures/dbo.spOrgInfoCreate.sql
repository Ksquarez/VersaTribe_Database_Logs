SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgInfoCreate]
(
	@Org_Id int,
	@About_org nvarchar(MAX),
	@City nvarchar(50),
	@Country nvarchar(50),
	@Contact_email varchar(50),
	@Contact_number varchar(15),
	@TStamp datetime2,
	@TOwner nvarchar(256),
	@Status int
)
AS
BEGIN TRY
	SET NOCOUNT OFF;
INSERT INTO [OrgInfo] ([Org_Id], [About_org], [City], [Country], [Contact_email], [Contact_number], [TStamp], [TOwner], [Status]) VALUES (@Org_Id, @About_org, @City, @Country, @Contact_email, @Contact_number, @TStamp, @TOwner, @Status);
	
SELECT * FROM OrgInfo WHERE (Org_Id = @Org_Id)

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO