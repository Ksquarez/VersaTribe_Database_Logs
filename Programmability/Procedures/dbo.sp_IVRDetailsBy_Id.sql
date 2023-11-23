SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_IVRDetailsBy_Id]
@ivr_id INT
AS
BEGIN
    SELECT ivr_id,ivr_name ,ivr__filename,timeout, enabled FROM ivr_details WHERE ivr_id = @ivr_id;
END
GO