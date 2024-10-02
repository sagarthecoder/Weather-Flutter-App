import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';

import '../../Oauth/Login/Views/LoginScreen.dart';
import '../Manager/VideoController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String videoAsset = 'utils/videos/weather_splash_screen.mp4';
    final VideoController videoController = Get.put(VideoController());

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: FutureBuilder(
          future: videoController.initializePlayer(videoAsset),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Chewie(controller: videoController.chewieController),
                  Obx(() {
                    if (videoController.isVideoFinished.value) {
                      Future.microtask(() {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => decideDestination()),
                          (route) => false,
                        );
                      });
                    }
                    return const SizedBox.shrink(); // Placeholder widget
                  }),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget decideDestination() {
    return const LoginScreen();
  }
}
