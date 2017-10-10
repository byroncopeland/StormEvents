CREATE TABLE [dbo].[StormEvents] (
    [EventID]         INT            NOT NULL,
    [EpisodeID]       INT            NOT NULL,
    [StateID]         INT            NOT NULL,
    [BeginDateTime]   DATETIME       NOT NULL,
    [EndDateTime]     DATETIME       NOT NULL,
    [timezone]        VARCHAR (6)    NOT NULL,
    [EventTypeID]     INT            NOT NULL,
    [LocationID]      INT            NULL,
    [Injuries]        INT            NULL,
    [Deaths]          INT            NULL,
    [DamageProperty]  MONEY          NULL,
    [DamageCrops]     MONEY          NULL,
    [SourceReporting] VARCHAR (50)   NOT NULL,
    [Magnitude]       DECIMAL (6, 2) NULL,
    [MagnitudeType]   CHAR (2)       NULL,
    [TorFScale]       CHAR (3)       NULL,
    CONSTRAINT [PK_StoreEvents] PRIMARY KEY CLUSTERED ([EventID] ASC),
    CONSTRAINT [FK_EventType_EventTypeID] FOREIGN KEY ([EventTypeID]) REFERENCES [dbo].[EventType] ([EventTypeID]),
    CONSTRAINT [FK_Location_LocationID] FOREIGN KEY ([LocationID]) REFERENCES [dbo].[Location] ([LocationID]),
    CONSTRAINT [FK_States_StateID] FOREIGN KEY ([StateID]) REFERENCES [dbo].[States] ([StateID])
);


GO
CREATE NONCLUSTERED INDEX [IDX_StormEvents_LocationID]
    ON [dbo].[StormEvents]([LocationID] ASC);

