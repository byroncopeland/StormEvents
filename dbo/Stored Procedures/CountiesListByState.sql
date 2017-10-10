/* 
==========================================================
CREATED BY:	Byron Copeland
DATE:		10.7.17
COMMENTS:	List County ID and Name by State using StateID
==========================================================
EXEC dbo.CountiesListByState 48

*/

CREATE PROCEDURE [dbo].[CountiesListByState] @StateID int

AS 
SET NOCOUNT ON

SELECT c.CountyID, c.CountyName, c.stateID 
  FROM dbo.County AS c
       INNER JOIN dbo.States AS s
	   ON s.StateID = c.StateID 
 WHERE s.StateID = @stateID
 ORDER BY c.CountyName
