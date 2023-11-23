CREATE TABLE [dbo].[ShiftHistory] (
  [Shift_Id] [int] NOT NULL,
  [Shift_Name] [nvarchar](50) NOT NULL,
  [Start_Time] [time] NOT NULL,
  [End_Time] [time] NOT NULL,
  [Status] [int] NOT NULL,
  [TStamp] [datetime2] NOT NULL,
  [TOwner] [nvarchar](256) NOT NULL
)
ON [PRIMARY]
GO