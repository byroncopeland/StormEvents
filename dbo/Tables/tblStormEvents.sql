CREATE TABLE [dbo].[tblStormEvents] (
    [BEGIN_YEARMONTH]    VARCHAR (50)   NULL,
    [BEGIN_DAY]          VARCHAR (50)   NULL,
    [BEGIN_TIME]         VARCHAR (50)   NULL,
    [END_YEARMONTH]      VARCHAR (50)   NULL,
    [END_DAY]            VARCHAR (50)   NULL,
    [END_TIME]           VARCHAR (50)   NULL,
    [EPISODE_ID]         VARCHAR (50)   NULL,
    [EVENT_ID]           VARCHAR (50)   NULL,
    [STATE]              VARCHAR (50)   NULL,
    [STATE_FIPS]         VARCHAR (50)   NULL,
    [YEAR]               VARCHAR (50)   NULL,
    [MONTH_NAME]         VARCHAR (50)   NULL,
    [EVENT_TYPE]         VARCHAR (50)   NULL,
    [CZ_TYPE]            VARCHAR (50)   NULL,
    [CZ_FIPS]            VARCHAR (50)   NULL,
    [CZ_NAME]            VARCHAR (2000) NULL,
    [WFO]                VARCHAR (50)   NULL,
    [BEGIN_DATE_TIME]    VARCHAR (50)   NULL,
    [CZ_TIMEZONE]        VARCHAR (50)   NULL,
    [END_DATE_TIME]      VARCHAR (50)   NULL,
    [INJURIES_DIRECT]    VARCHAR (50)   NULL,
    [INJURIES_INDIRECT]  VARCHAR (50)   NULL,
    [DEATHS_DIRECT]      VARCHAR (50)   NULL,
    [DEATHS_INDIRECT]    VARCHAR (50)   NULL,
    [DAMAGE_PROPERTY]    VARCHAR (50)   NULL,
    [DAMAGE_CROPS]       VARCHAR (50)   NULL,
    [SOURCE]             VARCHAR (50)   NULL,
    [MAGNITUDE]          VARCHAR (50)   NULL,
    [MAGNITUDE_TYPE]     VARCHAR (50)   NULL,
    [FLOOD_CAUSE]        VARCHAR (50)   NULL,
    [CATEGORY]           VARCHAR (50)   NULL,
    [TOR_F_SCALE]        VARCHAR (50)   NULL,
    [TOR_LENGTH]         VARCHAR (50)   NULL,
    [TOR_WIDTH]          VARCHAR (50)   NULL,
    [TOR_OTHER_WFO]      VARCHAR (50)   NULL,
    [TOR_OTHER_CZ_STATE] VARCHAR (50)   NULL,
    [TOR_OTHER_CZ_FIPS]  VARCHAR (50)   NULL,
    [TOR_OTHER_CZ_NAME]  VARCHAR (50)   NULL,
    [BEGIN_RANGE]        VARCHAR (50)   NULL,
    [BEGIN_AZIMUTH]      VARCHAR (50)   NULL,
    [BEGIN_LOCATION]     VARCHAR (50)   NULL,
    [END_RANGE]          VARCHAR (50)   NULL,
    [END_AZIMUTH]        VARCHAR (50)   NULL,
    [END_LOCATION]       VARCHAR (50)   NULL,
    [BEGIN_LAT]          VARCHAR (50)   NULL,
    [BEGIN_LON]          VARCHAR (50)   NULL,
    [END_LAT]            VARCHAR (50)   NULL,
    [END_LON]            VARCHAR (50)   NULL,
    [EPISODE_NARRATIVE]  VARCHAR (3000) NULL,
    [EVENT_NARRATIVE]    VARCHAR (3000) NULL,
    [DATA_SOURCE]        VARCHAR (50)   NULL
);




GO
CREATE NONCLUSTERED INDEX [idx2_tblstormevents]
    ON [dbo].[tblStormEvents]([STATE] ASC, [CZ_TYPE] ASC);


GO
CREATE NONCLUSTERED INDEX [idx1_tblstormevents]
    ON [dbo].[tblStormEvents]([EVENT_TYPE] ASC, [CZ_TYPE] ASC);

