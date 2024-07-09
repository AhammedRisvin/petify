import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../../pet profile/view/events/create_events_screen.dart';
import '../model/pet_slot_model.dart';
import '../view_model/services_provider.dart';
import '../widget/check_box _widget.dart';
import '../widget/custom_drop_down_widget.dart';
import '../widget/select_pet_widget.dart';
import '../widget/slot_selecting-widget.dart';
import '../widget/terms_and_condition_selecting_widget.dart';
import '../widget/textformfield_eith_prefix.dart';
import '../widget/write_more_textformfield.dart';

class ServiceProvidersScreen extends StatefulWidget {
  final String clinicId;
  final String serviceId;
  final String serviceName;
  const ServiceProvidersScreen(
      {super.key,
      required this.clinicId,
      required this.serviceId,
      required this.serviceName});

  @override
  State<ServiceProvidersScreen> createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// dynamic controllers

  List<int> indexCont = [];

  @override
  void initState() {
    var serviceProvider = context.read<ServiceProvider>();
    serviceProvider.formatDate(DateTime.now());
    serviceProvider.getPetSlotFn(
        context: context,
        clinicId: widget.clinicId,
        serviceId: widget.serviceId,
        date: context.read<ServiceProvider>().today ?? "");

    serviceProvider.singleLineControllers.clear();
    super.initState();
    initializeControllers();
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();

    for (var element in context.read<ServiceProvider>().singleLineControllers) {
      element.controller.dispose();
    }

    super.dispose();
  }

  void initializeControllers() {
    final provider = Provider.of<ServiceProvider>(context, listen: false);
    for (var element in provider.petSlotModel.formData ?? []) {
      switch (element.name?.toLowerCase()) {
        case "singleline":
          indexCont.add(1);
          provider.singleLineControllers.add(ControllersIsUsed(
            name: element.label ?? "",
            controller: TextEditingController(),
            isUsed: false,
          ));
          break;
        case "multiline":
          indexCont.add(1);
          context
              .read<ServiceProvider>()
              .singleLineControllers
              .add(ControllersIsUsed(
                name: element.label ?? "",
                controller: TextEditingController(),
                isUsed: false,
              ));
          break;

        default:
          break;
      }
    }
  }

  void handleSubmitDta() {
    if (formKey.currentState?.validate() ?? false) {
      // Collect static field data
      final contactNumber = phoneController.text;
      final email = emailController.text;
      debugPrint("Contact Number: $contactNumber");
      debugPrint("Email: $email");
      for (var element
          in context.read<ServiceProvider>().singleLineControllers) {
        if (element.controller.text.isEmpty) {
          toast(
            context,
            title: " Please fill ${element.name} field",
            backgroundColor: Colors.red,
          );
          return;
        }
      }

      context.read<ServiceProvider>().bookSlotForServiceFn(
            context: context,
            serviceId: widget.serviceId,
            contactEmail: emailController.text,
            contactNumber: phoneController.text,
            clearControllers: () {
              phoneController.clear();
              emailController.clear();
              for (var element
                  in context.read<ServiceProvider>().singleLineControllers) {
                element.controller.clear();
              }
            },
          );
    } else {
      debugPrint("Form is not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: commonTextWidget(
          text: widget.serviceName,
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
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer<ServiceProvider>(
            builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectPetWidget(
                  provider: provider,
                  petList: provider.petSlotModel.pets,
                ),
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
                // CalenderWidget(
                //   provider: provider,
                //   clinicId: widget.clinicId,
                //   serviceId: widget.serviceId,
                // ),
                const SizeBoxH(10),
                SlotSelectingWidget(
                  morningList: provider.morningSlots,
                  afternoonList: provider.afternoonSlots,
                ),
                ...provider.petSlotModel.formData?.asMap().entries.map(
                      (MapEntry<int, FormDatum> entry) {
                        final index = entry.key;
                        final formData = entry.value;
                        switch (formData.name?.toLowerCase()) {
                          case "singleline":
                            return TextFormFieldWithPrefix(
                              controller:
                                  provider.singleLineControllers.firstWhere(
                                (element) {
                                  if (element.name == formData.label) {
                                    element.isUsed = true;
                                  }
                                  return element.name == formData.label;
                                },
                                orElse: () => ControllersIsUsed(
                                  name: formData.label ?? "",
                                  controller: TextEditingController(),
                                  isUsed: false,
                                ),
                              ).controller,
                              hintText: formData.instruction ?? "",
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.next,
                              prefixIcon: const Icon(
                                Icons.person,
                                color: AppConstants.black40,
                              ),
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return 'Please enter ${formData.label}';
                                }
                                return null;
                              },
                              title: formData.label ?? "",
                            );
                          // case "date":
                          //   return DateWidget(
                          //     formData: formData,
                          //     provider: provider,
                          //   );

                          // case "time":
                          //   return TimeWidget(
                          //     formData: formData,
                          //     provider: provider,
                          //   );

                          case "multiline":
                            return WriteMoreTextFormFieldWidget(
                              provider: provider,
                              controller:
                                  provider.singleLineControllers.firstWhere(
                                (element) {
                                  if (element.name == formData.label) {
                                    element.isUsed = true;
                                  }
                                  return element.name == formData.label;
                                },
                                orElse: () => ControllersIsUsed(
                                  name: formData.label ?? "",
                                  controller: TextEditingController(),
                                  isUsed: false,
                                ),
                              ).controller,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return 'Please enter ${formData.label}';
                                }
                                return null;
                              },
                            );
                          case "dropdown":
                            return CustomDropDownWidget(
                              provider: provider,
                              formData: formData,
                              dropDownIndex: index,
                            );
                          case "imageupload":
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizeBoxH(10),
                                commonTextWidget(
                                  text: formData.label ?? "",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppConstants.black,
                                ),
                                CommonFileSelectingContainer(
                                  text: provider.thumbnailImage == null
                                      ? formData.instruction
                                      : provider.imagePaths[
                                              formData.label ?? ""] ??
                                          "",
                                  onTap: () {
                                    provider.uploadSingleImage(
                                        label: formData.label ?? "",
                                        context: context);
                                  },
                                ),
                                const SizeBoxH(10),
                              ],
                            );

                          // case "radio":
                          //   return RadioButtonWidget(
                          //     provider: provider,
                          //     formData: formData,
                          //   );

                          case "checkbox":
                            return CheckboxListWidget(
                              provider: provider,
                              formData: formData,
                            );

                          default:
                            return const Text("No data");
                        }
                      },
                    ) ??
                    [],
                const TermsAndConditionSelectWidget(),
                const SizeBoxH(30),
                CommonButton(
                  isFullRoundedButton: true,
                  onTap: () {
                    handleSubmitDta();
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
      ),
    );
  }
}

class ControllersIsUsed {
  final String name;
  final TextEditingController controller;
  bool isUsed;
  ControllersIsUsed({
    required this.name,
    required this.controller,
    required this.isUsed,
  });
}
