import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/extensions.dart';

class GetDocumentShimmerScreen extends StatelessWidget {
  const GetDocumentShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
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
              itemCount: 3,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppConstants.greyContainerBg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: commonTextWidget(
                        align: TextAlign.start,
                        color: AppConstants.black,
                        text: "Insurance",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: AppConstants.appCommonRed.withOpacity(.85),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: const Icon(
                            Icons.visibility,
                            color: AppConstants.white,
                            size: 18,
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
