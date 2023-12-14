SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE Proc [dbo].[sp_Servers_CRUD]
(
	@Srv_Id int = NULL,
	@Name nvarchar(max)= NULL,
	@IP_Address nvarchar(200)= NULL,
	@CreatedBy nvarchar(256)= NULL,
	@CreatedOn datetime= NULL,
	@UpdatedBy nvarchar(256)= NULL,
	@UpdatedOn datetime= NULL,
	@TotalRange int= NULL,
	@StartNum int= NULL,
	@CurrentNum int= NULL,
	@EndNum int= NULL,
	@Group_Start_Num int= NULL,
	@Group_Current_Num int= NULL,
	@Group_End_Num int= NULL,
	@server_trunk_limit int= NULL,
	@Server_Domain nvarchar(max)= NULL,
    @Action NVARCHAR(100)
)
AS
BEGIN TRY
	SET NOCOUNT ON;

	IF @Action = 'SELECT'
    BEGIN
        SELECT *
        FROM Servers
        WHERE (@Srv_Id IS NULL OR Srv_Id = @Srv_Id)
            AND (@Name IS NULL OR Name = @Name)
            AND (@IP_Address IS NULL OR IP_Address = @IP_Address)
            AND (@CreatedBy IS NULL OR CreatedBy = @CreatedBy)
            AND (@CreatedOn IS NULL OR CreatedOn = @CreatedOn)
            AND (@UpdatedBy IS NULL OR UpdatedBy = @UpdatedBy)
            AND (@UpdatedOn IS NULL OR UpdatedOn = @UpdatedOn)
            AND (@TotalRange IS NULL OR TotalRange = @TotalRange)
            AND (@StartNum IS NULL OR StartNum = @StartNum)
            AND (@CurrentNum IS NULL OR CurrentNum = @CurrentNum)
            AND (@EndNum IS NULL OR EndNum = @EndNum)
            AND (@Group_Start_Num IS NULL OR Group_Start_Num = @Group_Start_Num)
            AND (@Group_Current_Num IS NULL OR Group_Current_Num = @Group_Current_Num)
            AND (@Group_End_Num IS NULL OR Group_End_Num = @Group_End_Num)
            AND (@Server_Trunk_Limit IS NULL OR Server_Trunk_Limit = @Server_Trunk_Limit)
            AND (@Server_Domain IS NULL OR Server_Domain = @Server_Domain)
    END
	ELSE IF @Action = 'INSERT'
    BEGIN
        INSERT INTO Servers (Name, IP_Address, CreatedBy, CreatedOn, UpdatedBy, UpdatedOn, TotalRange, StartNum, CurrentNum, EndNum, Group_Start_Num, Group_Current_Num, Group_End_Num, Server_Trunk_Limit, Server_Domain)
        VALUES (@Name, @IP_Address, @CreatedBy, @CreatedOn, @UpdatedBy, @UpdatedOn, @TotalRange, @StartNum, @CurrentNum, @EndNum, @Group_Start_Num, @Group_Current_Num, @Group_End_Num, @Server_Trunk_Limit, @Server_Domain)

        SELECT * FROM Servers WHERE Srv_Id = SCOPE_IDENTITY();
    END
	 ELSE IF @Action = 'UPDATE'
    BEGIN
        UPDATE Servers
        SET 
            Name = ISNULL(@Name, Name),
            IP_Address = ISNULL(@IP_Address, IP_Address),
            CreatedBy = ISNULL(@CreatedBy, CreatedBy),
            CreatedOn = ISNULL(@CreatedOn, CreatedOn),
            UpdatedBy = ISNULL(@UpdatedBy, UpdatedBy),
            UpdatedOn = ISNULL(@UpdatedOn, UpdatedOn),
            TotalRange = ISNULL(@TotalRange, TotalRange),
            StartNum = ISNULL(@StartNum, StartNum),
            CurrentNum = ISNULL(@CurrentNum, CurrentNum),
            EndNum = ISNULL(@EndNum, EndNum),
            Group_Start_Num = ISNULL(@Group_Start_Num, Group_Start_Num),
            Group_Current_Num = ISNULL(@Group_Current_Num, Group_Current_Num),
            Group_End_Num = ISNULL(@Group_End_Num, Group_End_Num),
            Server_Trunk_Limit = ISNULL(@Server_Trunk_Limit, Server_Trunk_Limit),
            Server_Domain = ISNULL(@Server_Domain, Server_Domain)
        WHERE Srv_Id = @Srv_Id

        SELECT * FROM Servers WHERE Srv_Id = @Srv_Id;
    END
    ELSE IF @Action = 'DELETE'
    BEGIN
        DELETE FROM Servers
        WHERE Srv_Id = @Srv_Id

        SELECT * FROM Servers WHERE Srv_Id = @Srv_Id;
    END

END TRY
BEGIN CATCH

  INSERT INTO dbo.DB_Errors
    VALUES (SUSER_SNAME(), ERROR_NUMBER(), ERROR_STATE(), ERROR_SEVERITY(), ERROR_LINE(), ERROR_PROCEDURE(), ERROR_MESSAGE(), GETDATE());

END CATCH
GO