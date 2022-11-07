import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/downloads/download.dart';
import 'package:growup/downloads/download_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key, List? videoInfo}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;
  VideoPlayerController? _controller;

  int tappedIndex = 0;

  // Duration? _position;
  // Duration? _duration;
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
    //_onTapVideo(-1);
  }

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var fileDownloaderProvider =
        Provider.of<FileDownloaderProvider>(context, listen: false);
    return Scaffold(
        body: Container(
      decoration: !_playArea
          ? BoxDecoration(
              gradient: LinearGradient(
              colors: [
                gradientFirst.withOpacity(0.9),
                //    gradientFirst
                gradientSecond
              ],
              begin: const FractionalOffset(0.0, 0.4),
              end: Alignment.topRight,
            ))
          : BoxDecoration(color: gradientSecond),
      child: Column(
        children: [
          !_playArea
              ? Container(
                  padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 20, color: secondPageIconColor),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.info_outline,
                              size: 20, color: secondPageIconColor),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Legs Toning",
                        style: TextStyle(
                            fontSize: 25, color: secondPageTitleColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "and Glutes Workout",
                        style: TextStyle(
                            fontSize: 25, color: secondPageTitleColor),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    secondPageContainerGradient1stColor,
                                    secondPageContainerGradient2ndColor
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 20,
                                  color: secondPageIconColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "68 min",
                                  style: TextStyle(
                                      fontSize: 16, color: secondPageIconColor),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ))
              : Container(
                  // height: 300,
                  // width: 300,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  //Naviga
                                },
                                icon: const Icon(Icons.arrow_back))
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          _playView(context),
                          Positioned(
                            bottom: 10,
                            child: SizedBox(
                              //  color: Colors.yellow,
                              height: 20,
                              width: MediaQuery.of(context).size.width,
                              child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.red[700],
                                    inactiveTrackColor: Colors.red[100],
                                    trackShape:
                                        const RoundedRectSliderTrackShape(),
                                    trackHeight: 1.5,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 7.0),
                                    thumbColor: Colors.redAccent,
                                    overlayColor: Colors.red.withAlpha(32),
                                    overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 28.0),
                                    tickMarkShape:
                                        const RoundSliderTickMarkShape(),
                                    activeTickMarkColor: Colors.red[700],
                                    inactiveTickMarkColor: Colors.red[100],
                                    valueIndicatorShape:
                                        const PaddleSliderValueIndicatorShape(),
                                    valueIndicatorColor: Colors.redAccent,
                                    valueIndicatorTextStyle: const TextStyle(
                                      color: Colors.white,
                                    ), // TextStyle
                                  ),
                                  child: Slider(
                                      value: max(0, min(_progress * 100, 100)),
                                      min: 0,
                                      max: 100,
                                      divisions: 100,
                                      label:
                                          _position?.toString().split(".")[0],
                                      onChanged: (value) {
                                        setState(() {
                                          _progress = value * 0.01;
                                        });
                                      },
                                      onChangeStart: (value) {
                                        _controller?.pause();
                                      },
                                      onChangeEnd: (value) {
                                        final duration =
                                            _controller?.value.duration;
                                        if (duration != null) {
                                          var newValue =
                                              max(0, min(value, 99)) * 0.01;
                                          var millis =
                                              (duration.inMilliseconds *
                                                      newValue)
                                                  .toInt();
                                          _controller?.seekTo(
                                              Duration(milliseconds: millis));
                                          _controller?.play();
                                        }
                                      })),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chapters",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: circuitsColor),
                    ),
                    Row(
                      children: [
                        Icon(Icons.loop, size: 30, color: loopColor),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "3 sets",
                          style: TextStyle(
                            fontSize: 15,
                            color: setsColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: downloadProgress(context, tappedIndex),
                    ),
                    // SizedBox(
                    //   width: 5,
                    // ),
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: videoInfo.length,
                  itemBuilder: (_, int index) {
                    return GestureDetector(
                      onTap: () {
                        _onTapVideo(index);
                        setState(() {
                          tappedIndex = index;
                        });
                        print(
                            "===============================================================");
                        print("Tapped Index is:" + tappedIndex.toString());
                        setState(() {
                          if (_playArea == false) {
                            _playArea = true;
                          }
                        });
                      },
                      child: SizedBox(
                        height: 135,
                        width: 100,
                        // color: Colors.redAccent,
                        child: Column(
                          children: [
                            Stack(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                videoInfo[index]["thumbnail"])),
                                      )),
                                ),
                                Positioned(
                                  left: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        videoInfo[index]["title"],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 3.0),
                                        child: Text(
                                          videoInfo[tappedIndex]["time"],
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )),
              ],
            ),
          ))
        ],
      ),
    ));
  }

  _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            VideoPlayer(controller),
          ],
        ),
      );
    } else {
      return const AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )));
    }
  }

  var _onUpdateControllerTime;
  Duration? _position;
  Duration? _duration;
  var _progress = 0.0;
  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint("controller insnull");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller cannot be intilaized");
      return;
    }
    _duration ??= _controller?.value.duration;
    var duration = _duration;
    if (duration == null) return;

    var position = await controller.position;
    _position = position;

    final playing = controller.value.isPlaying;
    if (playing) {
      if (_disposed) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializeVideo(int index) async {
    final controller =
        VideoPlayerController.network(videoInfo[index]["videoUrl"]);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  void _onTapVideo(int index) {
    _initializeVideo(index);
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0; //if is
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);

    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      color: gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                if (noMute) {
                  _controller?.setVolume(0);
                } else {
                  _controller?.setVolume(1.0);
                }
                setState(() {});
              },
              icon: Icon(
                noMute ? Icons.volume_up_rounded : Icons.volume_off_outlined,
                // noMute ? color: Colors.white : color: Colors.red,
                size: 30,
              )),
          FlatButton(
              onPressed: () async {
                final index = _isPlayingIndex - 1;
                if (index >= 0 && videoInfo.length >= 0) {
                  _initializeVideo(index);
                } else {
                  Get.snackbar("Video", "No more vidoes to play",
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(
                        Icons.face,
                        size: 25,
                        color: Colors.white,
                      ));
                }
              },
              child: const Icon(
                Icons.fast_rewind,
                size: 36,
                color: Colors.white,
              )),
          FlatButton(
              onPressed: () async {
                if (_isPlaying) {
                  setState(() {
                    _isPlaying = false;
                  });
                  _controller?.pause();
                } else {
                  setState(() {
                    _isPlaying = true;
                  });
                  _controller?.play();
                }
              },
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 36,
                color: Colors.white,
              )),
          FlatButton(
              onPressed: () async {
                final index = _isPlayingIndex + 1;
                if (index <= videoInfo.length - 1) {
                  _initializeVideo(index);
                } else {
                  Get.snackbar("Video List", "",
                      snackPosition: SnackPosition.BOTTOM,
                      messageText: const Text(
                        "No more vidoes available",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      backgroundColor: gradientSecond,
                      icon: const Icon(
                        Icons.face,
                        size: 25,
                        color: Colors.white,
                      ));
                }
              },
              child: const Icon(
                Icons.fast_forward,
                size: 36,
                color: Colors.white,
              )),
          Text(
            "$mins:$secs",
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
