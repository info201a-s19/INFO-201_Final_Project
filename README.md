# Final Project
Use this `README.md` file to describe your final project (as detailed on Canvas).

# Domain
Flights in the United States
## Why are you interested in this field/domain?
We wanted to learn more about flights in the United States because many people travel everyday by plane within the United States and internationally. Therefore, knowing flight details and when flights are typically delayed are important and can be helpful for people especially out of state and international students that need to book tickets to fly home. There are many datasets about flights in general, but we wanted to specifically find statistics about flights here in the United States.

## What other examples of data driven project have you found related to this domain (share at least 3)?
- There is a package called [nycflights13](https://cran.r-project.org/web/packages/nycflights13/index.html) which detail all the flights to and from NYC in 2013.
- There is a tutorial called [predicting flight delays](https://www.kaggle.com/fabiendaniel/predicting-flight-delays-tutorial) on Kaggle that developed a prediction model.
It also emphasizes the steps needed to build such a model.
- A Kaggle user used a dataset on [2015 Flight Delays and Cancellations](https://www.kaggle.com/usdot/flight-delays) to rank airlines.

## What data-driven questions do you hope to answer about this domain (share at least 3)?
- What is the largest airline by passenger count? We can answer this question by filtering for the highest passenger count on an airline.
- What is the most common flight path? We can find this by checking to see which route between two airports is used the most.
- What is the highest elevation of an airport in the United States? We can see what the highest elevation is by filtering by highest elevation of airports.

# Dataset 1

## Where did you download the data (e.g., a web URL)?
[From Catalog: Air traffic statistics](https://catalog.data.gov/dataset/air-traffic-passenger-statistics)

## How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?
The data is reported by San Francisco International Airport. The data is about monthly passenger traffic statistics by airline in San Francisco International Airport.

## How many observations (rows) are in your data?
19815 observations

## How many features (columns) are in the data?
12 features

## What questions (from above) can be answered using the data in this dataset?
What is the largest airline by passenger count? To answer this, we filter the dataset by passenger count to find the airline with the highest passenger count.

# Dataset 2

## Where did you download the data (e.g., a web URL)?
[From Kaggle: Flights Route Database](https://www.kaggle.com/open-flights/flight-route-database)

## How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?
This dataset is collected from openflight.org under the open database license and contains 59036 routes between 3209 airports on 531 airlines spanning the globe. Openflight.org is organized by Jani Patokallio, who sourced the airport
base data from Digital Aeronautical Flight Information File (DAFIF, October 2006 cycle), OurAirports, and timezone information form EarthTools. Airline data was extracted directly from Wikipedia's list of airlines. Plane data is
sourced from the List of ICAO aircraft type designators.

## How many observations (rows) are in your data?
67663 observations

## How many features (columns) are in the data?
9 features

## What questions (from above) can be answered using the data in this dataset?
What is the most common flight path? To find this, we can mutate the dataset and add a column that keeps track of the number of flights between two airports.
From there, we can filter by the highest number of flights between two airports.

# Dataset 3

## Where did you download the data (e.g., a web URL)?
[From Github: Airport Codes](https://github.com/datasets/airport-codes)

## How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?
The dataset was compiled by David Megginson, a private pilot, onto ourairports.com. He sourced the data from the multiple sources for various reasons. He collected data on airport and aviation weather data through Federal Aviation Administration (FAA) and DAFIF. A list of Canadian airports and seaplane bases is sourced from George Plews's website. Other airport data
are sourced from navaid.com, soaringweb.com, and Great Circle Mapper. A list of North Korean and Australian airports are
sourced from the Federation of American Scientists (FAS) and Kwik Navigation Flight Planner, respectively. Arrival and
departure data are sourced from FlightStats and weather forecasts based on longitude and latitude from forecast.io. Overall,
these datasets were organized using a free Google Maps mapping API and geocoder by David Megginson and Geonames's
geolocation APIs. The dataset contains airport codes, which could refer to either the IATA airport code, a three-letter code which is used in passenger reservation, ticketing and baggage-handling systems, or the ICAO airport code which is a four letter code used by ATC systems and for airports that do not have an IATA airport code.

## How many observations (rows) are in your data?
55237 observations

## How many features (columns) are in the data?
18 features

## What questions (from above) can be answered using the data in this dataset?
What is the highest elevation of an airport in the United States? To see this, we can filter by elevation of airports, and find the maximum elevation of airports.
