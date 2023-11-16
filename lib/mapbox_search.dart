library mapbox_search;

export 'package:color/color.dart';

export 'generated_enums/maki_icons.dart';
export 'generated_enums/poi_category.dart';
export 'models/bbox.dart';
export 'models/failure_response.dart';
export 'models/geometry.dart';
export 'models/location.dart'
    hide
        LocationAsList,
        DoubleListToLocation,
        LocationProximity,
        NoProximity,
        IpProximity;
export 'models/location_context.dart';
export 'models/predictions.dart';
export 'models/retrieve_response.dart';
export 'models/suggestion_response.dart';
export 'src/geocoding_api.dart';
// part "src/maki_icons.dart";
export 'src/place_types.dart' hide StringToPlaceType;
export 'src/search_box_api.dart';
export 'src/static_image.dart';

final class MapBoxSearch {
  static String? apiKey;

  MapBoxSearch.init(String apiKey) {
    MapBoxSearch.apiKey = apiKey;
  }
}
