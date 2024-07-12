SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Asterisk].[Vw_ServerGroups] AS
SELECT
    dbo.ServerGroups.Srv_Group_Id,
    --dbo.ServerGroups.Srv_Id,
    dbo.ServerGroups.Group_Id,
    dbo.ServerGroups.Queue_Id,
    dbo.ServerGroups.Queue_Name,
    dbo.ServerGroups.Status,
    dbo.ServerGroups.Active,
    dbo.ServerGroups.context_Id,
    --dbo.ServerGroups.Entity_TStamp,
    --dbo.ServerGroups.Service_TStamp,
    --dbo.ServerGroups.Service_Response,
    dbo.context.ContextName,
    --dbo.Servers.IP_Address,
    --dbo.Servers.Server_Domain,
    dbo.Groups.Group_Name,
    dbo.Groups.Strategy,
    dbo.Groups.TimeOut
FROM
    dbo.Groups
    INNER JOIN dbo.ServerGroups ON dbo.Groups.Group_Id = dbo.ServerGroups.Group_Id
    INNER JOIN dbo.context ON dbo.ServerGroups.context_Id = dbo.context.Id
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "Groups"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 294
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ServerGroups"
            Begin Extent = 
               Top = 24
               Left = 254
               Bottom = 301
               Right = 435
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Servers"
            Begin Extent = 
               Top = 6
               Left = 476
               Bottom = 136
               Right = 675
            End
            DisplayFlags = 280
            TopColumn = 0
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
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'Asterisk', 'VIEW', N'Vw_ServerGroups'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'Asterisk', 'VIEW', N'Vw_ServerGroups'
GO