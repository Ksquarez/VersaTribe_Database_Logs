SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[spPersonByTOwner]
(
	@TOwner nvarchar(256)
)
AS
	SET NOCOUNT ON;
SELECT        Person_Id, FirstName, LastName, Gender, City, Country, DOJ, DOB, TStamp, TOwner, Status
FROM            Person
WHERE        (TOwner = @TOwner)
GO