import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VlcService {
  late final VlcPlayerController controller;

  VlcService(String url) {
    controller = VlcPlayerController.network(
      url,
      hwAcc: HwAcc.full,
      autoPlay: false,
      options: VlcPlayerOptions(),
      allowBackgroundPlayback: true,
    );

  }

  void pause() => controller.pause();
  void dispose() => controller.dispose();
  
 
  Future<void> stop() async {
    await controller.stop();
  }

  Future<void> play() async {
    await controller.play();
  }
}
