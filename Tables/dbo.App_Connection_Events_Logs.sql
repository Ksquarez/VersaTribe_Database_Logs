CREATE TABLE [dbo].[App_Connection_Events_Logs] (
  [Id] [int] IDENTITY,
  [Org_Id] [int] NULL,
  [Person_Id] [int] NULL,
  [Connect] [bit] NULL,
  [TStamp] [datetime2] NULL,
  [TOwner] [nvarchar](256) NULL,
  [Status] [int] NULL,
  [Owner] [nvarchar](256) NULL,
  [Login_Date_Time] [datetime2] NULL,
  CONSTRAINT [PK_App_Connection_Events_Logs] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO