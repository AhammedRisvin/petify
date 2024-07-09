// import 'package:clan_of_pets/app/utils/app_images.dart';
// import 'package:clan_of_pets/app/utils/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../helpers/common_widget.dart';
// import '../../../helpers/size_box.dart';
// import '../../../utils/app_constants.dart';
// import '../../../utils/app_router.dart';
// import '../view_model/appinfo_provider.dart';

// class AppInfoScreen extends StatelessWidget {
//   const AppInfoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         width: Responsive.width * 100,
//         height: Responsive.height * 100,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(AppImages.appInfobg), fit: BoxFit.cover),
//         ),
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 AppBar(
//                   backgroundColor: Colors.transparent,
//                   title: const commonTextWidget(
//                     text: "App Help",
//                     color: AppConstants.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   leading: IconButton(
//                     onPressed: () {
//                       Routes.back(context: context);
//                     },
//                     style: const ButtonStyle(
//                       backgroundColor: MaterialStatePropertyAll(
//                         AppConstants.greyContainerBg,
//                       ),
//                     ),
//                     icon: const Icon(
//                       Icons.arrow_back_ios_new,
//                       size: 19,
//                       color: AppConstants.appPrimaryColor,
//                     ),
//                   ),
//                 ),
//                 SizeBoxH(Responsive.height * 23),
//                 Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 20),
//                   width: Responsive.width * 100,
//                   decoration: const BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                         color:
//                             Color(0x1A000000), // Alpha value 1A in hexadecimal
//                         offset: Offset(0, 1),
//                         blurRadius: 5,
//                         spreadRadius: 0,
//                       )
//                     ],
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(20),
//                     ),
//                     color: Color(0xffFFFFFF),
//                   ),
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const commonTextWidget(
//                         color: Colors.black,
//                         text: 'Please put the following information below',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 15,
//                       ),
//                       SizeBoxH(Responsive.height * 3),
//                       const commonTextWidget(
//                         color: Colors.black,
//                         text: 'Name',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 15,
//                       ),
//                       SizeBoxH(Responsive.height * 1),
//                       CommonTextFormField(
//                         controller: context.read<AppInfoProvider>().controller,
//                         textInputAction: TextInputAction.none,
//                         keyboardType: TextInputType.name,
//                         bgColor: const Color(0xffffffff),
//                         hintText: 'Name',
//                       ),
//                       SizeBoxH(Responsive.height * 1),
//                       const commonTextWidget(
//                         color: Colors.black,
//                         text: 'Email',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 15,
//                       ),
//                       SizeBoxH(Responsive.height * 1),
//                       CommonTextFormField(
//                         controller: context.read<AppInfoProvider>().controller,
//                         textInputAction: TextInputAction.none,
//                         keyboardType: TextInputType.name,
//                         bgColor: const Color(0xffffffff),
//                         hintText: 'Missing',
//                       ),
//                       SizeBoxH(Responsive.height * 1),
//                       const commonTextWidget(
//                         color: Colors.black,
//                         text: 'Message',
//                         fontWeight: FontWeight.w400,
//                         fontSize: 15,
//                       ),
//                       SizeBoxH(Responsive.height * 1),
//                       CommonTextFormField(
//                         controller: context.read<AppInfoProvider>().controller,
//                         textInputAction: TextInputAction.none,
//                         keyboardType: TextInputType.name,
//                         bgColor: const Color(0xffffffff),
//                         hintText: 'Message',
//                       ),
//                       SizeBoxH(Responsive.height * 1),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               const CircleAvatar(
//                                 radius: 10,
//                                 backgroundColor: Color(0xffFBC5AE),
//                                 child: Icon(
//                                   Icons.phone,
//                                   color: Colors.white,
//                                   size: 12,
//                                 ),
//                               ),
//                               SizeBoxV(Responsive.width * 2),
//                               const commonTextWidget(
//                                 color: Colors.black,
//                                 text: '+97 344 576 90',
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 12,
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               const commonTextWidget(
//                                 color: Colors.black,
//                                 text: '+97 344 576 90',
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 12,
//                               ),
//                               SizeBoxV(Responsive.width * 2),
//                               const CircleAvatar(
//                                 radius: 10,
//                                 backgroundColor: Color(0xffFBC5AE),
//                                 child: Icon(
//                                   Icons.email,
//                                   color: Colors.white,
//                                   size: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizeBoxH(Responsive.height * 2)
//                     ],
//                   ),
//                 ),
//                 SizeBoxH(Responsive.height * 8),
//                 const commonTextWidget(
//                   color: Colors.black,
//                   text: 'Follow us on',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                 ),
//                 SizeBoxH(Responsive.height * 1.5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       AppImages.x,
//                       color: AppConstants.appPrimaryColor,
//                     ),
//                     SizeBoxV(Responsive.width * 2),
//                     Image.asset(AppImages.facebook),
//                     SizeBoxV(Responsive.width * 2),
//                     Image.asset(AppImages.linkdin),
//                     SizeBoxV(Responsive.width * 2),
//                     Image.asset(AppImages.instegram),
//                   ],
//                 )
//               ],
//             ),
//             Positioned(
//               bottom: Responsive.height * 18,
//               left: Responsive.width * 40,
//               right: Responsive.width * 40,
//               child: Container(
//                 width: Responsive.width * 8,
//                 height: Responsive.height * 8,
//                 decoration: const ShapeDecoration(
//                   color: AppConstants.appPrimaryColor,
//                   shape: CircleBorder(),
//                   shadows: [
//                     BoxShadow(
//                       color: Color(0xffFBC5AE),
//                       offset: Offset(0, 1),
//                       blurRadius: 5,
//                       spreadRadius: 4,
//                     )
//                   ],
//                 ),
//                 padding: const EdgeInsets.only(left: 6, bottom: 5),
//                 alignment: Alignment.center,
//                 child: Transform.rotate(
//                     angle: 5.600,
//                     alignment: Alignment
//                         .center, // Specify the alignment of the transformation
//                     origin: Offset.zero,
//                     child: const Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 30,
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
