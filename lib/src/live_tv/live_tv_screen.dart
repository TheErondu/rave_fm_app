import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/videos_list.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveTvScreen extends StatefulWidget {
    static const routeName = '/live/tv';
  //
  const LiveTvScreen(
      {Key? key,
      this.onEnterFullScreen,
      this.onExitFullScreen})
      : super(key: key);
  final VoidCallback? onEnterFullScreen;
  final VoidCallback? onExitFullScreen;

  @override
  LiveTvScreenState createState() => LiveTvScreenState();
}

class LiveTvScreenState extends State<LiveTvScreen> {
  //
  late YoutubePlayerController _controller;
  late bool _isPlayerReady;
  bool _fullScreen = true;

  @override
  void initState() {
    super.initState();
    _isPlayerReady = false;
    _controller = YoutubePlayerController(
      initialVideoId:"VEyS51y4-Jg",
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
              title: const Text(
               "Western Spring Television Live Stream",
                style: TextStyle(
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
