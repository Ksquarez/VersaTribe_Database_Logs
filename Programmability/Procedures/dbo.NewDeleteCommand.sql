SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[NewDeleteCommand]
(
	@Original_Person_Id int
)
AS
	SET NOCOUNT OFF;
DELETE FROM [Person] WHERE (([Person_Id] = @Original_Person_Id))
GO