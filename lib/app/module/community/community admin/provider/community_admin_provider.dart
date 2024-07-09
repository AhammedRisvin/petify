// ignore_for_file: use_build_context_synchronously

import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/server_client_services.dart';
import '../../../../core/urls.dart';
import '../../../../utils/app_router.dart';
import '../../create community/provider/create_community_provider.dart';
import '../model/get_community_admin_model.dart';
import '../model/get_members_search_model.dart';

class CommunityAdminProvider extends ChangeNotifier {
  GetCommunityAdminModel getCommunityAdminModel = GetCommunityAdminModel();
  int getCommunityAdminModelStatus = 0;

  Future<void> getCommunityAdminHomeFun(String communityId) async {
    try {
      getCommunityAdminModelStatus = 0;
      List response =
          await ServerClient.get(Urls.adminCommunityDetail + communityId);
      if (response.first >= 200 && response.first < 300) {
        getCommunityAdminModel = GetCommunityAdminModel.fromJson(response.last);
        communityMembersFoundList.clear();
        communityMembersFoundList
            .addAll(getCommunityAdminModel.message?.groupDetails?.users ?? []);
        notifyListeners();
      } else {
        communityMembersFoundList = [];
      }
    } catch (e) {
      communityMembersFoundList = [];
      debugPrint(e.toString());
    } finally {
      getCommunityAdminModelStatus++;
      notifyListeners();
    }
  }

  void getCommunityMembersList(List<UserElement> joinedGroups) {
    communityMembersFoundList.clear();
    communityMembersFoundList = joinedGroups;
    notifyListeners();
  }

  TextEditingController communityMembersSearchCOntroller =
      TextEditingController();
  List<UserElement> communityMembersFoundList = [];
  int communityMembersSearchFnStatus = 0;
  getCommunityMembersListSearchFn(
      {required String enteredKeyword, required String communityId}) async {
    communityMembersSearchFnStatus = 0;
    List<UserElement> resluts = [];

    resluts.clear();
    notifyListeners();
    try {
      if (enteredKeyword.isEmpty) {
        List<UserElement> searchedCommunityList = [];
        List response =
            await ServerClient.get(Urls.adminCommunityDetail + communityId);
        GetCommunityAdminModel getCommunityAdminModel =
            GetCommunityAdminModel.fromJson(response.last);
        searchedCommunityList.clear();
        searchedCommunityList
            .addAll(getCommunityAdminModel.message?.groupDetails?.users ?? []);

        ///////

        resluts.clear();
        resluts.addAll(searchedCommunityList);
        communityMembersSearchFnStatus++;
        notifyListeners();
      } else if (enteredKeyword.length > 3) {
        List response = await ServerClient.get(
          "${Urls.searchCommunityGroupMembers + communityId}?keyword=$enteredKeyword",
        );
        if (response.first >= 200 && response.first < 300) {
          GetCommunityMemebersSearchModel getCommunitySearchModel =
              GetCommunityMemebersSearchModel.fromJson(response.last);
          resluts.clear();
          resluts.addAll(getCommunitySearchModel.users ?? []);
          notifyListeners();
        } else {
          communityMembersFoundList = [];
          //  toast(context,)
        }

        communityMembersSearchFnStatus++;
        notifyListeners();
      }
      communityMembersFoundList.clear();
      communityMembersFoundList.addAll(resluts);
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      communityMembersFoundList = [];
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }

  Future<void> removeUserFromCommunity({
    required String memberId,
    required BuildContext context,
    required String communityId,
  }) async {
    try {
      var data = {"userId": memberId};
      List response = await ServerClient.put(
          Urls.removeUserFromGroup + communityId,
          put: true,
          data: data);
      if (response.first >= 200 && response.first < 300) {
        toast(context,
            title: response.last['message'].toString(),
            backgroundColor: Colors.green);
        await getCommunityAdminHomeFun(communityId);

        notifyListeners();
      } else {
        toast(context, title: response.last, backgroundColor: Colors.red);
        notifyListeners();
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Failed to fetch posts');
    } finally {
      notifyListeners();
    }
  }

  TextEditingController communityNamerController = TextEditingController();

  TextEditingController communityDescriptionController =
      TextEditingController();

  Future updateCommunityFn({
    required BuildContext context,
    required String communityId,
  }) async {
    try {
      var data = {
        "groupName": communityNamerController.text,
        "groupDescription": communityDescriptionController.text,
        "groupProfileImage":
            context.read<CreateCommunityProvider>().singleImageUr,
        "groupCoverImage": context.read<CreateCommunityProvider>().coverImageUr
      };
      List response = await ServerClient.put(
        Urls.editCommunityUrl + communityId,
        put: true,
        data: data,
      );
      if (response.first >= 200 && response.first < 300) {
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);
        communityNamerController.clear();
        communityDescriptionController.clear();
        context.read<CreateCommunityProvider>().singleImageUr = '';
        context.read<CreateCommunityProvider>().coverImageUr = '';
        context.read<CreateCommunityProvider>().imageTitle = null;
        context.read<CreateCommunityProvider>().coverImageTitle = null;
        context.read<CreateCommunityProvider>().thumbnailImage = null;
        getCommunityAdminHomeFun(communityId);
        Routes.back(context: context);
      } else {
        toast(context,
            title: response.last["message"], backgroundColor: Colors.red);
        throw Exception('Failed to fetch posts');
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteCommunity({
    required BuildContext context,
    required String communityId,
  }) async {
    try {
      List response = await ServerClient.put(
        Urls.deleteCommunity + communityId,
        put: false,
      );
      if (response.first >= 200 && response.first < 300) {
        List response =
            await ServerClient.get(Urls.adminCommunityDetail + communityId);
        Routes.back(context: context);
        Routes.back(context: context);
        toast(context,
            title: response.last['message'], backgroundColor: Colors.green);

        notifyListeners();
      } else {
        toast(context, title: response.last, backgroundColor: Colors.red);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
