import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/videos_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  //
  const VideoPlayerScreen(
      {Key? key,
      required this.videoItem,
      this.onEnterFullScreen,
      this.onExitFullScreen})
      : super(key: key);
  final VideoItem videoItem;
  final VoidCallback? onEnterFullScreen;
  final VoidCallback? onExitFullScreen;

  @override
  VideoPlayerScreenState createState() => VideoPlayerScreenState();
}

class VideoPlayerScreenState extends State<VideoPlayerScreen> {
  //
  late YoutubePlayerController _controller;
  late bool _isPlayerReady;
  bool _fullScreen = true;

  @override
  void initState() {
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      initialVideoId:
          widget.videoItem.video?.resourceId?.videoId ?? "pUUOOmoaMZM",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      //
    }
  }

  void listener() {
    setState(() {
      _fullScreen = _controller.value.isFullScreen;
    });
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _fullScreen
          ? null
          : AppBar(
              backgroundColor: Colors.black,
              centerTitle: true,
              title: Text(
                widget.videoItem.video?.title ?? "null",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
      body: SizedBox(
        height: double.infinity,
        child: YoutubePlayer(
          thumbnail: Image.asset(
            "assets/images/wstv_logo.png",
            height: 80,
            width: 80,
          ),
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            _isPlayerReady = true;
          },
        ),
      ),
    );
  }
}
