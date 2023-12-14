SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GroupExtension_Delete__Group_Id]
    @Group_Id INT
AS
BEGIN TRY
	SET NOCOUNT ON;

    DELETE FROM [dbo].[GroupExtensions]
    WHERE [Group_Id] = @Group_Id;

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO