import 'package:clan_of_pets/app/module/auth/view%20model/auth_provider.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthProvider? authProvider;
  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
  }

  @override
  dispose() {
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appPrimaryColor,
      appBar: AppBar(
        backgroundColor: AppConstants.appPrimaryColor,
        elevation: 0,
        surfaceTintColor: AppConstants.appPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: true,
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
                        SizeBoxH(Responsive.height * 1),
                        commonTextWidget(
                          color: AppConstants.black,
                          text: provider.isSignInTrue ? "Sign in" : "Sign Up",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        SizeBoxH(Responsive.height * 1),
                        commonTextWidget(
                          color: AppConstants.black40,
                          text: provider.isSignInTrue
                              ? "Please sign in to continue"
                              : "Please  sign up to continue",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                        provider.isSignInTrue
                            ? SizeBoxH(Responsive.height * 4)
                            : SizeBoxH(Responsive.height * 5.5),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: commonTextWidget(
                            align: TextAlign.start,
                            color: AppConstants.black,
                            text: "Mobile Number",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizeBoxH(10),
                        Row(
                          children: [
                            CountryListPick(
                              theme: CountryTheme(
                                isShowFlag: false,
                                isShowTitle: false,
                                isShowCode: true,
                                isDownIcon: true,
                                showEnglishName: true,
                                // alphabetSelectedBackgroundColor:
                                //     AppColors.limeColor,
                              ),
                              initialSelection: '+971',
                              onChanged: (CountryCode? code) {
                                provider.updateCountryCode(
                                  code?.dialCode ?? 'AE',
                                );
                              },
                              appBar: AppBar(
                                systemOverlayStyle: const SystemUiOverlayStyle(
                                  statusBarColor: AppConstants.appPrimaryColor,
                                  statusBarIconBrightness: Brightness.light,
                                ),
                                backgroundColor: AppConstants.appPrimaryColor,
                                title: const Text(
                                  'Choose Country',
                                  style: TextStyle(
                                    color: AppConstants.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              pickerBuilder: (context, CountryCode? code) {
                                return Row(
                                  children: [
                                    commonTextWidget(
                                      text: code?.dialCode ?? "+971",
                                      color: AppConstants.black,
                                    ),
                                    SizedBox(width: Responsive.width * 2),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: AppConstants.appPrimaryColor,
                                    ),
                                  ],
                                );
                              },
                            ),
                            Expanded(
                              child: Container(
                                height: Responsive.height * 6,
                                margin: EdgeInsets.only(
                                  left: Responsive.width * 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.white,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: AppConstants.greyContainerBg,
                                  ),
                                ),
                                child: CommonTextFormField(
                                  bgColor: AppConstants.white,
                                  hintTextColor: AppConstants.black40,
                                  hintText: "Mobile Number",
                                  keyboardType: TextInputType.number,
                                  textInputAction: provider.isSignInTrue
                                      ? TextInputAction.done
                                      : TextInputAction.next,
                                  controller: phoneNumberController,
                                  maxLength: provider.maxLength,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizeBoxH(Responsive.height * 2),
                        CommonButton(
                          onTap: () {
                            context.read<AuthProvider>().petsLoginFn(
                                  context: context,
                                  phoneNumberController:
                                      phoneNumberController.text,
                                  clear: () {
                                    phoneNumberController.clear();
                                  },
                                );
                          },
                          text: provider.isSignInTrue ? "Sign In" : "Sign Up",
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
}
