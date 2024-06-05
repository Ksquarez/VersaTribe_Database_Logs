SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [Histroy].[log_extension_service_IU]

  @extension nvarchar(4000),
  @secret nvarchar(4000),
  @transport nvarchar(4000),
  @serverip nvarchar(4000),
  @name nvarchar(4000),
  @Service_Response dbo.Service_Response,
  @Service_TStamp dbo.Service_TStamp,
  @Action nvarchar(4000) AS
BEGIN

    INSERT INTO Histroy.log_extension_service (
      
      extension,
      secret,
      transport,
      serverip,
      name,
      Service_Response,
      Service_TStamp,
      Action)
    VALUES(

      @extension,
      @secret,
      @transport,
      @serverip,
      @name,
      @Service_Response,
      @Service_TStamp,
      @Action)
END
GO