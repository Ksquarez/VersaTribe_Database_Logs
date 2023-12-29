CREATE TABLE [dbo].[did_route] (
  [id] [int] IDENTITY,
  [did] [nvarchar](14) NULL,
  [description] [nvarchar](max) NULL,
  [Srv_Id] [int] NULL,
  [route_type] [int] NULL,
  [route_type_queue_id] [int] NULL,
  [route_type_phone_id] [int] NULL,
  [route_type_ivr_id] [int] NULL,
  [create_date] [datetime] NULL,
  [update_date] [datetime] NULL,
  [enabled] [bit] NULL,
  [Org_Id] [int] NULL,
  [call_time_id] [int] NULL,
  [TStamp] [datetime] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL,
  CONSTRAINT [PK_did_route] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[did_route]
  ADD FOREIGN KEY ([call_time_id]) REFERENCES [dbo].[call_times] ([call_time_id])
GO

ALTER TABLE [dbo].[did_route]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[did_route]
  ADD FOREIGN KEY ([route_type]) REFERENCES [dbo].[Mst_did_route_types] ([Id])
GO

ALTER TABLE [dbo].[did_route]
  ADD FOREIGN KEY ([route_type_phone_id]) REFERENCES [dbo].[Extensions] ([Extension_Id])
GO

ALTER TABLE [dbo].[did_route]
  ADD FOREIGN KEY ([route_type_queue_id]) REFERENCES [dbo].[ServerGroups] ([Srv_Group_Id])
GO

ALTER TABLE [dbo].[did_route]
  ADD FOREIGN KEY ([route_type_ivr_id]) REFERENCES [dbo].[ivr_details] ([ivr_id])
GO

ALTER TABLE [dbo].[did_route]
  ADD FOREIGN KEY ([Srv_Id]) REFERENCES [dbo].[Servers] ([Srv_Id])
GO