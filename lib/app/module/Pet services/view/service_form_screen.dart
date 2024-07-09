import 'dart:developer';

import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../widget/calender_widget.dart';
import '../widget/pet_health_option_widget.dart';
import '../widget/pet_size_drop_down_widget.dart';
import '../widget/select_country_widget.dart';
import '../widget/select_pet_widget.dart';
import '../widget/slot_selecting-widget.dart';
import '../widget/terms_and_condition_selecting_widget.dart';
import '../widget/textformfield_eith_prefix.dart';
import '../widget/write_more_textformfield.dart';
import 'booking_summary_screen.dart';

class ServiceFormScreen extends StatefulWidget {
  const ServiceFormScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<ServiceFormScreen> createState() => _ServiceFormScreenState();
}

class _ServiceFormScreenState extends State<ServiceFormScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    log("widget.title${widget.title}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: commonTextWidget(
          text: widget.title,
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
        leading: IconButton(
          onPressed: () {
            Routes.back(context: context);
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppConstants.greyContainerBg,
            ),
          ),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 19,
            color: AppConstants.appPrimaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<ServiceProvider>(
          builder: (context, provider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectPetWidget(
                provider: provider,
                petList: provider.petSlotModel.pets,
              ),
              const SizeBoxH(10),
              if (widget.title == "Veterinary" ||
                  widget.title == "Pet Grooming") ...[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HealthOptionWidget(
                      title: "Deworned",
                    ),
                    HealthOptionWidget(
                      title: "Vaccinated",
                    ),
                    HealthOptionWidget(
                      title: "Allergies",
                    ),
                  ],
                ),
              ],
              if (widget.title == "Pet Boarding" ||
                  widget.title == "Pet Training") ...[
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HealthOptionWidget(
                      title: "Pickup & Drop Required ?",
                    ),
                    SizeBoxH(10),
                  ],
                ),
              ],
              if (widget.title == "Pet Taxi" || widget.title == "Day Care") ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFieldWithPrefix(
                      isFromLocation: true,
                      controller: TextEditingController(),
                      hintText: "Location",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/greenLocationIcon.png",
                          height: 10,
                        ),
                      ),
                      title: "Pickup Location ",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }

                        return null;
                      },
                    ),
                    const SizeBoxH(10),
                    TextFormFieldWithPrefix(
                      isFromLocation: true,
                      controller: TextEditingController(),
                      hintText: "Location",
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/greenLocationIcon.png",
                          height: 10,
                        ),
                      ),
                      title: "Pickup Location ",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ],
              if (widget.title == "Pet Boarding" ||
                  widget.title == "Pet Taxi" ||
                  widget.title == "Pet Training") ...[
                PetSizeSelectingDropDownWidget(
                  provider: provider,
                ),
              ],
              const SizeBoxH(10),
              if (widget.title == "Pet Taxi") ...[
                SelectCountryWidget(
                  provider: provider,
                ),
              ],
              TextFormFieldWithPrefix(
                controller: phoneController,
                hintText: "Contact Number",
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.phone,
                  color: AppConstants.black40,
                ),
                title: "Contact Number",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid contact number';
                  }
                  return null;
                },
              ),
              const SizeBoxH(10),
              TextFormFieldWithPrefix(
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(
                  Icons.mail,
                  color: AppConstants.black40,
                ),
                title: "Email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizeBoxH(10),
              CalenderWidget(
                provider: provider,
                clinicId: "",
                serviceId: "",
                title: widget.title,
              ),
              const SizeBoxH(10),
              SlotSelectingWidget(
                morningList: provider.morningSlots,
                afternoonList: provider.afternoonSlots,
              ),
              if (widget.title == "Pet Boarding" ||
                  widget.title == "Pet Training") ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizeBoxH(10),
                    Container(
                      width: Responsive.height * 30,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xff712D2E),
                      ),
                      child: const Center(
                        child: commonTextWidget(
                          color: AppConstants.white,
                          text: "Total 0 Days",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizeBoxH(10),
                  ],
                ),
              ],
              const commonTextWidget(
                color: AppConstants.black,
                text: "Amount",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              const SizeBoxH(10),
              if (widget.title == "Day Care") ...[
                const Column(
                  children: [
                    SizeBoxH(20),
                    PaymentRowWidget(
                      title: "Day care",
                      amount: "200 AED",
                    ),
                  ],
                ),
              ],
              if (widget.title == "Veterinary") ...[
                const Column(
                  children: [
                    SizeBoxH(20),
                    PaymentRowWidget(
                      title: "Dermatology",
                      amount: "200 AED",
                    ),
                    SizeBoxH(15),
                    PaymentRowWidget(
                      title: "Wellness exams",
                      amount: "200 AED",
                    ),
                    SizeBoxH(15),
                    PaymentRowWidget(
                      title: "Total Amount",
                      amount: "200 AED",
                      isFromTotal: true,
                    ),
                  ],
                ),
              ],
              if (widget.title == "Pet Grooming") ...[
                const Column(
                  children: [
                    SizeBoxH(20),
                    PaymentRowWidget(
                      title: "Trimming",
                      amount: "200 AED",
                    ),
                    SizeBoxH(15),
                    PaymentRowWidget(
                      title: "Medicated Bath",
                      amount: "200 AED",
                    ),
                    SizeBoxH(15),
                    PaymentRowWidget(
                      title: "Total Amount",
                      amount: "200 AED",
                      isFromTotal: true,
                    ),
                  ],
                ),
              ],
              if (widget.title == "Pet Boarding") ...[
                const Column(
                  children: [
                    SizeBoxH(20),
                    PaymentRowWidget(
                      title: "Pet Boarding",
                      amount: "200 AED",
                    ),
                    SizeBoxH(15),
                    PaymentRowWidget(
                      title: "Total Amount",
                      amount: "200 AED",
                      isFromTotal: true,
                    ),
                  ],
                ),
              ],
              if (widget.title == "Pet Taxi") ...[
                const Column(
                  children: [
                    SizeBoxH(20),
                    PaymentRowWidget(
                      title: "Pet Boarding",
                      amount: "200 AED",
                    ),
                    SizeBoxH(15),
                    PaymentRowWidget(
                      title: "Total Amount",
                      amount: "200 AED",
                      isFromTotal: true,
                    ),
                  ],
                ),
              ],
              if (widget.title == "Pet Training") ...[
                const Column(
                  children: [
                    SizeBoxH(20),
                    PaymentRowWidget(
                      title: "Pet Boarding",
                      amount: "200 AED",
                    ),
                    SizeBoxH(15),
                    PaymentRowWidget(
                      title: "Total Amount",
                      amount: "200 AED",
                      isFromTotal: true,
                    ),
                  ],
                ),
              ],
              const SizeBoxH(10),
              WriteMoreTextFormFieldWidget(
                provider: provider,
                controller: TextEditingController(),
              ),
              const TermsAndConditionSelectWidget(),
              const SizeBoxH(30),
              CommonButton(
                isFullRoundedButton: true,
                onTap: () {
                  Routes.push(
                    screen: const ServiceBookingSummaryScreen(),
                    exit: () {},
                    context: context,
                  );
                },
                text: "Submit",
                size: 16,
                width: Responsive.width * 100,
                height: 50,
              ),
              const SizeBoxH(30),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentRowWidget extends StatelessWidget {
  const PaymentRowWidget({
    super.key,
    required this.title,
    required this.amount,
    this.isFromTotal = false,
  });
  final String title;
  final String amount;
  final bool isFromTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonTextWidget(
          color: AppConstants.black,
          text: title,
          fontSize: isFromTotal ? 18 : 16,
          fontWeight: isFromTotal ? FontWeight.w600 : FontWeight.w500,
        ),
        commonTextWidget(
          color: AppConstants.black60,
          text: amount,
          fontSize: isFromTotal ? 18 : 16,
          fontWeight: isFromTotal ? FontWeight.w600 : FontWeight.w500,
        ),
      ],
    );
  }
}
