CREATE TABLE [dbo].[Mst_did_route_types] (
  [Id] [int] IDENTITY,
  [route_type] [nvarchar](max) NULL,
  [TStamp] [datetime] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL,
  CONSTRAINT [PK_Mst_did_route_types_Id] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO