SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[NewUpdateCommand]
(
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Gender nvarchar(50),
	@City nvarchar(50),
	@Country nvarchar(50),
	@DOJ datetime2,
	@DOB date,
	@TStamp datetime2,
	@TOwner nvarchar(256),
	@Status int,
	@Original_Person_Id int,
	@Person_Id int
)
AS
	SET NOCOUNT OFF;
UPDATE [Person] SET [FirstName] = @FirstName, [LastName] = @LastName, [Gender] = @Gender, [City] = @City, [Country] = @Country, [DOJ] = @DOJ, [DOB] = @DOB, [TStamp] = @TStamp, [TOwner] = @TOwner, [Status] = @Status WHERE (([Person_Id] = @Original_Person_Id));
	
SELECT Person_Id, FirstName, LastName, Gender, City, Country, DOJ, DOB, TStamp, TOwner, Status FROM Person WHERE (Person_Id = @Person_Id)
GO