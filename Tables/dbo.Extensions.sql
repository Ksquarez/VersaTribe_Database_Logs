CREATE TABLE [dbo].[Extensions] (
  [Extension_Id] [int] IDENTITY,
  [Org_Id] [int] NULL,
  [Person_Id] [int] NULL,
  [Extension_Srv_Id] [int] NULL,
  [Srv_Id] [int] NULL,
  [UserName] [nvarchar](max) NULL,
  [Secret] [nvarchar](max) NULL,
  [Transport] [nvarchar](max) NULL,
  CONSTRAINT [PK_Extensions] PRIMARY KEY CLUSTERED ([Extension_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Extensions]
  ADD FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO

ALTER TABLE [dbo].[Extensions]
  ADD FOREIGN KEY ([Person_Id]) REFERENCES [dbo].[Person] ([Person_Id])
GO

ALTER TABLE [dbo].[Extensions]
  ADD CONSTRAINT [FK_Extensions_Servers] FOREIGN KEY ([Srv_Id]) REFERENCES [dbo].[Servers] ([Srv_Id])
GO