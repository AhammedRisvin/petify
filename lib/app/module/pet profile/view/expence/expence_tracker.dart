import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:clan_of_pets/app/module/widget/empty_screen.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_router.dart';
import '../../../../utils/extensions.dart';
import '../../../widget/confirmation_widget.dart';
import '../../model/get_pet_expence_model.dart';
import 'create_new_expances.dart';

class ExpenceTrackerSCreen extends StatefulWidget {
  const ExpenceTrackerSCreen({
    super.key,
  });

  @override
  State<ExpenceTrackerSCreen> createState() => _ExpenceTrackerSCreenState();
}

class _ExpenceTrackerSCreenState extends State<ExpenceTrackerSCreen> {
  @override
  initState() {
    super.initState();
    context.read<PetProfileProvider>().getPetExpenceFun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.appPrimaryColor,
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Stack(
          children: [
            Container(
              height: Responsive.height * 38,
              width: Responsive.width * 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  onError: (exception, stackTrace) => const SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.image_not_supported,
                        size: 40,
                        color: Colors.grey,
                      )),
                  fit: BoxFit.fill,
                  image: const AssetImage(
                    'assets/images/ExpenceTracker.png',
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 27.0, left: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Routes.back(context: context);
                              },
                              style: ButtonStyle(
                                fixedSize:
                                    const WidgetStatePropertyAll(Size(4, 4)),
                                backgroundColor: WidgetStatePropertyAll(
                                  AppConstants.white.withOpacity(.5),
                                ),
                              ),
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 15,
                                color: AppConstants.appPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizeBoxV(10),
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: commonTextWidget(
                            text: "Expenses",
                            color: AppConstants.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 28,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                side:
                                    const BorderSide(color: AppConstants.white),
                                backgroundColor: AppConstants.transparent,
                                padding: const EdgeInsets.all(5)),
                            onPressed: () {
                              Routes.push(
                                context: context,
                                screen: CrateExpenceScreen(),
                                exit: () {},
                              );
                            },
                            icon: const Icon(
                              Icons.add,
                              color: AppConstants.white,
                              size: 17,
                            ),
                            label: const commonTextWidget(
                              align: TextAlign.start,
                              color: AppConstants.white,
                              text: "Create New",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizeBoxV(15)
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Responsive.height * 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const commonTextWidget(
                          text: "Total Expenses",
                          color: AppConstants.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                        SizeBoxH(Responsive.height * .1),
                        Selector<PetProfileProvider, int>(
                          selector: (p0, p1) => p1.getPetExpenceModelStatus,
                          builder: (context, getPetExpenceModelStatus, child) =>
                              getPetExpenceModelStatus == 0
                                  ? Shimmer.fromColors(
                                      baseColor: AppConstants.shimmerbaseColor!,
                                      highlightColor:
                                          AppConstants.shimmerhighlightColor!,
                                      child: const Center(
                                          child: CircularProgressIndicator()))
                                  : Selector<PetProfileProvider,
                                      GetPetExpenceModel>(
                                      selector: (p0, p1) =>
                                          p1.getPetExpenceModel,
                                      builder: (context, getPetExpenceModel,
                                              child) =>
                                          commonTextWidget(
                                        text:
                                            "AED ${getPetExpenceModel.totalExpenecs ?? ""}",
                                        color: AppConstants.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                        ),
                      ],
                    ),
                  ),
                  CommonInkwell(
                    onTap: () {
                      context
                          .read<PetProfileProvider>()
                          .selectDateRangeForExpenceFilter(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 55.0, left: Responsive.width * 80),
                      child: Container(
                          height: 35,
                          width: 35,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: AppConstants.white)),
                          child: Image.asset(
                            AppImages.calenderIcon,
                          )),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                height: Responsive.height * 62,
                width: Responsive.width * 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Selector<PetProfileProvider, int>(
                  selector: (p0, p1) => p1.getPetExpenceModelStatus,
                  builder: (context, getPetExpenceModelStatus, child) =>
                      getPetExpenceModelStatus == 0
                          ? Shimmer.fromColors(
                              baseColor: AppConstants.shimmerbaseColor!,
                              highlightColor:
                                  AppConstants.shimmerhighlightColor!,
                              child: GridView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 17 / 12,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8),
                                itemBuilder: (context, index) =>
                                    PetExpenceWidget(
                                  petExpence: Expence(
                                      amount: 100,
                                      currency: "AED",
                                      date: DateTime.now(),
                                      id: "fsjdgfjsdk",
                                      name: "vfksdgjvsdk",
                                      pet: "fv"),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: Responsive.height * 60,
                              child: Selector<PetProfileProvider,
                                  GetPetExpenceModel>(
                                selector: (p0, p1) => p1.getPetExpenceModel,
                                builder: (context, getPetExpenceModel, child) =>
                                    getPetExpenceModel.expences?.isEmpty ?? true
                                        ? EmptyScreenWidget(
                                            text: "No expenses found",
                                            image: AppImages.noBlogImage,
                                            height: Responsive.height * 1,
                                          )
                                        : MediaQuery.removePadding(
                                            context: context,
                                            removeTop: true,
                                            child: GridView.builder(
                                              itemCount: getPetExpenceModel
                                                      .expences?.length ??
                                                  0,
                                              scrollDirection: Axis.vertical,
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 17 / 12,
                                                      crossAxisSpacing: 8,
                                                      mainAxisSpacing: 8),
                                              itemBuilder: (context, index) {
                                                var petExpence =
                                                    getPetExpenceModel
                                                        .expences?[index];
                                                return PetExpenceWidget(
                                                  petExpence: petExpence,
                                                );
                                              },
                                            ),
                                          ),
                              ),
                            ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PetExpenceWidget extends StatelessWidget {
  final Expence? petExpence;
  const PetExpenceWidget({
    super.key,
    this.petExpence,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(
                0x1A000000), // Color with alpha value 1A, RGB values 00 for red, green, and blue
            blurRadius: 5,
          )
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(AppImages.datebg),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                child: Column(
                  children: [
                    commonTextWidget(
                      text: DateFormat('MMM')
                          .format(DateTime.parse("${petExpence?.date}")),
                      color: AppConstants.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    commonTextWidget(
                      text: DateFormat('dd')
                          .format(DateTime.parse("${petExpence?.date}")),
                      color: AppConstants.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              SizeBoxV(Responsive.width * 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonTextWidget(
                    text: petExpence?.name ?? "",
                    color: AppConstants.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      Image.asset(
                          height: 12, width: 15, AppImages.calenderPrimaryIcon),
                      commonTextWidget(
                        text:
                            " ${DateFormat('dd-MM-yyyy').format(DateTime.parse("${petExpence?.date}"))}",
                        color: AppConstants.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          SizeBoxH(Responsive.height * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonTextWidget(
                    text: "Expense",
                    color: AppConstants.black.withOpacity(.6),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                  commonTextWidget(
                    text:
                        "${petExpence?.currency ?? ""} ${petExpence?.amount ?? ""}",
                    color: AppConstants.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              CommonInkwell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationWidget(
                        title: "DELETE",
                        image: AppImages.deletePng,
                        message: "Are you sure you want to delete?",
                        onTap: () {
                          context
                              .read<PetProfileProvider>()
                              .deletePetExpenceFun(
                                  context, petExpence?.id ?? '');
                        },
                      );
                    },
                  );
                },
                child: Container(
                  width: 33,
                  height: 24,
                  decoration: BoxDecoration(
                      color: const Color(0xffEE5158).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40)),
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                      color: AppConstants.red, AppImages.deleteIcon),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
