CREATE TABLE [dbo].[Location] (
    [LocationID] INT IDENTITY (1, 1) NOT NULL,
    [CountyID]   INT NOT NULL,
    [ZoneID]     INT NOT NULL,
    CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED ([LocationID] ASC),
    CONSTRAINT [fk_county_countyid] FOREIGN KEY ([CountyID]) REFERENCES [dbo].[County] ([CountyID]),
    CONSTRAINT [fk_zone_zoneid] FOREIGN KEY ([ZoneID]) REFERENCES [dbo].[Zone] ([zoneID])
);


GO
CREATE NONCLUSTERED INDEX [IDX_Location_CountyID]
    ON [dbo].[Location]([CountyID] ASC);

