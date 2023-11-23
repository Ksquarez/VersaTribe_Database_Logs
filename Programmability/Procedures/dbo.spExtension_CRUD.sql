SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create Proc [dbo].[spExtension_CRUD]
(
  @Ext_Id INT = NULL,
  @Ext_Num INT = NULL,
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
        FROM Extension
        WHERE (@Ext_Id IS NULL OR Ext_Id = @Ext_Id)
            AND (@Ext_Num IS NULL OR Ext_Num = @Ext_Num)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Extension(Ext_Num , Status, TStamp, TOwner)
        VALUES (@Ext_Num , @Status , @TStamp, @TOwner)

		SELECT * FROM Extension WHERE Ext_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Extension
        SET Ext_Num = ISNULL(@Ext_Num,Ext_Num),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Ext_Id = @Ext_Id;

		SELECT * FROM Extension  WHERE Ext_Id = @Ext_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Extension
        WHERE Ext_Id= @Ext_Id

		Select * FROM Extension Where Ext_Id= @Ext_Id

    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO