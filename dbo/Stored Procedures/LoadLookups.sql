/*==========================================================
CREATED BY:	Byron Copeland
DATE:		10.29.17
COMMENTS:	Initial load of lookup tables
==========================================================
 

*/
CREATE PROCEDURE [dbo].[LoadLookups]

AS 

SET NOCOUNT ON
declare @return int = 0

BEGIN TRY
	EXEC @return = dbo.SetupStates
	IF @return = 1
	BEGIN
		PRINT 'Error in [SetupStates]'
		RETURN
	END

	EXEC @return = dbo.SetupCounty 
	IF @return = 1
	BEGIN
		PRINT 'Error in [SetupCounty]'
		RETURN
	END

	EXEC @return = dbo.SetupZone
	IF @return = 1
	BEGIN
		PRINT 'Error in [SetupZone]'
		RETURN
	END
--Bridge Table for Zone and County
	EXEC @return = dbo.SetupLocation 
	IF @return = 1
	BEGIN
		PRINT 'Error in [SetupLocation]'
		RETURN
	END

END TRY


BEGIN CATCH
  
   ;THROW
   RETURN 1
END CATCH