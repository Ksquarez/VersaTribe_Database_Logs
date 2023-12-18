SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create PROCEDURE [dbo].[sp_ServerGroups_Delete__ByGroup_Id]
    @Group_Id INT
AS
BEGIN TRY
	SET NOCOUNT ON;

    DELETE FROM [dbo].ServerGroups
    WHERE [Group_Id] = @Group_Id;

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO