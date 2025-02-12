# [4.3.1] - 12 Feb 2025
- Fixed nullable issue `RetrieveProperties.placeFormatted`

# [4.3.0] - 31 Jan 2025
- Replaces http with dio for network requests.
- Fixed Reported bugs and fixed some issues with mapping of response.

# [4.2.2] - 31 Jan 2024
- Fixed `externalIds` in `SuggestionResponse` and `RetrieveResonse` class and generated *.g.dart files again to include these changes.
- Fixed bug where `proximity` would always resolve to `NoProximity()` even when supplied with a value.

# [4.2.1] - 18 Jan 2024
- Fixed `externalIds` in `SuggestionResponse` class. Mapbox has changed the response for `externalIds` and it can be nullable now.


# [4.2.0] - 26 Nov 2023
- Huge code refactoring by [@LorenzSchueler](https://github.com/LorenzSchueler). Json parsing is now done using [json_serializable](https://pub.dev/packages/json_serializable) and [json_annotation](https://pub.dev/packages/json_annotation) packages.


# [4.1.0-beta.3] - 22 Sep 2023
- Package Upgrades
- Minor bug fixes

# [4.1.0-beta.2] - 18 May 2023
- Added color dependency to the package so that I don't have to manage code related to it.

# [4.1.0-beta.1] - 17 May 2023
- Updated Readme with examples on how to use new added dart 3.0 features
- Introduced MapBoxSearch.init() method to initialize the API Key for the package (This is not a breaking change since the API Key can be passed to every class that uses the package)
- Require Dart 3.0 to use the package
- Breaking Change:
  - Instead of throwing exceptions, the package now returns `ApiResponse` Record which can be either `Success` or `Failure` and can be handled using `fold` method.
  - Location class is now converted to a record.
  - List of coordinates are now converted to a record `(lat: double, long: doube)` whereever possible.

# [4.0.0-beta.2] - 15 May 2023
- Fixed Parsing issue for Search Results
- Added maki_icons to enum_generating script to keepup with new icons
- This will be last version to support dart < 3.0
- Require Dart 2.19 to use the package

# [4.0.0-beta.1] - 25 April 2023
## Breaking Changes
- PlaceSearch and ReverseGeoCoding classes are now merged into one class called GeoCoding with two methods `getPlaces` and `getAddress` since both of them are using the same API.

## New Features
- MapBox's new [SearchBox API](https://docs.mapbox.com/api/search/search-box/) is added to the package.
- Overal code refactoring

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
- Added [Places type](https://docs.mapbox.com/api/search/geocoding/#data-types) to filter Search  [PR #48]

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
