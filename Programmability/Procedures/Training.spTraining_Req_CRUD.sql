SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE Proc [Training].[spTraining_Req_CRUD]
(
  @Training_Req_Id INT = NULL,
  @Org_Id INT = NULL,
  @Person_Id INT = NULL,
  @Training_Req_Name NVARCHAR(500) = NULL,
  @Description NVARCHAR(MAX) = NULL,
  @Created_At DATETIME = NULL, -- NULLABLE
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
        FROM Training_Request
        WHERE (@Training_Req_Id IS NULL OR Training_Req_Id = @Training_Req_Id)
			AND (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Person_Id IS NULL OR Person_Id = @Person_Id)  
			AND (@Training_Req_Name IS NULL OR Training_Req_Name = @Training_Req_Name)  
			AND (@Description IS NULL OR Description = @Description)  
			AND (@Created_At IS NULL OR Created_At = @Created_At)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			
		
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN


        INSERT INTO Training_Request (Org_Id, Person_Id, Training_Req_Name, Description,Created_At, Status,TStamp,TOwner)
        VALUES (@Org_Id, @Person_Id, @Training_Req_Name, @Description, @Created_At, @Status, @TStamp, @TOwner)

		SELECT * FROM Training_Request WHERE Training_Req_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Training_Request
        SET Training_Req_Name = ISNULL(@Training_Req_Name,Training_Req_Name),
			Description = ISNULL(@Description,Description),			
			Created_At = ISNULL(@Created_At,Created_At),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner
        WHERE Training_Req_Id =  @Training_Req_Id

		SELECT * FROM Training_Request WHERE Training_Req_Id =  @Training_Req_Id

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Training_Request
        WHERE Training_Req_Id =  @Training_Req_Id

		SELECT * FROM Training_Request
        WHERE Training_Req_Id =  @Training_Req_Id
    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

  THROW;

END CATCH
GO