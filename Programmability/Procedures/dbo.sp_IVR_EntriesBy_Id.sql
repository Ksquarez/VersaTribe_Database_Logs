SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_IVR_EntriesBy_Id]
@ivr_id BIGINT
AS
BEGIN
   SELECT ivr_id,selection,destination,destination_type FROM ivr_entries WHERE ivr_id = @ivr_id;
END
GO