SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Histroy].[log_did_service_IU]
  @serverip nvarchar(4000),
  @did nvarchar(4000),
  @Service_Response dbo.Service_Response,
  @Service_TStamp dbo.Entity_TStamp,
  @Action nvarchar(4000) AS
BEGIN
    INSERT INTO Histroy.log_did_service (
      serverip,
      did,
      Service_Response,
      Service_TStamp,
      Action)
    VALUES(
      @serverip,
      @did,
      @Service_Response,
      @Service_TStamp,
      @Action)
END
GO