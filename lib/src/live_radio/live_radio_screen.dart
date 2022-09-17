import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';

class LiveRadioScreen extends StatefulWidget {
  static const routeName = '/live/radio';
  const LiveRadioScreen({Key? key}) : super(key: key);

  @override
  LiveRadioScreenState createState() => LiveRadioScreenState();
}

class LiveRadioScreenState extends State<LiveRadioScreen> {
  final RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  List<String>? metadata;

  @override
  void initState() {
    super.initState();
    initRadioPlayer();
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: 'Rave FM',
      url: 'http://stream-uk1.radioparadise.com/aac-320',
      imagePath: 'assets/cover.jpg',
    );

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: _radioPlayer.getArtworkImage(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Image artwork;
                if (snapshot.hasData) {
                  artwork = snapshot.data;
                } else {
                  artwork = Image.asset(
                    'assets/cover.jpg',
                    fit: BoxFit.cover,
                  );
                }
                return SizedBox(
                  height: 180,
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: artwork,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              metadata?[0] ?? 'Metadata',
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
              metadata?[1] ?? '',
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
        },
        tooltip: 'Control button',
        child: Icon(
          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
        ),
      ),
    );
  }
}
