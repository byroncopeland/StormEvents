/*==========================================================
CREATED BY:	Byron Copeland
DATE:		10.9.17
COMMENTS:	Populate Distinct Event Types from tblStormEvents
==========================================================
Example Event Types
Dust Storm Z
Excessive Heat Z
Extreme Cold/Wind Chill Z
Flash Flood C
Flood C
Freezing Fog Z
--Note: Must run sp StormEventsCorrectTypeUpdate prior to running this sp
*/
CREATE PROCEDURE [dbo].[SetupEventType]

AS 

SET NOCOUNT ON;
BEGIN TRY
	BEGIN TRANSACTION;
----------------------------------------------------------
-- EVENTS 
----------------------------------------------------------
--Populate the Event Type Lookup table
	INSERT dbo.EventType 
	       (EventType, 
		   Designator)
	SELECT DISTINCT 
	       Event_Type, 
		   CZ_TYPE		--C=County, Z=Zone
	  FROM tblStormEvents
	 ORDER BY EVENT_TYPE;

	 COMMIT TRANSACTION;
END TRY

BEGIN CATCH
IF @@trancount > 0 ROLLBACK TRANSACTION
   ;THROW
   RETURN 1
END CATCH

GO


