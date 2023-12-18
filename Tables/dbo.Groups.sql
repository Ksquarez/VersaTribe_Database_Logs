CREATE TABLE [dbo].[Groups] (
  [Group_Id] [int] IDENTITY,
  [Org_Id] [int] NULL,
  [Group_Name] [nvarchar](200) NULL,
  [Strategy] [nvarchar](max) NULL,
  [TimeOut] [int] NULL,
  [IsDefault] [bit] NULL,
  CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED ([Group_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

CREATE UNIQUE INDEX [IX_Groups]
  ON [dbo].[Groups] ([Org_Id], [Group_Name])
  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Groups]
  ADD CONSTRAINT [FK_Groups_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO