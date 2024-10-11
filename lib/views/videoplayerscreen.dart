import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerScreen extends StatefulWidget {
  String urlvideo;

  VideoPlayerScreen({
    super.key,
    required this.urlvideo
  });


  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();

    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
        Uri.parse(widget.urlvideo),
      ),
      autoPlay: true
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    flickManager.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlickVideoPlayer(
        wakelockEnabled: true,
        // preferredDeviceOrientation: [
        //   DeviceOrientation.landscapeLeft,
        //   DeviceOrientation.landscapeRight
        // ],
        flickManager: flickManager,
      ),
    );
  }
}
