import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/models/media_source.dart';
import 'package:growup/screens/postscreen/source_page.dart';
import 'package:growup/screens/postscreen/video_widget.dart';
import 'package:growup/services/apiservice.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? fileMedia;
  MediaSource? source;
  TextEditingController _titleControler = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   height: 200,
              //   width: 600,
              //   child: fileMedia == null
              //       ? Icon(Icons.photo, size: 120)
              //       : (source == MediaSource.image
              //           ? Image.file(fileMedia!)
              //           : VideoWidget(fileMedia!)),
              // ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
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
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        //    prefixIcon: Icon(Icons.search, color: Colors.black),
                        hintText: 'Add your title',
                        hintStyle:
                            TextStyle(fontSize: 19, color: Color(0xFF575656))),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  // GalleryImage();
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(10),
                  dashPattern: [10, 4],
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
                              Icon(
                                Iconsax.folder_open,
                                color: Colors.blue,
                                size: 40,
                              ),
                              SizedBox(
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
                    // Image.file(
                    //     fileMedia!,
                    //     width: 200.0,
                    //     height: 200.0,
                    //     fit: BoxFit.cover,
                    //   ),
                  ),
                ),
              ),
              Divider(),
              Container(
                height: MediaQuery.of(context).size.height / 9,
                width: MediaQuery.of(context).size.width,
                //color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            capture(MediaSource.image);
                            // CamaraImage();
                          },
                          child: Icon(Iconsax.camera),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            capture(MediaSource.video);
                            //GalleryImage();
                          },
                          child: Icon(Iconsax.video),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      width: 110,
                      height: 50,
                      //color: Colors.red,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
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
                      child: FlatButton(
                        onPressed: () {
                          postNewsFeed(_titleControler.text, fileMedia!);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Text(
                          'Post',
                          style: whiteTextStyle.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Future capture(MediaSource source) async {
    setState(() {
      this.source = source;
      this.fileMedia = null;
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
