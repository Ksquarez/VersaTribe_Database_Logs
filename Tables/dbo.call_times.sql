CREATE TABLE [dbo].[call_times] (
  [call_time_id] [int] IDENTITY,
  [call_time_name] [nvarchar](max) NULL,
  [call_time_comments] [nvarchar](max) NULL,
  [ct_default_start] [time] NULL,
  [ct_default_stop] [time] NULL,
  [ct_sunday_start] [time] NULL,
  [ct_sunday_stop] [time] NULL,
  [ct_monday_start] [time] NULL,
  [ct_monday_stop] [time] NULL,
  [ct_tuesday_start] [time] NULL,
  [ct_tuesday_stop] [time] NULL,
  [ct_wednesday_start] [time] NULL,
  [ct_wednesday_stop] [time] NULL,
  [ct_thursday_start] [time] NULL,
  [ct_thursday_stop] [time] NULL,
  [ct_friday_start] [time] NULL,
  [ct_friday_stop] [time] NULL,
  [ct_saturday_start] [time] NULL,
  [ct_saturday_stop] [time] NULL,
  [ct_state_call_times] [nvarchar](max) NULL,
  [default_afterhours_filename_override] [int] NULL,
  [sunday_afterhours_filename_override] [int] NULL,
  [monday_afterhours_filename_override] [int] NULL,
  [tuesday_afterhours_filename_override] [int] NULL,
  [wednesday_afterhours_filename_override] [int] NULL,
  [thursday_afterhours_filename_override] [int] NULL,
  [friday_afterhours_filename_override] [int] NULL,
  [saturday_afterhours_filename_override] [int] NULL,
  [user_group] [nvarchar](max) NULL,
  [Org_Id] [int] NULL,
  [ct_holidays] [nvarchar](max) NULL,
  CONSTRAINT [PK_call_times_call_time_id] PRIMARY KEY CLUSTERED ([call_time_id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[call_times]
  ADD FOREIGN KEY ([default_afterhours_filename_override]) REFERENCES [dbo].[Org_Files] ([Id])
GO

ALTER TABLE [dbo].[call_times]
  ADD FOREIGN KEY ([friday_afterhours_filename_override]) REFERENCES [dbo].[Org_Files] ([Id])
GO

ALTER TABLE [dbo].[call_times]
  ADD FOREIGN KEY ([monday_afterhours_filename_override]) REFERENCES [dbo].[Org_Files] ([Id])
GO

ALTER TABLE [dbo].[call_times]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[call_times]
  ADD FOREIGN KEY ([saturday_afterhours_filename_override]) REFERENCES [dbo].[Org_Files] ([Id])
GO

ALTER TABLE [dbo].[call_times]
  ADD FOREIGN KEY ([sunday_afterhours_filename_override]) REFERENCES [dbo].[Org_Files] ([Id])
GO

ALTER TABLE [dbo].[call_times]
  ADD FOREIGN KEY ([thursday_afterhours_filename_override]) REFERENCES [dbo].[Org_Files] ([Id])
GO

ALTER TABLE [dbo].[call_times]
  ADD FOREIGN KEY ([tuesday_afterhours_filename_override]) REFERENCES [dbo].[Org_Files] ([Id])
GO

ALTER TABLE [dbo].[call_times]
  ADD FOREIGN KEY ([wednesday_afterhours_filename_override]) REFERENCES [dbo].[Org_Files] ([Id])
GO