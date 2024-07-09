// ignore_for_file: library_prefixes, use_full_hex_values_for_flutter_colors

import 'dart:async';

import 'package:clan_of_pets/app/helpers/common_widget.dart';
import 'package:clan_of_pets/app/helpers/size_box.dart';
import 'package:clan_of_pets/app/module/community/chat/view%20model/chat_provider.dart';
import 'package:clan_of_pets/app/utils/app_constants.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:clan_of_pets/app/utils/app_router.dart';
import 'package:clan_of_pets/app/utils/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../core/server_client_services.dart';
import '../../../../core/urls.dart';
import '../model/chat_model.dart';
import 'image_screen.dart';
import 'selected_media_view_screen.dart';
import 'video_view_screen.dart';

class ChatView extends StatefulWidget {
  final String communityId;
  final String userId;
  final String communityName;

  const ChatView({
    super.key,
    required this.communityId,
    required this.userId,
    required this.communityName,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  StreamController<List<MessageData>> streamCtrl = StreamController();
  final ScrollController scrollController = ScrollController();
  List<MessageData> allMessages = [];

  Future<void> fetchAllMessages() async {
    try {
      allMessages.clear();
      List response = await ServerClient.get(
        Urls.fetchAllMessages + widget.communityId,
      );
      if (response.first >= 200 && response.first < 300) {
        final model = FetchAllMessagesModel.fromJson(response.last);
        allMessages.addAll(model.message ?? []);
        streamCtrl.add(model.message ?? []);
      } else {
        streamCtrl.add([]);
      }
    } catch (e) {
      streamCtrl.add([]);
    }
  }

  bool isTyping = false;
  @override
  void initState() {
    //Connect to websocket
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeChat();
    });
  }

  void initializeChat() {
    fetchAllMessages();
    initializeSocketConnection();
    setUpChatRoom([widget.communityId, widget.userId]);
    setupJoinChatRoom(widget.userId);
    listenMessageEvent(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(ChatView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.communityId != widget.communityId ||
        oldWidget.userId != widget.userId) {
      allMessages.clear();
      streamCtrl.add([]);
      disconnectFromSocket();
      initializeChat();
    }
  }

  @override
  void dispose() {
    disconnectFromSocket();
    scrollController.dispose();
    streamCtrl.close();
    msgController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.white,
      //For pop button
      appBar: AppBar(
        backgroundColor: AppConstants.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonTextWidget(
              color: AppConstants.black,
              text: widget.communityName,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
            const commonTextWidget(
              color: AppConstants.black,
              text: "Chats",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.2,
            ),
          ],
        ),
        leading: IconButton(
          icon: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: AppConstants.greyContainerBg,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppConstants.appPrimaryColor,
              size: 14,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<List<MessageData>>(
          stream: streamCtrl.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            return Column(
              children: <Widget>[
                Expanded(
                  child: buildMessages(snapshot: snapshot),
                ),
                buildInput(),
              ],
            );
          }),
    );
  }

  Widget buildMessages({required AsyncSnapshot<List<MessageData>> snapshot}) {
    return ListView.separated(
        separatorBuilder: (context, index) => const SizeBoxH(10),
        controller: scrollController,
        itemCount: snapshot.data?.length ?? 0,
        itemBuilder: (context, index) {
          var messages = snapshot.data?[index];

          return Align(
            alignment: setMessageAlignment(
              messages?.sender?.id ?? "",
              widget.userId,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: messages?.sender?.id == widget.userId
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                messages?.sender?.id == widget.userId
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.all(10),
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: AppConstants.greyContainerBg,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: commonNetworkImage(
                          url: messages?.sender?.petShopUserDetails?.profile ==
                                      null ||
                                  messages?.sender?.petShopUserDetails?.profile
                                          ?.isEmpty ==
                                      true
                              ? "https://media.istockphoto.com/id/526947869/vector/man-silhouette-profile-picture.jpg?s=612x612&w=0&k=20&c=5I7Vgx_U6UPJe9U2sA2_8JFF4grkP7bNmDnsLXTYlSc="
                              : messages?.sender?.petShopUserDetails?.profile ??
                                  "",
                          height: 40,
                          width: 40,
                        ),
                      ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: messages?.sender?.id == widget.userId
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppConstants.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              messages?.sender?.id == widget.userId
                                  ? Text(
                                      context.read<ChatProvider>().formatTime(
                                            messages?.createdAt?.toLocal() ??
                                                DateTime.now(),
                                          ),
                                      style: const TextStyle(
                                        color: AppConstants.black40,
                                        fontSize: 12,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              const SizeBoxV(10),
                              messages?.sender?.name == null ||
                                      messages?.sender?.name?.isEmpty == true
                                  ? const Text('User')
                                  : Text(messages?.sender?.name ?? ''),
                              const SizeBoxV(10),
                              messages?.sender?.id == widget.userId
                                  ? const SizedBox.shrink()
                                  : Text(
                                      context.read<ChatProvider>().formatTime(
                                            messages?.createdAt?.toLocal() ??
                                                DateTime.now(),
                                          ),
                                      style: const TextStyle(
                                        color: AppConstants.black40,
                                        fontSize: 12,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizeBoxH(2),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xfffffb38a),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment:
                                    messages?.sender?.id == widget.userId
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.start,
                                children: [
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxWidth:
                                            250), // Adjust maxWidth as needed
                                    child: Text(
                                      messages?.content ?? '',
                                      style: const TextStyle(
                                        color: AppConstants.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizeBoxH(10),
                                  messages?.image == null ||
                                          messages?.image?.isEmpty == true
                                      ? const SizedBox.shrink()
                                      : CommonInkwell(
                                          onTap: () {
                                            if (messages?.ext == 'jpg' ||
                                                messages?.ext == 'jpeg' ||
                                                messages?.ext == 'jpeg' ||
                                                messages?.ext == 'png') {
                                              Routes.push(
                                                context: context,
                                                screen: ImageScreen(
                                                  profilePicUrl: messages
                                                      ?.sender
                                                      ?.petShopUserDetails
                                                      ?.profile,
                                                  content: messages?.content,
                                                  imageUrl: messages?.image,
                                                ),
                                                exit: () {},
                                              );
                                            } else if (messages?.ext == 'pdf') {
                                              context
                                                  .read<ChatProvider>()
                                                  .launchPDF(
                                                      messages?.image ?? '');

                                            } else if (messages?.ext == 'mp4' ||
                                                messages?.ext == 'mkv') {
                                              Routes.push(
                                                context: context,
                                                screen: VideoPlayerScreen(
                                                  videoUrl:
                                                      messages?.image ?? '',
                                                ),
                                                exit: () {},
                                              );
                                            }
                                          },
                                          child: messages?.ext == 'jpg' ||
                                                  messages?.ext == 'jpeg' ||
                                                  messages?.ext == 'jpeg' ||
                                                  messages?.ext == 'png'
                                              ? commonNetworkImage(
                                                  url: messages?.image ?? "",
                                                  height: 100,
                                                  width: Responsive.width * 75,
                                                  radius: 15,
                                                )
                                              : messages?.ext == 'pdf'
                                                  ? SizedBox(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20.0),
                                                        child: Image.network(
                                                          "https://logowik.com/content/uploads/images/adobe-pdf3324.jpg",
                                                          width: 100,
                                                        ),
                                                      ),
                                                    )
                                                  : messages?.ext == 'mp4' ||
                                                          messages?.ext == 'mkv'
                                                      ? SizedBox(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child:
                                                                Image.network(
                                                              "https://www.pngmart.com/files/1/Video-Icon-PNG-Transparent-Image.png",
                                                              width: 100,
                                                            ),
                                                          ),
                                                        )
                                                      : const SizedBox.shrink(),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                messages?.sender?.id != widget.userId
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.all(10),
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: AppConstants.greyContainerBg,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: commonNetworkImage(
                          url: messages?.sender?.petShopUserDetails?.profile ==
                                      null ||
                                  messages?.sender?.petShopUserDetails?.profile
                                          ?.isEmpty ==
                                      true
                              ? "https://media.istockphoto.com/id/526947869/vector/man-silhouette-profile-picture.jpg?s=612x612&w=0&k=20&c=5I7Vgx_U6UPJe9U2sA2_8JFF4grkP7bNmDnsLXTYlSc="
                              : messages?.sender?.petShopUserDetails?.profile ??
                                  "",
                          height: 40,
                          width: 40,
                        ),
                      ),
              ],
            ),
          );
        });
  }

  Widget buildInput() {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            margin:
                const EdgeInsets.only(bottom: 20, right: 10, left: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppConstants.black40,
              ),
            ),
            child: CommonTextFormField(
                bgColor: AppConstants.transparent,
                hintText: "Type a message...",
                hintTextColor: AppConstants.black,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                controller: msgController,
                onChanged: (value) {
                  setState(() {
                    isTyping = value.isNotEmpty;
                  });
                },
                prefixIcon: CommonInkwell(
                  onTap: () {
                    context.read<ChatProvider>().pickChatMedia(
                        context: context,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectedMediaViewScreen(
                                  onTap: (String? caption) {
                                    context.read<ChatProvider>().uploadFile(
                                        context: context,
                                        onTap: (String? url, String? ext) {
                                          sendMessageUsingMedia(
                                            widget.communityId,
                                            widget.userId,
                                            () {
                                              setState(() {});
                                            },
                                            caption ?? "",
                                            ext ?? '',
                                            url ?? '',
                                          );
                                        });
                                  },
                                );
                              },
                            ),
                          );
                        });
                  },
                  child: Image.asset(
                    AppImages.chatFilePickIcon,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    sendMessage(
                      widget.communityId,
                      widget.userId,
                      () {
                        setState(() {});
                        isTyping = false;
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.send,
                  ),
                )
      
                ),
          ),
     
        ],
      ),
    );
  }

  String _fetchBaseUrl() {
    switch (kDebugMode) {
      case true:
        return "http://10.0.2.2:3008"; 
      default:
        //Product host url
        return "https://test.api.ecom.theowpc.com";
    }
  }

  //Our socket object
  IO.Socket get socket => IO.io(
      _fetchBaseUrl(), IO.OptionBuilder().setTransports(['websocket']).build());

  void initializeSocketConnection() {
    try {
      socket.connect();
      socket.onConnect((_) {
      });
      socket.onDisconnect((_) {
      });
      socket.onError((error) {
      });
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  disconnectFromSocket() {
    socket.disconnect();
    socket.disconnect();
    socket.off("message received");
    socket.off("connect");
    socket.off("disconnect");
    socket.off("error");

    socket.onDisconnect(
      (data) {
        debugPrint("Websocket disconnected from $data");
      },
    );
  }

  //Sending data to any channel
  void webSocketSender(String eventName, dynamic body) {
    socket.emit(eventName, body);
  }

  void setUpChatRoom(List<String> ids) {
    final data = {
      "userId": ids[1],
      "communityId": ids[0],
    };
    socket.emit(
      "setup",
      data,
    );
  }

  void setupJoinChatRoom(String userId) {
    socket.emit(
      "join chat",
      userId,
    );
  }

  // List<MessageModel> messages = [];
  final TextEditingController msgController = TextEditingController();

  listenMessageEvent(VoidCallback setState) {
    socket.on("message received", (data) {
      final model = MessageData.fromJson(data);
      allMessages.add(model);
      streamCtrl.add(allMessages);
      setState();
    });
  }

  sendMessage(String chatId, String sender, VoidCallback setState) async {

    final data = {
      "sender": sender,
      "msg": msgController.text,
      "chatId": chatId,
      "appId": "6626011bd97238113acb1105",
    };
    webSocketSender("newMessage", data);
    //Reset input
    msgController.text = "";
    setState();
  }

  sendMessageUsingMedia(
    String chatId,
    String sender,
    VoidCallback setState,
    String caption,
    String ext,
    String image,
  ) async {

    final data = {
      "sender": sender,
      "msg": caption,
      "image": image,
      "ext": ext,
      "chatId": chatId,
      "appId": "6626011bd97238113acb1105",
    };
    webSocketSender("newMessage", data);
    //Reset input
    msgController.text = "";
    setState();
    Routes.back(context: context);
  }

  Alignment setMessageAlignment(String senderId, String userId) {
    switch (senderId == userId) {
      case true:
        return Alignment.topRight;
      case false:
        return Alignment.topLeft;
    }
  }
}
