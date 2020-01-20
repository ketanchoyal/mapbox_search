part of mapbox_search;

class MapBoxPlaceSearchWidget extends StatefulWidget {
  MapBoxPlaceSearchWidget({
    @required this.apiKey,
    this.onSelected,
    // this.onSearch,
    this.searchHint = 'Search',
    this.language = 'en',
    this.location,
    this.limit = 5,
    this.country,
    this.context,
    this.height,
    this.popOnSelect = false,
  });

  /// True if there is different search screen and you want to pop screen on select
  final bool popOnSelect;

  ///To get the height of the page
  final BuildContext context;

  /// Height of whole search widget
  final double height;

  /// API Key of the MapBox.
  final String apiKey;

  /// The callback that is called when one Place is selected by the user.
  final void Function(MapBoxPlace place) onSelected;

  /// The callback that is called when the user taps on the search icon.
  // final void Function(MapBoxPlaces place) onSearch;

  /// Language used for the autocompletion.
  ///
  /// Check the full list of [supported languages](https://docs.mapbox.com/api/search/#language-coverage) for the MapBox API
  final String language;

  /// The point around which you wish to retrieve place information.
  final Location location;

  /// Limits the no of predections it shows
  final int limit;

  ///Limits the search to the given country
  ///
  /// Check the full list of [supported countries](https://docs.mapbox.com/api/search/) for the MapBox API
  final String country;

  ///Search Hint Localization
  final String searchHint;

  @override
  _MapBoxPlaceSearchWidgetState createState() =>
      _MapBoxPlaceSearchWidgetState();
}

class _MapBoxPlaceSearchWidgetState extends State<MapBoxPlaceSearchWidget>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController = TextEditingController();
  AnimationController _animationController;
  // SearchContainer height.
  Animation _containerHeight;
  // Place options opacity.
  Animation _listOpacity;

  Predections _placePredictions = Predections.empty();
  // MapBoxPlace _selectedPlace;

  @override
  void initState() {
    // _selectedPlace = null;
    _placePredictions = Predections.empty();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _containerHeight = Tween<double>(
            begin: 55,
            end: widget.height ??
                MediaQuery.of(widget.context).size.height - 60 ??
                300)
        .animate(
      CurvedAnimation(
        curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
        parent: _animationController,
      ),
    );
    _listOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
        parent: _animationController,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: MediaQuery.of(context).size.width,
        child: _searchContainer(
          child: _searchInput(context),
        ),
      );

  // Widgets
  Widget _searchContainer({Widget child}) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Container(
            height: _containerHeight.value,
            decoration: _containerDecoration(),
            padding: EdgeInsets.only(left: 0, right: 0, top: 15),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: child,
                ),
                SizedBox(height: 10),
                Opacity(
                  opacity: _listOpacity.value,
                  child: Container(
                    height: _containerHeight.value - 55,
                    child: ListView(
                      // addSemanticIndexes: true,
                      // itemExtent: 10,
                      children: <Widget>[
                        if (_placePredictions.features.length > 0)
                          for (var places in _placePredictions.features)
                            _placeOption(places),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _searchInput(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: _inputStyle(),
              controller: _textEditingController,
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
              onChanged: (value) => setState(() => _autocompletePlace(value)),
            ),
          ),
          Container(width: 15),
          GestureDetector(
            child: Icon(Icons.search, color: Colors.blue),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget _placeOption(MapBoxPlace prediction) {
    String place = prediction.text;
    String fullName = prediction.placeName;

    return MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      onPressed: () => _selectPlace(prediction),
      child: ListTile(
        title: Text(
          place.length < 45
              ? "$place"
              : "${place.replaceRange(45, place.length, "")} ...",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
          maxLines: 1,
        ),
        subtitle: Text(
          fullName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
          maxLines: 1,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0,
        ),
      ),
    );
  }

  // Styling
  InputDecoration _inputStyle() {
    return InputDecoration(
      hintText: widget.searchHint,
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
      boxShadow: [
        BoxShadow(color: Colors.black, blurRadius: 0, spreadRadius: 0)
      ],
    );
  }

  // Methods
  void _autocompletePlace(String input) async {
    /// Will be called everytime the input changes. Making callbacks to the Places
    /// Api and giving the user Place options

    if (input.length > 0) {
      String url =
          "https://api.mapbox.com/geocoding/v5/mapbox.places/$input.json?access_token=${widget.apiKey}&cachebuster=1566806258853&autocomplete=true&language=${widget.language}&limit=${widget.limit}";
      if (widget.location != null) {
        url += "&proximity=${widget.location.lng}%2C${widget.location.lat}";
      }
      if (widget.country != null) {
        url += "&country=${widget.country}";
      }
      final response = await http.get(url);
      // final json = jsonDecode(response.body);
      final predictions = Predections.fromRawJson(response.body);
      await _animationController.animateTo(0.5);
      setState(() => _placePredictions = predictions);
      await _animationController.forward();
    } else {
      await _animationController.animateTo(0.5);
      setState(() => _placePredictions = Predections.empty());
      await _animationController.reverse();
    }
  }

  void _selectPlace(MapBoxPlace prediction) async {
    /// Will be called when a user selects one of the Place options.

    // Sets TextField value to be the location selected
    _textEditingController.value = TextEditingValue(
      text: prediction.placeName,
      selection: TextSelection.collapsed(offset: prediction.placeName.length),
    );

    // Makes animation
    await _animationController.animateTo(0.5);
    setState(() {
      _placePredictions = Predections.empty();
      // _selectedPlace = prediction;
    });
    _animationController.reverse();

    // Calls the `onSelected` callback
    widget.onSelected(prediction);
    if (widget.popOnSelect) Navigator.pop(context);
  }
}
