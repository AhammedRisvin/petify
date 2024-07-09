// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:clan_of_pets/app/core/string_const.dart';
import 'package:clan_of_pets/app/module/blog/view/blog_home_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

import '../../../core/server_client_services.dart';
import '../../../core/urls.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_router.dart';
import '../../../utils/enums.dart';
import '../../../utils/loading_overlay.dart';
import '../../Pet services/view/pet_services_home_screen.dart';
import '../../community/community home/view/community_home_screen.dart';
import '../../pet profile/view/pet_profile_screen.dart';
import '../model/get_pet_model.dart';
import '../view/home_screen.dart';

class HomeProvider extends ChangeNotifier {
  int selectedIndex = 0;
  final List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const PetServicesHomeScreen(),
    const CommunityHomeScreen(),
    const BlogHomeScreen(),
    const PetProfileScreen(),
  ];

  void onItemTapped({required int index, bool isTap = false}) {
    selectedIndex = index;

    notifyListeners();
  }

  // PET SPECIES

  List<String> petSpecies = [
    'Dog',
    'Cat',
    'Bird',
    'Rabbit',
    'Fish',
    'Turtle',
    'Hamster',
    'Guinea Pig',
    'Horse',
    'Pig',
    'Goat',
    'Cow',
    'Sheep',
    'Chicken',
    'Duck',
    'Goose',
    'Turkey',
    'Pigeon',
    'Parrot',
    'Cockatoo',
    'Macaw',
    'Canary',
    'Finch',
    'Budgerigar',
    'Lovebird',
    'Cockatiel',
    'Conure',
    'African Grey',
    'Amazon',
    'Eclectus',
    'Lory',
    'Quaker',
    'Caique',
    'Pionus',
    'Senegal',
    'Peachface',
    'Rosella',
    'Bourke',
    'Neophema',
    'Plumhead',
    'Ringneck',
    'Alexandrine',
    'Indian Ringneck',
    'Moustache',
    'Derbyan',
    'Red Rump',
    'Kakariki',
    'Lorikeet',
    'Swift',
  ];

  // PET BREEDS

  List<String> petBreeds = [
    '',
    'Affenpinscher',
    'Afghan Hound',
    'Airedale Terrier',
    'Akita',
    'Alaskan Malamute',
    'American Bulldog',
    'American English Coonhound',
    'American Eskimo Dog',
    'American Foxhound',
    'American Pit Bull Terrier',
    'American Water Spaniel',
    'Anatolian Shepherd Dog',
    'Appenzeller Sennenhunde',
    'Australian Cattle Dog',
    'Australian Shepherd',
    'Australian Terrier',
    'Azawakh',
    'Barbet',
    'Basenji',
    'Basset Hound',
    'Beagle',
    'Bearded Collie',
    'Bedlington Terrier',
    'Belgian Malinois',
    'Belgian Sheepdog',
    'Belgian Tervuren',
    'Berger Picard',
    'Bernedoodle',
    'Bernese Mountain Dog',
    'Bichon Frise',
    'Black and Tan Coonhound',
    'Black Mouth Cur',
    'Bloodhound',
    'Bluetick Coonhound',
    'Boerboel',
    'Bolognese',
    'Border Collie',
    'Border Terrier',
    'Borzoi',
    'Boston Terrier',
    'Bouvier des Flandres',
    'Boxer',
    'Boykin Spaniel',
    'Bracco Italiano',
    'Briard',
    'Brittany',
    'Brussels Griffon',
    'Bull Terrier',
    'Bulldog',
    'Bullmastiff',
    'Cairn Terrier',
    'Canaan Dog',
    'Cane Corso',
    'Cardigan Welsh Corgi',
    'Catahoula Leopard Dog',
    'Caucasian Shepherd Dog',
    'Cavalier King Charles Spaniel',
    'Cesky Terrier',
    'Chesapeake Bay Retriever',
    'Chihuahua',
    'Chinese Crested',
    'Chinese Shar-Pei',
    'Chinook',
    'Chow Chow',
    'Clumber Spaniel',
    'Cockapoo',
    'Cocker Spaniel',
    'Collie',
    'Coton de Tulear',
    'Curly-Coated Retriever',
    'Dachshund',
    'Dalmatian',
    'Dandie Dinmont Terrier',
    'Doberman Pinscher',
    'Dogo Argentino',
    'Dogue de Bordeaux',
    'Dutch Shepherd',
    'English Cocker Spaniel',
    'English Foxhound',
    'English Setter',
    'English Springer Spaniel',
    'English Toy Spaniel',
    'Entlebucher Mountain Dog',
    'Estrela Mountain Dog',
    'Eurasier',
    'Field Spaniel',
    'Finnish Lapphund',
    'Finnish Spitz',
    'Flat-Coated Retriever',
    'French Bulldog',
    'German Pinscher',
    'German Shepherd Dog',
    'German Shorthaired Pointer',
    'German Wirehaired Pointer',
    'Giant Schnauzer',
    'Glen of Imaal Terrier',
    'Goldador',
    'Golden Retriever',
    'Goldendoodle',
    'Gordon Setter',
    'Great Dane',
    'Great Pyrenees',
    'Greater Swiss Mountain Dog',
    'Greyhound',
    'Harrier',
    'Havanese',
    'Ibizan Hound',
    'Icelandic Sheepdog',
    'Irish Red and White Setter',
    'Irish Setter',
    'Irish Terrier',
    'Irish Water Spaniel',
    'Irish Wolfhound',
    'Italian Greyhound',
    'Jack Russell Terrier',
    'Japanese Chin',
    'Japanese Spitz',
    'Korean Jindo Dog',
    'Karelian Bear Dog',
    'Keeshond',
    'Kerry Blue Terrier',
    'Komondor',
    'Kooikerhondje',
    'Kuvasz',
    'Labradoodle',
    'Labrador Retriever',
    'Lagotto Romagnolo',
    'Lakeland Terrier',
    'Lancashire Heeler',
    'Leonberger',
    'Lhasa Apso',
    'Lowchen',
    'Maltese',
    'Manchester Terrier',
    'Mastiff',
    'Miniature Pinscher',
    'Miniature Schnauzer',
    'Mudi',
    'Neapolitan Mastiff',
    'Newfoundland',
    'Norfolk Terrier',
    'Norwegian Buhund',
    'Norwegian Elkhound',
    'Norwegian Lundehund',
    'Norwich Terrier',
    'Nova Scotia Duck Tolling Retriever',
    'Old English Sheepdog',
    'Otterhound',
    'Papillon',
    'Peekapoo',
    'Pekingese',
    'Pembroke Welsh Corgi',
    'Petit Basset Griffon Vendeen',
    'Pharaoh Hound',
    'Plott',
    'Pocket Beagle',
    'Pointer',
    'Polish Lowland Sheepdog',
    'Pomeranian',
    'Poodle',
    'Portuguese Water Dog',
    'Pug',
    'Puli',
    'Pyrenean Shepherd',
    'Rat Terrier',
    'Redbone Coonhound',
    'Rhodesian Ridgeback',
    'Rottweiler',
    'Saint Bernard',
    'Saluki',
    'Samoyed',
    'Schipperke',
    'Scottish Deerhound',
    'Scottish Terrier',
    'Sealyham Terrier',
    'Shetland Sheepdog',
    'Shiba Inu',
    'Shih Tzu',
    'Siberian Husky',
    'Silky Terrier',
    'Skye Terrier',
    'Sloughi',
    'Small Munsterlander Pointer',
    'Soft Coated Wheaten Terrier',
    'Stabyhoun',
    'Staffordshire Bull Terrier',
    'Standard Schnauzer',
    'Sussex Spaniel',
    'Swedish Vallhund',
    'Tibetan Mastiff',
    'Tibetan Spaniel',
    'Tibetan Terrier',
    'Toy Fox Terrier',
    'Treeing Tennessee Brindle',
    'Treeing Walker Coonhound',
    'Vizsla',
    'Weimaraner',
    'Welsh Springer Spaniel',
    'Welsh Terrier',
    'West Highland White Terrier',
    'Whippet',
    'Wirehaired Pointing Griffon',
    'Xoloitzcuintli',
    'Yorkipoo',
    'Yorkshire Terrier',
  ];

  // Pet gender

  List<String> petGender = [
    "Male",
    "Female",
    "Other",
  ];

  String? selectedSpecies;

  void setSelectedSpecies(String species) {
    selectedSpecies = species;
    notifyListeners();
  }

  String? selectedBreed;

  void setSelectedBreed(String breed) {
    selectedBreed = breed;
    notifyListeners();
  }

  String? selectedSex;

  void setSelectedSex(String sex) {
    selectedSex = sex;
    notifyListeners();
  }

  DateTime? eventSelectedDate;

  String selectedDateString = '';
  String eventSelectedTimeString = '';

  String updateSelectedDate(DateTime date) {
    try {
      eventSelectedDate = date;
      selectedDateString = DateFormat('yyyy-MM-dd').format(date);
      return selectedDateString;
    } finally {
      notifyListeners();
    }
  }

  Future<void> eventSelectDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      updateSelectedDate(picked);
    }
  }

//pick image and upload image start
  File? thumbnailImage;
  String blogImagePath = '';
  File? profileImageFile;
  File? coverImageFile;
  String? thumbnailImagePathForProfilePic;
  String? thumbnailImagePathForCoverPic;
  String? profileImagePath;
  String? coverImagePath;
  Future<File?> pickImageFromGallery({required bool isFromProfilePic}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      var image = result?.files[0];
      if (image == null) return null;
      final imageTemporaryData = File(image.path!);
      if (isFromProfilePic == true) {
        profileImageFile = imageTemporaryData;
        thumbnailImagePathForProfilePic = profileImageFile?.path;
        profileImagePath = thumbnailImagePathForProfilePic?.split('/').last;
      } else {
        coverImageFile = imageTemporaryData;
        thumbnailImagePathForCoverPic = coverImageFile?.path;
        coverImagePath = thumbnailImagePathForCoverPic?.split('/').last;
      }
      return imageTemporaryData;
    } catch (e) {
      debugPrint('Failed to pick image: $e');
      return null;
    } finally {
      notifyListeners();
    }
  }

  // Image Upload Function
  String imageUrlForUploadProfile = '';
  String imageUrlForUploadCover = '';

  Future<void> uploadImage({
    required bool isFromProfilePic,
    required BuildContext context,
  }) async {
    File? tempImage =
        await pickImageFromGallery(isFromProfilePic: isFromProfilePic);
    if (tempImage == null) {
      return;
    }
    final fileType = getMimeType(tempImage.path);
    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_mushthak',
        tempImage.path,
        contentType: MediaType.parse(fileType),
      ),
    );
    request.headers['Content-Type'] = fileType;

    try {
      LoadingOverlay.of(context).show();
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        if (isFromProfilePic) {
          imageUrlForUploadProfile = data["images"][0]["imageUrl"];
        } else {
          imageUrlForUploadCover = data["images"][0]["imageUrl"];
        }
        LoadingOverlay.of(context).hide();
      } else {
        LoadingOverlay.of(context).hide();
        debugPrint('Error uploading image with response: $responseBody');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      debugPrint('Error occurred during upload: $e ');
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

// add new pet start

  Future addPetFn({
    required BuildContext context,
    required String name,
    required String nickName,
    required String height,
    required String weight,
    required VoidCallback clear,
    required String copId,
    required String microChipId,
  }) async {
    if (imageUrlForUploadCover.isEmpty) {
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
    } else if (selectedSpecies == null) {
      toast(
        context,
        title: 'Please select species',
        backgroundColor: Colors.red,
      );
    } else if (selectedBreed == null) {
      toast(
        context,
        title: 'Please select breed',
        backgroundColor: Colors.red,
      );
    } else if (selectedSex == null) {
      toast(
        context,
        title: 'Please select Gender',
        backgroundColor: Colors.red,
      );
    } else if (name.isEmpty) {
      toast(
        context,
        title: 'Please enter name',
        backgroundColor: Colors.red,
      );
    } else if (nickName.isEmpty) {
      toast(
        context,
        title: 'Please enter nick name',
        backgroundColor: Colors.red,
      );
    } else if (height.isEmpty) {
      toast(
        context,
        title: 'Please enter height',
        backgroundColor: Colors.red,
      );
    } else if (weight.isEmpty) {
      toast(
        context,
        title: 'Please enter weight',
        backgroundColor: Colors.red,
      );
    } else if (selectedDateString.isEmpty) {
      toast(
        context,
        title: 'Please select date of birth',
        backgroundColor: Colors.red,
      );
    } else if (copId.isEmpty) {
      toast(
        context,
        title: 'Please enter cop id',
        backgroundColor: Colors.red,
      );
    } else if (microChipId.isEmpty) {
      toast(
        context,
        title: 'Please enter micro chip id',
        backgroundColor: Colors.red,
      );
    } else {
      try {
        int? weightInt = int.tryParse(weight);
        int? heightInt = int.tryParse(height);
        LoadingOverlay.of(context).show();
        List response = await ServerClient.post(
          Urls.addPetUrl,
          data: {
            "name": name,
            "nickName": nickName,
            "species": selectedSpecies.toString(),
            "breed": selectedBreed.toString(),
            "sex": selectedSex.toString(),
            "birthDate": eventSelectedDate.toString(),
            "weight": weightInt,
            "height": heightInt,
            "image": imageUrlForUploadProfile,
            "coverImage": imageUrlForUploadCover,
            "copId": copId,
            "chipId": microChipId,
          },
        );

        if (response.first >= 200 && response.first < 300) {
          getPetModel.pets?.removeLast();
          getPetModel.pets?.add(
            PetData(
              name: name,
              nickName: nickName,
              species: selectedSpecies,
              breed: selectedBreed,
              appId: "",
              chipId: microChipId,
              copId: copId,
              birthDate: eventSelectedDate,
              coParents: [],
              coverImage: imageUrlForUploadCover,
              createdAt: DateTime.now(),
              height: heightInt,
              id: "",
              image: imageUrlForUploadProfile,
              parent: "",
              sex: selectedSex,
              temporaryParents: [],
              weight: weightInt,
              updatedAt: DateTime.now(),
              v: 1,
            ),
          );
          getPetModel.pets?.add(PetData());
          selectedSpecies = null;
          selectedBreed = null;
          selectedSex = null;
          imageUrlForUploadCover = "";
          imageUrlForUploadProfile = '';
          profileImagePath = '';
          coverImagePath = '';
          eventSelectedDate = null;
          selectedDateString = '';
          getPetFn();
          LoadingOverlay.of(context).hide();
          clear();
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
        notifyListeners();
      }
    }
  }

// add new pet end

  // GET PET START

  GetPetModel getPetModel = GetPetModel();

  GetPetStatus getPetStatus = GetPetStatus.initial;

  Future getPetFn() async {
    try {
      getPetStatus = GetPetStatus.loading;
      List response = await ServerClient.get(
        Urls.getPetUrl,
      );

      log("response.first ${response.first}  response.last ${response.last}");
      if (response.first >= 200 && response.first < 300) {
        getPetModel = GetPetModel.fromJson(response.last);
        getPetModel.pets?.add(PetData());
        StringConst.setPetId(pet: getPetModel.pets?.first.id ?? '');
        getPetStatus = GetPetStatus.loaded;
        pets.clear();
        pets.addAll(
          getPetModel.pets ?? [],
        );
        pets.removeLast();
        notifyListeners();
      } else {
        getPetStatus = GetPetStatus.error;
        getPetModel = GetPetModel();
      }
    } catch (e) {
      getPetModel = GetPetModel();
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  // GET PET END

  String formatDate(DateTime dateTime) {
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String month = _getMonthName(dateTime.month);
    final String year = dateTime.year.toString();
    return '$day $month $year';
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  String formatDate2(DateTime dateTime) {
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String year = dateTime.year.toString();
    return '$day / $month / $year';
  }

  String userRole = '';

  void getUserRole() async {
    userRole = await StringConst.getUserRole();
    notifyListeners();
  }

  Future editPetFn({
    required BuildContext context,
    required String name,
    required String nickName,
    required String height,
    required String weight,
    required VoidCallback clear,
  }) async {
    final editPetId = await StringConst.getPetID();
    if (imageUrlForUploadCover.isEmpty) {
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
    } else if (name.isEmpty) {
      toast(
        context,
        title: 'Please enter name',
        backgroundColor: Colors.red,
      );
    } else if (nickName.isEmpty) {
      toast(
        context,
        title: 'Please enter nick name',
        backgroundColor: Colors.red,
      );
    } else if (height.isEmpty) {
      toast(
        context,
        title: 'Please enter height',
        backgroundColor: Colors.red,
      );
    } else if (weight.isEmpty) {
      toast(
        context,
        title: 'Please enter weight',
        backgroundColor: Colors.red,
      );
    } else {
      try {
        int? weightInt = int.tryParse(weight);
        int? heightInt = int.tryParse(height);
        LoadingOverlay.of(context).show();
        List response = await ServerClient.put(
          Urls.addPetUrl,
          put: true,
          data: {
            "name": name,
            "nickName": nickName,
            "weight": weightInt,
            "height": heightInt,
            "image": imageUrlForUploadProfile,
            "coverImage": imageUrlForUploadCover,
            "petId": editPetId
          },
        );
        if (response.first >= 200 && response.first < 300) {
          // getPetFn();
          selectedSpecies = null;
          selectedBreed = null;
          selectedSex = null;
          imageUrlForUploadCover = "";
          imageUrlForUploadProfile = '';
          profileImagePath = '';
          coverImagePath = '';
          eventSelectedDate = null;
          selectedDateString = '';
          getPetFn();
          LoadingOverlay.of(context).hide();
          clear();
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
        notifyListeners();
      }
    }
  }

  String index = '0';
  int petIndex = 0;
  String? selectedValue;

  bool isLoading = true;

  List<PetData> pets = [];
  void getUserRoles({required BuildContext context}) async {
    userRole = await StringConst.getUserRole();
    if (userRole == "temporaryParent") {
      await getPetFn();
      pets.clear();
      pets.addAll(
        getPetModel.pets ?? [],
      );
      if (pets.length > 1) {
        pets.removeLast();
      }
      isLoading = false;
      notifyListeners();
    }
  }

  void getPetIndex() async {
    pets.clear();
    index = await StringConst.getPetIndex();
    petIndex = int.tryParse(index) ?? 0;
    pets.addAll(
      getPetModel.pets ?? [],
    );
    if (pets.length > 1) {
      pets.removeLast();
    }
    isLoading = false;
    notifyListeners();
  }

  setPetIndex({required String value}) async {
    petIndex = pets.indexWhere(
      (element) {
        return element.id == value;
      },
    );
    await StringConst.setPetIndex(index: petIndex.toString());
    notifyListeners();
  }
}
