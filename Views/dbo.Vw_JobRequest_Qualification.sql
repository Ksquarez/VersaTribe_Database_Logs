SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [dbo].[Vw_JobRequest_Qualification]
AS
SELECT        Recruitment.Job_Request_Qualification.Job_Request_Qual_Id, Recruitment.Job_Request_Qualification.Job_Request_Id, Recruitment.Job_Request_Qualification.QI, Recruitment.Job_Request_Qualification.YOP, 
                         Recruitment.Job_Request_Qualification.Grade, Recruitment.Job_Request_Qualification.City, Recruitment.Job_Request_Qualification.Mandatory, Recruitment.Job_Request_Qualification.Status, 
                         Recruitment.Job_Request_Qualification.TStamp, Recruitment.Job_Request_Qualification.TOwner, dbo.Institutes.Inst_Name, dbo.Course.Cou_Name
FROM            dbo.Course INNER JOIN
                         dbo.Qualification ON dbo.Course.Cou_Id = dbo.Qualification.Cou_Id INNER JOIN
                         dbo.Institutes ON dbo.Qualification.Inst_Id = dbo.Institutes.Inst_Id INNER JOIN
                         Recruitment.Job_Request_Qualification ON dbo.Qualification.QI_Id = Recruitment.Job_Request_Qualification.QI AND dbo.Qualification.QI_Id = Recruitment.Job_Request_Qualification.QI
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
         Begin Table = "Course"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Qualification"
            Begin Extent = 
               Top = 6
               Left = 691
               Bottom = 214
               Right = 861
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Institutes"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Job_Request_Qualification (Recruitment)"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 236
               Right = 653
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
         Alias = 600
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
', 'SCHEMA', N'dbo', 'VIEW', N'Vw_JobRequest_Qualification'
GO

EXEC sys.sp_addextendedproperty N'MS_DiagramPaneCount', 1, 'SCHEMA', N'dbo', 'VIEW', N'Vw_JobRequest_Qualification'
GO