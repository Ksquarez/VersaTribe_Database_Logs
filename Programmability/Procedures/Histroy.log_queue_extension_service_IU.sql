SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Histroy].[log_queue_extension_service_IU]
 
  @queueid nvarchar(4000),
  @serverip nvarchar(4000),
  @extension nvarchar(4000),
  @Service_TStamp dbo.Service_TStamp,
  @Service_Response dbo.Service_Response,
  @Action nvarchar(4000) AS
BEGIN

    INSERT INTO Histroy.log_queue_extension_service (
    
      queueid,
      serverip,
      extension,
      Service_TStamp,
      Service_Response,
      Action)
    VALUES(
      
      @queueid,
      @serverip,
      @extension,
      @Service_TStamp,
      @Service_Response,
      @Action)
END
GO