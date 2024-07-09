// import 'package:clan_of_pets/app/module/Pet%20services/model/pet_slot_model.dart';
// import 'package:clan_of_pets/app/module/Pet%20services/view_model/services_provider.dart';
// import 'package:flutter/material.dart';

// import '../../../helpers/common_widget.dart';
// import '../../../helpers/size_box.dart';
// import '../../../utils/app_constants.dart';
// import '../../../utils/extensions.dart';

// class CustomRadioButtonWidget extends StatelessWidget {
//   const CustomRadioButtonWidget({
//     super.key,
//     required this.index,
//     required this.valueText,
//     this.onTap,
//     required this.section,
//     required this.selectedValue,
//     required this.provider,
//   });
//   final void Function()? onTap;
//   final int index;
//   final String selectedValue;
//   // final ServiceProvider provider;
//   final String valueText;
//   final String section;

//   @override
//   Widget build(BuildContext context) {
//     return CommonInkwell(
//       onTap: () {
//         provider.selectedValueRadioFn(section, valueText);
//       },
//       child: SizedBox(
//         width: 60,
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: AppConstants.appPrimaryColor,
//               radius: Responsive.height * 1.5,
//               child: CircleAvatar(
//                 backgroundColor: const Color(0xffffffff),
//                 radius: Responsive.height * 1.2,
//                 child: CircleAvatar(
//                   backgroundColor: selectedValue == valueText
//                       ? AppConstants.appPrimaryColor
//                       : AppConstants.transparent,
//                   radius: Responsive.height * 0.9,
//                 ),
//               ),
//             ),
//             const SizeBoxV(10),
//             commonTextWidget(
//               color: AppConstants.black,
//               text: valueText,
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RadioButtonWidget extends StatelessWidget {
//   final ServiceProvider provider;
//   final FormDatum formData;

//   const RadioButtonWidget({
//     super.key,
//     required this.provider,
//     required this.formData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizeBoxH(10),
//         commonTextWidget(
//           color: AppConstants.black,
//           text: formData.label ?? '',
//           fontSize: 18,
//           fontWeight: FontWeight.w500,
//         ),
//         const SizeBoxH(10),
//         ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             final choices = formData.choices?[index];
//             return CustomRadioButtonWidget(
//               section: formData.label ?? '',
//               provider: provider,
//               index: index,
//               valueText: choices ?? '',
//               selectedValue: provider.getSelectedValue(formData.label ?? ''),
//             );
//           },
//           separatorBuilder: (context, index) => const SizeBoxH(10),
//           itemCount: formData.choices?.length ?? 0,
//         ),
//       ],
//     );
//   }
// }
