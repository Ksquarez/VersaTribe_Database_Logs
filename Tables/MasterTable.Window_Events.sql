CREATE TABLE [MasterTable].[Window_Events] (
  [Event_Id] [int] NOT NULL,
  [EventSummary] [nvarchar](max) NULL,
  [EventInvokType] [nvarchar](50) NULL,
  CONSTRAINT [PK_Window_Events_Id] PRIMARY KEY CLUSTERED ([Event_Id])
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', 'Active,InActive', 'SCHEMA', N'MasterTable', 'TABLE', N'Window_Events', 'COLUMN', N'EventInvokType'
GO