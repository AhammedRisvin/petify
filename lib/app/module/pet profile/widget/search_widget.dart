import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../view model/pet_profile_provider.dart';

class SearchWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  final String hintText;
  final void Function()? onTap;
  final bool readOnly;
  const SearchWidget({
    super.key,
    this.onChanged,
    this.hintText = 'Search product',
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      height: Responsive.height * 6,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: AppConstants.greyContainerBg,
      ),
      child: TextField(
        readOnly: readOnly,
        controller:
            context.read<PetProfileProvider>().searchTextEditingController,
        onChanged: onChanged,
        onTap: onTap,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: const Icon(
            Icons.search,
            size: 18,
            color: AppConstants.subTextGrey,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            height: 4,
            color: AppConstants.subTextGrey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
