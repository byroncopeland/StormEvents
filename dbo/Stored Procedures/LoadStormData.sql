/*==========================================================
CREATED BY:	Byron Copeland
DATE:		10.30.17
COMMENTS:	Manage loading Data 
			Calls 3 sp's in correct order
			Will not insert duplicate
==========================================================
 

*/
CREATE PROCEDURE [dbo].[LoadStormData]

AS 

SET NOCOUNT ON
declare @return int = 0

BEGIN TRY
	EXEC @return = dbo.StormeventsCorrectTypeUpdate
	IF @return = 1
	BEGIN
		PRINT 'Error in [StormeventsCorrectTypeUpdate]'
		RETURN
	END

	EXEC @return = dbo.SetupEventType 
	IF @return = 1
	BEGIN
		PRINT 'Error in [SetupEventType]'
		RETURN
	END

	EXEC @return = dbo.SetupStormEvents
	IF @return = 1
	BEGIN
		PRINT 'Error in [SetupStormEvents]'
		RETURN
	END
END TRY


BEGIN CATCH
   ;THROW
   RETURN 1
END CATCH