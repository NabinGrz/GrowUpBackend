import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/controller/myController.dart';
import 'package:growup/downloads/download_provider.dart';
import 'package:growup/models/commentmodel.dart';
import 'package:growup/services/apiservice.dart';
import 'package:growup/services/apiserviceteacher.dart';
import 'package:growup/widgets/shimmer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:share_plus/share_plus.dart';

StreamController _stream = StreamController();
FileDownloaderProvider? downloaderProvider;
bool isComment = false;
TextEditingController _commentController = TextEditingController();
//var d = getNews();
// import 'package:flutter_application_999/screen/chat.dart';
_showModalBottomSheet(context, int newsFeedIndex) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                    // borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Comments",
                            style: TextStyle(
                                color: Colors.black.withOpacity(.8),
                                fontWeight: FontWeight.w500,
                                fontSize: 24),
                          ),
                          const Icon(Iconsax.arrow_down)
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: SizedBox(
                          //color: Colors.red,
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //     height: 60,
                              //     width: 60,
                              //     decoration: BoxDecoration(
                              //         //     color: Colors.blue,
                              //         borderRadius:
                              //             BorderRadius.all(Radius.circular(50))),
                              //     child: Image.asset("images/person.png")),
                              // SizedBox(
                              //   width: 20,
                              // ),
                              FutureBuilder<List<CommentsModel>>(
                                future: getNewsFeedComments(
                                    //  _newsFeedData[index].applicationUserId
                                    newsFeedIndex),
                                builder: (context, snapshot) {
                                  print("FUTUTUTUTUTUTUTTU");
                                  //print();
                                  if (snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      snapshot.data == null) {
                                    return const Expanded(
                                        // color: Colors.red,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  } else if (snapshot.hasData ||
                                      snapshot.connectionState ==
                                          ConnectionState.done) {
                                    if (snapshot.data!.isEmpty) {
                                      print(
                                          "sooooooooorrrrrrrrrrrrrrrrrrrrrrrrrry");
                                      return const Expanded(
                                        //color: Colors.red,
                                        child: Center(
                                            child: Text(
                                          "No comments!!",
                                          style: TextStyle(
                                              fontSize: 25, color: Colors.grey),
                                        )),
                                      );
                                    } else {
                                      var comments = snapshot.data;
                                      return SizedBox(
                                        //color: Color.fromARGB(255, 70, 244, 54),
                                        height: 900,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                            itemCount: comments!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    height: 60,
                                                    width: double.infinity / 2,
                                                    decoration: const BoxDecoration(
                                                        color:
                                                            Color(0xFFF0F0F0),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          FutureBuilder<
                                                              dynamic>(
                                                            future:
                                                                getUserDetails(
                                                              comments[index]
                                                                  .applicationUserId
                                                                  .toString(),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                return Text(
                                                                  snapshot.data
                                                                      .fullName
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              .8),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16),
                                                                );
                                                              } else if (snapshot
                                                                  .hasError) {
                                                                return const Text(
                                                                    "NULL");
                                                              }
                                                              return buildShimmerEffect(
                                                                  context,
                                                                  Container(
                                                                    height: 20,
                                                                    width: 60,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                  ));
                                                            },
                                                          ),
                                                          Text(
                                                            comments[index]
                                                                .description
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        .8),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              );
                                            }),
                                      );
                                    }
                                  }
                                  return Container(
                                    color: Colors.red,
                                    height: 100,
                                    width: 100,
                                    child: const Center(
                                        child: Text(
                                      "No comments yet!!",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey),
                                    )),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            //    margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 1, color: greyColor)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                controller: _commentController,
                                cursorColor: Colors.red,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    //    prefixIcon: Icon(Icons.search, color: Colors.black),
                                    hintText: 'Write your comment...',
                                    hintStyle: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xFF575656))),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                isComment = true;
                              });
                              var userId = await getUserAppId();
                              var comment = await postComment(
                                  _commentController.text,
                                  newsFeedIndex,
                                  userId.toString());
                              print("COMMENT REPOSNE IS");
                              print(comment);
                              if (comment) {
                                setState(() {
                                  isComment = false;
                                });
                                Fluttertoast.showToast(
                                  msg: "Comment has been posted successfully",
                                );
                              } else {
                                setState(() {
                                  isComment = false;
                                });
                                Fluttertoast.showToast(
                                  msg: "Comment cannot be posted.SORRY!!",
                                );
                              }
                            },
                            child: !isComment
                                ? Icon(
                                    Iconsax.send1,
                                    size: 30,
                                    color: darkBlueColor,
                                  )
                                : Center(
                                    child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: darkBlueColor,
                                    ),
                                  )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
            ));
      });
}

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  //var d;
  // print(d);
  var _newsFeed;
  int? newsFeedIndex;
  var ratingCount;
  bool refreshOrderList = false;
  final newsFeedController = Get.put(MyController());
  @override
  void initState() {
    super.initState();
    _newsFeed = getNews();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    //print("NEWS FEED DATA");
    // print(d);
    // print("S REBUILD");
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: loadData,
        child: FutureBuilder(
            future: _newsFeed,
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  //color: Colors.amber,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey.withOpacity(.3)))),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ListTile(
                                  leading: buildShimmerEffect(
                                    context,
                                    const CircleAvatar(
                                        // backgroundImage: AssetImage('assets/images/kucuk.jpg'),
                                        ),
                                  ),
                                  title: buildShimmerEffect(
                                    context,
                                    Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.8),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 21),
                                    ),
                                  ),
                                  trailing: PopupMenuButton(
                                    icon: const Icon(Icons.more_vert_rounded),
                                    itemBuilder: (context) => [
                                      // PopupMenuItem(
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(Icons.ac_unit, color: Colors.black),
                                      //       Text("Flutter.io"),
                                      //     ],
                                      //   ),
                                      // ),
                                      // const PopupMenuItem(
                                      //   child: Text("Save Picture"),
                                      // ),
                                      // const PopupMenuItem(
                                      //   child: Text("Setting"),
                                      // ),
                                    ],
                                  ),
                                ),
                                buildShimmerEffect(
                                    context,
                                    Container(
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      height: 400,
                                      width: double.infinity,
                                    ))
                              ],
                            ),
                          )),
                );
              } else if (snapshot.hasData ||
                  snapshot.data != null ||
                  snapshot.connectionState == ConnectionState.done) {
                var _newsFeedData = snapshot.data;
                //var ratingCount = getRatingCount(13);
                print(
                    "|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
                print(ratingCount.toString());
                //var rateId = _newsFeedData[index].id;

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _newsFeedData.length,
                    itemBuilder: (context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder<dynamic>(
                                    future: getUserDetails(
                                        _newsFeedData[index].applicationUserId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return GestureDetector(
                                          onTap: () {
                                            //  postComment();
                                          },
                                          child: Text(
                                            snapshot.data.fullName.toString(),
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.8),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Text("NULL");
                                      }
                                      return const SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ));
                                    },
                                  ),
                                  const Text(
                                    "30 mins ago",
                                    style: TextStyle(
                                        color: Color(0xFF777777),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              trailing: PopupMenuButton(
                                icon: const Icon(Icons.more_vert_rounded),
                                itemBuilder: (context) => [
                                  // PopupMenuItem(
                                  //   child: Row(
                                  //     children: [
                                  //       Icon(Icons.ac_unit, color: Colors.black),
                                  //       Text("Flutter.io"),
                                  //     ],
                                  //   ),
                                  // ),
                                  //  PopupMenuItem(
                                  //   child: Text("Save Picture"),
                                  //   //onTap: downloaderProvider.downloadedFile(),
                                  // ),
                                  // const PopupMenuItem(
                                  //   child: Text("Setting"),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                _newsFeedData[index].title,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.8,
                                width: MediaQuery.of(context).size.width - 20,
                                //  alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(30)),
                                //  width: double.infinity,

                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: PinchZoom(
                                      resetDuration:
                                          const Duration(milliseconds: 100),
                                      maxScale: 3,
                                      // onZoomStart: () {
                                      //   print('Start zooming');
                                      // },
                                      // onZoomEnd: () {
                                      //   print('Stop zooming');
                                      // },
                                      child: CachedNetworkImage(
                                        //  imageUrl:
                                        //   "https://af39-2400-1a00-b020-c437-8c06-92c-b167-2b4c.ngrok.io/Media/Images/395f5c07-ae6d-4e1b-91bf-5d7834cb4c3ascaled_image_picker8777471418088588935.jpg",
                                        imageUrl: _newsFeedData[index]
                                            .imageUrl
                                            .toString(),
                                        //   imageUrl:
                                        //   "https://s3.studylib.net/store/data/025331692_1-30173db8fcb89067fe99553e7a80aad2-768x994.png",
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        placeholder: (context, url) {
                                          return buildShimmerEffect(
                                            context,
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2.8,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  20,
                                              color: Colors.red,
                                            ),
                                          );
                                        },
                                      ),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FutureBuilder<dynamic>(
                                  future: getAvergaeRatingCount(
                                    //_newsFeedData[index].applicationUserId
                                    int.parse(
                                        _newsFeedData[index].id.toString()),
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var average = snapshot.data!.toString();
                                      return Text(
                                        average,
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(.8),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(
                                        "No ratings",
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(.8),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      );
                                    }
                                    return buildShimmerEffect(
                                        context,
                                        Container(
                                          height: 20,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ));
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    RatingBar(
                                      initialRating: 0.0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 24,
                                      ratingWidget: RatingWidget(
                                        full: Icon(Icons.star_rate_rounded,
                                            color: darkBlueColor),
                                        half: Icon(Icons.star_half_rounded,
                                            color: darkBlueColor),
                                        empty: Icon(Icons.star_border_rounded,
                                            color: darkBlueColor),
                                      ),
                                      itemPadding: EdgeInsets.zero,
                                      onRatingUpdate: (rating) async {
                                        var ratingResponse =
                                            await postNewsFeedRating(
                                                int.parse(_newsFeedData[index]
                                                    .id
                                                    .toString()),
                                                rating);
                                        await ratingResponse ==
                                                "NewsFeedRating Saved Successfully"
                                            ? Fluttertoast.showToast(
                                                msg:
                                                    "Rating of $rating has been given for this feed",
                                              )
                                            : Fluttertoast.showToast(
                                                msg: "Rating unsuccessfull",
                                              );
                                        print(int.parse(_newsFeedData[index]
                                            .id
                                            .toString()));
                                        print("NABIN");
                                        print(newsFeedIndex);
                                        //  print(ratingResponse);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 6, top: 8.0),
                              child: FutureBuilder<dynamic>(
                                future: getRatingCount(
                                  int.parse(_newsFeedData[index].id.toString()),
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data.toString() + " Ratings",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 109, 109, 109),
                                          fontWeight: FontWeight.w400),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text("NULL");
                                  }
                                  return buildShimmerEffect(
                                      context,
                                      Container(
                                        height: 20,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ));
                                },
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              // color: Colors.red,
                              height: 40,
                              //  alignment: Alignment.l,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Row(children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              newsFeedIndex =
                                                  _newsFeedData[index].id;
                                            });
                                            _showModalBottomSheet(
                                                context, newsFeedIndex!);
                                            print(
                                                "{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
                                            print(newsFeedIndex);
                                          },
                                          icon: Icon(
                                            Iconsax.send_square5,
                                            size: 28,
                                            color: darkBlueColor,
                                          )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        "Comment",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF575656)),
                                      )
                                    ]),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        await Share.share("GrowUp");
                                        // setState(() {
                                        //   newsFeedIndex =
                                        //       _newsFeedData[index].id;
                                        // });
                                        // _showModalBottomSheet(
                                        //     context, newsFeedIndex!);
                                        // print(
                                        //     "{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{");
                                        // print(newsFeedIndex);
                                      },
                                      icon: Icon(
                                        Icons.share,
                                        size: 22,
                                        color: darkBlueColor,
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: 8,
                              width: double.infinity,
                              color: const Color(0xFFDFDFDF),
                            )
                          ],
                        ));
              }
              return const CircularProgressIndicator(
                color: Colors.red,
              );
            }),
      ),
    );
  }

  Future loadData() async {
    Future.delayed(const Duration(seconds: 1), () {
      getNews();
      print("REFRESHED");
      print(_newsFeed.length);
    });
  }

  getCount(int i) async {
    var count = await getRatingCount(i);
    return count;
  }
}
