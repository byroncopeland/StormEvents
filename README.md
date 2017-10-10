# StormEvents SQL DB
A SQL project using storm event .csv files from noaa.gov and converting to a normalized database.
The event files are available from:
ftp://ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/

To develop the database, we used the StormEventsdetail files from 2014, 2015 and 2016.
Each .csv file was inserted using SSIS into the raw working table, tblStormEvents
To get zone and county details and correlations, we pulled data from:
https://www.weather.gov/source/gis/Shapefiles/County/bp01nv16.dbx



