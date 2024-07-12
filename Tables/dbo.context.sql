CREATE TABLE [dbo].[context] (
  [Id] [int] IDENTITY,
  [ContextName] [nvarchar](max) NULL,
  [Srv_Id] [int] NULL,
  [Active] [bit] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL,
  [TStamp] [datetime] NULL,
  [Owner] [nvarchar](256) NULL,
  [Org_Id] [int] NULL,
  CONSTRAINT [PK_context] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UK_context_Org_Id]
  ON [dbo].[context] ([Org_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[context]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[context]
  ADD FOREIGN KEY ([Srv_Id]) REFERENCES [dbo].[Servers] ([Srv_Id])
GO