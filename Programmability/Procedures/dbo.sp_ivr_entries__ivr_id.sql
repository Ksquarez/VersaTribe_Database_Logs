SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_ivr_entries__ivr_id]
(
 @ivr_id INT
)
AS
BEGIN TRY

  SELECT IE.*,DR.route_type, SG.Queue_Name, SG.Queue_Id, EX.UserName, P.FirstName, p.LastName, p.TOwner AS 'UserEmail', ID.ivr_name FROM ivr_entries AS IE
  INNER JOIN Mst_did_route_types AS DR ON DR.Id = IE.destination_type
  LEFT JOIN ServerGroups AS SG ON SG.Srv_Group_Id = IE.destination_type_queue_id
  LEFT JOIN Extensions AS EX ON EX.Extension_Id = IE.destination_type_phone_id
  LEFT JOIN Person AS P ON P.Person_Id = EX.Person_Id
  LEFT JOIN ivr_details AS ID ON ID.ivr_id = IE.destination_type_ivr_id
  WHERE IE.ivr_id = @ivr_id

END TRY
BEGIN CATCH

  EXECUTE [dbo].[uspLogError];

END CATCH
GO