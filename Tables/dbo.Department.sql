CREATE TABLE [dbo].[Department] (
  [Dept_Id] [int] IDENTITY,
  [Org_Id] [int] NULL CONSTRAINT [DF_Department_Org_Id] DEFAULT (0),
  [Dept_Name] [nvarchar](50) NOT NULL,
  [Parent_dept_Id] [int] NULL,
  [Status] [int] NOT NULL CONSTRAINT [DF_Department_Status] DEFAULT (0),
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL,
  [Is_Default] [bit] NULL,
  CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED ([Dept_Id])
)
ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Department_1]
  ON [dbo].[Department] ([Dept_Name], [Org_Id])
  ON [PRIMARY]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_DepartmentActivity]
ON [dbo].[Department]
AFTER INSERT, UPDATE AS
BEGIN
INSERT INTO DepartmentHistory
SELECT * FROM INSERTED
END
GO

ALTER TABLE [dbo].[Department]
  ADD CONSTRAINT [FK_Department_AspNetUsers] FOREIGN KEY ([TOwner]) REFERENCES [dbo].[AspNetUsers] ([UserName]) ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[Department]
  ADD CONSTRAINT [FK_Department_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO