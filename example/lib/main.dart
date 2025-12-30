import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapbox Search v6 Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final TextEditingController _apiKeyController = TextEditingController();

  final List<Widget> _pages = [
    const GeocodingPage(),
    const BatchGeocodingPage(),
    const StaticImagePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox Search v6'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _apiKeyController,
              decoration: const InputDecoration(
                labelText: 'Mapbox API Key (Required for all features)',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                // Key is shared via MapBoxSearch.init or passed directly.
                // For this example, we'll let child widgets access this controller or init globally.
                MapBoxSearch.init(value);
              },
            ),
          ),
        ),
      ),
      body: _apiKeyController.text.isEmpty && MapBoxSearch.apiKey == null
          ? const Center(child: Text("Please enter your API Key to proceed"))
          : IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.place), label: 'Geocoding'),
          NavigationDestination(icon: Icon(Icons.layers), label: 'Batch'),
          NavigationDestination(icon: Icon(Icons.image), label: 'Static Image'),
        ],
      ),
    );
  }
}

class GeocodingPage extends StatefulWidget {
  const GeocodingPage({super.key});

  @override
  State<GeocodingPage> createState() => _GeocodingPageState();
}

class _GeocodingPageState extends State<GeocodingPage> {
  final TextEditingController _queryController = TextEditingController();
  String _result = "Results will appear here";
  bool _loading = false;

  GeoCodingApiV6 get _api => GeoCodingApiV6();

  Future<void> _forwardGeocode() async {
    if (_queryController.text.isEmpty) return;
    setState(() => _loading = true);
    try {
      final response = await _api.forward(_queryController.text);
      response.fold((success) {
        final buffer = StringBuffer();
        buffer.writeln("Found ${success.features.length} results:");
        for (var f in success.features) {
          buffer.writeln(
            "- ${f.properties.name} (${f.properties.fullAddress})",
          );
        }
        setState(() => _result = buffer.toString());
      }, (failure) => setState(() => _result = "Error: ${failure.message}"));
    } catch (e) {
      setState(() => _result = "Exception: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _reverseGeocode() async {
    setState(() => _loading = true);
    try {
      final response = await _api.reverse((lat: 38.8977, long: -77.0365));
      response.fold((success) {
        final buffer = StringBuffer();
        buffer.writeln("Reverse (White House):");
        if (success.features.isNotEmpty) {
          buffer.writeln(
            "- ${success.features.first.properties.placeFormatted}",
          );
        }
        setState(() => _result = buffer.toString());
      }, (failure) => setState(() => _result = "Error: ${failure.message}"));
    } catch (e) {
      setState(() => _result = "Exception: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _queryController,
            decoration: const InputDecoration(
              labelText: 'Search Query',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _loading ? null : _forwardGeocode,
                child: const Text('Forward'),
              ),
              ElevatedButton(
                onPressed: _loading ? null : _reverseGeocode,
                child: const Text('Reverse (WH)'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: Colors.grey[200],
              child: SingleChildScrollView(child: Text(_result)),
            ),
          ),
        ],
      ),
    );
  }
}

class BatchGeocodingPage extends StatefulWidget {
  const BatchGeocodingPage({super.key});

  @override
  State<BatchGeocodingPage> createState() => _BatchGeocodingPageState();
}

class _BatchGeocodingPageState extends State<BatchGeocodingPage> {
  String _result = "Batch results will appear here";
  bool _loading = false;

  GeoCodingApiV6 get _api => GeoCodingApiV6();

  Future<void> _runBatch() async {
    setState(() => _loading = true);
    try {
      final queries = [
        ForwardQuery(query: "Eiffel Tower", limit: 1),
        ReverseQuery(
          location: (lat: 40.6892, long: -74.0445),
          limit: 1,
        ), // Statue of Liberty
      ];

      final response = await _api.batch(queries);
      response.fold((success) {
        final buffer = StringBuffer();
        buffer.writeln("Batch Request 1 (Eiffel Tower):");
        if (success.batch[0].features.isNotEmpty) {
          buffer.writeln(
            "- ${success.batch[0].features.first.properties.placeFormatted}",
          );
        }
        buffer.writeln("\nBatch Request 2 (Statue of Liberty Coords):");
        if (success.batch[1].features.isNotEmpty) {
          buffer.writeln(
            "- ${success.batch[1].features.first.properties.placeFormatted}",
          );
        }
        setState(() => _result = buffer.toString());
      }, (failure) => setState(() => _result = "Error: ${failure.message}"));
    } catch (e) {
      setState(() => _result = "Exception: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _loading ? null : _runBatch,
            child: const Text('Run Batch (Eiffel Tower + Statue of Liberty)'),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: 300,
            color: Colors.grey[200],
            child: SingleChildScrollView(child: Text(_result)),
          ),
        ],
      ),
    );
  }
}

class StaticImagePage extends StatefulWidget {
  const StaticImagePage({super.key});

  @override
  State<StaticImagePage> createState() => _StaticImagePageState();
}

enum StaticExampleType { marker, polyline, simple, auto }

class _StaticImagePageState extends State<StaticImagePage> {
  String? _imageUrl;
  MapBoxStyle _selectedStyle = MapBoxStyle.Streets;
  StaticExampleType _selectedType = StaticExampleType.marker;

  StaticImage get _staticImage => StaticImage();

  void _generateImage() {
    try {
      Uri uri;
      switch (_selectedType) {
        case StaticExampleType.marker:
          uri = _staticImage.getStaticUrlWithMarker(
            center: (lat: 37.7749, long: -122.4194), // San Francisco
            marker: MapBoxMarker(
              markerColor: const RgbColor(255, 0, 0),
              markerLetter: 's',
              markerSize: MarkerSize.LARGE,
            ),
            zoomLevel: 13,
            width: 600,
            height: 400,
            style: _selectedStyle,
            render2x: true,
          );
          break;
        case StaticExampleType.polyline:
          uri = _staticImage.getStaticUrlWithPolyline(
            point1: (lat: 37.77343, long: -122.46589),
            point2: (lat: 37.75965, long: -122.42816),
            marker1: MapBoxMarker(
              markerColor: Color.rgb(0, 0, 0) as RgbColor,
              markerLetter: MakiIcons.aerialway.value,
              markerSize: MarkerSize.LARGE,
            ),
            marker2: MapBoxMarker(
              markerColor: Color.rgb(244, 67, 54) as RgbColor,
              markerLetter: 'q',
              markerSize: MarkerSize.SMALL,
            ),
            height: 300,
            width: 600,
            zoomLevel: 15.5,
            style: MapBoxStyle.Dark,
            render2x: true,
            path: MapBoxPath(
              pathColor: RgbColor(
                Colors.redAccent.red,
                Colors.redAccent.green,
                Colors.redAccent.blue,
              ),
              pathWidth: 5,
              pathPolyline:
                  "%7DrpeFxbnjVsFwdAvr%40cHgFor%40jEmAlFmEMwM_FuItCkOi%40wc%40bg%40wBSgM",
              pathOpacity: 0.8,
            ),
            // center: (lat: 37.766541503617475, long: -122.44702324243272),
            auto: true,
          );
          break;
        case StaticExampleType.simple:
          uri = _staticImage.getStaticUrlWithoutMarker(
            center: (lat: 48.8584, long: 2.2945), // Eiffel Tower
            zoomLevel: 14,
            width: 600,
            height: 400,
            style: _selectedStyle,
            render2x: true,
          );
          break;
        case StaticExampleType.auto:
          // Auto-framing example with marker
          uri = _staticImage.getStaticUrlWithMarker(
            center: (
              lat: 40.7128,
              long: -74.0060,
            ), // NYC (Ignored if auto is true usually, but needed for API sig)
            marker: MapBoxMarker(
              markerColor: const RgbColor(255, 165, 0),
              markerLetter: 'a',
              markerSize: MarkerSize.LARGE,
            ),
            auto: true,
            width: 600,
            height: 400,
            style: _selectedStyle,
            render2x: true,
          );
          break;
      }

      setState(() => _imageUrl = uri.toString());
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<MapBoxStyle>(
              value: _selectedStyle,
              items: MapBoxStyle.values.map((s) {
                return DropdownMenuItem(value: s, child: Text(s.name));
              }).toList(),
              onChanged: (v) {
                if (v != null) setState(() => _selectedStyle = v);
              },
            ),
            DropdownButton<StaticExampleType>(
              value: _selectedType,
              items: StaticExampleType.values.map((t) {
                return DropdownMenuItem(
                  value: t,
                  child: Text(t.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (v) {
                if (v != null) setState(() => _selectedType = v);
              },
            ),
            const SizedBox(height: 16),
            if (_imageUrl != null)
              Container(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Image.network(
                  _imageUrl!,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 50),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const CircularProgressIndicator();
                  },
                ),
              )
            else
              const SizedBox(
                height: 200,
                child: Center(child: Text("Select options and Generate")),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generateImage,
              child: const Text('Generate Static Image'),
            ),
          ],
        ),
      ),
    );
  }
}
