// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/server_client_services.dart';
import '../../../../core/urls.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../utils/app_router.dart';
import '../../create community/provider/create_community_provider.dart';

class CreateFeedProvider extends ChangeNotifier {
  TextEditingController creteFeedCaptionController = TextEditingController();

  TextEditingController communityLinkController = TextEditingController();

  Future createFeedFn(
      {required BuildContext context, required String communityId}) async {
    if (creteFeedCaptionController.text.isEmpty ||
        context.read<CreateCommunityProvider>().singleImageUr.isEmpty) {
      toast(context,
          title: "Please provide required details",
          backgroundColor: Colors.red);
    } else {
      try {
        List response = await ServerClient.post(
          Urls.createCommunityFeed,
          data: {
            "groupId": communityId,
            "caption": creteFeedCaptionController.text,
            "post": context.read<CreateCommunityProvider>().singleImageUr,
            "link": communityLinkController.text
          },
        );
        if (response.first >= 200 && response.first < 300) {
          creteFeedCaptionController.clear();
          communityLinkController.clear();
          context.read<CreateCommunityProvider>().singleImageUr = '';
          context.read<CreateCommunityProvider>().imageTitle = null;
          context.read<CreateCommunityProvider>().thumbnailImage = null;
          Routes.back(context: context);
          toast(
            context,
            title: "Feed Created Successfully",
            backgroundColor: Colors.green,
          );
        } else {
          toast(context,
              title: response.last["message"], backgroundColor: Colors.red);
          throw Exception('Failed to fetch posts');
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        notifyListeners();
      }
    }
  }
}
