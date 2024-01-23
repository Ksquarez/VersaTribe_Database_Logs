CREATE TABLE [dbo].[ivr_entries] (
  [id] [int] IDENTITY,
  [ivr_id] [int] NULL,
  [selection] [nvarchar](20) NULL,
  [destination] [int] NULL,
  [destination_type] [int] NULL,
  [destination_type_queue_id] [int] NULL,
  [destination_type_phone_id] [int] NULL,
  [destination_type_ivr_id] [int] NULL,
  [TStamp] [datetime] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL,
  CONSTRAINT [PK_ivr_entries_id] PRIMARY KEY CLUSTERED ([id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_ivr_entries]
  ON [dbo].[ivr_entries] ([ivr_id], [selection])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[ivr_entries]
  ADD FOREIGN KEY ([destination_type_queue_id]) REFERENCES [dbo].[ServerGroups] ([Srv_Group_Id]) ON DELETE SET NULL
GO

ALTER TABLE [dbo].[ivr_entries]
  ADD FOREIGN KEY ([destination_type_phone_id]) REFERENCES [dbo].[Extensions] ([Extension_Id]) ON DELETE SET NULL
GO

ALTER TABLE [dbo].[ivr_entries]
  ADD FOREIGN KEY ([destination_type_ivr_id]) REFERENCES [dbo].[ivr_details] ([ivr_id]) ON DELETE SET NULL
GO

ALTER TABLE [dbo].[ivr_entries]
  ADD FOREIGN KEY ([destination_type]) REFERENCES [dbo].[Mst_did_route_types] ([Id])
GO

ALTER TABLE [dbo].[ivr_entries]
  ADD FOREIGN KEY ([ivr_id]) REFERENCES [dbo].[ivr_details] ([ivr_id])
GO