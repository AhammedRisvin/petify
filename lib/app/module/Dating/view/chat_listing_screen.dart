// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:clan_of_pets/app/core/string_const.dart';
import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/Dating/view%20model/dating_provider.dart';
import 'package:clan_of_pets/app/module/Dating/view/chat/view/chat_view_screen.dart';
import 'package:clan_of_pets/app/module/widget/empty_screen.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/server_client_services.dart';
import '../../../core/urls.dart';
import '../../../helpers/common_widget.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_router.dart';
import '../model/get_chats_model.dart';
import '../widget/dating_cahting_listing_widgte.dart';

class ChatListingScreen extends StatefulWidget {
  const ChatListingScreen({super.key});

  @override
  State<ChatListingScreen> createState() => _ChatListingScreenState();
}

class _ChatListingScreenState extends State<ChatListingScreen> {
  StreamController<GetChatsModel> streamController = StreamController();
  Future<void> getAllChatsFn() async {
    while (true) {
      try {
        List response = await ServerClient.get(
          Urls.getAllChats,
        );
        if (response.first >= 200 && response.first < 300) {
          final model = GetChatsModel.fromJson(response.last);
          streamController.add(model);
        } else {
          streamController.add(GetChatsModel());
        }
      } catch (e) {
        streamController.add(GetChatsModel());
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  void initState() {
    super.initState();
    getAllChatsFn();
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
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        leading: SizedBox(
          height: 30,
          width: 30,
          child: Center(
            child: IconButton(
              onPressed: () {
                Routes.back(context: context);
              },
              style: ButtonStyle(
                fixedSize: const WidgetStatePropertyAll(Size(4, 4)),
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
      ),
      body: StreamBuilder<GetChatsModel>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data?.chats?.isEmpty == true) {
              return EmptyScreenWidget(
                text: "No chats Found",
                image: AppImages.noBlogImage,
                height: Responsive.height * 80,
              );
            } else {
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final chat = snapshot.data?.chats?[index];
                  return DatingChatListingContainer(
                    data: chat,
                    onTap: () async {
                      String userId = await StringConst.getUserID();
                      Routes.push(
                        context: context,
                        screen: DatingChatView(
                          communityId: chat?.id ?? "",
                          userId: userId,
                          communityName: chat?.users?[0].name ?? "",
                        ),
                        exit: () {
                          context.read<DatingProvider>().getAllChatsFn();
                        },
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizeBoxH(10),
                itemCount: snapshot.data?.chats?.length ?? 0,
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: AppConstants.appPrimaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
