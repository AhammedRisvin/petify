import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../widget/payment_success_widget.dart';

class ServiceBookingSummaryScreen extends StatefulWidget {
  const ServiceBookingSummaryScreen({super.key});

  @override
  State<ServiceBookingSummaryScreen> createState() =>
      _ServiceBookingSummaryScreenState();
}

class _ServiceBookingSummaryScreenState
    extends State<ServiceBookingSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Booking Summary",
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
            size: 18,
            color: AppConstants.appPrimaryColor,
          ),
        ),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: Responsive.height * 9.5,
                    width: Responsive.width * 18,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF3F3F5),
                    ),
                    child: Image.asset(
                      "assets/images/grooming.png",
                    ),
                  ),
                  const SizeBoxV(20),
                  const commonTextWidget(
                    text: "Pet Grooming",
                    color: AppConstants.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 4),
              Container(
                width: Responsive.width * 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppConstants.transparent,
                  border: Border.all(
                    color: AppConstants.black10,
                  ),
                ),
                child: const Column(
                  children: [
                    BookingSummaryRow(
                      title: "Date",
                      value: "MAR/29/2024",
                    ),
                    SizeBoxH(15),
                    BookingSummaryRow(
                      title: "Time",
                      value: "10.00 Am",
                    ),
                    SizeBoxH(15),
                    BookingSummaryRow(
                      title: "Trimming",
                      value: "200 AED",
                    ),
                    SizeBoxH(15),
                    BookingSummaryRow(
                      title: "Medicated Bath",
                      value: "200 AED",
                    ),
                    SizeBoxH(23),
                    BookingSummaryRow(
                      title: "Total Amount",
                      value: "400 AED",
                      isFromTotal: true,
                    ),
                  ],
                ),
              ),
              SizeBoxH(Responsive.height * 1.5),
              const commonTextWidget(
                text: "Payment Method",
                color: AppConstants.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
              SizeBoxH(Responsive.height * 1.5),
              Row(
                children: [
                  PaymentMethodWidget(
                    image: "assets/images/Stripe.png",
                    title: "Stripe",
                    provider: value,
                  ),
                  const SizeBoxV(15),
                  PaymentMethodWidget(
                    image: "assets/images/paypal.png",
                    title: "Paypal",
                    provider: value,
                  ),
                  const SizeBoxV(15),
                  PaymentMethodWidget(
                    image: "assets/images/tamara.png",
                    title: "Tamara",
                    provider: value,
                  ),
                  const SizeBoxV(15),
                  PaymentMethodWidget(
                    image: "assets/images/wallet.png",
                    title: "Wallet",
                    provider: value,
                  ),
                ],
              ),
              SizeBoxH(Responsive.height * 4),
              CommonButton(
                onTap: () {
                  Routes.push(
                    screen: const PaymentSuccessWidget(),
                    exit: () {},
                    context: context,
                  );
                },
                text: "Continue",
                width: Responsive.width * 100,
                height: Responsive.height * 6,
                radius: 100,
                size: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    super.key,
    required this.image,
    required this.title,
    required this.provider,
  });

  final String image;
  final String title;
  final ServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    final selected = provider.selectedPaymentMethod == title;
    return Column(
      children: [
        CommonInkwell(
          onTap: () {
            provider.updatePaymentMethod(title);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? AppConstants.appPrimaryColor
                    : AppConstants.transparent,
                width: 1,
              ),
            ),
            child: Image.asset(
              image,
              height: Responsive.height * 7,
              width: Responsive.height * 7,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizeBoxH(10),
        commonTextWidget(
          text: title,
          color: selected ? AppConstants.appPrimaryColor : AppConstants.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),
      ],
    );
  }
}

class BookingSummaryRow extends StatelessWidget {
  const BookingSummaryRow({
    super.key,
    required this.title,
    required this.value,
    this.isFromTotal = false,
  });

  final String title;
  final String value;
  final bool isFromTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonTextWidget(
          text: title,
          color: isFromTotal ? AppConstants.black60 : AppConstants.black,
          fontSize: isFromTotal ? 15 : 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),
        commonTextWidget(
          text: value,
          color: AppConstants.black60,
          fontSize: isFromTotal ? 14 : 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ],
    );
  }
}
