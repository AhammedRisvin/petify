import 'package:clan_of_pets/app/module/pet%20profile/model/pet_document_model.dart';
import 'package:clan_of_pets/app/module/pet%20profile/view/documents/add_new_document_screen.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../view model/pet_profile_provider.dart';
import 'get_document_shimmer.dart';

class PetDocumentsScreen extends StatefulWidget {
  const PetDocumentsScreen({super.key});

  @override
  State<PetDocumentsScreen> createState() => _PetDocumentsScreenState();
}

class _PetDocumentsScreenState extends State<PetDocumentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PetProfileProvider>().getPetDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Documents",
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
        actions: [
          SizedBox(
            height: 35,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppConstants.greyContainerBg,
                  padding: const EdgeInsets.all(8)),
              onPressed: () {
                Routes.push(
                  context: context,
                  screen: AddNewPetDocumentScreen(),
                  exit: () {},
                );
              },
              icon: const Icon(
                Icons.add,
                color: AppConstants.appPrimaryColor,
                size: 18,
              ),
              label: const commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.appPrimaryColor,
                text: "Create New",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizeBoxV(Responsive.width * 4),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Selector<PetProfileProvider, int>(
          selector: (p0, p1) => p1.getPetDocumentsStatus,
          builder: (context, value, child) => value == 0
              ? const GetDocumentShimmerScreen()
              : SingleChildScrollView(
                  child: Selector<PetProfileProvider, GetPetDocumentModel>(
                    selector: (p0, p1) => p1.getPetDocumentModel,
                    builder: (context, petDocumentModel, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const commonTextWidget(
                          align: TextAlign.start,
                          color: AppConstants.black,
                          text: "Upload A New\nDocuments",
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                        SizeBoxH(Responsive.height * 1),
                        const commonTextWidget(
                          align: TextAlign.start,
                          color: AppConstants.subTextGrey,
                          text:
                              """Please upload the following files about your pet\n(Supported file format png,jpeg only)""",
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        SizeBoxH(Responsive.height * 2),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: petDocumentModel.documents?.length ?? 0,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            var document = petDocumentModel.documents?[
                                (petDocumentModel.documents?.length ?? 0) -
                                    1 -
                                    index];
                            return Selector<PetProfileProvider, int>(
                              selector: (p0, p1) => p1.backgroundColor,
                              builder: (context, value, child) => CommonInkwell(
                                onTap: () => context
                                    .read<PetProfileProvider>()
                                    .changeColor(index),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: value == index
                                        ? AppConstants.appCommonRed
                                        : AppConstants.greyContainerBg,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: commonTextWidget(
                                          align: TextAlign.start,
                                          color: value == index
                                              ? AppConstants.white
                                              : AppConstants.black,
                                          text: document?.title ?? "",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: CommonInkwell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    buttonPadding:
                                                        const EdgeInsets.all(0),
                                                    contentPadding:
                                                        const EdgeInsets.all(0),
                                                    content: SizedBox(
                                                      width:
                                                          Responsive.width * 90,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const SizeBoxH(20),
                                                            ListView.builder(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemCount: document
                                                                      ?.documents
                                                                      ?.length ??
                                                                  0,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                var imag = document
                                                                            ?.documents?[
                                                                        index] ??
                                                                    '';

                                                                return imag.endsWith('.jpg') ||
                                                                        imag.endsWith(
                                                                            '.jpeg') ||
                                                                        imag.endsWith(
                                                                            '.png') ||
                                                                        imag.endsWith(
                                                                            '.webp')
                                                                    ? commonNetworkImage(
                                                                        radius:
                                                                            0,
                                                                        isTopCurved:
                                                                            true,
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius.circular(
                                                                                0)),
                                                                        url:
                                                                            imag,
                                                                        height:
                                                                            Responsive.height *
                                                                                35,
                                                                        width: Responsive.width *
                                                                            35)
                                                                    : imag.endsWith(
                                                                            '.pdf')
                                                                        ? SizedBox(
                                                                            height:
                                                                                Responsive.height * 65,
                                                                            width:
                                                                                Responsive.width * 85,
                                                                            child:
                                                                                PDFView(
                                                                              enableSwipe: true,
                                                                              swipeHorizontal: true,
                                                                              autoSpacing: false,
                                                                              pageFling: false,
                                                                              filePath: imag,
                                                                            ),
                                                                          )
                                                                        : const SizedBox
                                                                            .shrink();
                                                              },
                                                            ),
                                                            const SizeBoxH(20),
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: AppConstants
                                                                        .bgBrown,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30)),
                                                                height: Responsive
                                                                        .height *
                                                                    5,
                                                                width: Responsive
                                                                        .width *
                                                                    85,
                                                                child: Center(
                                                                  child: commonTextWidget(
                                                                      color: AppConstants
                                                                          .white,
                                                                      text: document
                                                                              ?.title ??
                                                                          ''),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizeBoxH(20),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: value == index
                                                    ? AppConstants.white
                                                        .withOpacity(.25)
                                                    : AppConstants.appCommonRed
                                                        .withOpacity(.85),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(6),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.visibility,
                                                color: AppConstants.white,
                                                size: 18,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  String getUrlType(String url) {
    if (url.endsWith('.jpg') || url.endsWith('.jpeg') || url.endsWith('.png')) {
      return 'image';
    } else if (url.endsWith('.pdf')) {
      return 'pdf';
    } else {
      return 'unknown';
    }
  }
}
