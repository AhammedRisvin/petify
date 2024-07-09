import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/extensions.dart';

class CrateExpenceScreen extends StatelessWidget {
  CrateExpenceScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        context.read<PetProfileProvider>().clearExpenceDataController();
      },
      child: Scaffold(
        backgroundColor: AppConstants.white,
        appBar: PreferredSize(
          preferredSize: Size(Responsive.width * 100, Responsive.height * 7),
          child: const CommonAppBarWidgets(
            text: "Create New Expenses",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeBoxH(Responsive.height * 2),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Please put the following information',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  SizeBoxH(Responsive.height * 3),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Expense name',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  CommonTextFormField(
                    controller: context
                        .read<PetProfileProvider>()
                        .expenceAddNameController,
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.name,
                    bgColor: const Color(0xffF3F3F5),
                    hintText: 'Expense name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter expense name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizeBoxH(Responsive.height * 3),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Expense Date',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  SizedBox(
                    height: 46,
                    child: Selector<PetProfileProvider, String>(
                      selector: (p0, p1) => p1.selectedAchivementDate,
                      builder: (context, value, child) => CommonTextFormField(
                        readOnly: true,
                        onTap: () => context
                            .read<PetProfileProvider>()
                            .expenceAddDateFun(context),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            AppImages.calenderIcon,
                            height: 16,
                            width: 16,
                          ),
                        ),
                        bgColor: AppConstants.greyContainerBg,
                        hintText: "Expense Date",
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        controller: context
                            .read<PetProfileProvider>()
                            .expenceDateController,
                      ),
                    ),
                  ),
                  SizeBoxH(Responsive.height * 3),
                  const commonTextWidget(
                    color: Colors.black,
                    text: 'Expense Amount',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  CommonTextFormField(
                    controller: context
                        .read<PetProfileProvider>()
                        .expenceAddAmountController,
                    textInputAction: TextInputAction.none,
                    keyboardType: TextInputType.number,
                    bgColor: const Color(0xffF3F3F5),
                    hintText: '871886186',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter expense amount';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizeBoxH(Responsive.height * 3),
                  CommonButton(
                    isFullRoundedButton: true,
                    height: Responsive.height * 6,
                    text: 'Save & Continue',
                    width: Responsive.width * 100,
                    bgColor: const Color(0XFFF6884F),
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<PetProfileProvider>()
                            .createNewPetExpenceFn(context: context);
                      }
                    },
                  ),
                  SizeBoxH(Responsive.height * 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
