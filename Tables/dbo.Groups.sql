CREATE TABLE [dbo].[Groups] (
  [Group_Id] [int] IDENTITY,
  [Org_Id] [int] NULL,
  [Group_Name] [nvarchar](max) NULL,
  [Strategy] [nvarchar](max) NULL,
  [TimeOut] [int] NULL,
  [IsDefault] [bit] NULL,
  CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED ([Group_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Groups]
  ADD CONSTRAINT [FK_Groups_Org] FOREIGN KEY ([Org_Id]) REFERENCES [dbo].[Org] ([Org_Id])
GO