import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:growup/colorpalettes/palette.dart';
import 'package:growup/downloads/download_provider.dart';
import 'package:provider/provider.dart';

bool isDownloading = false;
bool isDone = false;
Widget dowloadButton(String url, FileDownloaderProvider downloaderProvider,
    int index, String videoName) {
  return IconButton(
      onPressed: () {
        print(
            "=================================================================");
        print("URL: " + url);
        print("videoName: " + videoName);
        print("Index: " + index.toString());
        downloaderProvider
            .downloadFile(url, "$videoName.mp4")
            .then((onValue) {});
        Fluttertoast.showToast(
          msg: "Your download has been started",
        );
      },
      icon: const Icon(
        Icons.download,
        color: Colors.white,
      ));
}

Widget downloadProgress(BuildContext context, int index) {
  var fileDownloaderProvider =
      Provider.of<FileDownloaderProvider>(context, listen: true);

  return Row(
    children: [
      isDownloading
          ? SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: darkBlueColor,
                strokeWidth: 3,
              ))
          : isDone
              ? const Icon(
                  Icons.check,
                  color: Color.fromARGB(255, 92, 221, 96),
                )
              : Container(),
      const SizedBox(
        width: 5,
      ),
      Text(
        downloadStatus(fileDownloaderProvider, context, null),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    ],
  );
}

downloadStatus(FileDownloaderProvider fileDownloaderProvider,
    BuildContext context, GlobalKey<ScaffoldState>? _scaffoldKey) {
  var retStatus = "";

  switch (fileDownloaderProvider.downloadStatus) {
    case DownloadStatus.Downloading:
      {
        //return CircularProgressIndicator();
        isDownloading = true;
        isDone = false;
        retStatus = "Downloading... " +
            fileDownloaderProvider.downloadPercentage.toString() +
            "%";
        if (retStatus == "Downloading... 100%") {
          print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
          retStatus = "Downloaded Successfully";

          // _scaffoldKey.
          isDownloading = false;
          isDone = true;
          Fluttertoast.showToast(
            msg:
                "Your video will be saved in your 'Download' folder of phone storage",
          );
        }
      }
      break;
    case DownloadStatus.Completed:
      {
        retStatus = "Download Completeds";
      }
      break;
    case DownloadStatus.NotStarted:
      {
        retStatus = "";
      }
      break;
    case DownloadStatus.Started:
      {
        retStatus = "Download Starting";
      }
      break;
  }

  return retStatus;
}
