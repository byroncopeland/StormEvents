/*==========================================================
CREATED BY:	Byron Copeland
DATE:		10.9.17
COMMENTS:	Populate dbo.Location - the zone and county bridge table
			Zone and County is Many-To-Many relationship
			A zone can contain several counties
			A county can have multiple zones 
==========================================================

*/
CREATE PROCEDURE [dbo].[SetupStormEvents]
AS

SET NOCOUNT ON;
BEGIN TRY
	BEGIN TRANSACTION;
--------------------------------------------------------------------
-- ZONE EVENTS
--------------------------------------------------------------------
--Populate event table with all Zone type events
	INSERT [dbo].[StormEvents]
	SELECT
		EVENT_ID, 
		EPISODE_ID, 
		s.StateID,
		se.BEGIN_DATE_TIME, 
		se.END_DATE_TIME, 
		se.CZ_TIMEZONE,
		et.EventTypeID, 
		NULL,				--LocationID, Populate in next step
		INJURIES_DIRECT,
		DEATHS_DIRECT,
		CASE when CharINDEX('K', DAMAGE_PROPERTY) > 0 THEN
			CAST(REPLACE(DAMAGE_PROPERTY,'K','') as money)*1000
			WHEN CharINDEX('M', DAMAGE_PROPERTY) > 0 THEN
			CAST(REPLACE(DAMAGE_PROPERTY,'M','') as money)*1000000
			ELSE 0.00 END,
		CASE when CharINDEX('K', DAMAGE_CROPS) > 0 THEN
			CAST(REPLACE(DAMAGE_CROPS,'K','') as money)*1000
			WHEN CharINDEX('M', DAMAGE_CROPS) > 0 THEN
			CAST(REPLACE(DAMAGE_CROPS,'M','') as money)*1000000
			ELSE 0.00 END,
		SOURCE,
		CASE when MAGNITUDE <> '' then CAST(MAGNITUDE AS decimal(6,2))
			ELSE NULL end AS MAGNITUDE,
		    MAGNITUDE_TYPE,
		    TOR_F_SCALE
	  FROM tblStormEvents AS se
		   INNER JOIN dbo.States AS s
		   ON s.stateName = se.STATE
		   INNER JOIN dbo.EventType AS et
		   ON et.EventType = se.EVENT_TYPE
	 WHERE se.CZ_TYPE = 'Z'
 
--------------------------------------------------------------------------------------------
-- ZONE EVENT Location
--------------------------------------------------------------------------------------------
-- USE CTE to get ONE location record per Event WHERE zones cover multiple counties
	 ;WITH CTE AS (
	 SELECT se.EVENT_ID, min(l.LocationID) AS LocationID
	   FROM StormEvents se1
			INNER JOIN tblStormEvents se 
			ON se1.eventid = se.event_id
			INNER JOIN dbo.States AS s
			ON s.stateName = se.STATE
			INNER JOIN dbo.Zone AS z
			ON z.Zone = se.CZ_FIPS 
			  AND z.StateCode = s.StateCode
		   INNER JOIN dbo.Location AS l 
		   ON l.zoneID = z.zoneID
	 WHERE se.CZ_TYPE = 'Z'
	 GROUP BY se.event_ID)
	UPDATE StormEvents set LocationID = a.LocationID --Update LocationID from bridge table
	  FROM StormEvents AS se 
			INNER JOIN CTE a 
			ON a.Event_ID = se.EventID

--------------------------------------------------------------------
-- COUNTY EVENTS
--------------------------------------------------------------------
--Populate event table with all County type events
	INSERT [dbo].[StormEvents]
	SELECT
		EVENT_ID, 
		EPISODE_ID, 
		s.StateID,
		se.BEGIN_DATE_TIME, 
		se.END_DATE_TIME, 
		se.CZ_TIMEZONE,
		et.EventTypeID, 
		NULL,				--LocationID
		INJURIES_DIRECT,
		DEATHS_DIRECT,
		CASE when CharINDEX('K', DAMAGE_PROPERTY) > 0 THEN
			CAST(REPLACE(DAMAGE_PROPERTY,'K','') as money)*1000
			WHEN CharINDEX('M', DAMAGE_PROPERTY) > 0 THEN
			CAST(REPLACE(DAMAGE_PROPERTY,'M','') as money)*1000000
			ELSE 0.00 END,
		CASE when CharINDEX('K', DAMAGE_CROPS) > 0 THEN
			CAST(REPLACE(DAMAGE_CROPS,'K','') as money)*1000
			WHEN CharINDEX('M', DAMAGE_CROPS) > 0 THEN
			CAST(REPLACE(DAMAGE_CROPS,'M','') as money)*1000000
			ELSE 0.00 END,
		SOURCE,
		CASE when MAGNITUDE <> '' then CAST(MAGNITUDE AS decimal(6,2))
			ELSE NULL end AS MAGNITUDE,
		    MAGNITUDE_TYPE,
		    TOR_F_SCALE
	  FROM tblStormEvents AS se
		   INNER JOIN dbo.States AS s
		   ON s.stateName = se.STATE
		   INNER JOIN dbo.EventType AS et
		   ON et.EventType = se.EVENT_TYPE
	 WHERE se.CZ_TYPE = 'C'
 
--------------------------------------------------------------------------------------------
-- COUNTY EVENT Location
--------------------------------------------------------------------------------------------
-- USE CTE to get ONE location record per Event if County has multiple zones
	 ;WITH CTE AS (
	 SELECT se.EVENT_ID, min(l.LocationID) AS LocationID
	   FROM StormEvents se1
			INNER JOIN tblStormEvents se 
			ON se1.eventid = se.event_id
			INNER JOIN dbo.States AS s
			ON s.stateName = se.STATE
			INNER JOIN dbo.County AS c
			ON c.CountyFIPS = se.CZ_FIPS 
			  AND c.StateID = s.StateID
		   INNER JOIN dbo.Location AS l 
		   ON l.CountyID = c.CountyID
	 WHERE se.CZ_TYPE = 'C'
	 GROUP BY se.event_ID)
	UPDATE StormEvents set LocationID = a.LocationID --Update LocationID from bridge table
	  FROM StormEvents AS se 
			INNER JOIN CTE a 
			ON a.Event_ID = se.EventID

	COMMIT TRANSACTION;
END TRY

BEGIN CATCH
IF @@trancount > 0 ROLLBACK TRANSACTION
   ;THROW
   RETURN 1
END CATCH
GO

