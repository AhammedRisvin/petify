// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:clan_of_pets/app/core/string_const.dart';
import 'package:clan_of_pets/app/module/community/chat/view/chat_view.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/server_client_services.dart';
import '../../../../core/urls.dart';
import '../../../../helpers/common_widget.dart';
import '../../../../helpers/size_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';
import '../../widget/chats_more_group_containe.dart';
import '../../widget/community_chat_list_view.dart';
import '../model/listing_chats_model.dart';

class CommunityChatScreen extends StatefulWidget {
  const CommunityChatScreen({super.key});

  @override
  State<CommunityChatScreen> createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  StreamController<ListOfChatScreenModel> streamCtrl =
      StreamController.broadcast();

  Future<void> listAllChatsFn() async {
    try {
      List response = await ServerClient.get(
        Urls.getListOfChatsUrl,
      );
      if (response.first >= 200 && response.first < 300) {
        final model = ListOfChatScreenModel.fromJson(response.last);
        streamCtrl.add(model);
      } else {
        streamCtrl.add(ListOfChatScreenModel());
      }
    } catch (e) {
      streamCtrl.add(ListOfChatScreenModel());
    }
  }

  @override
  initState() {
    super.initState();
    listAllChatsFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: const commonTextWidget(
          text: "Chats",
          color: AppConstants.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          onPressed: () {
            Routes.back(context: context);
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppConstants.greyContainerBg,
            ),
          ),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 19,
            color: AppConstants.appPrimaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<ListOfChatScreenModel>(
                stream: streamCtrl.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible:
                            snapshot.data?.groupsWithoutMessages?.isNotEmpty ??
                                false,
                        child: const commonTextWidget(
                          color: AppConstants.black,
                          text: "More Groups",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizeBoxH(6),
                      Visibility(
                        visible:
                            snapshot.data?.groupsWithoutMessages?.isNotEmpty ??
                                false,
                        child: SizedBox(
                          // color: Colors.amber,
                          height: Responsive.height * 23,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              var chatsMoreData =
                                  snapshot.data?.groupsWithoutMessages?[index];
                              return ChatsMoreGroupContainer(
                                chatsMoreData: chatsMoreData,
                                onTap: () async {
                                  String userId = await StringConst.getUserID();
                                  Routes.push(
                                    context: context,
                                    screen: ChatView(
                                      communityId: chatsMoreData?.groupId ?? '',
                                      communityName:
                                          chatsMoreData?.groupName ?? '',
                                      userId: userId,
                                    ),
                                    exit: () {
                                      listAllChatsFn();
                                    },
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizeBoxV(10),
                            itemCount:
                                snapshot.data?.groupsWithoutMessages?.length ??
                                    0,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            StreamBuilder<ListOfChatScreenModel>(
              stream: streamCtrl.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Visibility(
                  visible:
                      snapshot.data?.groupsWithMessages?.isNotEmpty ?? false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizeBoxH(20),
                      const commonTextWidget(
                        color: AppConstants.black,
                        text: "Joined Groups",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizeBoxH(18),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          var joinedGroupsData =
                              snapshot.data?.groupsWithMessages?[index];
                          return communityChatListViewContainerWidget(
                            onTap: () async {
                              String userId = await StringConst.getUserID();
                              Routes.push(
                                context: context,
                                screen: ChatView(
                                  communityId: joinedGroupsData?.id ?? '',
                                  communityName:
                                      joinedGroupsData?.groupName ?? '',
                                  userId: userId,
                                ),
                                exit: () {
                                  listAllChatsFn();
                                },
                              );
                            },
                            joinedGroupsData: joinedGroupsData,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizeBoxH(17),
                        itemCount:
                            snapshot.data?.groupsWithMessages?.length ?? 0,
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
