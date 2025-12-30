import 'package:mapbox_search/mapbox_search.dart';
import 'package:mapbox_search/models/bbox.dart';
import 'package:mapbox_search/models/location.dart';

abstract class BatchQuery {
  Map<String, dynamic> toJson();
}

class ForwardQuery implements BatchQuery {
  final String query;
  final List<PlaceType>? types;
  final BBox? bbox;
  final int? limit;
  final bool? autocomplete;
  final bool? permanent;
  final Proximity? proximity;
  final String? country;
  final String? language;

  ForwardQuery({
    required this.query,
    this.types,
    this.bbox,
    this.limit,
    this.autocomplete,
    this.permanent,
    this.proximity,
    this.country,
    this.language,
  });

  @override
  Map<String, dynamic> toJson() => {
    'q': query,
    if (types != null && types!.isNotEmpty)
      'types': types!.map((e) => e.value).toList(),
    if (bbox != null) 'bbox': bbox!.asList,
    if (limit != null) 'limit': limit,
    if (autocomplete != null) 'autocomplete': autocomplete,
    if (permanent != null) 'permanent': permanent,
    ...switch (proximity) {
      (LocationProximity l) => {"proximity": l.asString},
      (IpProximity ip) => {"proximity": ip.asString},
      // Proximity list for batch is array of coordinates usually?
      // Docs say: "proximity": -73.99279,40.719296 or ["-73.99279", "40.719296"]?
      // Docs say: "Fields specifying multiple values ... can be passed either as a comma-separated strings or as JSON-formatted arrays"
      // Proximity in single request is "long,lat". In JSON it could be string "long,lat" or array [long, lat]?
      // Detailed docs for Batch: "Fields which were defined as query parameters ... become fields in the JSON object."
      // So "proximity" key with value string "long,lat" should work.
      // My Proximity classes have asString property.
      (null) || (NoProximity _) => {},
    },
    if (country != null) 'country': country,
    if (language != null) 'language': language,
  };
}

class ReverseQuery implements BatchQuery {
  final Location location;
  final List<PlaceType>? types;
  final int? limit;
  final bool? permanent;
  final String? language;

  ReverseQuery({
    required this.location,
    this.types,
    this.limit,
    this.permanent,
    this.language,
  });

  @override
  Map<String, dynamic> toJson() => {
    'longitude': location.long,
    'latitude': location.lat,
    if (types != null && types!.isNotEmpty)
      'types': types!.map((e) => e.value).toList(),
    if (limit != null) 'limit': limit,
    if (permanent != null) 'permanent': permanent,
    if (language != null) 'language': language,
  };
}

class StructuredQuery implements BatchQuery {
  final String? addressNumber;
  final String? street;
  final String? postcode;
  final String? place;
  final String? region;
  final String? country;
  final String? locality;
  final String? neighborhood;

  StructuredQuery({
    this.addressNumber,
    this.street,
    this.postcode,
    this.place,
    this.region,
    this.country,
    this.locality,
    this.neighborhood,
  });

  @override
  Map<String, dynamic> toJson() => {
    if (addressNumber != null) 'address_number': addressNumber,
    if (street != null) 'street': street,
    if (postcode != null) 'postcode': postcode,
    if (place != null) 'place': place,
    if (region != null) 'region': region,
    if (country != null) 'country': country,
    if (locality != null) 'locality': locality,
    if (neighborhood != null) 'neighborhood': neighborhood,
  };
}
