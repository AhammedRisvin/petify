import 'dart:async';

import 'package:clan_of_pets/app/module/Dating/view%20model/dating_provider.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utils/extensions.dart';
import '../view/location_view.dart';

class MapPreview extends StatefulWidget {
  const MapPreview({
    super.key,
    this.editLatitude,
    this.editLongitude,
    required this.isEdit,
  });
  final double? editLatitude;
  final double? editLongitude;
  final bool isEdit;

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  final Completer<GoogleMapController> _controllerCompleter =
      Completer<GoogleMapController>();
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatingProvider>(builder: (context, provider, child) {
      double lat = double.parse(provider.lat ?? "0.0");
      double long = double.parse(provider.long ?? "0.0");
      _controller?.moveCamera(
        CameraUpdate.newLatLng(
          LatLng(lat, long),
        ),
      );
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        height: Responsive.height * 20,
        width: Responsive.width * 100,
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            if (!_controllerCompleter.isCompleted) {
              _controllerCompleter.complete(controller);
            }
            _controller = controller;
            _controller?.moveCamera(
              CameraUpdate.newLatLng(
                widget.isEdit
                    ? LatLng(
                        widget.editLatitude ?? 0.0,
                        widget.editLongitude ?? 0.0,
                      )
                    : LatLng(
                        lat,
                        long,
                      ),
              ),
            );
          },
          initialCameraPosition: CameraPosition(
            target: widget.isEdit
                ? LatLng(
                    widget.editLatitude ?? 0.0,
                    widget.editLongitude ?? 0.0,
                  )
                : LatLng(
                    lat,
                    long,
                  ),
            zoom: 14.4746,
          ),
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          onTap: (_) {
            Routes.push(
                context: context,
                screen: LocationView(
                  editLatitude: widget.editLatitude,
                  editLongitude: widget.editLongitude,
                  isEdit: widget.isEdit,
                  lat: lat,
                  long: long,
                ),
                exit: () {
                  setState(() {});
                });
          },
        ),
      );
    });
  }
}
