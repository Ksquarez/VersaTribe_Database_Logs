SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgInfoUpdate]
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
	UPDATE [OrgInfo] 
	SET [About_org] = ISNULL(@About_org,About_org),
		[City] = ISNULL(@City,City), 
		[Country] = ISNULL(@Country,Country),
		[Contact_email] = ISNULL(@Contact_email,Contact_email),
		[Contact_number] = ISNULL(@Contact_number,Contact_number),
		[TStamp] = @TStamp, [TOwner] = @TOwner,
		[Status] = ISNULL(@Status,Status) 
		WHERE (([Org_Id] = @Org_Id));
	
SELECT *  FROM OrgInfo WHERE (Org_Id = @Org_Id)

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO