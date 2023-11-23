SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create Proc [dbo].[spServerExtension_CRUD]
(
  @Server_Id INT = NULL,
  @Ext_Id INT = NULL,
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL, 
  @Action NVARCHAR(100)

)   
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM ServerExtension
        WHERE (@Server_Id IS NULL OR Server_Id = @Server_Id)
            AND (@Ext_Id IS NULL OR Ext_Id = @Ext_Id)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
		INSERT INTO ServerExtension (Server_Id, Ext_Id, Status,TStamp,TOwner)
        VALUES (@Server_Id, @Ext_Id, @Status, @TStamp, @TOwner)

		SELECT * FROM ServerExtension WHERE Server_Id =  @Server_Id AND Ext_Id = @Ext_Id

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN

	    UPDATE ServerExtension
        SET Server_Id = ISNULL(@Server_Id,Server_Id),
		    Ext_Id = ISNULL(@Ext_Id,Ext_Id),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Server_Id =  @Server_Id AND Ext_Id = @Ext_Id

		SELECT * FROM ServerExtension WHERE Server_Id =  @Server_Id AND Ext_Id = @Ext_Id

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM ServerExtension
        WHERE Server_Id =  @Server_Id AND Ext_Id = @Ext_Id

		SELECT * FROM ServerExtension
        WHERE Server_Id =  @Server_Id AND Ext_Id = @Ext_Id
    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

  THROW;

END CATCH
GO