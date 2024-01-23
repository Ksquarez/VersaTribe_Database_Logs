SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp__Add_Entity_And_Service_Log]
(
 @Entity_Name NVARCHAR(MAX),
 --@Service_Name NVARCHAR(MAX),
 @PKey INT,
 @TStamp DATETIME,
 @TOwner NVARCHAR(256),
 @Status INT,
 @Entity_TStamp DATETIME,
 @Service_TStamp DATETIME,
 @Service_Response NVARCHAR(MAX)
)
As
BEGIN TRY

    SET NOCOUNT ON;

	IF @Entity_Name = 'Extensions'
	BEGIN

	  UPDATE Extensions
        SET 
            TStamp = ISNULL(@TStamp, TStamp),
			TOwner = ISNULL(@TOwner, TOwner),
			Status = ISNULL(@Status, Status),
			Entity_TStamp = ISNULL(@Entity_TStamp, Entity_TStamp),
			Service_TStamp = ISNULL(@Service_TStamp, Service_TStamp),
			Service_Response = ISNULL(@Service_Response, Service_Response)
        WHERE Extension_Id = @PKey;

	END
	ELSE IF @Entity_Name = 'Groups'
	BEGIN

	  UPDATE Groups
          SET 
            TStamp = ISNULL(@TStamp, TStamp),
	  		TOwner = ISNULL(@TOwner, TOwner),
	  		Status = ISNULL(@Status, Status),
	  		Entity_TStamp = ISNULL(@Entity_TStamp, Entity_TStamp),
	  		Service_TStamp = ISNULL(@Service_TStamp, Service_TStamp),
	  		Service_Response = ISNULL(@Service_Response, Service_Response)
          WHERE Group_Id = @PKey;

	END
	ELSE IF @Entity_Name = 'ServerGroups'
	BEGIN

	   UPDATE ServerGroups
             SET 
	     		Status = ISNULL(@Status, Status),
	     		Entity_TStamp = ISNULL(@Entity_TStamp, Entity_TStamp),
	     		Service_TStamp = ISNULL(@Service_TStamp, Service_TStamp),
	     		Service_Response = ISNULL(@Service_Response, Service_Response)
             WHERE Srv_Group_Id = @PKey;

	END
	ELSE IF @Entity_Name = 'GroupExtensions'
	BEGIN

	    UPDATE GroupExtensions
              SET 
                TStamp = ISNULL(@TStamp, TStamp),
	      		TOwner = ISNULL(@TOwner, TOwner),
	      		Status = ISNULL(@Status, Status),
	      		Entity_TStamp = ISNULL(@Entity_TStamp, Entity_TStamp),
	      		Service_TStamp = ISNULL(@Service_TStamp, Service_TStamp),
	      		Service_Response = ISNULL(@Service_Response, Service_Response)
              WHERE Grp_Ext_Id = @PKey;

	END
	ELSE IF @Entity_Name = 'did_route'
	BEGIN

	    UPDATE did_route
                  SET 
                    TStamp = ISNULL(@TStamp, TStamp),
	          		TOwner = ISNULL(@TOwner, TOwner),
	          		Status = ISNULL(@Status, Status),
	          		Entity_TStamp = ISNULL(@Entity_TStamp, Entity_TStamp),
	          		Service_TStamp = ISNULL(@Service_TStamp, Service_TStamp),
	          		Service_Response = ISNULL(@Service_Response, Service_Response)
                  WHERE id = @PKey;
	END
	

END TRY
BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO