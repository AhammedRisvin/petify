import 'package:flutter/material.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';

class PrivacyPolicyAndTermsAndConditionScreen extends StatefulWidget {
  const PrivacyPolicyAndTermsAndConditionScreen(
      {super.key, required this.isFromPrivacyPolicy});

  final bool isFromPrivacyPolicy;

  @override
  State<PrivacyPolicyAndTermsAndConditionScreen> createState() =>
      _PrivacyPolicyAndTermsAndConditionScreenState();
}

class _PrivacyPolicyAndTermsAndConditionScreenState
    extends State<PrivacyPolicyAndTermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: commonTextWidget(
          text: widget.isFromPrivacyPolicy
              ? "Privacy Policy"
              : "Terms & Conditions",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        leading: IconButton(
          onPressed: () {
            Routes.back(
              context: context,
            );
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              Colors.white.withOpacity(0.5),
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
        child: Text(
          widget.isFromPrivacyPolicy ? privacyPolicy : termsAndCondition,
        ),
      ),
    );
  }
}

String privacyPolicy = '''Privacy Policy

1. Introduction

Clan of Pets is committed to protecting your privacy. This Privacy Policy explains how we collect, use, and share information about you when you use our mobile application ("App").


2. Information We Collect

Personal Information: We collect information you provide directly to us, such as your name, email address, pet information, and any other information you choose to provide.
Usage Data: We automatically collect information about your interactions with the App, including the pages or features you use and the time you spend on the App.

3. How We Use Information

To Provide Services: We use your information to maintain and provide our services, including managing pet data and bookings.
To Improve the App: We use usage data to understand how our App is used and to improve its functionality.
To Communicate: We may use your information to communicate with you about updates, promotions, and other news.

4. Sharing Information

Service Providers: We may share your information with third-party service providers who perform services on our behalf.
Legal Requirements: We may disclose your information if required to do so by law or in response to valid requests by public authorities.

5. Security

We take reasonable measures to protect your information from unauthorized access, use, or disclosure. However, no internet or email transmission is ever fully secure or error-free.

6. Data Retention

We retain your information for as long as your account is active or as needed to provide you services.

7. Your Rights

You have the right to access, correct, or delete your personal information. You may also object to the processing of your information or request that we restrict the processing of your information.

8. Changes to Privacy Policy

We may update this Privacy Policy from time to time. The updated policy will be posted on the App, and your continued use of the App constitutes acceptance of the changes.

9. Contact Us

If you have any questions about this Privacy Policy, please contact us at +91 8921633521.''';

String termsAndCondition = '''Terms of Service

1. Introduction

Welcome to Clan of Pets! These Terms of Service ("Terms") govern your use of our mobile application ("App"). By using our App, you agree to these Terms. If you do not agree, do not use the App.

2. Use of the App

Eligibility: You must be at least 13 years old to use the App.
Account: You are responsible for maintaining the confidentiality of your account and password and for restricting access to your device.
Prohibited Conduct: You agree not to use the App for any unlawful or prohibited activities.

3. User Content

Content: You are responsible for any content you upload, post, or otherwise transmit through the App, including pet data, stats, and other information.
License: By submitting content, you grant Clan of Pets a non-exclusive, royalty-free, worldwide license to use, distribute, modify, and display the content.

4. Services

Booking Services: Users can book various pet-related services through the App. We are not responsible for the quality of the services provided by third-party service providers.
Lost Pets: Users can register lost pets in the App. Clan of Pets does not guarantee the recovery of lost pets.

5. Privacy

Your use of the App is also governed by our Privacy Policy.

6. Termination

We may terminate or suspend your account and access to the App at our sole discretion, without prior notice, for conduct that we believe violates these Terms.

7. Limitation of Liability

Clan of Pets is not liable for any indirect, incidental, special, consequential, or punitive damages arising from your use of the App.

8. Changes to Terms

We may update these Terms from time to time. The updated Terms will be posted on the App, and your continued use of the App constitutes acceptance of the changes.

9. Contact Us

If you have any questions about these Terms, please contact us at +91 8921633521.''';
