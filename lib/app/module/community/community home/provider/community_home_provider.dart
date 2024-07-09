// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/server_client_services.dart';
import '../../../../core/urls.dart';
import '../../../../helpers/common_widget.dart';
import '../model/get_all_community_search_model.dart';
import '../model/get_community_home_model.dart';
import '../model/get_joined_community_search_model.dart';

class CommunityHomeProvider extends ChangeNotifier {
  Future communityJoinFun(
      {required BuildContext context,
      required String communityId,
      required void Function() function}) async {
    try {
      List response = await ServerClient.put(
        Urls.communityJoin + communityId,
        put: false,
      );

      if (response.first >= 200 && response.first < 300) {
        toast(
          context,
          title: response.last['message'],
          backgroundColor: Colors.green,
        );
        function();
      } else {
        toast(
          context,
          title: response.last,
          backgroundColor: Colors.red,
        );
        throw Exception('Failed to fetch posts');
      }
    } finally {
      notifyListeners();
    }
  }

  Future communityFeedLikeFun({
    required BuildContext context,
    required String communityId,
    required void Function() function,
  }) async {
    try {
      List response = await ServerClient.post(
        Urls.communityFeedLike + communityId,
        post: false,
      );
      if (response.first >= 200 && response.first < 300) {
        function();
      } else {
        toast(context, title: response.last, backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } finally {
      notifyListeners();
    }
  }

  TextEditingController communityFeedCommentController =
      TextEditingController();
  Future communityFeedCommentFun({
    required BuildContext context,
    required String feedId,
    required VoidCallback function,
  }) async {
    try {
      List response = await ServerClient.post(
        Urls.commentFeed + feedId,
        data: {
          "text": communityFeedCommentController.text,
        },
        post: true,
      );
      if (response.first >= 200 && response.first < 300) {
        communityFeedCommentController.clear();
        function();

        toast(
          context,
          title: response.last['message'],
          backgroundColor: Colors.green,
        );
      } else {
        toast(context, title: response.last, backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } finally {
      notifyListeners();
    }
  }

  void shareFeedUrl({
    required String videoUrl,
    required String subject,
  }) {
    Share.share(
      videoUrl,
      subject: subject,
    );
  }

  String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double result = number / 1000;
      if (result % 1 == 0) {
        return '${result.toInt()}K';
      } else {
        return '${result.toStringAsFixed(1)}K';
      }
    } else {
      double result = number / 1000000;
      if (result % 1 == 0) {
        return '${result.toInt()}M';
      } else {
        return '${result.toStringAsFixed(1)}M';
      }
    }
  }

  launchURL(String url) async {
    await launch(url);
  }

  void getJoinedCommunityList(List<Community> joinedGroups) {
    joinedCommunityFOundList = joinedGroups;
    notifyListeners();
  }

  TextEditingController joinedCommunitySearchCOntroller =
      TextEditingController();
  List<Community> joinedCommunityFOundList = [];
  int joinedCommunitySearchFnStatus = 0;
  joinedCommunitySearchFn({required String enteredKeyword}) async {
    joinedCommunitySearchFnStatus = 0;
    List<Community> results = [];

    results.clear();
    notifyListeners();
    try {
      if (enteredKeyword.isEmpty) {
        List<Community> searchedCommunityList = [];
        List response = await ServerClient.get(
          Urls.getCommunityHome,
        );
        GetCommunityHomeModel getCommunityHomeModel =
            GetCommunityHomeModel.fromJson(response.last);
        searchedCommunityList.clear();
        searchedCommunityList.addAll(getCommunityHomeModel.joinedGroups ?? []);

        results.clear();
        results.addAll(searchedCommunityList);
        joinedCommunitySearchFnStatus++;
        notifyListeners();
      } else if (enteredKeyword.length > 3) {
        List response = await ServerClient.get(
          Urls.fetchJoinedGroupsSearch + enteredKeyword,
        );
        if (response.first >= 200 && response.first < 300) {
          GetCommunitySearchModel getCommunitySearchModel =
              GetCommunitySearchModel.fromJson(response.last);
          results.addAll(getCommunitySearchModel.groups ?? []);
        }

        joinedCommunitySearchFnStatus++;
        notifyListeners();
      }

      joinedCommunityFOundList.clear();
      joinedCommunityFOundList.addAll(results);
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }

  TextEditingController allCommunitySearchCOntroller = TextEditingController();
  List<Group> allCommunityFOundList = [];
  int allCommunitySearchFnStatus = 0;
  bool allCommunityListEnded = false;
  int allCommunityCurrentPage = 1;
  allCommunitySearchFn(
      {required String enteredKeyword, int pageNum = 0}) async {
    allCommunitySearchFnStatus = 0;
    List<Group> resluts = [];

    resluts.clear();
    notifyListeners();
    try {
      if (enteredKeyword.isEmpty) {
        allCommunitySearchFnStatus = 0;
        allCommunityListEnded = false;
        String page = '';
        if (pageNum != 0) {
          page = pageNum.toString();
        } else {
          page = allCommunityCurrentPage.toString();
        }
        List response = await ServerClient.get(
            "${Urls.fetchAllGroups + enteredKeyword}&page=$page");
        if (response.first >= 200 && response.first < 300) {
          if (pageNum != 0) {
            GetAllCommunitySearchModel getAllCommunitySearchModel =
                GetAllCommunitySearchModel.fromJson(response.last);
            allCommunityCurrentPage = 2;
            resluts.clear();
            resluts.addAll(getAllCommunitySearchModel.groups ?? []);
            notifyListeners();
          } else {
            final getModel = GetAllCommunitySearchModel.fromJson(response.last);
            if (getModel.groups?.isEmpty ?? true) {
              allCommunityListEnded = true;
              notifyListeners();
            }

            resluts.clear();
            resluts.addAll(getModel.groups ?? []);
            allCommunityCurrentPage++;
            notifyListeners();
          }
          allCommunityFOundList.addAll(resluts);
          notifyListeners();
        } else {
          throw Exception('Failed to fetch posts');
        }
      } else if (enteredKeyword.length > 3) {
        List response = await ServerClient.get(
          Urls.fetchAllGroups + enteredKeyword,
        );
        if (response.first >= 200 && response.first < 300) {
          GetAllCommunitySearchModel getAllCommunitySearchModel =
              GetAllCommunitySearchModel.fromJson(response.last);
          resluts.clear();
          resluts.addAll(getAllCommunitySearchModel.groups ?? []);
        } else {}
        allCommunityFOundList.clear();
        allCommunityFOundList.addAll(resluts);
        allCommunitySearchFnStatus++;
        allCommunityCurrentPage = 1;
        notifyListeners();
      }
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }
}
