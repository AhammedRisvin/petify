import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../helpers/size_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../../../utils/extensions.dart';
import '../view_model/services_provider.dart';

class FilterBottomSheetWidget extends StatelessWidget {
  const FilterBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceProvider>(
      builder: (context, value, child) => SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          width: Responsive.width * 100,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          decoration: const BoxDecoration(
            color: AppConstants.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const commonTextWidget(
                    color: AppConstants.black,
                    text: "Filter by",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                    onPressed: () {
                      Routes.back(context: context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppConstants.black,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: AppConstants.black10,
              ),
              const SizeBoxH(10),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final name = value.filterByNames[index];
                    final isSelected = value.selectedFilterByIndex == name;
                    return CommonInkwell(
                      onTap: () {
                        value.updateFilterByIndex(name);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected
                              ? AppConstants.appPrimaryColor
                              : AppConstants.transparent,
                          border: Border.all(
                            color: isSelected
                                ? AppConstants.transparent
                                : AppConstants.black10,
                          ),
                        ),
                        child: Center(
                          child: commonTextWidget(
                            color: isSelected
                                ? AppConstants.white
                                : AppConstants.black,
                            text: name,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizeBoxV(15),
                  itemCount: value.filterByNames.length,
                ),
              ),
              const SizeBoxH(10),
              value.buildFilterContent(value, context),
              const SizeBoxH(10),
              Row(
                children: [
                  Expanded(
                    child: CommonButton(
                      height: Responsive.height * 7,
                      width: Responsive.width * 40,
                      text: "Clear Filter",
                      onTap: () {},
                      size: 12,
                      bgColor: AppConstants.transparent,
                      borderColor: AppConstants.appPrimaryColor,
                      textColor: AppConstants.appPrimaryColor,
                    ),
                  ),
                  const SizeBoxV(10),
                  Expanded(
                    child: CommonButton(
                      height: Responsive.height * 7,
                      width: Responsive.width * 40,
                      text: "Apply",
                      onTap: () {},
                      bgColor: AppConstants.appPrimaryColor,
                      textColor: AppConstants.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
