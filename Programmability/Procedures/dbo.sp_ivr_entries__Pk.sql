SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_ivr_entries__Pk]
@id INT
AS
BEGIN
  
  SELECT * FROM ivr_entries  WHERE id = @id

END
GO