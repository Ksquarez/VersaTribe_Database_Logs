SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_GroupExtension_Create]
    @Extension_Id INT,
    @Srv_Group_Id INT,
    @Group_Id INT
AS
BEGIN TRY
	SET NOCOUNT ON;

    INSERT INTO [dbo].[GroupExtensions] ([Extension_Id], [Srv_Group_Id], [Group_Id])
    VALUES (@Extension_Id, @Srv_Group_Id, @Group_Id);

	SELECT * FROM [GroupExtensions] WHERE Grp_Ext_Id = SCOPE_IDENTITY();

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO