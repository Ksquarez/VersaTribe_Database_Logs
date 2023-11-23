SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spTraining_Req_JsonModel]
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
			FOR JSON  PATH, INCLUDE_NULL_VALUES		
    END
	 ELSE IF @Action = 'api/Training_Request/Org/{Org_Id:int}/Training_Requests'
    BEGIN
	SELECT Training_Request.Training_Req_Id,
		Training_Request.Org_Id, Training_Request.Person_Id,
		Training_Request.Training_Req_Name, Training_Request.Description,
		Training_Request.Created_At,
		Person.TOwner As 'Person_TOwner'  , Person.FirstName AS 'Person_FirstName' ,
		Org.Org_Name As 'Org_Org_Name'
        FROM Training_Request
		INNER JOIN Org ON Training_Request.Org_Id = Org.Org_Id
		INNER JOIN Person ON Training_Request.Person_Id = Person.Person_Id
        WHERE Training_Request.Org_Id = @Org_Id
		FOR JSON  PATH, INCLUDE_NULL_VALUES

    END
	 ELSE IF @Action = 'api/Training_Request/Person/{Person_Id:int}/Training_Requests'
    BEGIN
	SELECT Training_Request.Training_Req_Id,
		Training_Request.Org_Id, Training_Request.Person_Id,
		Training_Request.Training_Req_Name, Training_Request.Description,
		Training_Request.Created_At,
		Person.TOwner As 'Person_TOwner'  , Person.FirstName AS 'Person_FirstName' ,
		Org.Org_Name As 'Org_Org_Name'
        FROM Training_Request
		INNER JOIN Org ON Training_Request.Org_Id = Org.Org_Id
		INNER JOIN Person ON Training_Request.Person_Id = Person.Person_Id
        WHERE Training_Request.Person_Id = @Person_Id
		FOR JSON  PATH, INCLUDE_NULL_VALUES

    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

  THROW;

END CATCH
GO