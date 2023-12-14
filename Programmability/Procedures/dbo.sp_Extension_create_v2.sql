SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
-- Create
-- 1. get all orgservers by order asc and if count > 1
-- 2. get total limit of orgserver by orgid
-- 3. check one by one orgserver have space to create extension
-- 4. if have space create extension and add in to the group

--Extension_Id
--Group_Id
--@Org_Id

CREATE PROCEDURE [dbo].[sp_Extension_create_v2]
    @Extension_Id INT,
    @Org_Id INT,
	@Person_Id INT,
    @Extension_Srv_Id INT,
    @Srv_Id INT,
	@UserName NVARCHAR(MAX),
	@Secret NVARCHAR(MAX),
	@Transport NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

	-----------------------------------------------------------------
	DECLARE @Server_Id INT;
    DECLARE @Limit INT;
	  
	-- Declare a cursor to fetch servers one by one
    DECLARE serverCursor CURSOR FOR
    SELECT Server_Id, Limit
    FROM OrgServers
    WHERE Org_Id = @Org_Id ORDER BY Server_Id ASC;

	-- Open the cursor
    OPEN serverCursor;

	-- Fetch the first server
   FETCH NEXT FROM serverCursor INTO @Server_Id, @Limit;
    -- Loop through the servers
   WHILE @@FETCH_STATUS = 0
   BEGIN
       -- Your logic for each server goes here
	    DECLARE @ServerTrunkLimit INT

	   -- Get the server_trunk_limit for the specified Server_IP
       SELECT @ServerTrunkLimit = server_trunk_limit
       FROM Servers
       WHERE Srv_Id = @Server_Id;

	   IF @ServerTrunkLimit > 0 AND (SELECT COUNT(*) FROM Extensions WHERE Srv_Id = @Server_Id) < @ServerTrunkLimit
       BEGIN

	      DECLARE @Extension_Created_Id INT;

	      INSERT INTO Extensions (Org_Id, Person_Id, Extension_Srv_Id, Srv_Id, UserName, Secret, Transport)
          VALUES (@Org_Id, @Person_Id,dbo.fn_GenerateExetnsionSequentialNumber(@Server_Id), @Server_Id, @UserName, @Secret, @Transport);

		  SET @Extension_Created_Id = SCOPE_IDENTITY();

		   -- Check if a default group exists in the organization
           IF EXISTS (SELECT 1 FROM Groups WHERE Org_Id = @Org_Id AND IsDefault = 1)
           BEGIN
		       
			    DECLARE @GetDefaultGroupId INT

				DECLARE @GetDefaultGroupName NVARCHAR(MAX)

				DECLARE @GetServerDefaultGroupId INT

			    SELECT @GetDefaultGroupId = Group_Id, @GetDefaultGroupName = Group_Name FROM Groups WHERE Org_Id = @Org_Id AND IsDefault = 1

				IF NOT EXISTS (SELECT 1 FROM ServerGroups WHERE Srv_Id = @Server_Id AND Group_Id = @GetDefaultGroupId)
				BEGIN
				-- Add
	               DECLARE @SequentialNumber INT;
	               
	               INSERT INTO ServerGroups (Srv_Id, Group_Id, Queue_Id, Queue_Name)
                   SELECT OS.Server_Id, @GetDefaultGroupId, dbo.fn_GenerateGroupSequentialNumber(OS.Server_Id), @GetDefaultGroupName 
                   FROM OrgServers AS OS 
                   WHERE Org_Id = @Org_Id;

				   INSERT INTO [dbo].[GroupExtensions] ([Extension_Id], [Srv_Group_Id], [Group_Id])
                   VALUES (@Extension_Created_Id, SCOPE_IDENTITY(), @GetDefaultGroupId);
				--
				END
				ELSE
				BEGIN
				-- Add Group Extension
				   SELECT @GetServerDefaultGroupId = Srv_Group_Id FROM ServerGroups WHERE Srv_Id = @Server_Id AND Group_Id = @GetDefaultGroupId

				   INSERT INTO [dbo].[GroupExtensions] ([Extension_Id], [Srv_Group_Id], [Group_Id])
                   VALUES (@Extension_Created_Id, @GetServerDefaultGroupId, @GetDefaultGroupId);

				END
           END
           ELSE
           BEGIN

		   --   DECLARE @DefaultGroupId INT

			  --EXEC [dbo].[sp_Groups_create] @Org_Id, 'Default Group', 'no', '10';

			  -- INSERT INTO [dbo].[GroupExtensions] ([Extension_Id], [Srv_Group_Id], [Group_Id])
     --              VALUES (@Extension_Created_Id, @GetServerDefaultGroupId, @GetDefaultGroupId);
	 select 1

           END
          
		  SELECT * FROM Extensions WHERE Extension_Id = @Extension_Created_Id;

		  BREAK;
	   END
   
       -- Fetch the next server
       FETCH NEXT FROM serverCursor INTO @Server_Id, @Limit;
   END;

   -- Close and deallocate the cursor
  CLOSE serverCursor;
  DEALLOCATE serverCursor;

END;
GO