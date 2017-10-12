# StormEvents SQL DB
A SQL project using storm event .csv files from noaa.gov and converting to a normalized database.
The event files are available from:
ftp://ftp.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/

To develop the database, we use the StormEvents detail files.
Each .csv file was inserted using SSIS into the raw working table, tblStormEvents.

The data columns in the storm event detail file are described in Storm-Data-Export-Format.docx

An issue to overcome with the stormevents table is that there is one location column, cz_fips, and it can represent two different types of IDs, zone or county, based on the cz_type column value, Z or C. We want to be able to see for every storm event record, a county and a county fips. In other words, we want to choose a county and see every event that occured including zone events. 

To get zone and county details and correlations, we pull data from:
https://www.weather.gov/source/gis/Shapefiles/County/bp01nv16.dbx

Since counties can include one or more zones and some zones can cover multiple counties, there is a many-to-many relationship. To solve this, we use a bridge table, Location. In the StormEvents table, LocationID is foreign key to Location.LocationID. 


