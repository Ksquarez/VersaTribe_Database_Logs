SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Asterisk].[Vw_did_route] AS
SELECT
    dbo.did_route.id,
    dbo.did_route.did,
    dbo.did_route.description,
    dbo.did_route.Srv_Id,
    dbo.did_route.route_type,
    dbo.did_route.route_type_queue_id,
    dbo.did_route.route_type_phone_id,
    dbo.did_route.route_type_ivr_id,
    dbo.did_route.create_date,
    dbo.did_route.update_date,
    dbo.did_route.enabled,
    dbo.did_route.Org_Id,
    dbo.did_route.call_time_id,
    dbo.did_route.TStamp,
    dbo.did_route.TOwner,
    dbo.did_route.Status,
    dbo.did_route.Entity_TStamp,
    dbo.did_route.Service_TStamp,
    dbo.did_route.Service_Response,
    dbo.Mst_did_route_types.route_type AS 'Mst_did_route_types__route_type',
    dbo.Servers.Name,
    dbo.Servers.IP_Address,
    dbo.Servers.Server_Domain,
    dbo.Extensions.UserName,
    dbo.ServerGroups.Queue_Id,
    dbo.ServerGroups.Queue_Name,
    dbo.ivr_details.ivr_name,
    dbo.Org.Org_Name,
    dbo.Org.OrgAdmin_Id
FROM
    dbo.did_route
    INNER JOIN dbo.Servers ON dbo.did_route.Srv_Id = dbo.Servers.Srv_Id
    INNER JOIN dbo.Mst_did_route_types ON dbo.did_route.route_type = dbo.Mst_did_route_types.Id
    INNER JOIN dbo.Org ON dbo.did_route.Org_Id = dbo.Org.Org_Id
    LEFT OUTER JOIN dbo.Extensions ON dbo.Extensions.Extension_Id = dbo.did_route.route_type_phone_id
    LEFT OUTER JOIN dbo.ivr_details ON dbo.did_route.route_type_ivr_id = dbo.ivr_details.ivr_id
    LEFT OUTER JOIN dbo.ServerGroups ON dbo.did_route.route_type_queue_id = dbo.ServerGroups.Srv_Group_Id
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[46] 4[15] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "did_route"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 335
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Servers"
            Begin Extent = 
               Top = 6
               Left = 275
               Bottom = 136
               Right = 474
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Mst_did_route_types"
            Begin Extent = 
               Top = 223
               Left = 347
               Bottom = 353
               Right = 517
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Org"
            Begin Extent = 
               Top = 285
               Left = 626
               Bottom = 415
               Right = 796
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Extensions"
            Begin Extent = 
               Top = 173
               Left = 817
               Bottom = 303
               Right = 998
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ivr_details"
            Begin Extent = 
               Top = 6
               Left = 731
               Bottom = 136
               Right = 901
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "ServerGroups"
            Begin Extent = 
               Top = 143
               Left = 636
               Bottom = 273
               Right = 817
            End
         ', 'SCHEMA', N'Asterisk', 'VIEW', N'Vw_did_route'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPane2', N'   DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 3480
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1515
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'Asterisk', 'VIEW', N'Vw_did_route'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 2, 'SCHEMA', N'Asterisk', 'VIEW', N'Vw_did_route'
GO