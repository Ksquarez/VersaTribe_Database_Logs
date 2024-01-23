SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[spTrainingUserApplied]
@Org_Id int,
@Person_Id int
AS
BEGIN TRY
	select Training.*,Person.FirstName,Person.LastName,Person.TOwner As 'PersonEmail'  ,Training_Join.Is_Join from Training	 
	left join Training_Join On Training.Training_Id= Training_Join.Training_Id AND
	Training_Join.Person_Id = @Person_Id
	inner JOIN
        Person ON Training.Trainer_Id = Person.Person_Id
	where Org_Id = @Org_Id
END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO