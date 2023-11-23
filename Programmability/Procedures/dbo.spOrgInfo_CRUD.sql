SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spOrgInfo_CRUD]
(
  @Org_Id INT = NULL,
  @About_org nvarchar(MAX) = NULL,
  @City nvarchar(50) = NULL,
  @Country nvarchar(50) = NULL,
  @Contact_email varchar(50) = NULL,
  @Contact_number varchar(15) = NULL,
  @TStamp DATETIME2(7) = NULL,
  @TOwner NVARCHAR(256) = NULL,
  @Status INT = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM OrgInfo
        WHERE (@Org_Id IS NULL OR Org_Id = @Org_Id)
            AND (@About_org IS NULL OR About_org = @About_org)
			AND (@City IS NULL OR City = @City)
			AND (@Country IS NULL OR Country = @Country)
			AND (@Contact_email IS NULL OR Contact_email = @Contact_email)
			AND (@Contact_number IS NULL OR Contact_number = @Contact_number)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO OrgInfo (Org_Id, About_org, City, Country, Contact_email, Contact_number, TStamp, TOwner, Status)
        VALUES (@Org_Id, @About_org, @City, @Country, @Contact_email, @Contact_number, @TStamp, @TOwner, @Status)

		SELECT * FROM OrgInfo WHERE Org_Id = @Org_Id;

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE OrgInfo
        SET About_org = ISNULL(@About_org,About_org),
            City = ISNULL(@City,City),
			Country = ISNULL(@Country,Country),
			Contact_email = ISNULL(@Contact_email,Contact_email),
			Contact_number = ISNULL(@Contact_number,Contact_number),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
        WHERE Org_Id = @Org_Id

		SELECT * FROM OrgInfo WHERE Org_Id = @Org_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM OrgInfo
        WHERE Org_Id = @Org_Id;

		SELECT * FROM OrgInfo
        WHERE Org_Id = @Org_Id;
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO