// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/module/Dating/view%20model/dating_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class LocationProvider extends ChangeNotifier {
  bool permissionGranted = false;

  Future<void> checkLocationPermission({required BuildContext context}) async {
    bool serviceEnabled = await Location.instance.serviceEnabled();
    if (!serviceEnabled) {
      await Location.instance.requestService();
    }
    permissionGranted = await Location.instance.serviceEnabled();
    if (!permissionGranted) {
      toast(
        context,
        title: "Location Permission",
      );
      if (Platform.isAndroid) {
        await Geolocator.openLocationSettings();
      } else if (Platform.isIOS) {
        await Geolocator.openAppSettings();
      }
    }
    await getCurrentLocation(context: context);
  }

  // get current location

  LatLng? latLng;

  Future<void> getCurrentLocation({required BuildContext context}) async {
    try {
      Location location = Location();
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        await location.requestService();
      }
      LocationData lo = await location.getLocation();
      latLng = LatLng(lo.latitude ?? 0.00, lo.longitude ?? 0.0);
      context.read<DatingProvider>().placeName =
          await context.read<DatingProvider>().getPlaceNameFromLatLng(
                latLng?.latitude ?? 0.00,
                latLng?.longitude ?? 0.00,
              );
      context.read<DatingProvider>().lat = lo.latitude.toString();
      context.read<DatingProvider>().long = lo.longitude.toString();
      notifyListeners();
    } catch (e) {
      toast(
        context,
        title: "Location Error",
      );
    }
  }
}
