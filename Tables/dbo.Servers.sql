CREATE TABLE [dbo].[Servers] (
  [Srv_Id] [int] IDENTITY,
  [Name] [nvarchar](max) NULL,
  [IP_Address] [nvarchar](200) NOT NULL,
  [CreatedBy] [nvarchar](256) NULL,
  [CreatedOn] [datetime] NULL,
  [UpdatedBy] [nvarchar](256) NULL,
  [UpdatedOn] [datetime] NULL,
  [TotalRange] [int] NULL,
  [StartNum] [int] NULL,
  [CurrentNum] [int] NULL,
  [EndNum] [int] NULL,
  [Group_Start_Num] [int] NULL,
  [Group_Current_Num] [int] NULL,
  [Group_End_Num] [int] NULL,
  [server_trunk_limit] [int] NULL,
  [Server_Domain] [nvarchar](max) NULL,
  CONSTRAINT [PK_Servers] PRIMARY KEY CLUSTERED ([Srv_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO