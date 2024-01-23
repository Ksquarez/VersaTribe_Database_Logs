SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fn_GenerateGroupSequentialNumber](@Srv_Id INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN

    DECLARE @startNum NVARCHAR(MAX);

    -- Get the initial value from the Servers table
    SELECT @startNum = CAST(Group_Start_Num AS NVARCHAR(MAX)) FROM Servers WHERE Srv_Id = @Srv_Id;

    DECLARE @timestamp NVARCHAR(50);

	 -- Get current timestamp as a string
    SET @timestamp = CONVERT(NVARCHAR(50), GETDATE(), 112) + REPLACE(CONVERT(NVARCHAR(50), GETDATE(), 108), ':', '');


	-- Combine prefix, timestamp, and random number
    DECLARE @uniqueNumber NVARCHAR(MAX) = @startNum + @timestamp;

	RETURN @uniqueNumber;

END;
GO