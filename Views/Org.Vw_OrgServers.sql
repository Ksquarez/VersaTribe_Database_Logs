SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Org].[Vw_OrgServers] AS
SELECT
    dbo.OrgServers.Org_Id,
    dbo.OrgServers.Server_Id,
    dbo.OrgServers.Limit,
    dbo.OrgServers.Status,
    dbo.OrgServers.TStamp,
    dbo.OrgServers.TOwner,
    dbo.OrgServers.Group_Id,
    dbo.OrgServers.Is_Prime,
    dbo.Org.Org_Name,
    dbo.Org.OrgAdmin_Id,
    dbo.Servers.IP_Address,
    dbo.Servers.Name,
    dbo.Servers.Server_Domain,
     (SELECT COUNT(*) FROM Extensions WHERE Extensions.Org_Id = OrgServers.Org_Id AND Extensions.Srv_Id = OrgServers.Server_Id) AS 'Extensions_Person_Count'
FROM
    dbo.Org
    INNER JOIN dbo.OrgServers ON dbo.Org.Org_Id = dbo.OrgServers.Org_Id
    INNER JOIN dbo.Servers ON dbo.OrgServers.Server_Id = dbo.Servers.Srv_Id
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[18] 2[20] 3) )"
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
         Begin Table = "Org"
            Begin Extent = 
               Top = 6
               Left = 26
               Bottom = 293
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrgServers"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 239
               Right = 484
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Servers"
            Begin Extent = 
               Top = 26
               Left = 572
               Bottom = 355
               Right = 951
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
', 'SCHEMA', N'Org', 'VIEW', N'Vw_OrgServers'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'Org', 'VIEW', N'Vw_OrgServers'
GO