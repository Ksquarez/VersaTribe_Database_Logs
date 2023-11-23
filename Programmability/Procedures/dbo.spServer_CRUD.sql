SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spServer_CRUD]
(
  @Server_Id INT = NULL,
  @Server_Name NVARCHAR(50) = NULL,
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
        FROM Servers
        WHERE (@Server_Id IS NULL OR Server_Id = @Server_Id)
            AND (@Server_Name IS NULL OR Server_Name = @Server_Name)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Servers(Server_Name , Status, TStamp, TOwner)
        VALUES (@Server_Name , @Status , @TStamp, @TOwner)

		SELECT * FROM Servers WHERE Server_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Servers
        SET Server_Name = ISNULL(@Server_Name,Server_Name),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Server_Id = @Server_Id;

		SELECT * FROM Servers  WHERE Server_Id = @Server_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Servers
        WHERE Server_Id= @Server_Id

		Select * FROM Servers Where Server_Id= @Server_Id

    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO