// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../view model/dating_provider.dart';

class LocationView extends StatefulWidget {
  const LocationView(
      {super.key,
      this.lat,
      this.long,
      required this.isEdit,
      this.editLatitude,
      this.editLongitude});
  final double? lat;
  final double? long;
  final double? editLatitude;
  final double? editLongitude;
  final bool isEdit;

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  bool searchSwap = false;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final focusOne = FocusNode();
  final focusTwo = FocusNode();

  bool isLocationPicked = false;

  Future<LatLng> fetchLatLng(String id) async {
    try {
      String apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';
      String url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&fields=name,geometry&key=$apiKey';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var result = data['result'];
        var location = result['geometry']['location'];
        context.read<DatingProvider>().lat = location['lat'].toString();
        context.read<DatingProvider>().long = location['lng'].toString();
        return LatLng(location['lat'], location['lng']);
      } else {
        debugPrint('Failed to load details.');
        return const LatLng(37.42796133580664, -122.085749655962);
      }
    } catch (e) {
      debugPrint(e.toString());
      return const LatLng(37.42796133580664, -122.085749655962);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppConstants.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppConstants.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MapView(
              mapController: _controller,
              onTap: () {
                setState(() {
                  searchSwap = false;
                  isLocationPicked = true;
                });
              },
              lat: widget.lat,
              long: widget.long,
              isEdit: widget.isEdit,
              editLatitude: widget.editLatitude,
              editLongitude: widget.editLongitude,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: searchSwap
                  ? SearchWidget(
                      node: focusOne,
                      onTap: (String id, String name) async {
                        setState(() {
                          searchSwap = !searchSwap;
                          focusOne.unfocus();
                        });
                        if (id.isNotEmpty) {
                          context.read<DatingProvider>().placeName = name;
                          isLocationPicked = true;
                          LatLng latLng = await fetchLatLng(id);
                          _controller.future.then(
                            (controller) {
                              controller.animateCamera(
                                CameraUpdate.newLatLng(latLng),
                              );
                            },
                          );
                        }
                      },
                    )
                  : isLocationPicked == true
                      ? LocationPicked(
                          onTap: () {
                            setState(() {
                              focusOne.requestFocus();
                              searchSwap = !searchSwap;
                            });
                            focusOne.requestFocus();
                          },
                        )
                      : SearchWidgetDup(
                          onTap: () {
                            setState(() {
                              focusOne.requestFocus();
                              searchSwap = !searchSwap;
                            });
                            focusOne.requestFocus();
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({
    super.key,
    required this.onTap,
    required this.mapController,
    this.lat,
    this.long,
    required this.isEdit,
    this.editLatitude,
    this.editLongitude,
  });

  final Function() onTap;
  final Completer<GoogleMapController> mapController;
  final double? lat;
  final double? long;
  final double? editLatitude;
  final double? editLongitude;
  final bool isEdit;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  String? _mapStyle;
  final DeBouncer _debounce = DeBouncer(milliseconds: 300);
  CameraPosition? cameraPosition;
  bool isUpdatingCameraPosition = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  void toggleIcon() {
    setState(() {
      isUpdatingCameraPosition = !isUpdatingCameraPosition;
    });
  }

  void updateCameraPosition(CameraPosition position) {
    setState(() {
      cameraPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GoogleMap(
          onTap: (_) {
            widget.onTap();
          },
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: true,
          buildingsEnabled: true,
          initialCameraPosition: CameraPosition(
            target: widget.isEdit
                ? LatLng(
                    widget.editLatitude ?? 0.0,
                    widget.editLongitude ?? 0.0,
                  )
                : LatLng(
                    widget.lat ?? 0.0,
                    widget.long ?? 0.0,
                  ),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController cnt) {
            widget.mapController.complete(cnt);
            // ignore: deprecated_member_use
            cnt.setMapStyle(_mapStyle!);
            setState(() {
              isLoading = false;
            });
          },
          onCameraMoveStarted: () {
            toggleIcon();
            widget.onTap();
          },
          onCameraMove: (position) {
            updateCameraPosition(position);
            context.read<DatingProvider>().lat =
                position.target.latitude.toString();
            context.read<DatingProvider>().long =
                position.target.longitude.toString();
            _debounce.run(() async {
              context.read<DatingProvider>().placeName =
                  await context.read<DatingProvider>().getPlaceNameFromLatLng(
                        position.target.latitude,
                        position.target.longitude,
                      );
            });
          },
          onCameraIdle: () {
            if (isUpdatingCameraPosition) {
              toggleIcon();
            }
            if (cameraPosition != null) {}
          },
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: isUpdatingCameraPosition
              ? Container(
                  width: 10.0,
                  decoration: BoxDecoration(
                    color: AppConstants.appPrimaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppConstants.appPrimaryColor.withOpacity(0.5),
                        spreadRadius: 2.0,
                        blurRadius: 4.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                )
              : const Icon(
                  Icons.location_on,
                  size: 42.0,
                  color: AppConstants.appPrimaryColor,
                ),
        ),
      ],
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    super.key,
    required this.onTap,
    required this.node,
  });

  final Function(String id, String placeName) onTap;
  final FocusNode node;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  List<PlaceSuggestion> suggestions = [];
  final searchCont = TextEditingController();
  bool isSearching = false;

  String apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';

  Future<void> fetchSuggestions(String query) async {
    setState(() {
      isSearching = true;
    });
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&components=country:IN&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      suggestions.clear();
      for (var item in data['predictions']) {
        final suggestionsList = PlaceSuggestion(
          name: item['description'],
          placeId: item['place_id'],
        );
        suggestions.add(suggestionsList);
      }
    } else {
      suggestions.clear();
      setState(() {
        isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: Responsive.height * 80,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withOpacity(0.3),
            spreadRadius: 2.0,
            blurRadius: 4.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Set up your favorite location',
              style: textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Drag the map to move the pin',
              style: textTheme.bodyLarge,
            ),
            const Divider(height: 32.0),
            TextFormField(
              focusNode: widget.node,
              onTapOutside: (_) {
                widget.node.unfocus();
              },
              onChanged: (value) => fetchSuggestions(value),
              controller: searchCont,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                filled: true,
                hintText: 'Search',
                fillColor: AppConstants.appPrimaryColor.withOpacity(0.1),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.appPrimaryColor,
                  ),
                  child: Icon(
                    Icons.search,
                    size: 20,
                    color: colorScheme.onPrimary,
                  ),
                ),
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.black,
                  icon: const Icon(
                    Icons.clear,
                    color: AppConstants.appPrimaryColor,
                  ),
                  onPressed: () {
                    searchCont.clear();
                    suggestions.clear();
                    if (searchCont.text.isEmpty) {
                      widget.onTap('', '');
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            suggestions.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final suggestion = suggestions[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor:
                                AppConstants.appPrimaryColor.withOpacity(0.1),
                            radius: 16.0,
                            child: const Icon(
                              Icons.location_on,
                              size: 16,
                            ),
                          ),
                          title: Text(suggestion.name),
                          onTap: () {
                            widget.node.unfocus();
                            widget.onTap(suggestion.placeId, suggestion.name);
                          },
                        );
                      },
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}

class SearchWidgetDup extends StatelessWidget {
  const SearchWidgetDup({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        // top side shadow
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withOpacity(0.3),
            spreadRadius: 2.0,
            blurRadius: 4.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Set up your favorite location',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Drag the map to move the pin',
                      style: textTheme.bodyLarge,
                    ),
                  ],
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.black,
                  icon: const Icon(
                    Icons.clear,
                    color: AppConstants.appPrimaryColor,
                  ),
                  onPressed: () {
                    Routes.back(context: context);
                  },
                ),
              ],
            ),
            const Divider(height: 32.0),
            TextFormField(
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              onTap: onTap,
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                filled: true,
                hintText: 'Search',
                fillColor: AppConstants.appPrimaryColor.withOpacity(0.1),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.appPrimaryColor,
                  ),
                  child: Icon(
                    Icons.location_on,
                    size: 15,
                    color: colorScheme.onPrimary,
                  ),
                ),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationPicked extends StatelessWidget {
  const LocationPicked({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
        // top side shadow
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withOpacity(0.3),
            spreadRadius: 2.0,
            blurRadius: 4.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      'Set up your favorite location',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Drag the map to move the pin',
                      style: textTheme.bodyLarge,
                    ),
                  ],
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  color: Colors.black,
                  icon: const Icon(
                    Icons.clear,
                    color: AppConstants.appPrimaryColor,
                  ),
                  onPressed: () {
                    Routes.back(context: context);
                  },
                ),
              ],
            ),
            const Divider(height: 32.0),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundColor: AppConstants.appPrimaryColor.withOpacity(0.1),
                radius: 16.0,
                child: const Icon(
                  Icons.location_on,
                  size: 16,
                ),
              ),
              title: Text(context.read<DatingProvider>().placeName ?? ''),
              subtitle: const Text('Click here to change location'),
              onTap: () {
                Routes.back(context: context);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              onTap: onTap,
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                filled: true,
                hintText: 'Search',
                fillColor: AppConstants.appPrimaryColor.withOpacity(0.1),
                prefixIcon: Container(
                  margin: const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppConstants.appPrimaryColor,
                  ),
                  child: Icon(
                    Icons.location_on,
                    size: 15,
                    color: colorScheme.onPrimary,
                  ),
                ),
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class PlaceSuggestion {
  final String name;
  final String placeId;
  PlaceSuggestion({required this.name, required this.placeId});
}

class DeBouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DeBouncer({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
