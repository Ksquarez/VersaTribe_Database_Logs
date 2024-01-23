CREATE TABLE [dbo].[OrgDept] (
  [Org_Id] [int] NOT NULL,
  [Dept_Id] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF__OrgDept__Status__18D6A699] DEFAULT (0),
  CONSTRAINT [PK_OrgDept] PRIMARY KEY CLUSTERED ([Org_Id], [Dept_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_OrgDept]
  ON [dbo].[OrgDept] ([Org_Id], [Dept_Id])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrgDept]
  ADD CONSTRAINT [FK_OrgDept_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[OrgDept]
  ADD CONSTRAINT [FK_OrgDept_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO