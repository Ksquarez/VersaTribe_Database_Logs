SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Histroy].[log_queue_service_IU]

  @queueid nvarchar(4000),
  @serverip nvarchar(4000),
  @strategy nvarchar(4000),
  @timeout nvarchar(4000),
  @group_name nvarchar(4000),
  @Service_TStamp dbo.Service_TStamp,
  @Service_Response dbo.Service_Response,
  @Action nvarchar(4000) AS
BEGIN

    INSERT INTO Histroy.log_queue_service (
    
      queueid,
      serverip,
      strategy,
      timeout,
      group_name,
      Service_TStamp,
      Service_Response,
      Action)
    VALUES(
     
      @queueid,
      @serverip,
      @strategy,
      @timeout,
      @group_name,
      @Service_TStamp,
      @Service_Response,
      @Action)
END
GO