SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spOrgPerson_CRUD]
(
  @Person_Id INT = NULL,
  @Org_Id INT = NULL,
  @Dept_Id INT = NULL, -- NULLABLE
  @Status INT = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Request_Status INT = NULL, 
  @Dept_Req nvarchar(50) = NULL, -- NULLABLE ('')
  @Action NVARCHAR(100)

)   
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM OrgPerson
        WHERE (@Person_Id IS NULL OR Person_Id = @Person_Id)
            AND (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@Dept_Id IS NULL OR Dept_Id = @Dept_Id)
            AND (@Status IS NULL OR Status = @Status)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Request_Status IS NULL OR Request_Status = @Request_Status)
			AND (@Dept_Req IS NULL OR Dept_Req = @Dept_Req)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN

	    DECLARE @Requested INT = 0
        DECLARE @Approved INT = 1
        DECLARE @Rejected INT = -1
        DECLARE @Removed INT = -2

		IF @Request_Status NOT IN(@Requested)
           THROW 5001,  'Invalid Request_Status..', 1;
        /*
		IF EXISTS (SELECT 1 FROM OrgPerson WHERE Person_Id = @Person_Id AND Org_Id = @Org_Id AND Request_Status != @Approved)
		 BEGIN
		   UPDATE OrgPerson SET Dept_Id = ISNULL(@Dept_Id,Dept_Id),
		 END
		 */

        INSERT INTO OrgPerson (Person_Id, Org_Id, Dept_Id,Status,TStamp,TOwner,Request_Status,Dept_Req)
        VALUES (@Person_Id, @Org_Id, @Dept_Id, @Status, @TStamp, @TOwner, @Request_Status, @Dept_Req)

		SELECT * FROM OrgPerson WHERE Person_Id =  @Person_Id AND Org_Id = @Org_Id

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN

	   IF @Request_Status NOT IN(-2,-1,0,1,NULL)
           THROW 5001,  'Invalid Request_Status..', 1;

	   --IF @Dept_Id IS NULL AND @Request_Status = 1
	    --THROW 5002, 'Please assign department to the person after approval..', 1;

        UPDATE OrgPerson
        SET Person_Id = ISNULL(@Person_Id,Person_Id),
		    Org_Id = ISNULL(@Org_Id,Org_Id),
			Dept_Id = ISNULL(@Dept_Id,Dept_Id),
            Status = ISNULL(@Status,Status),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Request_Status = ISNULL(@Request_Status,Request_Status),
			Dept_Req = ISNULL(@Dept_Req,Dept_Req)
        WHERE Person_Id =  @Person_Id AND Org_Id = @Org_Id

		SELECT * FROM OrgPerson WHERE Person_Id =  @Person_Id AND Org_Id = @Org_Id

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM OrgPerson
        WHERE Person_Id =  @Person_Id AND Org_Id = @Org_Id

		SELECT * FROM OrgPerson
        WHERE Person_Id =  @Person_Id AND Org_Id = @Org_Id
    END
	
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

  THROW;

END CATCH
GO