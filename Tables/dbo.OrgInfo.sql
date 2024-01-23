CREATE TABLE [dbo].[OrgInfo] (
  [Org_Id] [int] NOT NULL,
  [About_org] [nvarchar](max) NOT NULL,
  [City] [nvarchar](50) NOT NULL,
  [Country] [nvarchar](50) NOT NULL,
  [Contact_email] [varchar](50) NOT NULL,
  [Contact_number] [varchar](15) NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF__OrgInfo__Status__16EE5E27] DEFAULT (0),
  CONSTRAINT [PK_OrgInfo] PRIMARY KEY CLUSTERED ([Org_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_OrgInfoActivity]
ON [dbo].[OrgInfo]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO [Histroy].[OrgInfo]
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[OrgInfo]
  ADD CONSTRAINT [FK_OrgInfo_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[OrgInfo]
  ADD CONSTRAINT [FK_OrgInfo_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO