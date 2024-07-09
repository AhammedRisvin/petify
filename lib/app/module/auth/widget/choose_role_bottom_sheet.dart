import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extensions.dart';
import '../view model/auth_provider.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({
    super.key,
    required this.roles,
    required this.isUserAccount,
    required this.userId,
  });

  final List roles;
  final bool isUserAccount;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Choose Account",
          color: AppConstants.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: roles.length + 1,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20);
              },
              itemBuilder: (context, index) {
                if (index == 0) {
                  return isUserAccount
                      ? _buildRoleItem(
                          petRole: "User",
                          ownerName: "Your Account",
                          ownerId: "",
                          context: context,
                          isFromUser: true,
                          userId: userId)
                      : _buildCreateAccountItem(
                          petRole: "User",
                          context: context,
                        );
                }
                final role = roles[index - 1];
                return _buildRoleItem(
                  petRole: role['petRole'],
                  ownerName: role['ownerName'],
                  ownerId: role['ownerId'],
                  context: context,
                  isFromUser: false,
                  userId: userId,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleItem({
    required String petRole,
    required String ownerName,
    required ownerId,
    required BuildContext context,
    required bool isFromUser,
    required String userId,
  }) {
    return GestureDetector(
      onTap: () {
        if (isFromUser) {
          log("isFromUser  $isFromUser");
          context.read<AuthProvider>().changeCurrentRoleFn(
                context: context,
                petRole: petRole,
                ownerId: ownerId,
                isUser: true,
                userId: userId,
              );
        } else {
          log("isFromUser  $isFromUser");
          context.read<AuthProvider>().changeCurrentRoleFn(
                context: context,
                petRole: petRole,
                ownerId: ownerId,
                isUser: false,
                userId: '',
              );
        }
      },
      child: Container(
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          color: AppConstants.white,
          border: Border.all(color: AppConstants.black10),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppConstants.black.withOpacity(0.1),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.black,
                text: "Continue as $petRole of $ownerName",
                maxLines: 3,
                overFlow: TextOverflow.ellipsis,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppConstants.appPrimaryColor,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCreateAccountItem({
    required String petRole,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        context.read<AuthProvider>().changeCurrentRoleFn(
              context: context,
              petRole: petRole,
              ownerId: "",
              isUser: true,
              userId: userId,
            );
      },
      child: Container(
        width: Responsive.width * 100,
        decoration: BoxDecoration(
          color: AppConstants.white,
          border: Border.all(color: AppConstants.black10),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppConstants.black.withOpacity(0.01),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: commonTextWidget(
                align: TextAlign.start,
                color: AppConstants.black,
                text: "Create your account",
                maxLines: 3,
                overFlow: TextOverflow.ellipsis,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppConstants.appPrimaryColor,
            )
          ],
        ),
      ),
    );
  }
}
