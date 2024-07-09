// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:clan_of_pets/app/utils/loading_overlay.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/server_client_services.dart';
import '../../../core/urls.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/enums.dart';
import '../model/get_lost-pet_model.dart';
import '../view/lost_pet_share_widget.dart';

class LostGemProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();

  LostPetSelectedContainer _selectedContainer =
      LostPetSelectedContainer.lostPetAll;

  LostPetSelectedContainer get selectedContainer => _selectedContainer;

  void updateSelectedContainer(LostPetSelectedContainer newContainer) {
    _selectedContainer = newContainer;
    notifyListeners();
  }

  // GET LOST PET END START

  GetLostPetModel getLostPetModel = GetLostPetModel();

  GetLostPetStatus getLostPetStatus = GetLostPetStatus.initial;

  Future getLostPetFn({required String status, required String keyword}) async {
    try {
      getLostPetStatus = GetLostPetStatus.loading;
      List response = await ServerClient.get(
        "${Urls.getLostPetUrl + status}&keyword=$keyword",
      );

      if (response.first >= 200 && response.first < 300) {
        getLostPetModel = GetLostPetModel.fromJson(response.last);
        getLostPetStatus = GetLostPetStatus.loaded;
      } else {
        getLostPetModel = GetLostPetModel();
        getLostPetStatus = GetLostPetStatus.error;
      }
    } catch (e) {
      getLostPetModel = GetLostPetModel();
      getLostPetStatus = GetLostPetStatus.error;
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }
  // GET LOST PET END

  // GET SINGLE LOST PET START

  Pet? singlePetData;

  getSinglePet(Pet? petData) {
    singlePetData = petData;
    notifyListeners();
  }

  // GET SINGLE LOST PET END

  String formatDateTimeToString(DateTime dateTime) {
    // Define the desired format
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    // Format the DateTime object into a string
    final String formatted = formatter.format(dateTime);

    // Return the formatted string
    return formatted;
  }

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

  // Image Upload Function
  String imageUrlForUpload = '';

  Future<void> uploadImage() async {
    File? tempImage = await pickImageFromGallery();
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
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        imageUrlForUpload = data["images"][0]["imageUrl"];
        debugPrint(
            'Image uploaded successfully with imageUrlForUpload: $imageUrlForUpload');
      } else {
        // Error uploading image
        debugPrint('Error uploading image with response: $responseBody');
      }
    } catch (e) {
      // Error occurred during upload
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

  TextEditingController petInformLocationCntrlr = TextEditingController();
  TextEditingController petInformContactCntrlr = TextEditingController();
  TextEditingController petInformRemarksCntrlr = TextEditingController();
  TextEditingController petInformTimeSeenCntrlr = TextEditingController();

  Future foundPetFn(
      {required BuildContext context, required String petId}) async {
    final combinedDatenTime = DateTime(
      lostPetSelectedDate?.year ?? 00,
      lostPetSelectedDate?.month ?? 00,
      lostPetSelectedDate?.day ?? 00,
      lostPetSelectedTime?.hour ?? 00,
      lostPetSelectedTime?.minute ?? 00,
    );
    if (imageUrlForUpload == '') {
      toast(
        context,
        title: "Image required",
        backgroundColor: Colors.red,
      );
    } else {
      LoadingOverlay.of(context).show();
      try {
        List response = await ServerClient.post(
          Urls.postFoundPet + petId,
          data: {
            "date": combinedDatenTime.toIso8601String(),
            "identification": imageUrlForUpload,
            "contact": petInformContactCntrlr.text,
            "remarks": petInformRemarksCntrlr.text,
            "location": petInformLocationCntrlr.text,
          },
        );
        if (response.first >= 200 && response.first < 300) {
          petInformLocationCntrlr.clear();
          petInformRemarksCntrlr.clear();
          petInformContactCntrlr.clear();
          imageTitle = null;
          lostPetSelectedTimeString = '';
          lostPetSelectedDateString = '';
          imageUrlForUpload = '';
          getLostPetFn(status: "", keyword: "");
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
        notifyListeners();
      }
    }
  }

  //  event date and time selecting start

  DateTime? lostPetSelectedDate;
  TimeOfDay? lostPetSelectedTime;

  String lostPetSelectedDateString = '';
  String registerLostPetSelectedDateString = '';
  String lostPetSelectedTimeString = '';

  void updateSelectedDate(DateTime date, bool isFromRegister) {
    if (isFromRegister == true) {
      lostPetSelectedDate = date;
      registerLostPetSelectedDateString = DateFormat.yMMMd().format(date);
      notifyListeners();
    } else {
      lostPetSelectedDate = date;
      lostPetSelectedDateString = DateFormat.yMMMd().format(date);
      notifyListeners();
    }
  }

  void updateSelectedTime(TimeOfDay time) {
    lostPetSelectedTime = time;
    lostPetSelectedTimeString = '${time.hour}:${time.minute}';
    notifyListeners();
  }

  Future<void> eventSelectDate(
    BuildContext context,
    bool isFromRegister,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
    );
    if (picked != null) {
      updateSelectedDate(picked, isFromRegister);
    }
  }

  Future<void> eventSelectTime(
    BuildContext context,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      updateSelectedTime(picked);
    }
  }

  //  event date and time selecting end

  TextEditingController registerLostPetNameCntrlr = TextEditingController();
  TextEditingController registerLostPetLocationCntrlr = TextEditingController();
  TextEditingController registerLostPetNumberCntrlr = TextEditingController();

  Future registerLostPetFn({
    required BuildContext context,
  }) async {
    if (imageUrlForUpload == '') {
      toast(
        context,
        title: "Image required",
        backgroundColor: Colors.red,
      );
    } else {
      LoadingOverlay.of(context).show();
      try {
        List response = await ServerClient.post(
          Urls.postLostPetUrl,
          data: {
            "date": lostPetSelectedDate?.toIso8601String(),
            "identification": imageUrlForUpload,
            "contact": registerLostPetNumberCntrlr.text,
            "name": registerLostPetNameCntrlr.text,
            "location": registerLostPetLocationCntrlr.text,
          },
        );
        if (response.first >= 200 && response.first < 300) {
          registerLostPetNumberCntrlr.clear();
          registerLostPetNameCntrlr.clear();
          registerLostPetLocationCntrlr.clear();
          lostPetSelectedDate = null;
          registerLostPetSelectedDateString = '';
          imageTitle = null;
          imageUrlForUpload = '';
          getLostPetFn(status: "", keyword: "");
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
        notifyListeners();
      }
    }
  }

  ScreenshotController screenshotController = ScreenshotController();

  File? file;
  Future<File?> uint8ListToFile(Uint8List uint8List) async {
    // Get the temporary directory
    final Directory tempDir = await getTemporaryDirectory();
    // Generate a unique file name
    final String filePath = '${tempDir.path}/screenshot.png';
    // Write the Uint8List to a file in the temporary directory
    file = File(filePath);
    await file?.writeAsBytes(uint8List);
    // Return the file
    return file;
  }

  Future<void> captureScreenShot(
      {required BuildContext context,
      required MissingDetails? missingDetails,
      required String pet}) async {
    LoadingOverlay.of(context).show();
    screenshotController
        .captureFromWidget(
      Container(
        padding: const EdgeInsets.all(0.0),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: LostPetShareWidget(
          missingDetails: missingDetails,
          pet: pet,
        ),
      ),
    )
        .then((capturedImage) async {
      final filePath = await uint8ListToFile(capturedImage);
      LoadingOverlay.of(context).hide();
      final result = await Share.shareXFiles([XFile(filePath?.path ?? "")],
          text: 'Help to find this pet!');
      if (result.status == ShareResultStatus.success) {
        toast(context,
            title: 'Shared successfully', backgroundColor: Colors.green);
      } else {
        toast(context, title: 'Failed to share', backgroundColor: Colors.red);
      }
    });
  }
}

enum LostPetSelectedContainer {
  lostPetAll,
  lostPetMissing,
  lostPetFound,
  myLostPet
}
