SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spOrgUpdate]
(
	@Org_Id int,
	@Org_Name nvarchar(50),
	@Status int,
	@OrgAdmin_Id nvarchar(256),
	@TStamp datetime2,
	@TOwner nvarchar(256)
	
)
AS
BEGIN TRY

	SET NOCOUNT OFF;
	UPDATE [Org] 
				SET [Org_Name] = ISNULL(@Org_Name,Org_Name),
					[OrgAdmin_Id] = ISNULL(@OrgAdmin_Id,OrgAdmin_Id), 
					[Status] = ISNULL(@Status ,Status), 
					[TStamp] = @TStamp, [TOwner] = @TOwner
					WHERE (([Org_Id] = @Org_Id));
	
SELECT * FROM Org WHERE (Org_Id = @Org_Id)

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO