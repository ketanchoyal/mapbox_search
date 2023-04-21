# [3.2.0] - 21 April 2023
- Added BBox in Forward Geododing API (As per MapBox API we can use BBox to get the results in a specific area)

## [3.1.1] - 21 April 2023
- Fixed Static Image URL generation issue

## [3.1.0] - 19 April 2023
- Added Proximity Type to Search (As per MapBox API we can use location or ip address to get the nearest results)
- Optimized the code and added tests for reverse geocoding class too
- Fixed some issues regarding static image to use custom markers
- Changed zoom level to use double instead of int(Fix #61)

## [3.0.1+2] - 20 Dec 2021
- PlaceType enum to string conversion fixed

## [3.0.1+1] - 14 Sep 2021
- Homepage URL fixed

## [3.0.1] - 14 Sep 2021
- Added [Places type]((https://docs.mapbox.com/api/search/geocoding/#data-types)) to filter Search  [PR #48]

## [3.0.0-nullsafety.0] - 07 Mar 2021
- Migrate to null safety [Pull Request #43]
- Removed Color dependency [Pull Request #44]

## [2.1.0+1] - 04 Mar 2021
- Updated http dependency (PR #41)

## [2.1.0] - 10 Feb 2021
- Updated dependencies
- Major missing feature added
  - Maki Icons can now be used in marker icon

## [2.0.1+1] - 02 Oct 2020

- Added Missing Address Attribute to the fetched MapBoxPlace Data (PR by @ juampiq6).

## [2.0.1] - 31 Aug 2020
### PR by @lukas-h
### Some breaking Changes
- renamed 
  ```dart
   MapBoxStaticImage 
   ``` 
   ### to 
   ```dart 
   StaticImage 
   ``` 
   to make the naming in this library more consistent
### Improvements
- simplified the url serialisation
- added the auto attribute to static images
- added simple unit tests for static images

## [2.0.0] - 12 February 2020.

- Breaking changes(migration from v1.x ro v2.0)

## [2.0.0-dev] - 01 February 2020.

- Removed 'flutter' dependency. 

All Flutter code, including 'MapBoxPlaceSearchWidget' has been moved to library 
[mapbox_search_flutter](https://pub.dev/packages/mapbox_search_flutter). Check README for more details.

## [1.0.7] - 29 January 2020.

- Added Places Search for querying places by text.
- Fixed `limit` and `country` parameters for ReverseGeocoding.

## [1.0.6] - 20 January 2020.

- Added 'address' property to the Properties class.

## [1.0.5] - 20 Jan 2020

- Search text in search Widget localized

## [1.0.4] - 19 October 2019.

- Reverse Geocoding query type set to dynamic(String or double)

## [1.0.3] - 10 September 2019.

- Reverse Geocoding returning empty list bug Solved

## [1.0.2] - 30 August 2019.

Feature:
- Reverse Geocoding Added

## [1.0.1] - 27 August 2019.

Feature:
- add defaultPathPolyline and add assert(Merge Request)

## [1.0.0] - 26 August 2019.

Initial release.

Feature:
- Places Search with prediction
- Static Image with marker
- Static Image without marker
- Static Image with Polyline path
