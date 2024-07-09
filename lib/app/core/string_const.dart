// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../env.dart';
import '../module/onboarding/view/splash_screen.dart';
import '../utils/app_router.dart';

class StringConst {
  static const storage = FlutterSecureStorage();

  static String token = "petShopUserToken";
  static String eStoreToken = "petShopeStorToken";
  static String facilityLoginUserId = "petShopFacilityLoginUserId";
  static String isFromMemberLogin = "";
  static String petId = "petShopPetId";
  static String userRole = "petShopUserRole";
  static String petIndex = "0";
  static String deepLinkUrl = "petShopDeepLinkUrl";
  static String fcmToken = "petShopFcmToken";

  static Future<void> addDeepLinkUrl({required String url}) async {
    await storage.write(key: deepLinkUrl, value: url);
  }

  static Future<String> getDeepLinkurl() async {
    return await storage.read(key: deepLinkUrl) ?? "";
  }

  static Future<void> logout({required BuildContext context}) async {
    await storage.deleteAll();
    Routes.pushRemoveUntil(screen: const SplashScreen(), context: context);
  }

  static Future<String> getUserToken() async {
    return await storage.read(key: token) ?? "";
  }

  static Future<void> addUserToken({required String userToken}) async {
    await storage.write(key: token, value: userToken);
  }

  static Future<String> getIsFromMemberLogin() async {
    return await storage.read(key: isFromMemberLogin) ?? "";
  }

  static Future<void> addIsFromMemberLogin(
      {required String loginTrueOrFalse}) async {
    await storage.write(key: isFromMemberLogin, value: loginTrueOrFalse);
  }

  static Future<String> getUserID() async {
    return await storage.read(key: 'userId') ?? "";
  }

  static Future<void> setUserId({required String userId}) async {
    await storage.write(key: 'userId', value: userId);
  }

  static Future<String> getPetID() async {
    return await storage.read(key: petId) ?? "";
  }

  static Future<void> setPetId({required String pet}) async {
    await storage.write(key: petId, value: pet);
  }

  static Future<String> getPetIndex() async {
    return await storage.read(key: petIndex) ?? "";
  }

  static Future<void> setPetIndex({required String index}) async {
    await storage.write(key: petIndex, value: index);
  }

  static Future<void> addUserRole({required String roleOfTheUser}) async {
    await storage.write(key: userRole, value: roleOfTheUser);
  }

  static Future<String> getUserRole() async {
    return await storage.read(key: userRole) ?? "";
  }

  static String baseUrl = Environments.baseUrl;

  static String userLoginUrl = "${baseUrl}user/petUserlogin";
  static String userOtpFn = "${baseUrl}user/petUserOtpVerifyOtp";
  static String facilityHomeList = "${baseUrl}facility/getAllFacility";
  static String facilityBookingList = "${baseUrl}facility/getBookings";
  static String facilityGetSlot = "${baseUrl}facility/getSlotes";
  static String applyForFacility = "${baseUrl}facility/applyForRent";
  static String facilityStripeUrl =
      '${baseUrl}facility/checkout-stripe-payment';
  static String facilityPaymentValidationUrl =
      '${baseUrl}facility/checkout-stripe-payment-success';
  static String getAllPlansUrl = '${baseUrl}user/getAllPlans';
  static String stripeUrl = '${baseUrl}user/stripePayment';
  static String paymentValidationUrl = '${baseUrl}user/stripeValidation';
  static String myBookingCompletedUrl = '${baseUrl}user/getCompletedClass';
  static String postFeedback = '${baseUrl}user/addFeedback';
  static String bookClass = "${baseUrl}user/bookClass";
  static String userLogin = "${baseUrl}user/login";
  static String getHomeData = "${baseUrl}user/getHomeDatas";
  static String getTrainingVideos = "${baseUrl}user/getTrainingVideos";
  static String qrUsingAttendens = "${baseUrl}user/addAttendense";
  static String upComingBookingUrl = "${baseUrl}user/getUpcomingClass";
  static String bookingCancelUrtl = "${baseUrl}user/cancelBooking";
  static String getAllClasses = "${baseUrl}user/getAllClasses?date=";
  static String getBranch = "${baseUrl}user/getAllBranches";
}
