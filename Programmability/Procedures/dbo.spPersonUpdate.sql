SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[spPersonUpdate]
	@Person_Id int,
    @FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
    @Gender NVARCHAR(50),
    @City NVARCHAR(50),
    @Country NVARCHAR(50),
    @DOJ DATETIME2(7),
    @DOB DATE,
    @TStamp DATETIME2(7),
    @TOwner NVARCHAR(256),
	@Status int
AS
BEGIN Try
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
    WHERE
        Person_Id = @Person_Id;

		 SELECT * FROM Person WHERE Person_Id = @Person_Id
END Try

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH

GO