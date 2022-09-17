import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rave_fm_app/src/components/video_player_screen.dart';
import 'package:rave_fm_app/src/live_tv/live_tv_screen.dart';
import '../models/channel_info.dart';
import '../models/videos_list.dart';
import '../services/services.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  VideosScreenState createState() => VideosScreenState();
}

class VideosScreenState extends State<VideosScreen> {
  //
  late ChannelInfo _channelInfo;
  late VideosList _videosList;
  late Item _item;
  late bool _loading;
  late String _playListId;
  late String _nextPageToken;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList.videos = [];
    _getChannelInfo();
  }

  _getChannelInfo() async {
    _channelInfo = await Services.getChannelInfo();
    _item = _channelInfo.items![0];
    _playListId = _item.contentDetails?.relatedPlaylists?.uploads ?? "null";
    await _loadVideos();
    setState(() {
      _loading = false;
    });
  }

  _loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList(
      playListId: _playListId,
      pageToken: _nextPageToken,
    );
    _nextPageToken = "${tempVideosList.nextPageToken}";
    _videosList.videos!.addAll(tempVideosList.videos!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, LiveTvScreen.routeName);
        },
        tooltip: 'Watch Live TV button',
        child: const Icon(Icons.live_tv,
        color: Colors.white,
        ),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            _buildInfoView(),
            Expanded(
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (ScrollNotification notification) {
                  if (_videosList.videos!.length >=
                      int.parse(_item.statistics!.videoCount ?? "1")) {
                    return true;
                  }
                  if (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                    _loadVideos();
                  }
                  return true;
                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _videosList.videos?.length,
                  itemBuilder: (context, index) {
                    VideoItem videoItem = _videosList.videos![index];
                    return InkWell(
                      onTap: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return VideoPlayerScreen(
                            videoItem: videoItem,
                          );
                        }));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              errorWidget: (context, url, error) {
                                return Image.asset(
                                    "assets/images/wstv_logo.png");
                              },
                              imageUrl:
                                  "${videoItem.video?.thumbnails!.thumbnailsDefault?.url}",
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: Text(
                                "${videoItem.video?.title}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildInfoView() {
    return _loading
        ? const CircularProgressIndicator()
        : Container(
            padding: const EdgeInsets.all(20.0),
          );
  }
}
