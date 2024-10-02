import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  RxBool isVideoFinished = false.obs;

  Future<void> initializePlayer(String videoAsset) async {
    videoPlayerController = VideoPlayerController.asset(videoAsset);
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      fullScreenByDefault: true,
      showControls: false,
    );

    videoPlayerController.addListener(() {
      if (videoPlayerController.value.position ==
          videoPlayerController.value.duration) {
        isVideoFinished.value = true;
      }
    });
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.onClose();
  }
}
