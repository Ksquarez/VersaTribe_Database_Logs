﻿SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [Project].[Vw_Project_User]
AS
SELECT        dbo.Org.Org_Name, dbo.Org.OrgAdmin_Id, dbo.Projects.Project_Name, dbo.Project_User.Id, dbo.Project_User.Person_Id, dbo.Project_User.Project_Id, dbo.Project_User.Status, dbo.Project_User.Role, dbo.Project_User.TStamp, 
                         dbo.Project_User.TOwner, dbo.Project_User.IsApproved, dbo.Person.FirstName, dbo.Person.LastName, dbo.Person.TOwner AS 'PersonEmail'
FROM            dbo.Project_User INNER JOIN
                         dbo.Person ON dbo.Project_User.Person_Id = dbo.Person.Person_Id INNER JOIN
                         dbo.Projects ON dbo.Project_User.Project_Id = dbo.Projects.Project_Id INNER JOIN
                         dbo.Org ON dbo.Projects.Org_Id = dbo.Org.Org_Id

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
         Begin Table = "Org"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Person"
            Begin Extent = 
               Top = 189
               Left = 132
               Bottom = 319
               Right = 302
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "Project_User"
            Begin Extent = 
               Top = 70
               Left = 749
               Bottom = 200
               Right = 919
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Projects"
            Begin Extent = 
               Top = 6
               Left = 356
               Bottom = 136
               Right = 526
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
', 'SCHEMA', N'Project', 'VIEW', N'Vw_Project_User'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'Project', 'VIEW', N'Vw_Project_User'
GO