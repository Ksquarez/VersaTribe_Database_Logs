SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_ServerGroups_update__Group_Id] 
(
    @Group_Id INT,
	@Queue_Name NVARCHAR(MAX)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	BEGIN TRANSACTION;

   BEGIN
        -- Update the OrgServer record
        UPDATE ServerGroups
        SET Queue_Name = ISNULL(@Queue_Name,Queue_Name)		    
        WHERE Group_Id = @Group_Id ;

        -- You can add additional logic or error handling here if needed

        SELECT * FROM ServerGroups WHERE Group_Id = @Group_Id

    END

	 COMMIT;

END TRY
BEGIN CATCH

  ROLLBACK;

  EXECUTE [dbo].[uspLogError];

END CATCH
GO