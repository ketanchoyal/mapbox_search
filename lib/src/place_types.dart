///Various types of geographic features are available in the Mapbox geocoder. Any type might appear as a top-level response, as context in a top-level response, or as a filtering option using the types parameter. Not all features are available or relevant in all parts of the world. New types are occasionally added as necessary to correctly capture global administrative hierarchies.
///The data types available in the geocoder, listed from the largest to the most granular, are:
enum PlaceType {
  ///Generally recognized countries or, in some cases like Hong Kong, an area of quasi-national administrative status that has been given a designated country code under ISO 3166-1.
  country('country'),

  ///Top-level sub-national administrative features, such as states in the United States or provinces in Canada or China.
  region('region'),

  ///Postal codes used in country-specific national addressing systems.
  postcode('postcode'),

  ///Features that are smaller than top-level administrative features but typically larger than cities, in countries that use such an additional layer in postal addressing (for example, prefectures in China).
  district('district'),

  ///Typically these are cities, villages, municipalities, etc. They’re usually features used in postal addressing, and are suitable for display in ambient end-user applications where current-location context is needed (for example, in weather displays).
  place('place'),

  ///Official sub-city features present in countries where such an additional administrative layer is used in postal addressing, or where such features are commonly referred to in local parlance. Examples include city districts in Brazil and Chile and arrondissements in France.
  locality('locality'),

  ///Colloquial sub-city features often referred to in local parlance. Unlike locality features, these typically lack official status and may lack universally agreed-upon boundaries.
  neighborhood('neighborhood'),

  ///Individual residential or business addresses.
  address('address'),

  ///Points of interest. These include restaurants, stores, concert venues, parks, museums, etc.
  poi('poi');

  const PlaceType(this.value);

  final String value;
}

extension StringToPlaceType on String {
  PlaceType? get placeType {
    switch (this) {
      case 'country':
        return PlaceType.country;
      case 'region':
        return PlaceType.region;
      case 'postcode':
        return PlaceType.postcode;
      case 'district':
        return PlaceType.district;
      case 'place':
        return PlaceType.place;
      case 'locality':
        return PlaceType.locality;
      case 'neighborhood':
        return PlaceType.neighborhood;
      case 'address':
        return PlaceType.address;
      case 'poi':
        return PlaceType.poi;
      default:
        return null;
    }
  }
}
