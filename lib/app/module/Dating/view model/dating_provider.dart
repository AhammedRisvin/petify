// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/server_client_services.dart';
import '../../../core/string_const.dart';
import '../../../core/urls.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_router.dart';
import '../../../utils/enums.dart';
import '../../../utils/loading_overlay.dart';
import '../model/get_all_post.dart';
import '../model/get_chats_model.dart';
import '../model/get_post_details.dart';
import '../model/get_user_post.dart';
import '../view/chat/view/chat_view_screen.dart';

class DatingProvider extends ChangeNotifier {
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

  String? selectedSpecies;

  void setSelectedSpecies(String species) {
    selectedSpecies = species;
    notifyListeners();
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

  String updateSelectedDate(DateTime date) {
    try {
      eventSelectedDate = date;
      selectedDateString = DateFormat('yyyy-MM-dd').format(date);
      return selectedDateString;
    } finally {
      notifyListeners();
    }
  }

  DateTime? eventSelectedDate;

  String selectedDateString = '';

  File? thumbnailImage;
  String? imageTitle;
  String blogImagePath = '';
  Future<File?> pickImageFromGallery() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      var image = result?.files[0];
      if (image == null) return null;
      final imageTemporaryData = File(image.path!);
      thumbnailImage = imageTemporaryData;
      blogImagePath = thumbnailImage?.path ?? "";
      imageTitle = thumbnailImage?.path.split('/').last;
      return imageTemporaryData;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
    }
  }

  String singleImageUr = '';

  String imageTitlee = '';
  Future<void> uploadSingleImage({required BuildContext context}) async {
    singleImageUr = '';
    imageTitlee = '';
    File? tempImage = await pickImageFromGallery();
    LoadingOverlay.of(context).show();
    imageTitlee = tempImage?.path.split('/').last ?? "";
    final fileType = getMimeType(tempImage?.path ?? "");
    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_mushthak',
        tempImage?.path ?? "",
        contentType: MediaType.parse(fileType),
      ),
    );
    request.headers['Content-Type'] = fileType;

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        var data = json.decode(responseBody);
        singleImageUr = data["images"][0]["imageUrl"];
      }
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

// single image picker end

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

// add new date post start

  Future createDatePost({
    required BuildContext context,
    required String name,
    required String age,
    required String height,
    required String weight,
    required VoidCallback clear,
    required String breed,
    required String gender,
    required String lookingFor,
  }) async {
    if (selectedSpecies == null) {
      toast(
        context,
        title: 'Please select species',
        backgroundColor: Colors.red,
      );
    } else if (name.isEmpty) {
      toast(
        context,
        title: 'Please enter name',
        backgroundColor: Colors.red,
      );
    } else if (age.isEmpty) {
      toast(
        context,
        title: 'Please enter age',
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
    } else if (breed.isEmpty) {
      toast(
        context,
        title: 'Please enter breed',
        backgroundColor: Colors.red,
      );
    } else if (gender.isEmpty) {
      toast(
        context,
        title: 'Please enter gender',
        backgroundColor: Colors.red,
      );
    } else if (lookingFor.isEmpty) {
      toast(
        context,
        title: 'Please enter looking for',
        backgroundColor: Colors.red,
      );
    } else if (imageTitle?.isEmpty == true) {
      toast(
        context,
        title: 'Please select image',
        backgroundColor: Colors.red,
      );
    } else {
      try {
        int? weightInt = int.tryParse(weight);
        int? heightInt = int.tryParse(height);
        LoadingOverlay.of(context).show();
        List response = await ServerClient.post(
          Urls.addNewDatePost,
          data: {
            "name": name,
            "age": age,
            "species": selectedSpecies.toString(),
            "breed": breed,
            "gender": gender,
            "birthdate": selectedDateString,
            "weight": weightInt,
            "height": heightInt,
            "image": singleImageUr,
            "location": placeName,
            "latitude": lat,
            "longitude": long,
            "lookingFor": lookingFor,
          },
        );
        if (response.first >= 200 && response.first < 300) {
          selectedSpecies = null;
          singleImageUr = '';
          imageTitle = '';
          thumbnailImage = null;
          imageTitlee = '';
          eventSelectedDate = null;
          selectedDateString = '';
          selectedDateString = '';
          getAllDatePostFn(
            isFromSearch: false,
            isFromCatagory: false,
            isFromFilter: false,
            value: "",
          );

          LoadingOverlay.of(context).hide();
          clear();
          Routes.back(context: context);
          toast(context,
              title: response.last['message'], backgroundColor: Colors.green);
        } else {
          throw Exception('Failed to fetch posts');
        }
      } finally {
        notifyListeners();
      }
    }
  }

  //  add new date post end

  Future<String> getPlaceNameFromLatLng(
    double latitude,
    double longitude,
  ) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        lat = latitude.toString();
        long = longitude.toString();
        notifyListeners();
        return place.locality ?? "Place name not found";
      }
    } catch (e) {
      notifyListeners();
    }
    return "Place name not found";
  }

  String? lat;
  String? long;
  String? placeName;

  GetDateAllPostModel getDateAllPostModel = GetDateAllPostModel();

  GetDateAllPostStatus getDateAllPostStatus = GetDateAllPostStatus.initial;

  Future<void> getAllDatePostFn({
    required bool isFromSearch,
    required bool isFromCatagory,
    required bool isFromFilter,
    required String value,
  }) async {
    try {
      getDateAllPostStatus = GetDateAllPostStatus.loading;
      String url;
      if (isFromSearch) {
        url = Urls.searchDatingPosts + value;
      } else if (isFromCatagory) {
        url = Urls.categoryDatingPosts + value;
      } else if (isFromFilter) {
        url = "${Urls.filterDatingUrl}$long&latitude=$lat";
      } else {
        url = Urls.viewAllDatingPosts;
      }

      // Make the network request
      List response = await ServerClient.get(url);
      if (response.first >= 200 && response.first < 300) {
        getDateAllPostModel = GetDateAllPostModel.fromJson(response.last);
        getDateAllPostStatus = GetDateAllPostStatus.loaded;
        notifyListeners();
      } else {
        getDateAllPostModel = GetDateAllPostModel();
        getDateAllPostStatus = GetDateAllPostStatus.error;
      }
    } finally {
      notifyListeners();
    }
  }

  int selectedIndex = -1;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  List<String> dateFilter = [
    "All",
    "Nearest",
  ];

  String? selectedFilter;

  setSelectedFilter(String? value) {
    selectedFilter = value;
    notifyListeners();
  }

  GetDatePostDetailsModel getDatePostDetailsModel = GetDatePostDetailsModel();

  GetDatePostDetailsStatus getDatePostDetailsStatus =
      GetDatePostDetailsStatus.initial;

  Future<void> getDatePostDetailsFn({required String link}) async {
    try {
      getDatePostDetailsStatus = GetDatePostDetailsStatus.loading;
      List response = await ServerClient.get(
        link,
      );
      if (response.first >= 200 && response.first < 300) {
        getDatePostDetailsModel =
            GetDatePostDetailsModel.fromJson(response.last);
        getDatePostDetailsStatus = GetDatePostDetailsStatus.loaded;
        notifyListeners();
      } else {
        getDatePostDetailsModel = GetDatePostDetailsModel();
        getDatePostDetailsStatus = GetDatePostDetailsStatus.error;
      }
    } finally {
      notifyListeners();
    }
  }

  void shareLink(BuildContext context, String link) {
    Share.share(
      link,
      subject: "Dating Post",
    );
  }

  GetUserDatePostStatus getUserDatePostStatus = GetUserDatePostStatus.initial;

  GetUserPostModel getUserPostModel = GetUserPostModel();

  Future<void> getUserDatePostFn() async {
    try {
      getUserDatePostStatus = GetUserDatePostStatus.loading;
      List response = await ServerClient.get(
        Urls.getUserDatingPosts,
      );
      if (response.first >= 200 && response.first < 300) {
        getUserPostModel = GetUserPostModel.fromJson(response.last);
        getUserDatePostStatus = GetUserDatePostStatus.loaded;
        notifyListeners();
      } else {
        getUserPostModel = GetUserPostModel();
        getUserDatePostStatus = GetUserDatePostStatus.error;
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteDatePostFn(
      {required BuildContext context, required String id}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.put(
        Urls.deleteDatePost + id,
      );
      if (response.first >= 200 && response.first < 300) {
        getUserDatePostFn();
        LoadingOverlay.of(context).hide();
        Routes.back(context: context);
        toast(
          context,
          title: response.last['message'],
          backgroundColor: Colors.green,
        );
      } else {
        LoadingOverlay.of(context).hide();

        toast(
          context,
          title: response.last["message"],
          backgroundColor: Colors.red,
        );
      }
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  // DELETE POST FN END

  // birthday function start

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
      return '$years years and $months months';
    } else if (months > 0) {
      return '$months months and $days days';
    } else {
      return '$days days';
    }
  }

  void formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    selectedDateString = formatter.format(dateTime);
    return;
  }

  String formatDate2(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MMMM-dd');
    final date = formatter.format(dateTime);
    return date;
  }

  Future editDatePostFn({
    required BuildContext context,
    required String name,
    required String age,
    required String height,
    required String weight,
    required VoidCallback clear,
    required String breed,
    required String gender,
    required String lookingFor,
    required String id,
  }) async {
    if (selectedSpecies == null) {
      toast(
        context,
        title: 'Please select species',
        backgroundColor: Colors.red,
      );
    } else if (name.isEmpty) {
      toast(
        context,
        title: 'Please enter name',
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
    } else if (breed.isEmpty) {
      toast(
        context,
        title: 'Please enter breed',
        backgroundColor: Colors.red,
      );
    } else if (gender.isEmpty) {
      toast(
        context,
        title: 'Please enter gender',
        backgroundColor: Colors.red,
      );
    } else if (lookingFor.isEmpty) {
      toast(
        context,
        title: 'Please enter looking for',
        backgroundColor: Colors.red,
      );
    } else if (singleImageUr.isEmpty) {
      toast(
        context,
        title: 'Please select image',
        backgroundColor: Colors.red,
      );
    } else {
      try {
        int? weightInt = int.tryParse(weight);
        int? heightInt = int.tryParse(height);
        LoadingOverlay.of(context).show();
        List response = await ServerClient.put(
          Urls.editNewDatePostUrl + id,
          put: true,
          data: {
            "name": name,
            "age": age,
            "species": selectedSpecies.toString(),
            "breed": breed,
            "gender": gender,
            "birthdate": selectedDateString,
            "weight": weightInt,
            "height": heightInt,
            "image": singleImageUr,
            "location": placeName,
            "latitude": lat,
            "longitude": long,
            "lookingFor": lookingFor,
          },
        );
        if (response.first >= 200 && response.first < 300) {
          selectedSpecies = null;
          singleImageUr = '';
          imageTitle = '';
          thumbnailImage = null;
          imageTitlee = '';
          eventSelectedDate = null;
          selectedDateString = '';
          selectedDateString = '';
          getUserDatePostFn();
          LoadingOverlay.of(context).hide();
          clear();
          Routes.back(context: context);
          toast(context,
              title: response.last['message'], backgroundColor: Colors.green);
        }
      } finally {
        notifyListeners();
      }
    }
  }

  // edit date post end

  // GET CHATS FN START
  GetChatsModel getChatsModel = GetChatsModel();

  GetAllChatsStatus getAllChatsStatus = GetAllChatsStatus.initial;

  Future<void> getAllChatsFn() async {
    try {
      getAllChatsStatus = GetAllChatsStatus.loading;
      List response = await ServerClient.get(
        Urls.getAllChats,
      );
      if (response.first >= 200 && response.first < 300) {
        getChatsModel = GetChatsModel.fromJson(response.last);
        getAllChatsStatus = GetAllChatsStatus.loaded;
        notifyListeners();
      } else {
        getChatsModel = GetChatsModel();
        getAllChatsStatus = GetAllChatsStatus.error;
      }
    } finally {
      notifyListeners();
    }
  }

  // GET CHATS FN END

  // GET ACCESS CHAT FN START

  Future<void> getAccessChatFn({
    required BuildContext context,
    required String id,
    required String userName,
  }) async {
    String userId = await StringConst.getUserID();
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.get(
        Urls.getAccessChat + id,
      );
      if (response.first >= 200 && response.first < 300) {
        String chatId = response.last["chat"]["_id"];
        LoadingOverlay.of(context).hide();
        Routes.push(
          context: context,
          screen: DatingChatView(
            communityId: chatId,
            communityName: userName,
            userId: userId,
          ),
          exit: () {},
        );
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
      }
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  // GET ACCESS CHAT FN END
}
