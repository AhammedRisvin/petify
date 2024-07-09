// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:clan_of_pets/app/core/firebase_api/notification_service.dart';
import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/module/home/model/get_pet_model.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:clan_of_pets/app/utils/loading_overlay.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/server_client_services.dart';
import '../../../core/string_const.dart';
import '../../../core/urls.dart';
import '../../../utils/enums.dart';
import '../model/get_dewarming_model.dart';
import '../model/get_growth_history_model.dart';
import '../model/get_pet_achievements_model.dart';
import '../model/get_pet_expence_model.dart';
import '../model/get_vaccination_model.dart';
import '../model/pet_document_model.dart';
import '../model/pet_event_model.dart';
import '../widget/download_screen.dart';

class PetProfileProvider extends ChangeNotifier {
  TextEditingController dateController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController searchTextEditingController = TextEditingController();

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();

  DateTime? selectedDate;
  String? selectedType;

  void setDate(DateTime? date) {
    selectedDate = date;
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate!);
    notifyListeners();
  }

  void setType(String? type) {
    selectedType = type;
    notifyListeners();
  }

  /* EXPENCE SCTIO start    */

  GetPetExpenceModel getPetExpenceModel = GetPetExpenceModel();
  int getPetExpenceModelStatus = 0;

  Future<void> getPetExpenceFun() async {
    try {
      getPetExpenceModelStatus = 0;
      final petId = await StringConst.getPetID();
      List response = await ServerClient.get(
          "${Urls.getPetExpenses + petId}&from=$startDateForExpenceFilterApi&to=$endDateForExpenceFilterApi");
      if (response.first >= 200 && response.first < 300) {
        getPetExpenceModel = GetPetExpenceModel.fromJson(response.last);
        notifyListeners();
      } else {
        getPetExpenceModel = GetPetExpenceModel();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      getPetExpenceModelStatus++;
      endDateForExpenceFilterApi = '';
      startDateForExpenceFilterApi = '';
      notifyListeners();
    }
  }

  String selectedExpenceDate = '';

  Future<void> expenceAddDateFun(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // achivementSelectedDate = picked;
      selectedExpenceDate = DateFormat('yyyy-MM-dd').format(picked);
      expenceDateController.text = selectedExpenceDate;
      notifyListeners();
    }
    notifyListeners();
  }

  TextEditingController expenceAddNameController = TextEditingController();
  TextEditingController expenceAddAmountController = TextEditingController();
  TextEditingController expenceDateController = TextEditingController();
  Future<void> createNewPetExpenceFn({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      final petId = await StringConst.getPetID();
      var body = {
        "pet": petId,
        "name": expenceAddNameController.text,
        "amount": expenceAddAmountController.text,
        "date": selectedExpenceDate,
        "currency": "AED"
      };
      if (selectedExpenceDate == '') {
        toast(context,
            title: 'Please select expense date',
            backgroundColor: AppConstants.red);
      } else {
        List response = await ServerClient.post(Urls.createPetExpense,
            data: body, post: true);

        if (response.first >= 200 && response.first < 300) {
          toast(context,
              title: response.last['message'], backgroundColor: Colors.green);
          await getPetExpenceFun();
          notifyListeners();
          clearExpenceDataController();
          Routes.back(context: context);
        } else {
          toast(context, title: response.last, backgroundColor: Colors.green);
          throw Exception('Failed to fetch posts');
        }
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      notifyListeners();
      LoadingOverlay.of(context).hide();
    }
  }

  void clearExpenceDataController() {
    expenceAddNameController.clear();
    expenceAddAmountController.clear();
    expenceDateController.clear();
    selectedExpenceDate = '';
    notifyListeners();
  }

  DateTime startDateForExpenceFilter =
      DateTime.now().subtract(const Duration(days: 3));
  DateTime endDateForExpenceFilter = DateTime.now();

  String startDateForExpenceFilterApi = '';
  String endDateForExpenceFilterApi = '';

  Future<void> selectDateRangeForExpenceFilter(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      initialDateRange: DateTimeRange(
        start: startDateForExpenceFilter,
        end: endDateForExpenceFilter,
      ),
    );
    if (picked != null &&
        picked !=
            DateTimeRange(
                start: startDateForExpenceFilter,
                end: endDateForExpenceFilter)) {
      startDateForExpenceFilter = picked.start;
      endDateForExpenceFilter = picked.end;
      startDateForExpenceFilterApi =
          picked.start.add(const Duration(days: 1)).toUtc().toIso8601String();
      endDateForExpenceFilterApi =
          picked.end.add(const Duration(days: 1)).toUtc().toIso8601String();
      getPetExpenceFun();
      notifyListeners();
    }

    notifyListeners();
  }

  Future<void> deletePetExpenceFun(
      BuildContext context, String expenceId) async {
    try {
      List response = await ServerClient.delete(
        Urls.deletePetExpense + expenceId,
        id: expenceId,
      );
      if (response.first >= 200 && response.first < 300) {
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
        Routes.back(context: context);
        await getPetExpenceFun();
        notifyListeners();
      } else {
        toast(context, title: response.last, backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      notifyListeners();
    }
  }

  /* EXPENCE SCTIO end    */
  //**clinic remarks  Section Start **/

  List<String> dropDownlist = <String>['Medical History', 'Grooming History'];

  List<String> servicelist = <String>[
    'Nail cutting',
    'Ear cleaning',
  ];

  String dropDownValue = 'Medical History';
  void dropDownFnc({String? value}) {
    dropDownValue = value ?? '';
    notifyListeners();
  }

  String selectedMedicalService = 'Medical History';
  void updateMedicalHistoryService(String value) {
    selectedMedicalService = value;
    log('selectedMedicalService $selectedMedicalService');
    notifyListeners();
  }

  String selectedServiceDetailedOption = 'info';
  void updateServiceDetailedOption(String value) {
    selectedServiceDetailedOption = value;
    notifyListeners();
  }

  int currentIndex = 0;
  currentIndexFnc({int? index}) {
    currentIndex = index ?? 0;
    notifyListeners();
  }

  //**clinic remarks  Section end **/

//** Document Section Start **/
  TextEditingController documentTitleController = TextEditingController();

  int backgroundColor = -1;
  void changeColor(int index) {
    backgroundColor = index; // Change to desired color
    notifyListeners();
  }

  List<File> petDocumentFiles = [];
  String picked = 'Upload your documents';

  void pickDocumentFile(
      {bool isAddDocument = false, BuildContext? context}) async {
    try {
      List<PlatformFile> petDocumentList = [];
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', "png", "jpeg", 'pdf', 'doc'],
      );
      petDocumentList.addAll(result?.files ?? []);
      // result?.files[0];
      if (petDocumentList.isEmpty) return;
      petDocumentFiles.clear();
      for (var element in petDocumentList) {
        final imageTemporaryData = File(element.path!);
        petDocumentFiles.add(imageTemporaryData);
      }
      picked = petDocumentFiles.first.path;
      if (isAddDocument == true) {
        uploadImage(context: context!);
      }
      // thumbnailImage?.value = imageTemporaryData;
    } on PlatformException catch (e) {
      debugPrint('Failed to image pick $e');
    }
    notifyListeners();
  }

//upload document to aws
  List<String> uploadedPetDocumentUrls = [];
  String imageUrlForUpload = '';

  Future<void> uploadImage({required BuildContext context}) async {
    if (petDocumentFiles.isEmpty) {
      // No image selected
      return;
    }

    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Add images to the request
    for (var i = 0; i < petDocumentFiles.length; i++) {
      final fileType = getMimeType(petDocumentFiles[i].path);
      request.files.add(
        await http.MultipartFile.fromPath(
          'image_mushthak',
          petDocumentFiles[i].path,
          contentType: MediaType.parse(fileType),
        ),
      );
      request.headers['Content-Type'] = fileType;
    }

    try {
      LoadingOverlay.of(context).show();
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseBody);
      if (response.statusCode == 200) {
        // Image uploaded successfully
        debugPrint('Image uploaded successfully with response: $responseBody');
        List<String> imageUrls = [];
        for (var element in jsonResponse['images']) {
          imageUrls.add(element['imageUrl']);
        }
        // Assuming you have a list to store image URLs
        uploadedPetDocumentUrls.clear();
        uploadedPetDocumentUrls = imageUrls;
        debugPrint("uploadedPetDocumentUrls $uploadedPetDocumentUrls");
      } else {
        // Error uploading image
        debugPrint('Error uploading image with response: $responseBody');
      }
    } catch (e) {
      // Error occurred during upload
      debugPrint('Error occurred during upload: $e ');
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
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

  GetPetDocumentModel getPetDocumentModel = GetPetDocumentModel();
  int getPetDocumentsStatus = 0;
  Future<void> getPetDocuments() async {
    try {
      getPetDocumentsStatus = 0;
      String petId = await StringConst.getPetID();

      List response = await ServerClient.get(
        Urls.getDocuments + petId,
      );
      if (response.first >= 200 && response.first < 300) {
        getPetDocumentModel = GetPetDocumentModel.fromJson(response.last);

        notifyListeners();
      } else {
        getPetDocumentModel = GetPetDocumentModel();
      }
    } catch (e) {
      getPetDocumentModel = GetPetDocumentModel();
      debugPrint(e.toString());
    } finally {
      getPetDocumentsStatus++;
    }
    notifyListeners();
  }

  Future<void> createPetDocument({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      String petId = await StringConst.getPetID();
      var body = {
        "title": documentTitleController.text,
        "documents": uploadedPetDocumentUrls,
        "pet": petId
      };
      List response =
          await ServerClient.post(Urls.addPetDocument, data: body, post: true);
      if (response.first >= 200 && response.first < 300) {
        picked = 'Upload your documents';
        uploadedPetDocumentUrls.clear();
        documentTitleController.clear();
        getPetDocuments();
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
        Routes.back(context: context);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      LoadingOverlay.of(context).hide();
    }
    notifyListeners();
  }

//** Document Section End **/

//** Vaccination Section Start **/

  TextEditingController vaccinationTrackervaccinenameCtrl =
      TextEditingController();

  TextEditingController vaccinationTrackerserialNumberCtrl =
      TextEditingController();
  TextEditingController vaccinationTrackerclinicNameCtrl =
      TextEditingController();
  TextEditingController vaccinationTrackerremarksCtrl = TextEditingController();

  int selectedVaccinationButton = 1;
  void selecteVaccinationButtonFun(int index) {
    selectedVaccinationButton = index; // Change to desired color
    notifyListeners();
  }

  final List<Color> colors = [
    AppConstants.appCommonRed,
    AppConstants.bgBrown,
  ];
  DateTime? vaccinationSelectedDate;
  String vaccinationSelectedDateString = '';
  DateTime? vaccinationDueDateSelected;
  String vaccinationDueSelectedDateString = '';

  Future<void> addNewVaccinationSelectDate({
    required BuildContext context,
    required bool isDueDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: isDueDate ? DateTime.now() : DateTime(2000),
      lastDate: isDueDate ? DateTime(2100) : DateTime.now(),
    );
    if (picked != null) {
      if (isDueDate == true) {
        vaccinationDueDateSelected = picked;
        vaccinationDueSelectedDateString =
            DateFormat('yyyy-MM-dd').format(picked);
        notifyListeners();
      } else {
        vaccinationSelectedDate = picked;
        vaccinationSelectedDateString = DateFormat('yyyy-MM-dd').format(picked);
        notifyListeners();
      }
    }
  }

  String barcodeScanRes = '';
  Future getSerialNumberUsingQrScannFn() async {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#F5895A', "Cancel", true, ScanMode.DEFAULT);
    vaccinationTrackerserialNumberCtrl.text = barcodeScanRes;
    notifyListeners();
  }

  GetVaccinationTrackerModel getVaccinationTrackerModel =
      GetVaccinationTrackerModel();
  int getVaccinationStatus = 0;

  Future<void> getVaccinationFn() async {
    try {
      getVaccinationStatus = 0;
      String petId = await StringConst.getPetID();
      List response = await ServerClient.get(
        Urls.vaccination + petId,
      );
      if (response.first >= 200 && response.first < 300) {
        getVaccinationTrackerModel =
            GetVaccinationTrackerModel.fromJson(response.last);
        notifyListeners();
      } else {
        getVaccinationTrackerModel = GetVaccinationTrackerModel();
      }
    } catch (e) {
      getVaccinationTrackerModel = GetVaccinationTrackerModel();
      debugPrint(e.toString());
    } finally {
      getVaccinationStatus++;
    }
    notifyListeners();
  }

  Future<void> createVaccinationTrackerFn(
      {required BuildContext context}) async {
    try {
      String petId = await StringConst.getPetID();
      LoadingOverlay.of(context).show();
      var body = {
        "vaccineName": vaccinationTrackervaccinenameCtrl.text,
        "adminastrationDate": vaccinationSelectedDateString,
        "dueDate": vaccinationDueSelectedDateString,
        "serialNumber": vaccinationTrackerserialNumberCtrl.text,
        "clinic": vaccinationTrackerclinicNameCtrl.text,
        "remarks": vaccinationTrackerremarksCtrl.text,
        "pet": petId,
      };
      List response =
          await ServerClient.post(Urls.vaccination, data: body, post: true);
      if (response.first >= 200 && response.first < 300) {
        vaccinationTrackervaccinenameCtrl.clear();
        vaccinationSelectedDateString = '';
        vaccinationDueSelectedDateString = '';
        vaccinationTrackerserialNumberCtrl.clear();
        vaccinationTrackerclinicNameCtrl.clear();
        vaccinationTrackerremarksCtrl.clear();
        barcodeScanRes = '';
        getVaccinationFn();
        notifyListeners();
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
        Routes.back(context: context);
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      LoadingOverlay.of(context).hide();
    }
    notifyListeners();
  }

  Future<void> deleteVaccinationFn(
      {required String vaccinId, required BuildContext context}) async {
    LoadingOverlay.of(context).show();
    try {
      List response = await ServerClient.delete(
        Urls.deleteVaccination + vaccinId,
      );
      if (response.first >= 200 && response.first < 300) {
        Routes.back(context: context);

        await getVaccinationFn();
        LoadingOverlay.of(context).hide();
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      throw Exception('Failed to fetch posts');
    } finally {
      LoadingOverlay.of(context).hide();
      notifyListeners();
    }
  }

  Future<void> updateVaccinationTrackerFn(
      {required String vaccinId, required BuildContext context}) async {
    try {
      String petId = await StringConst.getPetID();
      LoadingOverlay.of(context).show();
      var body = {
        "vaccineName": vaccinationTrackervaccinenameCtrl.text,
        "adminastrationDate": vaccinationSelectedDateString,
        "dueDate": vaccinationDueSelectedDateString,
        "serialNumber": vaccinationTrackerserialNumberCtrl.text,
        "clinic": vaccinationTrackerclinicNameCtrl.text,
        "remarks": vaccinationTrackerremarksCtrl.text,
        "pet": petId,
      };
      List response = await ServerClient.put(Urls.updateVaccination + vaccinId,
          data: body, put: true);
      if (response.first >= 200 && response.first < 300) {
        vaccinationTrackervaccinenameCtrl.clear();
        vaccinationSelectedDateString = '';
        vaccinationDueSelectedDateString = '';
        vaccinationTrackerserialNumberCtrl.clear();
        vaccinationTrackerclinicNameCtrl.clear();
        vaccinationTrackerremarksCtrl.clear();
        barcodeScanRes = '';
        getVaccinationFn();
        notifyListeners();
        toast(context,
            title: "Edited successfully", backgroundColor: Colors.green);
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
//** Vaccination Section End **/
  // selecting between 3 containers start

  SelectedContainer _selectedContainer = SelectedContainer.all;

  SelectedContainer get selectedContainer => _selectedContainer;

  void updateSelectedContainer(SelectedContainer newContainer) {
    _selectedContainer = newContainer;
    notifyListeners();
  }

  // selecting between 3 containers end

  //  event date and time selecting start

  DateTime? eventSelectedDate;

  String selectedDateString = '';
  String eventSelectedTimeString = '';
  TimeOfDay? time;

  void updateSelectedDate(DateTime date) {
    eventSelectedDate = date;
    selectedDateString = DateFormat('yyyy-MM-dd').format(date);
    notifyListeners();
  }

  void updateSelectedTime(TimeOfDay time) {
    time = time;
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    eventSelectedTimeString = '$hour:$minute';
    notifyListeners();
  }

  Future<void> growthSelectDate(
    BuildContext context,
    bool isEdit,
    bool isGrowthEdit,
    DateTime? editDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: isEdit ? DateTime.now() : DateTime(2000),
      lastDate: isEdit ? DateTime(2500) : DateTime.now(),
      initialDate: isGrowthEdit ? editDate : DateTime.now(),
    );
    if (picked != null) {
      updateSelectedDate(picked);
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

// single image picker start

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
      debugPrint('Failed to pick image: $e');
      return null;
    } finally {
      notifyListeners();
    }
  }

/* Achivements section  start    */
  // DateTime? achivementSelectedDate;
  String selectedAchivementDate = '';

  Future<void> achivementSelectDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      // achivementSelectedDate = picked;
      selectedAchivementDate = DateFormat('yyyy-MM-dd').format(picked);
    }
    notifyListeners();
  }

  GetAchievementsModel getAchievementsModel = GetAchievementsModel();
  int getAchievementsModelStatus = 0;

  Future<void> getAchievementsFun() async {
    try {
      getAchievementsModelStatus = 0;
      final petId = await StringConst.getPetID();
      List response = await ServerClient.get(Urls.getPetAchievements + petId);
      if (response.first >= 200 && response.first < 300) {
        getAchievementsModel = GetAchievementsModel.fromJson(response.last);
        notifyListeners();
      } else {
        getAchievementsModel = GetAchievementsModel();
      }
    } catch (e) {
      getAchievementsModel = GetAchievementsModel();
      debugPrint(e.toString());
    } finally {
      getAchievementsModelStatus++;
      notifyListeners();
    }
  }

  String getachievementformateDateFun(String date) {
    DateTime isoDate = DateTime.parse(date).toLocal();
    return DateFormat('dd, MMMM yyyy').format(isoDate);
  }

  TextEditingController createNewAchievementNameCtrl = TextEditingController();

  TextEditingController createNewAchievementVenueCtrl = TextEditingController();
  TextEditingController createNewAchievementOrganisationCtrl =
      TextEditingController();

  Future<void> createNewAchievementFn({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      final petId = await StringConst.getPetID();
      var body = {
        "pet": petId,
        "name": createNewAchievementNameCtrl.text,
        "venue": createNewAchievementVenueCtrl.text,
        "date": selectedAchivementDate,
        "organisation": createNewAchievementOrganisationCtrl.text,
        "image": singleImageUr
      };
      if (selectedAchivementDate == '') {
        toast(context,
            title: 'Please select venue date',
            backgroundColor: AppConstants.red);
      } else {
        List response = await ServerClient.post(Urls.createPetAchievment,
            data: body, post: true);
        if (response.first >= 200 && response.first < 300) {
          createNewAchievementNameCtrl.clear();
          createNewAchievementVenueCtrl.clear();
          createNewAchievementOrganisationCtrl.clear();
          selectedAchivementDate = '';
          singleImageUr = '';
          imageTitlee = '';
          getAchievementsFun();
          notifyListeners();
          toast(context,
              title: response.last['message'], backgroundColor: Colors.green);
          Routes.back(context: context);
        } else {
          throw Exception('Failed to fetch posts');
        }
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      notifyListeners();
      LoadingOverlay.of(context).hide();
    }
  }

  Future<void> deleteAchievementFn(
      {required BuildContext context, required String id}) async {
    try {
      List response = await ServerClient.delete(
        Urls.deletePetAchievment + id,
      );
      if (response.first >= 200 && response.first < 300) {
        toast(context,
            title: response.last['message'].toString(),
            backgroundColor: Colors.green);
        getAchievementsFun();
        notifyListeners();
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      notifyListeners();
    }
  }

/* Achivements section  end    */
//** Dewarming Tracker section  Start */

  TextEditingController dewarmingTrackervaccinenameCtrl =
      TextEditingController();

  TextEditingController dewarmingTrackerserialNumberCtrl =
      TextEditingController();
  TextEditingController dewarmingTrackerclinicNameCtrl =
      TextEditingController();
  TextEditingController dewarmingTrackerremarksCtrl = TextEditingController();

  int getDewarmingCurrentPage = 1;

  GetDewarmingTrackerModel getDewarmingTrackerModel =
      GetDewarmingTrackerModel();
  int getDewarmingStatus = 0;
  bool isDewarmingListEnded = false;
  Future<void> getDewarmingFn({int pageNum = 0}) async {
    try {
      String petId = await StringConst.getPetID();

      getDewarmingStatus = 0;
      isDewarmingListEnded = false;
      String page = '';
      if (pageNum != 0) {
        page = pageNum.toString();
      } else {
        page = getDewarmingCurrentPage.toString();
      }
      List response =
          await ServerClient.get("${Urls.getDewarming + petId}&page=$page");
      if (response.first >= 200 && response.first < 300) {
        if (pageNum != 0) {
          getDewarmingTrackerModel =
              GetDewarmingTrackerModel.fromJson(response.last);
          getDewarmingCurrentPage = 2;
          notifyListeners();
        } else {
          final getModel = GetDewarmingTrackerModel.fromJson(response.last);
          if (getModel.dewarmingDatas?.isEmpty ?? true) {
            isDewarmingListEnded = true;
            notifyListeners();
          }
          getDewarmingTrackerModel.dewarmingDatas
              ?.addAll(getModel.dewarmingDatas ?? []);
          getDewarmingCurrentPage++;
          notifyListeners();
        }
        notifyListeners();
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      getDewarmingStatus = 1;
      isDewarmingListEnded = true;
    }
    notifyListeners();
  }

  Future<void> createDewarmingTrackerFn({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      String petId = await StringConst.getPetID();

      var body = {
        "image": singleImageUr,
        "vaccineName": dewarmingTrackervaccinenameCtrl.text,
        "administrationDate": vaccinationSelectedDateString,
        "dueDate": vaccinationDueSelectedDateString,
        "serialNumber": dewarmingTrackerserialNumberCtrl.text,
        "clinicName": dewarmingTrackerclinicNameCtrl.text,
        "remarks": dewarmingTrackerremarksCtrl.text,
        "petId": petId,
      };
      List response =
          await ServerClient.post(Urls.addDewarming, data: body, post: true);
      if (response.first >= 200 && response.first < 300) {
        singleImageUr = '';
        imageTitlee = '';
        dewarmingTrackervaccinenameCtrl.clear();
        vaccinationSelectedDateString = '';
        vaccinationDueSelectedDateString = '';
        dewarmingTrackerserialNumberCtrl.clear();
        dewarmingTrackerclinicNameCtrl.clear();
        dewarmingTrackerremarksCtrl.clear();
        getDewarmingFn(pageNum: 1);
        notifyListeners();
        Routes.back(context: context);
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      LoadingOverlay.of(context).hide();
    }
    notifyListeners();
  }

  Future<void> deleteDewarmingTrackerFn(
      {required String dewarmingId, required BuildContext context}) async {
    try {
      List response = await ServerClient.delete(Urls.deleteDewarming,
          delete: true, data: {"id": dewarmingId});
      if (response.first >= 200 && response.first < 300) {
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
        context.pop();
        await getDewarmingFn(pageNum: 1);
      } else {
        toast(context, title: response.last, backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateDewarmingTrackerFn(
      {required String dewarmingId, required BuildContext context}) async {
    try {
      String petId = await StringConst.getPetID();
      LoadingOverlay.of(context).show();
      var body = {
        "id": dewarmingId,
        "image": singleImageUr,
        "vaccineName": dewarmingTrackervaccinenameCtrl.text,
        "administrationDate": vaccinationSelectedDateString,
        "dueDate": vaccinationDueSelectedDateString,
        "serialNumber": dewarmingTrackerserialNumberCtrl.text,
        "clinicName": dewarmingTrackerclinicNameCtrl.text,
        "remarks": dewarmingTrackerremarksCtrl.text,
        "petId": petId,
      };
      List response =
          await ServerClient.post(Urls.editDewarming, data: body, post: true);
      if (response.first >= 200 && response.first < 300) {
        singleImageUr = '';
        imageTitlee = '';
        dewarmingTrackervaccinenameCtrl.clear();
        vaccinationSelectedDateString = '';
        vaccinationDueSelectedDateString = '';
        dewarmingTrackerserialNumberCtrl.clear();
        dewarmingTrackerclinicNameCtrl.clear();
        dewarmingTrackerremarksCtrl.clear();
        await getDewarmingFn(pageNum: 1);
        notifyListeners();
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

//** Dewarming Tracker section   End */

  // void pickImageFromGalleryOrCamera({required bool isGallery,required BuildContext context}) async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  // Image Upload Function
  String singleImageUr = '';

  String imageTitlee = '';
  Future<void> uploadSingleImage() async {
    singleImageUr = '';
    imageTitlee = '';
    File? tempImage = await pickImageFromGallery();
    if (tempImage == null) {
      return;
    }
    imageTitlee = tempImage.path.split('/').last;
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
      debugPrint(
          "responseBody is $responseBody  status code is ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        singleImageUr = data["images"][0]["imageUrl"];
        debugPrint(
            'Image uploaded successfully with imageUrlForUpload: $singleImageUr');
      } else {
        // Error uploading image
        debugPrint('Error uploading image with response: $responseBody');
      }
    } catch (e) {
      // Error occurred during upload
      debugPrint('Error occurred during upload: $e ');
    }
  }

// single image picker end

  // CREATE EVENT FN START

  Future createEventFn({required BuildContext context}) async {
    if (eventSelectedDate == null ||
        eventSelectedTimeString == '' ||
        selectedType == '' ||
        selectedDateString == '') {
      toast(
        context,
        title: 'Please fill all the fields',
        backgroundColor: Colors.red,
      );
      return;
    } else if (eventNameController.text.isEmpty ||
        eventLocationController.text.isEmpty ||
        eventDescriptionController.text.isEmpty) {
      toast(
        context,
        title: 'Please fill all the fields',
        backgroundColor: Colors.red,
      );
      return;
    } else {
      try {
        List response = await ServerClient.post(
          Urls.addEventUrl,
          data: {
            "date": selectedDateString,
            "time": eventSelectedTimeString,
            "image": singleImageUr,
            "name": eventNameController.text,
            "description": eventDescriptionController.text,
            "location": eventLocationController.text,
          },
        );
        if (response.first >= 200 && response.first < 300) {
          getEventFn(filter: "", pageNo: "", searchKeyword: "");
          final hours = int.parse(eventSelectedTimeString.split(":")[0]);
          final minutes = eventSelectedTimeString.split(":").length > 1
              ? int.parse(eventSelectedTimeString.split(":")[1])
              : 0;
          DateTime reminderTime = DateTime(
            eventSelectedDate!.year,
            eventSelectedDate!.month,
            eventSelectedDate!.day,
            hours,
            minutes,
          );
          NotificationService().scheduleReminder(eventDate: reminderTime);
          toast(context,
              title: response.last['message'], backgroundColor: Colors.green);
          eventLocationController.clear();
          eventDescriptionController.clear();
          eventNameController.clear();
          singleImageUr = '';
          imageTitle = null;
          thumbnailImage = null;
          eventSelectedTimeString = '';
          selectedDateString = '';
          Routes.back(context: context);
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
  // CREATE EVENT FN END

  // GET EVENT START

  PetEventModel petEventModel = PetEventModel();

  GetEventStatus getEventStatus = GetEventStatus.initial;

  Future getEventFn(
      {required String filter, String? searchKeyword, String? pageNo}) async {
    try {
      getEventStatus = GetEventStatus.loading;
      List response = await ServerClient.get(
        "${Urls.getEventsUrl + filter}&search=$searchKeyword&page=$pageNo",
      );
      if (response.first >= 200 && response.first < 300) {
        petEventModel = PetEventModel.fromJson(response.last);
        getEventStatus = GetEventStatus.loaded;
      } else {
        petEventModel = PetEventModel();
        getEventStatus = GetEventStatus.error;
      }
    } catch (e) {
      getEventStatus = GetEventStatus.error;
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }
  // GET EVENT END

  // DATE TIME INTO DATE FUN

  String formatDate(DateTime dateTime) {
    // Format the DateTime object into a string representing the date
    String formattedDate = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    return formattedDate;
  }

  String formatTime(DateTime dateTime) {
    String formattedTime = '${dateTime.hour}:${dateTime.minute}';

    return formattedTime;
  }

  // CREATE HEIGHT GROWTH FN START

  Future createNewHeightGrowthFn({
    required BuildContext context,
    required bool isEdit,
    required String growthId,
    required Null Function() successCallback,
  }) async {
    if (heightController.text.isEmpty ||
        selectedType == '' ||
        selectedDateString == '') {
      toast(
        context,
        title: 'Please fill all the fields',
        backgroundColor: Colors.red,
      );
      return;
    } else {
      try {
        LoadingOverlay.of(context).show();
        final petId = await StringConst.getPetID();
        List response = await ServerClient.post(
          isEdit ? Urls.editGrowthUrl : Urls.addNewGrowthUrl,
          data: isEdit
              ? {
                  "date": selectedDateString,
                  "petId": petId,
                  "value": weightController.text,
                  "growthId": growthId,
                  "type": selectedType,
                }
              : {
                  "date": selectedDateString,
                  "petId": petId,
                  "height": heightController.text,
                  "heightUnit": "cm",
                  "type": selectedType,
                },
        );
        log("isedit $isEdit");
        log("response.first ${response.first} response.last ${response.last}");
        if (response.first >= 200 && response.first < 300) {
          if (isEdit) {
            successCallback();
            getGrowthHistoryFn(petId: petId);
          }
          heightController.clear();
          selectedDateString = '';
          selectedType = null;
          LoadingOverlay.of(context).hide();
          toast(context,
              title: response.last['message'], backgroundColor: Colors.green);
          Routes.back(context: context);
        } else {
          LoadingOverlay.of(context).hide();
          toast(context,
              title: response.last["message"], backgroundColor: Colors.red);
          throw Exception('Failed to fetch posts');
        }
      } catch (e) {
        LoadingOverlay.of(context).hide();
        debugPrint(e.toString());
      } finally {
        notifyListeners();
      }
    }
  }

  // CREATE HEIGHT GROWTH FN START FN END

  GetGrowthDataHistoryModel getGrowthDataHistoryModel =
      GetGrowthDataHistoryModel();

  GetGrowthHistoryStatus getGrowthHistoryStatus =
      GetGrowthHistoryStatus.initial;

  Future getGrowthHistoryFn({
    required String petId,
  }) async {
    try {
      getGrowthHistoryStatus = GetGrowthHistoryStatus.loading;
      List response = await ServerClient.get(
        Urls.getGrowthHistoryUrl + petId,
      );
      log("response.first ${response.first} response.last ${response.last}");
      if (response.first >= 200 && response.first < 300) {
        getGrowthDataHistoryModel =
            GetGrowthDataHistoryModel.fromJson(response.last);
        getGrowthHistoryStatus = GetGrowthHistoryStatus.loaded;
      } else {
        petEventModel = PetEventModel();
        getGrowthHistoryStatus = GetGrowthHistoryStatus.error;
      }
    } catch (e) {
      getGrowthHistoryStatus = GetGrowthHistoryStatus.error;
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  String formatGrowthDate(DateTime dateTime) {
    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    String month = monthNames[dateTime.month - 1];
    int day = dateTime.day;
    int year = dateTime.year;
    return "$month $day $year";
  }

  // CREATE WEIGHT GROWTH FN START

  Future createNewWeightGrowthFn({
    required BuildContext context,
    required bool isEdit,
    required String growthId,
    required Null Function() successCallback,
  }) async {
    if (weightController.text.isEmpty ||
        selectedType == '' ||
        selectedDateString == '') {
      toast(
        context,
        title: 'Please fill all the fields',
        backgroundColor: Colors.red,
      );
      return;
    } else {
      try {
        final petId = await StringConst.getPetID();
        List response = await ServerClient.post(
          isEdit ? Urls.editGrowthUrl : Urls.addNewGrowthUrl,
          data: isEdit
              ? {
                  "date": selectedDateString,
                  "petId": petId,
                  "value": weightController.text,
                  "growthId": growthId,
                  "type": selectedType,
                }
              : {
                  "date": selectedDateString,
                  "petId": petId,
                  "weight": weightController.text,
                  "weightUnit": "Kg",
                  "type": selectedType,
                },
        );
        log("isedit $isEdit");
        log("response.first ${response.first} response.last ${response.last}");
        if (response.first >= 200 && response.first < 300) {
          if (isEdit) {
            successCallback();
            getGrowthHistoryFn(petId: petId);
          }
          weightController.clear();
          selectedDateString = '';
          selectedType = null;

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
  // CREATE WEIGHT GROWTH FN START FN END

  // DELETE GROWTH FN START
  Future<void> deleteGrowthFn({
    required String growthId,
    required String type,
    required String petId,
    required BuildContext context,
    required Null Function() successCallback,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      final body = {
        "petId": petId,
        "growthId": growthId,
        "type": type,
      };
      List response =
          await ServerClient.post(Urls.deleteGrowth, data: body, post: true);
      if (response.first >= 200 && response.first < 300) {
        successCallback();
        getGrowthHistoryFn(petId: await StringConst.getPetID());

        Routes.back(context: context);
        LoadingOverlay.of(context).hide();
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);

        notifyListeners();
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }
  // DELETE GROWTH FN START

  // PET  GROWTH FUNCTIONALITIES

  String selectedGrowthShowingDateTypeForHeight = 'weekly';
  String selectedGrowthShowingDateTypeForWeight = 'weekly';

  changeGrowthShowingDateType(String type, bool isFromHeight) async {
    if (isFromHeight) {
      selectedGrowthShowingDateTypeForHeight = type;
      selectedGrowthShowingDateTypeForWeight = "weekly";
    } else {
      selectedGrowthShowingDateTypeForWeight = type;
      selectedGrowthShowingDateTypeForHeight = "weekly";
    }
    notifyListeners();
  }

  // caluculate pet age start

  String calculatePetAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();

    // Calculate the difference between current date and birthdate
    Duration difference = currentDate.difference(birthDate);

    // Calculate years, months, and days
    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int days = (difference.inDays % 365) % 30;

    // Construct the age string
    String ageString = '';
    if (years > 0) {
      ageString += '$years ${years == 1 ? 'year' : 'years'}';
      if (months > 0) {
        ageString += ' and $months ${months == 1 ? 'month' : 'months'}';
      }
    } else if (months > 0) {
      ageString += '$months ${months == 1 ? 'month' : 'months'}';
      if (days > 0) {
        ageString += ' and $days ${days == 1 ? 'day' : 'days'}';
      }
    } else {
      ageString += '$days ${days == 1 ? 'day' : 'days'}';
    }

    return ageString;
  }

  // caluculate pet age end

  // screen shot and make a pdf to download start

  ScreenshotController screenshotController = ScreenshotController();

  File? file;
  Future<File?> uint8ListToFile(Uint8List uint8List) async {
    final Directory tempDir = await getTemporaryDirectory();

    final String filePath = '${tempDir.path}/screenshot.png';

    file = File(filePath);
    await file?.writeAsBytes(uint8List);

    return file;
  }

  Future<void> captureScreenShot(
      {required PetData data, required BuildContext context}) async {
    LoadingOverlay.of(context).show();
    screenshotController
        .captureFromWidget(
      Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          color: Colors.white,
        ),
        child: DownloadingWidgetWithPetDetails(
          data: data,
        ),
      ),
    )
        .then((capturedImage) async {
      final pdf = pw.Document();
      final image = pw.MemoryImage(capturedImage);
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(child: pw.Image(image));
      }));
      // Save PDF to file
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/myPet.pdf");
      await file.writeAsBytes(await pdf.save());
      LoadingOverlay.of(context).hide();
      // Share the PDF
      await Share.shareXFiles([XFile(file.path)], text: 'About my pet');
    }).catchError((error) {
      LoadingOverlay.of(context).hide();
    });
  }
}

enum SelectedContainer { all, ended, upcoming, cancelled }
