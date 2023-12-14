SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_ServerGroups_CRUD]
(
  @Srv_Group_Id INT = NULL,
  @Srv_Id INT = NULL,
  @Group_Id INT = NULL,
  @Queue_Id INT = NULL,
  @Queue_Name NVARCHAR(MAX) = NULL,
  @Action NVARCHAR(100)
)
AS
BEGIN TRY
    SET NOCOUNT ON;

    IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM ServerGroups
        WHERE (@Srv_Group_Id IS NULL OR Srv_Group_Id = @Srv_Group_Id)
            AND (@Srv_Id IS NULL OR Srv_Id = @Srv_Id)
            AND (@Group_Id IS NULL OR Group_Id = @Group_Id)
            AND (@Queue_Id IS NULL OR Queue_Id = @Queue_Id)
            AND (@Queue_Name IS NULL OR Queue_Name = @Queue_Name)
    END
    ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO ServerGroups (Srv_Id, Group_Id, Queue_Id, Queue_Name)
        VALUES (@Srv_Id, @Group_Id, @Queue_Id, @Queue_Name)

        SELECT * FROM ServerGroups WHERE Srv_Group_Id = SCOPE_IDENTITY();
    END
    ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE ServerGroups
        SET 
            Srv_Id = ISNULL(@Srv_Id, Srv_Id),
            Group_Id = ISNULL(@Group_Id, Group_Id),
            Queue_Id = ISNULL(@Queue_Id, Queue_Id),
            Queue_Name = ISNULL(@Queue_Name, Queue_Name)
        WHERE Srv_Group_Id = @Srv_Group_Id

        SELECT * FROM ServerGroups WHERE Srv_Group_Id = @Srv_Group_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM ServerGroups
        WHERE Srv_Group_Id = @Srv_Group_Id

        SELECT * FROM ServerGroups WHERE Srv_Group_Id = @Srv_Group_Id;
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH



GO