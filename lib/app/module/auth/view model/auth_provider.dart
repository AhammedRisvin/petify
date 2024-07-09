// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:clan_of_pets/app/core/urls.dart';
import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/firebase_api/notification_service.dart';
import '../../../core/server_client_services.dart';
import '../../../core/string_const.dart';
import '../../../utils/app_go_router.dart';
import '../../../utils/app_router.dart';
import '../../../utils/loading_overlay.dart';
import '../../community/community details/view/post_details_how_vie_link.dart';
import '../../home/view model/home_provider.dart';
import '../../home/view/bottom_nav_screen.dart';
import '../view/otp_screen.dart';
import 'number_validation_map.dart';

class AuthProvider extends ChangeNotifier {
  String? otpController;

  bool isSignInTrue = true;

  changeSignInFn() {
    isSignInTrue = !isSignInTrue;
    notifyListeners();
  }

  // user login fn start
  String phoneNumber = '';

  Future<void> petsLoginFn(
      {required BuildContext context,
      required String phoneNumberController,
      required Function() clear}) async {
    if (phoneNumberController == "") {
      toast(context,
          title: "provide proper phone number", backgroundColor: Colors.red);
    } else {
      LoadingOverlay.of(context).show();
      try {
        List response = await ServerClient.post(StringConst.userLoginUrl,
            data: {
              "phone":
                  "$countryCodeCtrl$phoneNumberController", //      "phone": "$countryCodeCntrlr$phoneNumberController",
            },
            post: true);
        log("response.first ${response.first}  response.last ${response.last}");

        if (response.first >= 200 && response.first < 300) {
          clear();
          LoadingOverlay.of(context).hide();
          toast(
            context,
            title: response.last["message"],
            backgroundColor: Colors.green,
          );

          phoneNumber = response.last["phone"];

          Routes.push(
            context: context,
            screen: const OtpScreen(),
            exit: () {},
          );
        } else {
          LoadingOverlay.of(context).hide();
          toast(
            context,
            title: "Something went wrong",
            backgroundColor: Colors.red,
          );
          throw Exception('Failed to fetch posts');
        }
      } catch (e) {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: "Something went wrong",
          backgroundColor: Colors.red,
        );
      } finally {
        notifyListeners();
      }
    }
  }
  //  user login end

  // user otp verification start

  Future<Map<String, dynamic>> petsUserOtpVerificationFn(
      {required BuildContext context}) async {
    if (otpController == "" || otpController == null) {
      toast(context, title: "provide proper OTP", backgroundColor: Colors.red);
      return {
        'success': false,
        'message': 'OTP not provided',
        'isUserAccount': false
      };
    } else {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        StringConst.userOtpFn,
        data: {
          "otp": otpController,
          "phone": phoneNumber,
          "firebaseId": NotificationService().fcmToken
        },
        post: true,
      );

      log("response.first ${response.first}  response.last ${response.last}");
      if (response.first >= 200 && response.first < 300) {
        otpController = "";
        await StringConst.addUserToken(userToken: response.last["token"]);
        await StringConst.setUserId(userId: response.last["userId"]);
        const FlutterSecureStorage storage = FlutterSecureStorage();
        String? deepLink = await storage.read(key: StringConst.deepLinkUrl);
        LoadingOverlay.of(context).hide();
        if (deepLink != null) {
          Routes.pushRemoveUntil(
            context: context,
            screen: CommunityPostDetailsScreen(
              isFromLogin: true,
              url: StringConst.deepLinkUrl,
            ),
          );
          return {
            'success': true,
            'roles': response.last["role"],
            'isUserAccount': response.last["isUserAccount"],
            'userId': response.last["userId"]
          };
        } else {
          return {
            'success': true,
            'roles': response.last["role"],
            'isUserAccount': response.last["isUserAccount"],
            'userId': response.last["userId"]
          };
        }
      } else if (response.first >= 300 && response.first < 500) {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last,
          backgroundColor: Colors.red,
        );
        return {
          'success': false,
          'message': response.last,
          'isUserAccount': false
        };
      }
    }
    return {
      'success': false,
      'message': 'Unhandled exception',
      'isUserAccount': false
    };
  }

  //  user otp verification end

  //  change current role fn start

  Future<void> changeCurrentRoleFn({
    required BuildContext context,
    required String petRole,
    required String ownerId,
    required bool isUser,
    required String userId,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      final body = isUser
          ? {
              "petRole": petRole,
              "ownerId": userId,
            }
          : {
              "petRole": petRole,
              "ownerId": ownerId,
            };
      List response = await ServerClient.post(
        Urls.changeCurrentRole,
        data: body,
        post: true,
      );
      log("response.first ${response.first}  response.last ${response.last}");
      if (response.first >= 200 && response.first < 300) {
        createUserRoleFn();
        await StringConst.addUserRole(roleOfTheUser: response.last["role"]);
        LoadingOverlay.of(context).hide();
        if (response.last["role"] == "user" ||
            response.last["role"] == "coParent") {
          Routes.pushRemoveUntil(
            context: context,
            screen: const BottomNavBarWidget(),
          );
        } else if (response.last["role"] == 'temporaryParent') {
          context.read<HomeProvider>().getPetFn();
          context.goNamed(AppRouter.petProfile);
        } else {
          context.goNamed(AppRouter.onboardingScreen);
        }
      } else {
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: response.last,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      toast(
        context,
        title: "Something went wrong, please try again later",
        backgroundColor: Colors.red,
      );
      debugPrint("error in changeCurrentRoleFn $e");
    }
  }

  //  change current role fn end

  // create user role fn start
  Future<void> createUserRoleFn() async {
    try {
      List response = await ServerClient.post(
        Urls.createUserRole,
        post: false,
      );
      log("createUserRole.first ${response.first}  createUserRole.last ${response.last}");
      if (response.first >= 200 && response.first < 300) {
        debugPrint("user role created");
      } else {
        debugPrint("error in createUserRoleFn ${response.last}");
      }
    } catch (e) {
      debugPrint("error in createUserRoleFn $e");
    }
  } // crate user role fn end

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
}
