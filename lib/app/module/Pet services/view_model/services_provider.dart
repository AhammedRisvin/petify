// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:clan_of_pets/app/core/urls.dart';
import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/module/Pet%20services/view/service_providers_screen.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view/myappointment/appointment.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

import '../../../core/server_client_services.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/enums.dart';
import '../../../utils/extensions.dart';
import '../../../utils/loading_overlay.dart';
import '../model/pet_clinics_model.dart';
import '../model/pet_slot_model.dart';
import '../model/service_appoinments_model.dart';
import '../widget/location_search_widget.dart';

class ServiceProvider extends ChangeNotifier {
  container() {
    initialize();
  }

  String selectedSortOption = 'Sort';

  final List<String> sortOptions = ['Sort', 'Rating', 'Distance'];

  void selectSortFn(String value) {
    selectedSortOption = value;
    notifyListeners();
  }

  bool ontapSortButton = false;
  void ontapSortFun(bool value) {
    ontapSortButton = value;
    notifyListeners();
  }

  String selectedFilterOption = 'Filter';

  final List<String> filterOptions = [
    'Filter',
    'Mobile grooming',
    'Onsite grooming',
    'Offsite grooming'
  ];

  void selectFilterFn(String value) {
    selectedFilterOption = value;
    notifyListeners();
  }

  String selectedButtonForServiceDetails = 'Info';
  final List<String> servicesOptions = [
    'Nail cutting',
    'Ear cleaning',
    'Nail cutting',
    'Ear cleaning',
    'Ear cleaning',
    'Nail cutting',
    "paw cleaning",
  ];
  void selectServiceDetailsButtonFun(String value) {
    selectedButtonForServiceDetails = value;
    notifyListeners();
  }

  String? selectedType;
  void setType(String? type) {
    selectedType = type;
    notifyListeners();
  }

  Map<String, String> selectedRadioValues = {};

  void selectedValueRadioFn(String section, String value) {
    selectedRadioValues[section] = value;
    notifyListeners();
  }

  String getSelectedValue(String section) {
    return selectedRadioValues[section] ?? '';
  }

  List<String> month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  String selectedMonth = 'May';

  setSelectedMonth(String value) {
    selectedMonth = value;
    notifyListeners();
  }

  bool isAgree = false;
  agreeTermsNCondition(bool agree) {
    isAgree = agree;
    notifyListeners();
  }

//** Home Screen  */
  List<PetServiceModel> petServiceList = [
    PetServiceModel(img: AppImages.petGrooming, name: 'Pet Grooming'),
    PetServiceModel(img: AppImages.petSitting, name: 'Pet sitting'),
    PetServiceModel(img: AppImages.petBoarding, name: 'Pet Boarding'),
    PetServiceModel(img: AppImages.petTransportation, name: 'Transportation'),
    PetServiceModel(img: AppImages.petTraining, name: 'Pet Training'),
    PetServiceModel(img: AppImages.myAppointment, name: 'My appoinments'),
  ];

  String selectedService = 'Pet Grooming';
  selectederviceFn(String value) {
    selectedService = value;
    notifyListeners();
  }

  bool selectIsFrom = true;
  selectIsFromFn(bool agree) {
    selectIsFrom = agree;
    notifyListeners();
  }

  final Set<Marker> markers = {};
  void onMapCreated(
      GoogleMapController controller, double latitude, double longitude) {
    markers.add(
      Marker(
        markerId: const MarkerId('Id-1'),
        position: LatLng(latitude, longitude),
      ),
    );
    notifyListeners();
  }

  String? selectedPet;

  setSelectedPet(String value) {
    selectedPet = value;
    notifyListeners();
  }

  String selectedContainer = "From";

  void setSelectedContainer(String container) {
    selectedContainer = container;
    notifyListeners();
  }

  // week calender

  String selectedDateT = '';
  late DateTime currentWeekStartDate;

  void initialize() {
    currentWeekStartDate = DateTime.now();
    selectedDateT = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  selecteDateStringFn(DateTime value) {
    selectedDateT = DateFormat('yyyy-MM-dd').format(value);
    notifyListeners();
  }

  List<String> petServiceImageList = [
    AppImages.petGrooming,
    AppImages.petSitting,
    AppImages.petBoarding,
    AppImages.petTransportation,
    AppImages.petTraining,
    AppImages.myAppointment,
  ];

  // get address using lat and long start

  Future<String> getAddressFromLatLng(String lat, String lng) async {
    try {
      double latitude = double.parse(lat.trim());
      double longitude = double.parse(lng.trim());
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return " ${place.locality}, ${place.postalCode}, ${place.country}";
      }
    } catch (e) {
      debugPrint("Error parsing latitude or longitude: $e");
    }
    return "Address not found";
  }

  //  get address using lat and long end

  // GET PET Clinic START

  GetPetClinicsModel petClinicsModel = GetPetClinicsModel();
  GetPetClinicsStatus getPetClinicsStatus = GetPetClinicsStatus.initial;

  Future getPetClinicFn({
    required String clinicId,
    String? value,
    String? search,
    required bool isFromFilter,
  }) async {
    try {
      getPetClinicsStatus = GetPetClinicsStatus.loading;
      List response = await ServerClient.get(
        isFromFilter
            ? value == "All"
                ? Urls.getPetClinicsUrl + clinicId
                : "${Urls.getPetClinicsUrl + clinicId}&filter=$value"
            : "${Urls.getPetClinicsUrl + clinicId}&search=$search",
      );
      if (response.first >= 200 && response.first < 300) {
        petClinicsModel = GetPetClinicsModel.fromJson(response.last);
        getPetClinicsStatus = GetPetClinicsStatus.loaded;
      } else {
        getPetClinicsStatus = GetPetClinicsStatus.error;
        petClinicsModel = GetPetClinicsModel();
      }
    } catch (e) {
      getPetClinicsStatus = GetPetClinicsStatus.error;
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  //  GET PET clinic END

  // GET PET CLINIC SLOT START

  String? today;

  void setToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    today = formatter.format(now);
  }

  String slotFormattedDate = '';
  String formatDate(DateTime dateTime) {
    DateTime localDateTime = dateTime.toLocal();
    int year = localDateTime.year;
    int month = localDateTime.month;
    int day = localDateTime.day;
    slotFormattedDate =
        '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    return slotFormattedDate;
  }

  GetPetSlotModel petSlotModel = GetPetSlotModel();
  GetPetStatusStatus getPetStatusStatus = GetPetStatusStatus.initial;

  List<SlotForBooking> allSlot = [];

  Future getPetSlotFn(
      {required String clinicId,
      required BuildContext context,
      required String serviceId,
      required String date}) async {
    try {
      getPetStatusStatus = GetPetStatusStatus.loading;
      List response = await ServerClient.get(
        "${Urls.getPetSlotUrl}$clinicId&date=$date&serviceId=$serviceId",
      );
      if (response.first >= 200 && response.first < 300) {
        petSlotModel = GetPetSlotModel.fromJson(response.last);
        allSlot.clear();
        selectedAfternoonIndex = -1;
        selectedMorningIndex = -1;
        allSlot.addAll(petSlotModel.slotForBooking ?? []);

        splitSlotsByTime(allSlot);

        getPetStatusStatus = GetPetStatusStatus.loaded;
      } else if (response.first == 400) {
        allSlot.clear();
        morningSlots.clear();
        afternoonSlots.clear();
        getPetStatusStatus = GetPetStatusStatus.loaded;
        toast(
          context,
          title: response.last,
          backgroundColor: Colors.red,
        );
      } else {
        getPetStatusStatus = GetPetStatusStatus.error;
        petSlotModel = GetPetSlotModel();
      }
    } catch (e) {
      getPetStatusStatus = GetPetStatusStatus.error;
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  //  GET CLINIC SLOT END

// convert into two slots

  List<SlotForBooking> morningSlots = [];
  List<SlotForBooking> afternoonSlots = [];

  Map<String, List<SlotForBooking>> splitSlotsByTime(
      List<SlotForBooking> slots) {
    DateTime now = DateTime.now();

    if (slots.isEmpty) {
      return {
        'morning': [],
        'afternoon': [],
      };
    }
    morningSlots.clear();
    afternoonSlots.clear();

    for (SlotForBooking slot in slots) {
      DateTime? slotStartTime = slot.startTime?.toLocal();
      if (slotStartTime != null) {
        // Check if the slot is for today and time has passed
        bool isTodayAndTimePassed = slotStartTime.day == now.day &&
            slotStartTime.month == now.month &&
            slotStartTime.year == now.year &&
            slotStartTime.hour < now.hour;

        // For simplicity, this does not consider minutes for comparison
        // Add additional checks if minute precision is needed

        if (!isTodayAndTimePassed) {
          if (slotStartTime.hour < 12) {
            morningSlots.add(slot);
          } else {
            afternoonSlots.add(slot);
          }
        }
      }
    }
    return {
      'morning': morningSlots,
      'afternoon': afternoonSlots,
    };
  }

  String getHourAndMinute(DateTime dateTime) {
    DateTime localDateTime = dateTime.toLocal();
    int hour = localDateTime.hour;
    int minute = localDateTime.minute;
    String formattedTime =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  //  select slot container start
  int selectedMorningIndex = -1;
  int selectedAfternoonIndex = -1;
  String? morningSlotId;
  String subSlotId = '';
  void setMorningIndex(
      int index, String slotId, bool isFromMorning, String subSlotIdTemp) {
    if (isFromMorning) {
      selectedAfternoonIndex = -1;
      selectedMorningIndex = index;
    } else {
      selectedMorningIndex = -1;
      selectedAfternoonIndex = index;
    }
    morningSlotId = slotId;
    subSlotId = subSlotIdTemp;
    notifyListeners();
  }

  // select slot container end

  // image picking start

  String singleImageUr = '';

  String imageTitlee = '';

  Map<String, String> uploadedImages = {};
  Map<String, String> imagePaths = {};
  Future<void> uploadSingleImage(
      {required String label, required BuildContext context}) async {
    singleImageUr = '';
    imageTitlee = '';
    File? tempImage = await pickImageFromGallery();
    if (tempImage == null) {
      return;
    }
    imageTitlee = tempImage.path.split('/').last;
    imagePaths[label] = imageTitlee;
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
        singleImageUr = data["images"][0]["imageUrl"];
        uploadedImages[label] = singleImageUr;
      } else {
        debugPrint('Error uploading image with response: $responseBody');
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    }
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
      return imageTemporaryData;
    } catch (e) {
      return null;
    } finally {
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

  // image picking end

  // Map to store dropdown values
  Map<String, String> dropdownValues = {};

  // Method to set selected value for a specific dropdown
  void setSelectedDropdownValue(String key, String value) {
    dropdownValues[key] = value;
    notifyListeners();
  }

  //  date and time

  Map<String, DateTime?> servicesSelectedDates = {};
  Map<String, String> selectedDateStrings = {};

  Future<void> servicesSelectDate(
      BuildContext context, String dateLabel) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2500),
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      updateSelectedDate(dateLabel, picked);
    }
  }

  void updateSelectedDate(String dateLabel, DateTime date) {
    servicesSelectedDates[dateLabel] = date;
    selectedDateStrings = {dateLabel: DateFormat('yyyy-MM-dd').format(date)};
    notifyListeners();
  }

  Map<String, String> servicesSelectedTimes = {};

  void updateSelectedTime(String label, TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    servicesSelectedTimes[label] = '$hour:$minute';
    notifyListeners();
  }

  Future<void> servicesSelectTime(BuildContext context, String label) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      updateSelectedTime(label, picked);
    }
  }

  // check box start

  Map<String, List<String>> selectedCheckboxValues = {};

  void toggleValueCheckboxFn(String section, String value) {
    if (selectedCheckboxValues[section]?.contains(value) ?? false) {
      selectedCheckboxValues[section]?.remove(value);
    } else {
      selectedCheckboxValues[section] = (selectedCheckboxValues[section] ?? [])
        ..add(value);
    }
    notifyListeners();
  }

  List<String> getSelectedValues(String section) {
    return selectedCheckboxValues[section] ?? [];
  }

  //  check box end

  // book slot fn start
  List<ControllersIsUsed> singleLineControllers = [];
  Future<void> bookSlotForServiceFn({
    required BuildContext context,
    required String serviceId,
    required String contactNumber,
    required String contactEmail,
    required Function() clearControllers,
  }) async {
    if (selectedPet == '' || selectedPet == null) {
      toast(
        context,
        title: 'Please select a Pet',
        backgroundColor: Colors.red,
      );
    } else if (slotFormattedDate == '') {
      toast(
        context,
        title: 'Please select a date',
        backgroundColor: Colors.red,
      );
    } else if (morningSlotId == null || morningSlotId == '') {
      toast(
        context,
        title: 'Please select a slot',
        backgroundColor: Colors.red,
      );
    } else if (!isAgree) {
      toast(
        context,
        title: 'Please agree to the terms and conditions',
        backgroundColor: Colors.red,
      );
    }

    if (petSlotModel.formData != null) {
      for (var e in petSlotModel.formData!) {
        switch (e.name?.toLowerCase()) {
          case "date":
            if (selectedDateStrings.values.isEmpty) {
              toast(
                context,
                title: 'Please fill in the value for ${e.label}',
                backgroundColor: Colors.red,
              );
              break; // Stop execution if a value is missing
            }
          case "time":
            if (servicesSelectedTimes.values.isEmpty) {
              toast(
                context,
                title: 'Please fill in the value for ${e.label}',
                backgroundColor: Colors.red,
              );
              break; // Stop execution if a value is missing
            }
            break;
          case "radio":
            if (selectedRadioValues.values.isEmpty) {
              toast(
                context,
                title: 'Please fill in the value for ${e.label}',
                backgroundColor: Colors.red,
              );
              break; // Stop execution if a value is missing
            }
            break;
          case "checkbox":
            if (selectedCheckboxValues.values.isEmpty) {
              toast(
                context,
                title: 'Please fill in the value for ${e.label}',
                backgroundColor: Colors.red,
              );
              break; // Stop execution if a value is missing
            }
            break;
          case "image":
            if (uploadedImages.values.isEmpty) {
              toast(
                context,
                title: 'Please fill in the value for ${e.label}',
                backgroundColor: Colors.red,
              );
              break; // Stop execution if a value is missing
            }
            break;
          case "dropdown":
            if (dropdownValues.values.isEmpty) {
              toast(
                context,
                title: 'Please fill in the value for ${e.label}',
                backgroundColor: Colors.red,
              );
              break; // Stop execution if a value is missing
            }
        }
      }
    }

    LoadingOverlay.of(context).show();
    try {
      Map<String, dynamic> body = {
        "serviceId": serviceId,
        "slotId": morningSlotId,
        "subSlotId": subSlotId,
        "petId": selectedPet,
        "contactNumber": contactNumber,
        "contactEmail": contactEmail,
        "Appointment Date": slotFormattedDate,
      };
      for (var i = 0; i < singleLineControllers.length; i++) {
        final tempData = {
          singleLineControllers[i].name:
              singleLineControllers[i].controller.text
        };
        body.addEntries(tempData.entries);
      }
      try {
        selectedDateStrings.forEach((key, value) {
          body[key] = value;
        });
      } catch (e) {
        debugPrint("Error adding selectedDateStrings to body: $e");
      }
      try {
        servicesSelectedTimes.forEach((key, value) {
          body[key] = value;
        });
      } catch (e) {
        debugPrint("Error adding selectedDateStrings to body: $e");
      }
      try {
        dropdownValues.forEach((key, value) {
          body[key] = value;
        });
      } catch (e) {
        debugPrint("Error adding selectedDateStrings to body: $e");
      }
      try {
        selectedRadioValues.forEach((key, value) {
          body[key] = value;
        });
      } catch (e) {
        debugPrint("Error adding selectedDateStrings to body: $e");
      }
      try {
        selectedCheckboxValues.forEach((key, value) {
          body[key] = value;
        });
      } catch (e) {
        debugPrint("Error adding selectedDateStrings to body: $e");
      }
      try {
        uploadedImages.forEach((key, value) {
          body[key] = value;
        });
      } catch (e) {
        debugPrint("Error adding selectedDateStrings to body: $e");
      }
      List response = await ServerClient.post(
        Urls.bookServicesSlotUrl,
        data: body,
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        clearControllers();
        selectedDateStrings.clear();
        servicesSelectedTimes.clear();
        dropdownValues.clear();
        selectedRadioValues.clear();
        selectedCheckboxValues.clear();
        uploadedImages.clear();
        singleLineControllers.clear();
        selectedPet = '';
        morningSlotId = '';
        subSlotId = '';
        isAgree = false;
        slotFormattedDate = '';
        selectedAfternoonIndex = -1;
        selectedMorningIndex = -1;

        getServiceAppoinments(
          page: 1,
          search: '',
        );
        petSlotModel.formData?.clear();
        LoadingOverlay.of(context).hide();
        Routes.back(context: context);
        Routes.back(context: context);
        Routes.pushReplace(
            context: context, screen: const MyAppointmentScreen());

        toast(
          context,
          title: "Slot booked successfully",
          backgroundColor: Colors.green,
        );
      } else {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint("$e");
    }
  }

  // book slot fn end

  // GET ALL Appoinments START

  GetServiceAppoinmentsModel appoinmentsModel = GetServiceAppoinmentsModel();
  GetAppoinmentsStatus getAppoinmentsStatus = GetAppoinmentsStatus.initial;

  Future getServiceAppoinments(
      {required int page, required String search}) async {
    getAppoinmentsStatus = GetAppoinmentsStatus.loading;
    try {
      List response = await ServerClient.get(
        "${Urls.allAppoinmentsUrl}?page=$page&search=$search",
      );
      if (response.first >= 200 && response.first < 300) {
        appoinmentsModel = GetServiceAppoinmentsModel.fromJson(response.last);
        getAppoinmentsStatus = GetAppoinmentsStatus.loaded;
      } else {
        getAppoinmentsStatus = GetAppoinmentsStatus.error;
        appoinmentsModel = GetServiceAppoinmentsModel();
      }
    } catch (e) {
      getAppoinmentsStatus = GetAppoinmentsStatus.error;
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  //  GET ALL Appoinments END

  // GET Upcoming Appoinments START

  Future getUpcomingAppoinmentsFn({
    required int page,
    required String search,
  }) async {
    try {
      getAppoinmentsStatus = GetAppoinmentsStatus.loading;
      List response = await ServerClient.get(
        "${Urls.upcomingAppoinmentsUrl}?page=$page&search=$search",
      );

      if (response.first >= 200 && response.first < 300) {
        appoinmentsModel = GetServiceAppoinmentsModel.fromJson(response.last);
        getAppoinmentsStatus = GetAppoinmentsStatus.loaded;
      } else {
        getAppoinmentsStatus = GetAppoinmentsStatus.error;
        appoinmentsModel = GetServiceAppoinmentsModel();
      }
    } catch (e) {
      getAppoinmentsStatus = GetAppoinmentsStatus.error;
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  //  GET Upcoming Appoinments END

  // GET Upcoming Appoinments START

  Future getEndedAppoinments({
    required int page,
    required String search,
  }) async {
    try {
      getAppoinmentsStatus = GetAppoinmentsStatus.loading;
      List response = await ServerClient.get(
        "${Urls.endedAppoinmentsUrl}?page=$page&search=$search",
      );

      if (response.first >= 200 && response.first < 300) {
        appoinmentsModel = GetServiceAppoinmentsModel.fromJson(response.last);
        getAppoinmentsStatus = GetAppoinmentsStatus.loaded;
      } else {
        getAppoinmentsStatus = GetAppoinmentsStatus.error;
        appoinmentsModel = GetServiceAppoinmentsModel();
      }
    } catch (e) {
      getAppoinmentsStatus = GetAppoinmentsStatus.error;
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  //  GET Upcoming Appoinments END

  String serviceDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  String serviceTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  // --------- PET SERVICE HOME STATIC DATA--------- //
  List<String> serviceNames = [
    "Veterinary",
    "Pet Grooming",
    "Pet Taxi",
    "Community",
    "Pet Boarding",
    "Day Care",
    "Pet Training",
    "Dating",
  ];
  List<String> serviceImages = [
    "assets/images/vetinaryIcon.png",
    "assets/images/grooming.png",
    "assets/images/pet_taxi.png",
    "assets/images/community.png",
    "assets/images/petBourdingIcon.png",
    "assets/images/dayCareIcon.png",
    "assets/images/hireAtraineeIcon.png",
    "assets/images/datingIcon.png",
  ];

  List<String> serviceHomeNames = [
    "Veterinary",
    "Pet Grooming",
    "Pet Taxi",
    "Pet Boarding",
    "Day Care",
    "Pet Training",
  ];
  List<String> serviceHomeImages = [
    "assets/images/vetinaryIcon.png",
    "assets/images/grooming.png",
    "assets/images/pet_taxi.png",
    "assets/images/petBourdingIcon.png",
    "assets/images/dayCareIcon.png",
    "assets/images/hireAtraineeIcon.png",
  ];

  //  SERVICE FORM NEW UPDATES FUNCTIONALITIES
  final Map<String, String> _status = {
    'Deworned': '',
    'Vaccinated': '',
    'Allergies': '',
    'Pickup & Drop Required ?': '',
  };

  // Get the current selection status for a key
  String getSelectionStatus(String key) => _status[key] ?? '';

  // Set the selection status for a key
  void setSelectionStatus(String key, String value) {
    if (value == 'Yes' || value == 'No' || value == '') {
      _status[key] = value;
      notifyListeners();
    }
  }

  List<String> petSizes = ['Small', 'Medium', 'Large'];

  String? selectedSize;

  void setSelectedSize(String? size) {
    selectedSize = size;
    notifyListeners();
  }

  String selectedCountry = '';

  void setCountry(String country) {
    selectedCountry = country;
    notifyListeners();
  }

  String fromContainer = "From";
  void updateContainerBg(String title) {
    fromContainer = title;
    notifyListeners();
  }

  //  SERVICE CLINIC SELECTING NEW UPDATES FUNCTIONALITIES

  List<String> filterByNames = [
    'Facilities',
    'Service Type',
    'Pet Type',
    'Location'
  ];
  String selectedFilterByIndex = 'Facilities';
  void updateFilterByIndex(String title) {
    selectedFilterByIndex = title;
    notifyListeners();
  }

  Widget buildFilterContent(ServiceProvider value, BuildContext context) {
    switch (value.selectedFilterByIndex) {
      case 'Location':
        return SearchWidget(
          node: FocusNode(),
          onTap: (id, placeName) {
            log('Place ID: $id, Place Name: $placeName');
          },
        );
      default:
        return _buildDefaultFilterList();
    }
  }

  Widget _buildDefaultFilterList() {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              height: Responsive.height * 3,
              width: Responsive.height * 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppConstants.appPrimaryColor,
              ),
            ),
            title: const commonTextWidget(
              align: TextAlign.start,
              color: AppConstants.black,
              text: "Ear care",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizeBoxH(0),
        itemCount: 10,
      ),
    );
  }

  //  Booking summary payment selection fn
  String selectedPaymentMethod = 'Stripe';
  void updatePaymentMethod(String title) {
    selectedPaymentMethod = title;
    notifyListeners();
  }
}

class PetServiceModel {
  final String img;
  final String name;

  PetServiceModel({required this.img, required this.name});
}
