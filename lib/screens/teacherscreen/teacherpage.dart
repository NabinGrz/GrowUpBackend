import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/media_source.dart';
import 'package:growup/screens/drawerscreen/teacher_drawer_screen.dart';
import 'package:growup/screens/postscreen/source_page.dart';
import 'package:growup/screens/postscreen/video_widget.dart';
import 'package:growup/services/apiservice.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';

class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  var _image;
  File? fileMedia;
  bool isPosted = false;
  MediaSource? source;
  final TextEditingController _titleControler = TextEditingController();
  Future CamaraImage() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera, maxWidth: 400, imageQuality: 100);

    setState(() {
      _image = File(image!.path);
    });
  }

  Future GalleryImage() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 400, imageQuality: 100);

    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TeacherDrawerScreen(),
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: const Text("GrowUp"),
        actions: [
          SizedBox(
              height: 25,
              width: 50,
              child: IconButton(
                  onPressed: () {
                    var d = getTeacherDetails();
                  },
                  icon: const Icon(
                    Iconsax.notification,
                  ))),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 45,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: greyColor)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  controller: _titleControler,
                  cursorColor: Colors.red,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add your title',
                      hintStyle:
                          TextStyle(fontSize: 19, color: Color(0xFF575656))),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                color: Colors.blue.shade400,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: fileMedia == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Iconsax.folder_open,
                              color: Colors.blue,
                              size: 40,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Select your file',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade400),
                            ),
                          ],
                        )
                      : (source == MediaSource.image
                          ? Image.file(
                              fileMedia!,
                              fit: BoxFit.contain,
                            )
                          : VideoWidget(
                              fileMedia!,
                            )),
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          capture(MediaSource.image);
                        },
                        child: const Icon(Iconsax.camera),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          capture(MediaSource.video);
                        },
                        child: const Icon(Iconsax.video),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Container(
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xffFE876C),
                            Color(0xffFD5D37),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          30.0,
                        ),
                      ),
                      child: !isPosted
                          ? FlatButton(
                              onPressed: () async {
                                bool isSuccess = await postNewsFeed(
                                    _titleControler.text, fileMedia!);
                                if (isSuccess) {
                                  print("YYYYYYYYYYYYYYYYYYYYYYYYYEEEEEEEEEEE");
                                  setState(() {
                                    isPosted = false;
                                  });
                                  Fluttertoast.showToast(
                                    msg: "Posted Successfully",
                                  );
                                } else {
                                  setState(() {
                                    isPosted = false;
                                  });
                                  Fluttertoast.showToast(
                                    msg: "Something went wrong",
                                  );
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Text(
                                'Post',
                                style: whiteTextStyle.copyWith(fontSize: 18),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )),
                  const SizedBox(
                    width: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      fileMedia = null;
    });

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SourcePage(),
        settings: RouteSettings(
          arguments: source,
        ),
      ),
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }
}
