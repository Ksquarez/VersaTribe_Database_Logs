SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spServer_JsonModel]
(
  @Server_Id INT = NULL,
  @Server_Name NVARCHAR(50) = NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @PageSize INT = NULL,
  @PageNumber INT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	-- GET: Servers

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Servers
        WHERE (@Server_Id IS NULL OR Server_Id = @Server_Id)
            AND (@Server_Name IS NULL OR Server_Name = @Server_Name)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	 ELSE IF @Action = '/api/Servers/GetListPaging'
    BEGIN

        DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;
	
        SELECT 
		Servers.*
		FROM
		Servers
		ORDER BY Servers.Server_Name 
		OFFSET @Offset ROWS
        FETCH NEXT @PageSize ROWS ONLY
		FOR JSON PATH, INCLUDE_NULL_VALUES

    END
	
	
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO