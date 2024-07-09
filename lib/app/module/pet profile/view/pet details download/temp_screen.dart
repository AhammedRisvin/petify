import 'dart:io';

import 'package:clan_of_pets/app/module/pet%20profile/view%20model/pet_profile_provider.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_constants.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Center(
          child: Image.file(
            context.read<PetProfileProvider>().file ??
                File(
                  "",
                ),
            height: 300,
          ),
        ),
      ),
    );
  }
}
