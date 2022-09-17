import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import 'package:rave_fm_app/src/components/constants.dart';
import 'package:ticker_text/ticker_text.dart';

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
      title: 'Rave 91.7 FM',
      url:
          'https://stream-53.zeno.fm/qt1xm9vg7f0uv?zs=V4q_Mp9JRjqpytFiXr3a2A&listening-from-radio-garden=1663251843',
      imagePath: 'assets/images/rave_bg.png',
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const Text("Rave 91.7 FM ",
            style: TextStyle(fontSize: 20),),
            FutureBuilder(
              future: _radioPlayer.getArtworkImage(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Image artwork;
                if (snapshot.hasData) {
                  artwork = snapshot.data;
                } else {
                  artwork = Image.asset(
                    'assets/images/rave_bg.png',
                    fit: BoxFit.cover,
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: artwork,
                  ),
                );
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.95, // constrain the parent width so the child overflows and scrolling takes effect
              child: Stack(
                children: [
                    Container(
                      color: Colors.black,
                      margin: const EdgeInsets.only(left: 65),
                    padding:const EdgeInsets.symmetric(vertical: 8.0) ,
                    child: const TickerText(
                      // default values // this is optional
                      scrollDirection: Axis.horizontal,
                      speed: 25,
                      startPauseDuration: Duration(seconds: 2),
                      endPauseDuration: Duration(seconds: 2),
                      returnDuration: Duration(milliseconds: 400),
                      primaryCurve: Curves.linear,
                      returnCurve: Curves.easeOut,
                      child:Text(
                          Utils.tickerText,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        shape: BoxShape.rectangle,
                        color: Colors.green),
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
                      child: Align(
                        child: Text(
                          "Rave FM",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
