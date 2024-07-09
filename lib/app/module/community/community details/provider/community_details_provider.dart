// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../core/server_client_services.dart';
import '../../../../core/urls.dart';
import '../../../../helpers/common_widget.dart';

class CommunityDetailsProvider extends ChangeNotifier {
  bool isLeftGroup = false;
  void isUnJoinedCommunity() {
    isLeftGroup = true;
    notifyListeners();
  }

  Future communityLeftFun(
      {required BuildContext context,
      required String communityId,
      required void Function() function}) async {
    try {
      isLeftGroup = false;
      List response = await ServerClient.put(
          Urls.communityLeftGroup + communityId,
          put: false);

      if (response.first >= 200 && response.first < 300) {
        isLeftGroup = true;
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
        function();
      } else {
        isLeftGroup = false;
        toast(context, title: response.last, backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } finally {
      notifyListeners();
    }
  }

  Future communityJoinFun(
      {required BuildContext context,
      required String communityId,
    required void Function() function,
  }) async {

    try {
      List response =
          await ServerClient.put(Urls.communityJoin + communityId, put: false);
      if (response.first >= 200 && response.first < 300) {
        isLeftGroup = false;
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
        function();
      } else {
        isLeftGroup = true;
        toast(context, title: response.last, backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } finally {
      notifyListeners();
    }
  }
}
