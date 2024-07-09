// ignore_for_file: use_build_context_synchronously

import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../view model/auth_provider.dart';
import '../widget/choose_role_bottom_sheet.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appPrimaryColor,
        surfaceTintColor: AppConstants.appPrimaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppConstants.appPrimaryColor,
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              SizedBox(height: Responsive.height * 6),
              Center(
                child: Image.asset(
                  AppImages.signUpLogo,
                  height: Responsive.height * 14,
                  color: AppConstants.white,
                ),
              ),
              SizedBox(height: Responsive.height * 10),
              Expanded(
                child: Container(
                  width: Responsive.width * 100,
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: AppConstants.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizeBoxH(Responsive.height * 2),
                        const commonTextWidget(
                          color: AppConstants.black,
                          text: "Enter Verification Code",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                        SizeBoxH(Responsive.height * 1),
                        const commonTextWidget(
                          align: TextAlign.center,
                          color: AppConstants.black60,
                          text:
                              "We are automatically sent a OTP to your mobile number",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                        SizeBoxH(Responsive.height * 6),
                        Center(
                          child: Pinput(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            length: 6,
                            focusedPinTheme: PinTheme(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppConstants.appPrimaryColor
                                    .withOpacity(0.1),
                                border: Border.all(
                                  color: AppConstants.appPrimaryColor
                                      .withOpacity(.4),
                                ),
                              ),
                            ),
                            defaultPinTheme: PinTheme(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: AppConstants.appPrimaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            showCursor: true,
                            onCompleted: (pin) {
                              context.read<AuthProvider>().otpController = pin;
                            },
                            errorPinTheme: PinTheme(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: AppConstants.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppConstants.red.withOpacity(.4),
                                ),
                              ),
                            ),
                            errorText: 'Entered pin is incorrect',
                            errorTextStyle: const TextStyle(
                              color: AppConstants.red,
                              fontSize: 12,
                            ),
                            onTapOutside: (_) {
                              FocusScope.of(context).unfocus();
                            },
                            pinAnimationType: PinAnimationType.fade,
                            submittedPinTheme: PinTheme(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.green.withOpacity(.4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizeBoxH(Responsive.height * 3),
                        CommonButton(
                          onTap: () {
                            verifyOtp();
                          },
                          text: "Verify Code",
                          width: Responsive.width * 100,
                          height: Responsive.height * 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void verifyOtp() async {
    var result = await context
        .read<AuthProvider>()
        .petsUserOtpVerificationFn(context: context);
    if (result['success']) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return ChooseRoleScreen(
              roles: result['roles'],
              isUserAccount: result['isUserAccount'],
              userId: result['userId'],
            );
          },
        ),
      );
    } else {
      toast(
        context,
        title: "Something went wrong, please try again",
        backgroundColor: Colors.red,
      );
    }
  }
}
