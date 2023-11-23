SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spDidRoutesCreate]
(
  @did BIGINT,
  @description nvarchar(255),
  @route_type nvarchar(10),
  @route_id nvarchar(10),
  @create_date datetime,
  @update_date datetime,
  @enabled bit,
  @Org_Id int
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	INSERT INTO did_route(did,description,route_type,route_id,create_date,update_date,enabled,Org_Id)
		VALUES(@did,@description,@route_type,@route_id,@create_date,@update_date,@enabled,@Org_Id)

		SELECT * FROM did_route WHERE id = SCOPE_IDENTITY();
END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO