import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../events/create_events_screen.dart';

class AddNewPetDocumentScreen extends StatelessWidget {
  AddNewPetDocumentScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Add document",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
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
      body: Container(
        padding: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const commonTextWidget(
                  align: TextAlign.start,
                  color: AppConstants.black,
                  text: "Upload your documents",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                Selector<PetProfileProvider, String>(
                  selector: (p0, p1) => p1.picked,
                  builder: (context, value, child) =>
                      CommonFileSelectingContainer(
                    text: value,
                    onTap: () async {
                      context.read<PetProfileProvider>().pickDocumentFile(
                          context: context, isAddDocument: true);
                    },
                  ),
                ),
                SizeBoxH(Responsive.height * 1),
                const commonTextWidget(
                  color: AppConstants.black,
                  text: "Title",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizeBoxH(Responsive.height * 1),
                SizedBox(
                  child: CommonTextFormField(
                    bgColor: AppConstants.greyContainerBg,
                    hintText: "title",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter document title';
                      } else {
                        return null;
                      }
                    },
                    controller: context
                        .read<PetProfileProvider>()
                        .documentTitleController,
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                CommonButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (context
                            .read<PetProfileProvider>()
                            .uploadedPetDocumentUrls
                            .isNotEmpty) {
                          context
                              .read<PetProfileProvider>()
                              .createPetDocument(context: context);
                        } else {
                          toast(context,
                              title: 'Please upload image of the document');
                        }
                      }
                    },
                    isFullRoundedButton: true,
                    text: "Save & Continue",
                    width: Responsive.width * 100,
                    height: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
