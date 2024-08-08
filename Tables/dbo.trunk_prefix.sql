CREATE TABLE [dbo].[trunk_prefix] (
  [Id] [int] IDENTITY,
  [Org_Id] [int] NULL,
  [trunk_Id] [int] NULL,
  [trunk_prefix_name] [nvarchar](10) NULL,
  [Status] [int] NULL,
  [TStamp] [datetime] NULL,
  [TOwner] [nvarchar](max) NULL,
  [Active] [bit] NULL,
  CONSTRAINT [PK_trunk_prefix_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IDX_trunk_prefix]
  ON [dbo].[trunk_prefix] ([trunk_Id], [trunk_prefix_name])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[trunk_prefix]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[trunk_prefix]
  ADD FOREIGN KEY ([trunk_Id]) REFERENCES [dbo].[trunk] ([Id])
GO