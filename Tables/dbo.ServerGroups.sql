CREATE TABLE [dbo].[ServerGroups] (
  [Srv_Group_Id] [int] IDENTITY,
  [Srv_Id] [int] NULL,
  [Group_Id] [int] NULL,
  [Queue_Id] [int] NULL,
  [Queue_Name] [nvarchar](max) NULL,
  CONSTRAINT [PK_ServerGroups_Id] PRIMARY KEY CLUSTERED ([Srv_Group_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IDX_ServerGroups]
  ON [dbo].[ServerGroups] ([Srv_Id], [Group_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[ServerGroups]
  ADD CONSTRAINT [FK_ServerGroups_Groups] FOREIGN KEY ([Group_Id]) REFERENCES [dbo].[Groups] ([Group_Id])
GO

ALTER TABLE [dbo].[ServerGroups]
  ADD CONSTRAINT [FK_ServerGroups_Servers] FOREIGN KEY ([Srv_Id]) REFERENCES [dbo].[Servers] ([Srv_Id])
GO