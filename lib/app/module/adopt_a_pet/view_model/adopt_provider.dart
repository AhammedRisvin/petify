// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:clan_of_pets/app/core/server_client_services.dart';
import 'package:clan_of_pets/app/core/urls.dart';
import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/utils/loading_overlay.dart';
import 'package:flutter/material.dart';

import '../../../utils/enums.dart';
import '../model/get_adopt_pet_details_model.dart';
import '../model/get_all_adoption_pet_model.dart';
import '../model/shown_intrest_model.dart';

class AdoptProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void updateIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  GetAllAdoptionPetModel allPetModel = GetAllAdoptionPetModel();
  GetAllAdoptionPetStatus status = GetAllAdoptionPetStatus.loading;

  List<String> speciesList = [];
  String searchKeyword = '';

  Future<void> getAllAdoptionPetsFn(
      {String petType = '', String search = ''}) async {
    try {
      status = GetAllAdoptionPetStatus.loading;
      searchKeyword = search;
      List response = await ServerClient.get(
        "${Urls.getAllAdoptedPets}$search&petType=$petType",
      );
      if (response.first >= 200 && response.first < 300) {
        allPetModel = GetAllAdoptionPetModel.fromJson(response.last);
        speciesList.clear();
        speciesList.addAll(allPetModel.speciesList ?? []);
        speciesList.insert(0, "All");
        status = GetAllAdoptionPetStatus.loaded;
        notifyListeners();
      } else {
        status = GetAllAdoptionPetStatus.error;
      }
    } catch (e) {
      status = GetAllAdoptionPetStatus.error;
      debugPrint("Error: $e");
    } finally {
      notifyListeners();
    }
  }

  GetAdoptPetDetailsModel detailsModel = GetAdoptPetDetailsModel();
  GetAdoptPetDetailsStatus detailsStatus = GetAdoptPetDetailsStatus.loading;

  Future<void> getAdoptPetDetailsFn({required String petId}) async {
    try {
      detailsModel = GetAdoptPetDetailsModel();
      detailsStatus = GetAdoptPetDetailsStatus.loading;
      List response = await ServerClient.get(
        Urls.getAdoptedPetDetails + petId,
      );
      if (response.first >= 200 && response.first < 300) {
        detailsModel = GetAdoptPetDetailsModel.fromJson(response.last);
        detailsStatus = GetAdoptPetDetailsStatus.loaded;
        notifyListeners();
      } else {
        detailsStatus = GetAdoptPetDetailsStatus.error;
      }
    } catch (e) {
      detailsStatus = GetAdoptPetDetailsStatus.error;
      debugPrint("Error: $e");
    } finally {
      notifyListeners();
    }
  }

  String getPetAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int years = currentDate.year - birthDate.year;
    int months = currentDate.month - birthDate.month;
    int days = currentDate.day - birthDate.day;

    if (days < 0) {
      months--;
      days += 30;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    if (years > 0) {
      return '$years years';
    } else if (months > 0) {
      return '$months months';
    } else {
      return '$days days';
    }
  }

  // ------- show interest start ------- //

  Future<void> showInterestFn(
      {required BuildContext ctx, required String petId}) async {
    try {
      LoadingOverlay.of(ctx).show();
      List response = await ServerClient.put(
        Urls.showInterest + petId,
        put: false,
      );

      if (response.first >= 200 && response.first < 300) {
        detailsModel.intrested = true;
        toast(
          ctx,
          title: "Interest shown successfully",
          backgroundColor: Colors.green,
        );
        notifyListeners();
      } else {
        toast(
          ctx,
          title: "Failed to show interest",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      toast(
        ctx,
        title: "Server is busy, try again later",
        backgroundColor: Colors.red,
      );
      debugPrint("Error: $e");
    } finally {
      LoadingOverlay.of(ctx).hide();
    }
  }

  // ------- show interest end ------- //

  // ------- GET INTRESTED PETS FN START ------- //

  GetShowIntrestModel shownIntrestModel = GetShowIntrestModel();
  GetShowIntrestStatus shownIntrestStatus = GetShowIntrestStatus.loading;

  Future<void> getIntrestedPetFn() async {
    try {
      shownIntrestModel = GetShowIntrestModel();
      shownIntrestStatus = GetShowIntrestStatus.loading;
      List response = await ServerClient.get(
        Urls.getInterestedPets,
      );
      log(" response.first ${response.first} \n response.last ${response.last}");
      if (response.first >= 200 && response.first < 300) {
        shownIntrestModel = GetShowIntrestModel.fromJson(response.last);
        shownIntrestStatus = GetShowIntrestStatus.loaded;
        notifyListeners();
      } else {
        shownIntrestStatus = GetShowIntrestStatus.error;
      }
    } catch (e) {
      shownIntrestStatus = GetShowIntrestStatus.error;
      debugPrint("Error: $e");
    } finally {
      notifyListeners();
    }
  }

  // ------- GET INTRESTED PETS FN END ------- //

  // ------- Show un intrest FN Start ------- //

  Future<void> showUnIntrest(
      {required BuildContext ctx, required String petId}) async {
    try {
      LoadingOverlay.of(ctx).show();
      List response = await ServerClient.put(
        Urls.unIntrestUrl + petId,
        put: false,
      );

      if (response.first >= 200 && response.first < 300) {
        toast(
          ctx,
          title: "Uninterested successfully",
          backgroundColor: Colors.green,
        );
        getIntrestedPetFn();
      } else {
        toast(
          ctx,
          title: "Failed to remove the pet",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      toast(
        ctx,
        title: "Server is busy, try again later",
        backgroundColor: Colors.red,
      );
      debugPrint("Error: $e");
    } finally {
      LoadingOverlay.of(ctx).hide();
    }
  }

  // ------- Show un intrest FN END ------- //
}
