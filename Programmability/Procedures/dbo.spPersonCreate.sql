SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spPersonCreate]
@FirstName nvarchar(50),
@LastName nvarchar(50),
@Gender nvarchar(50),
@City nvarchar(50),
@Country nvarchar(50),
@DOJ datetime2(7),
@DOB date,
@TStamp datetime2(7),
@TOwner nvarchar(256)
As
Begin Try
	Insert Into Person(FirstName,LastName,Gender,City,Country,DOJ,DOB,TStamp,TOwner)
		Values(@FirstName,@LastName,@Gender,@City,@Country,@DOJ,@DOB, @TStamp,@TOwner)

SELECT Person_Id,FirstName,LastName,Gender,City,Country,DOJ,DOB, TStamp, TOwner FROM Person WHERE (Person_Id= SCOPE_IDENTITY())
End try
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO