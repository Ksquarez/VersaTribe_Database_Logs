SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[fn_GenerateGroupSequentialNumber](@Srv_Id INT)
RETURNS INT
AS
BEGIN

    DECLARE @startNum INT;

    -- Get the initial value from the Servers table
    SELECT @startNum = Group_Start_Num FROM Servers WHERE Srv_Id = @Srv_Id;

    -- Check if there are no records for the given Server_IP in the Extensions table
    IF (SELECT COUNT(*) FROM ServerGroups WHERE Srv_Id = @Srv_Id) = 0
    BEGIN	
        -- Return the initial value if no records exist
        RETURN  @startNum;
    END
    ELSE
    BEGIN
        -- Loop until a unique sequential number is generated
        WHILE EXISTS (SELECT 1 FROM ServerGroups WHERE Srv_Id = @Srv_Id AND Queue_Id = @startNum)
        BEGIN
            -- Increment the sequential number
            SET @startNum = @startNum + 1;
        END

        -- Return the generated sequential number
        RETURN  @startNum;
    END;

	 RETURN  0;
END;
GO