﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_Groups__Group_Id] 
(
    @Group_Id INT
)
AS
BEGIN TRY
	
	SELECT * FROM Groups WHERE Group_Id = @Group_Id

END TRY
BEGIN CATCH

   EXECUTE [dbo].[uspLogError];

END CATCH
GO