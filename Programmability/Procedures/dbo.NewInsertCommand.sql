SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[NewInsertCommand]
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
	@Status int
)
AS
	SET NOCOUNT OFF;
INSERT INTO [Person] ([FirstName], [LastName], [Gender], [City], [Country], [DOJ], [DOB], [TStamp], [TOwner], [Status]) VALUES (@FirstName, @LastName, @Gender, @City, @Country, @DOJ, @DOB, @TStamp, @TOwner, @Status);
	
SELECT Person_Id, FirstName, LastName, Gender, City, Country, DOJ, DOB, TStamp, TOwner, Status FROM Person WHERE (Person_Id = SCOPE_IDENTITY())
GO