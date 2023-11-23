SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPerson_CRUD]
(
  @Person_Id INT = NULL,
  @FirstName NVARCHAR(50) = NULL,
  @LastName NVARCHAR(50) = NULL,
  @Gender NVARCHAR(50) = NULL,
  @City NVARCHAR(50) = NULL,
  @Country NVARCHAR(50) = NULL,
  @DOJ DATETIME2(7) = NULL,
  @DOB DATE = NULL,
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
        FROM Person
        WHERE (@Person_Id IS NULL OR Person_Id = @Person_Id)
            AND (@FirstName IS NULL OR FirstName = @FirstName)
            AND (@LastName IS NULL OR LastName = @LastName)
			AND (@Gender IS NULL OR Gender = @Gender)
			AND (@City IS NULL OR City = @City)
			AND (@Country IS NULL OR Country = @City)
			AND (@DOJ IS NULL OR DOJ = @DOJ)
			AND (@DOB IS NULL OR DOB = @DOB)
			AND (@TStamp IS NULL OR TStamp = @TStamp)
			AND (@TOwner IS NULL OR TOwner = @TOwner)
			AND (@Status IS NULL OR Status = @Status)
			
    END
	 ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Person (FirstName, LastName, Gender, City, Country, DOJ, DOB, TStamp, TOwner, Status)
        VALUES (@FirstName, @LastName, @Gender, @City, @Country, @DOJ, @DOB, @TStamp, @TOwner, @Status)

		SELECT * FROM Person WHERE Person_Id = SCOPE_IDENTITY();

    END
	ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Person
        SET FirstName = ISNULL(@FirstName,FirstName),
            LastName = ISNULL(@LastName,LastName),
            Gender = ISNULL(@Gender,Gender),
			City = ISNULL(@City,City),
			Country = ISNULL(@Country,Country),
			DOJ = ISNULL(@DOJ,DOJ),
			DOB = ISNULL(@DOB,DOB),
			TStamp = @TStamp,
			TOwner = @TOwner,
			Status = ISNULL(@Status,Status)
			
        WHERE Person_Id = @Person_Id

		SELECT * FROM Person WHERE Person_Id = @Person_Id;

    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Person
        WHERE Person_Id = @Person_Id;

		SELECT * FROM Person
        WHERE Person_Id = @Person_Id
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO