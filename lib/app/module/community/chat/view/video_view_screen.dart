// ignore_for_file: must_be_immutable

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../../../../utils/app_constants.dart';
import '../../../../utils/app_router.dart';

class VideoPlayerScreen extends StatefulWidget {
  String videoUrl;

  VideoPlayerScreen({
    super.key,
    required this.videoUrl,
  });

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);


    try {
      // ignore: deprecated_member_use
      _controller = VideoPlayerController.network(
        widget.videoUrl,
      )..initialize().then((_) {
          setState(() {});
          _controller.play();
        });

      _chewieController = ChewieController(
        videoPlayerController: _controller,
        autoPlay: true,
        looping: true,
        allowPlaybackSpeedChanging: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppConstants.appPrimaryColor,
          handleColor: Colors.blue,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightGreen,
        ),
        placeholder: Container(
          color: Colors.black,
        ),
        autoInitialize: true,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(
                      _controller,
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
          Chewie(
            controller: _chewieController,
          ),
          Positioned(
            left: 20,
            top: 20,
            child: IconButton(
              onPressed: () {
                Routes.back(context: context);
              },
              icon: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                radius: 25,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
