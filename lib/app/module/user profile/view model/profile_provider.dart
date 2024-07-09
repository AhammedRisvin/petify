// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:clan_of_pets/app/utils/loading_overlay.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:language_picker/languages.dart';
import 'package:provider/provider.dart';

import '../../../core/server_client_services.dart';
import '../../../core/urls.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_router.dart';
import '../../../utils/enums.dart';
import '../../auth/view model/number_validation_map.dart';
import '../../pet profile/view model/pet_profile_provider.dart';
import '../model/pet_model.dart';
import '../model/pet_without_temp_parrent_model.dart';
import '../model/temmp_pets_model.dart';
import '../model/user_profile_model.dart';

class EditController extends ChangeNotifier {
  String selectedCountry = '';
  String? selectedState;
  String? selectedCity;
  Language? selectedLanguage;

  void setCountry(String country) {
    selectedCountry = country;
    notifyListeners();
  }

  void setState(String? state) {
    selectedState = state;
    notifyListeners();
  }

  void setCity(String? city) {
    selectedCity = city;
    notifyListeners();
  }

  void setLanguage(Language? language) {
    selectedLanguage = language;
    notifyListeners();
  }

  /// Add Co Parent and Temp access Section  Start

  TextEditingController addCoParentFirstNameController =
      TextEditingController();
  TextEditingController addCoParentLastNameController = TextEditingController();
  TextEditingController addCoParentMobileController = TextEditingController();

  int maxLength = 9;
  String countryCodeCtrl = "+917";

  void updateCountryCode(String value) {
    countryCodeCtrl = value;
    getMaxLength();
    notifyListeners();
  }

  void getMaxLength() {
    maxLength = NumberValidation.getLength(countryCodeCtrl);
  }

  String? selectedPet;
  TempPet? selectedPetId;
  List<TempPet> selectedPetListForTempAccess = [];
  void selectPetFun(TempPet? pet) {
    selectedPet = pet?.name;
    selectedPetId = pet;
    notifyListeners();
  }

  List<String> selectPetIdForAddPetInTempUser = [];
  void selectPetForAddPetInTempParentFun(String? petId) {
    selectPetIdForAddPetInTempUser.clear();
    selectPetIdForAddPetInTempUser.add(petId!);
    notifyListeners();
  }

  GetPetWithoutTempParentModel petWithoutTempParentModel =
      GetPetWithoutTempParentModel();

  int petWithoutTempParentModelStatus = 0;

  List<TempPet> petWithoutTempParentModelList = [];
  Future getPetsWithoutTempParentFun() async {
    try {
      petWithoutTempParentModelStatus = 0;
      List response = await ServerClient.get(
        Urls.getPetsWithoutTempParent,
      );

      if (response.first >= 200 && response.first < 300) {
        petWithoutTempParentModel =
            GetPetWithoutTempParentModel.fromJson(response.last);
        petWithoutTempParentModelList.clear();
        petWithoutTempParentModelList.addAll(
            petWithoutTempParentModel.petsWithoutTemporaryParents ?? []);

        notifyListeners();
      } else {
        petWithoutTempParentModelList = [];
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      petWithoutTempParentModelStatus++;
      notifyListeners();
    }
  }

  Future addPetInTempParentFun(
      {required BuildContext context,
      required String temporaryParentId,
      required void Function() function}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.put(
        Urls.addPetForTemporaryParent,
        put: true,
        data: {
          "temporaryParent": temporaryParentId,
          "pets": selectPetIdForAddPetInTempUser
        },
      );
      if (response.first >= 200 && response.first < 300) {
        selectPetIdForAddPetInTempUser.clear();
        function();
        Routes.back(context: context);
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
      } else {
        toast(context,
            title: response.last["message"], backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  List<String> selectedPetList = [];
  void addPetForTempAccessFun(bool check) {
    if (check) {
      if (selectedPetList.contains(selectedPetId?.id)) {
        return;
      }
      selectedPetListForTempAccess.add(selectedPetId ?? TempPet());
      selectedPetList.add(selectedPetId?.id ?? '');
    } else {
      if (selectedPetListForTempAccess.contains(selectedPetId)) {
        selectedPetListForTempAccess.remove(selectedPetId);
      } else {
        selectedPetListForTempAccess.add(selectedPetId ?? TempPet());
      }

      if (selectedPetList.contains(selectedPetId?.id)) {
        selectedPetList.remove(selectedPetId?.id);
      } else {
        selectedPetList.add(selectedPetId?.id ?? '');
      }
    }

    notifyListeners();
  }

  PetModel petModel = PetModel();
  List<Pet> petModelList = [];
  int petModelStatus = 0;

  Future getPetsFun() async {
    try {
      petModelStatus = 0;
      List response = await ServerClient.get(
        Urls.getPets,
      );
      if (response.first >= 200 && response.first < 300) {
        petModel = PetModel.fromJson(response.last);
        petModelList.clear();
        petModelList.addAll(petModel.pets ?? []);

        notifyListeners();
      } else {
        petModelList = [];
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      petModelStatus++;
      notifyListeners();
    }
  }

  Future addCoParentFun({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.addCoParent,
        data: {
          "profile": context.read<PetProfileProvider>().singleImageUr,
          "firstName": addCoParentFirstNameController.text,
          "lastName": addCoParentLastNameController.text,
          "phone": "$countryCodeCtrl${addCoParentMobileController.text}",
        },
      );
      if (response.first >= 200 && response.first < 300) {
        getUserProfileDetailsFn();
        addCoParentFirstNameController.clear();
        addCoParentLastNameController.clear();
        addCoParentMobileController.clear();
        selectPetIdForAddPetInTempUser.clear();
        selectedPetListForTempAccess.clear();
        selectedPetList.clear();
        context.read<PetProfileProvider>().singleImageUr = '';
        context.read<PetProfileProvider>().imageTitle = null;

        Routes.back(context: context);
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
      } else {
        toast(context,
            title: response.last["message"], backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  Future addTemporaryAccessFun({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.addTempAccess,
        data: {
          "profile": context.read<PetProfileProvider>().singleImageUr,
          "firstName": addCoParentFirstNameController.text,
          "lastName": addCoParentLastNameController.text,
          "phone": "$countryCodeCtrl${addCoParentMobileController.text}",
          "pets": selectedPetList
        },
      );
      if (response.first >= 200 && response.first < 300) {
        getUserProfileDetailsFn();
        selectPetIdForAddPetInTempUser.clear();
        selectedPetListForTempAccess.clear();
        selectedPetList.clear();
        selectedPetId = null;
        selectedPet = null;

        selectedPetListForTempAccess.clear();
        addCoParentFirstNameController.clear();
        addCoParentLastNameController.clear();
        addCoParentMobileController.clear();
        selectedPetList.clear();
        context.read<PetProfileProvider>().singleImageUr = '';
        context.read<PetProfileProvider>().imageTitle = null;
        Routes.back(context: context);
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
      } else {
        toast(context,
            title: response.last["message"], backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  /// Add Co Parent nd Temp access  Section  End

//pick image and upload image start

  File? thumbnailImage;
  String? imageTitle;
  String blogImagePath = '';
  File? profileImageFile;
  File? coverImageFile;
  String? thumbnailImagePathForProfilePic;
  String? thumbnailImagePathForCoverPic;
  String? profileImagePath;
  String? coverImagePath;
  String imageUrlForUploadProfile = '';
  String imageUrlForUploadCover = '';

  Future<File?> pickImageFromGallery({
    required bool isFromProfilePic,
    required BuildContext context,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      if (result == null) return null;
      final imageTemporaryData = File(result.files.single.path!);

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageTemporaryData.path,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        uiSettings: [
          IOSUiSettings(minimumAspectRatio: 1.0),
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
      );
      if (croppedFile == null) return null;

      _setImagePaths(isFromProfilePic, croppedFile.path);
      return File(croppedFile.path);
    } catch (e) {
      debugPrint('Failed to pick image: $e');
      return null;
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  Future<void> uploadImage({
    required bool isFromProfilePic,
    required BuildContext context,
  }) async {
    LoadingOverlay.of(context).show();
    try {
      final tempImage = await pickImageFromGallery(
        isFromProfilePic: isFromProfilePic,
        context: context,
      );
      if (tempImage == null) return;

      final fileType = getMimeType(tempImage.path);
      // if (fileType == null) throw Exception('Unsupported file type');

      const url = 'https://api.dev.test.image.theowpc.com/upload';
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..files.add(await http.MultipartFile.fromPath(
          'image_mushthak',
          tempImage.path,
          contentType: MediaType.parse(fileType),
        ))
        ..headers['Content-Type'] = fileType;

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final data = json.decode(responseBody);
        _setImageUrl(isFromProfilePic, data["images"][0]["imageUrl"]);
      } else {
        debugPrint('Error uploading image: $responseBody');
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e');
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  void _setImagePaths(bool isFromProfilePic, String path) {
    if (isFromProfilePic) {
      profileImageFile = File(path);
      thumbnailImagePathForProfilePic = path;
      profileImagePath = path.split('/').last;
    } else {
      coverImageFile = File(path);
      thumbnailImagePathForCoverPic = path;
      coverImagePath = path.split('/').last;
    }
  }

  void _setImageUrl(bool isFromProfilePic, String imageUrl) {
    if (isFromProfilePic) {
      imageUrlForUploadProfile = imageUrl;
    } else {
      imageUrlForUploadCover = imageUrl;
    }
  }

  String getMimeType(String filePath) {
    final file = File(filePath);
    final fileType = file.path.split('.').last.toLowerCase();
    switch (fileType) {
      case 'jpg':
        return 'image/jpg';
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'mp4':
        return 'video/mp4';
      case 'webm':
        return 'video/webm';
      case 'mov':
        return 'video/quicktime';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'mkv':
        return 'video/x-matroska';
      case 'avi':
        return 'video/x-msvideo';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'flac':
        return 'audio/flac';
      default:
        return 'application/octet-stream';
    }
  }
// pick and upload image end

// edit profile start

  Future addUserProfileFn({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required VoidCallback clear,
  }) async {
    if (firstName.isEmpty) {
      toast(
        context,
        title: 'First name is empty',
        backgroundColor: Colors.red,
      );
    } else if (lastName.isEmpty) {
      toast(
        context,
        title: 'last name is empty',
        backgroundColor: Colors.red,
      );
    } else if (selectedCountry.isEmpty) {
      toast(
        context,
        title: 'Please select country',
        backgroundColor: Colors.red,
      );
    } else if (selectedState == null) {
      toast(
        context,
        title: 'Please select state',
        backgroundColor: Colors.red,
      );
    } else if (selectedCity == null) {
      toast(
        context,
        title: 'Please select city',
        backgroundColor: Colors.red,
      );
    } else if (selectedLanguage == null) {
      toast(
        context,
        title: 'Please select language',
        backgroundColor: Colors.red,
      );
    } else if (imageUrlForUploadCover.isEmpty) {
      toast(
        context,
        title: 'Please select cover image',
        backgroundColor: Colors.red,
      );
    } else if (imageUrlForUploadProfile.isEmpty) {
      toast(
        context,
        title: 'Please select profile image',
        backgroundColor: Colors.red,
      );
    } else {
      try {
        LoadingOverlay.of(context).show();
        List response = await ServerClient.post(
          Urls.addUserProfileUrl,
          data: {
            "firstName": firstName,
            "lastName": lastName,
            "nationality": selectedCountry.toString(),
            "country": selectedState.toString(),
            "city": selectedCity.toString(),
            "language": selectedLanguage?.isoCode,
            "timeZone": "Asia/Kolkata",
            "profile": imageUrlForUploadProfile,
            "coverImage": imageUrlForUploadCover,
          },
        );
        if (response.first >= 200 && response.first < 300) {
          selectedCountry = '';
          selectedState = '';
          selectedCity = '';
          selectedLanguage = null;
          imageUrlForUploadCover = "";
          imageUrlForUploadProfile = '';
          profileImagePath = '';
          coverImagePath = '';
          getUserProfileDetailsFn();
          LoadingOverlay.of(context).hide();
          Routes.back(context: context);
          toast(context,
              title: response.last['message'], backgroundColor: Colors.green);
        } else {
          toast(
            context,
            title: response.last["message"],
            backgroundColor: Colors.red,
          );
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        clear();
        notifyListeners();
      }
    }
  }

// edit profile end

// get profile start

  GetUserProfileModel getUserProfileModel = GetUserProfileModel();

  GetUserProfileStatus getUserProfileStatus = GetUserProfileStatus.initial;

  Future getUserProfileDetailsFn() async {
    try {
      getUserProfileStatus = GetUserProfileStatus.loading;
      List response = await ServerClient.get(Urls.getUserProfileUrl);
      if (response.first >= 200 && response.first < 300) {
        getUserProfileModel = GetUserProfileModel();
        getUserProfileModel = GetUserProfileModel.fromJson(response.last);
        getUserProfileStatus = GetUserProfileStatus.loaded;
      } else {
        getUserProfileModel = GetUserProfileModel();
        getUserProfileStatus = GetUserProfileStatus.error;
      }
    } catch (e) {
      getUserProfileModel = GetUserProfileModel();
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

// get profile end

  void addUserDataIntoCntrlrs() {
    selectedCountry = getUserProfileModel.details?.nationality ?? '';
    selectedCity = getUserProfileModel.details?.city ?? '';
    selectedState = getUserProfileModel.details?.country;
    coverImagePath =
        getUserProfileModel.details?.coverImage?.split('/').last ?? '';
    profileImagePath =
        getUserProfileModel.details?.profile?.split('/').last ?? '';
    notifyListeners();
  }

  // REMOVE COPARENT FN
  Future removeCoParentFun({
    required BuildContext context,
    required String id,
    required Function() onTap,
    required bool isFromCoParent,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.delete(
        isFromCoParent ? Urls.removeCoParent + id : Urls.removeTempAccess + id,
      );
      if (response.first >= 200 && response.first < 300) {
        getUserProfileDetailsFn();
        onTap();
        LoadingOverlay.of(context).hide();

        toast(context,
            title: response.last['message'], backgroundColor: Colors.red);
      } else {
        toast(context,
            title: response.last["message"], backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateTempParentAccessForPetFn(
      {required String petId,
      required String tempParentId,
      required BuildContext context,
      required void Function() function}) async {
    try {
      LoadingOverlay.of(context).show();
      var body = {
        "pet": petId,
        "temporaryParent": tempParentId,
      };
      List response = await ServerClient.put(Urls.removePetFromTempParent,
          data: body, put: true);
      if (response.first >= 200 && response.first < 300) {
        function();
        notifyListeners();
        toast(context, title: "Removed", backgroundColor: Colors.green);
        Routes.back(context: context);
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  //  edi user profile start

  Future editUserProfileFn({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required VoidCallback clear,
  }) async {
    if (firstName.isEmpty) {
      toast(
        context,
        title: 'First name is empty',
        backgroundColor: Colors.red,
      );
    } else if (lastName.isEmpty) {
      toast(
        context,
        title: 'last name is empty',
        backgroundColor: Colors.red,
      );
    } else if (selectedCountry.isEmpty) {
      toast(
        context,
        title: 'Please select country',
        backgroundColor: Colors.red,
      );
    } else if (selectedState == null) {
      toast(
        context,
        title: 'Please select state',
        backgroundColor: Colors.red,
      );
    } else if (selectedCity == null) {
      toast(
        context,
        title: 'Please select city',
        backgroundColor: Colors.red,
      );
    } else if (selectedLanguage == null) {
      toast(
        context,
        title: 'Please select language',
        backgroundColor: Colors.red,
      );
    } else if (imageUrlForUploadCover.isEmpty) {
      toast(
        context,
        title: 'Please select cover image',
        backgroundColor: Colors.red,
      );
    } else if (imageUrlForUploadProfile.isEmpty) {
      toast(
        context,
        title: 'Please select profile image',
        backgroundColor: Colors.red,
      );
    } else {
      try {
        LoadingOverlay.of(context).show();
        List response = await ServerClient.put(
          Urls.addUserProfileUrl,
          put: true,
          data: {
            "firstName": firstName,
            "lastName": lastName,
            "nationality": selectedCountry.toString(),
            "country": selectedState.toString(),
            "city": selectedCity.toString(),
            "language": selectedLanguage?.isoCode,
            "timeZone": "Asia/Kolkata",
            "profile": imageUrlForUploadProfile,
            "coverImage": imageUrlForUploadCover,
          },
        );
        if (response.first >= 200 && response.first < 300) {
          selectedCountry = '';
          selectedState = '';
          selectedCity = '';
          selectedLanguage = null;
          imageUrlForUploadCover = "";
          imageUrlForUploadProfile = '';
          profileImagePath = '';
          coverImagePath = '';
          getUserProfileDetailsFn();
          LoadingOverlay.of(context).hide();

          Routes.back(context: context);
          toast(context,
              title: response.last['message'], backgroundColor: Colors.green);
        } else {
          toast(context,
              title: response.last["message"], backgroundColor: Colors.red);
          throw Exception('Failed to fetch posts');
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        clear();
        notifyListeners();
      }
    }
  }

  bool isSelected = false;

  void isPeSelected() {
    isSelected = !isSelected;
    notifyListeners();
  }

  //  edit user profile end
}
