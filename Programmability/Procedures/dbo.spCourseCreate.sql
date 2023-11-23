SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROC [dbo].[spCourseCreate] @Cou_Name nvarchar(256),
@CTyp_Id int,
@TStamp datetime2(7),
@TOwner nvarchar(256)
AS
BEGIN TRY

  INSERT INTO Course (Cou_Name, CTyp_Id, TStamp, TOwner)
    VALUES (@Cou_Name, @CTyp_Id, @TStamp, @TOwner)

  SELECT
    Cou_Id,
    Cou_Name,
    CTyp_Id,
    TStamp,
    TOwner
  FROM Course
  WHERE (Cou_Id = SCOPE_IDENTITY())

END TRY

BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO