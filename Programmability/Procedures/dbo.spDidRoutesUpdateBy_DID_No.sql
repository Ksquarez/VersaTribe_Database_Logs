SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

Create PROCEDURE [dbo].[spDidRoutesUpdateBy_DID_No]
(
  @id INT = NULL, -- The ID of the record to update
  @did BIGINT,
  @description NVARCHAR(255),
  @route_type NVARCHAR(10),
  @route_id NVARCHAR(10),
  @create_date DATETIME,
  @update_date DATETIME,
  @enabled BIT
)
AS
BEGIN TRY
    UPDATE did_route
    SET
      did = @did,
      description = ISNULL(@description,description),
      route_type = ISNULL(@route_type,route_type),
      route_id = ISNULL(@route_id,route_id),
      create_date = ISNULL(@create_date,create_date),
      update_date = ISNULL(@update_date,update_date),
      enabled = ISNULL(@enabled,enabled)

    WHERE did = @did;

    SELECT * FROM did_route WHERE did = @did;
  
  
END TRY

BEGIN CATCH
  INSERT INTO dbo.DB_Errors
  VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());
END CATCH
GO