import 'dart:io';

import 'package:flutter/material.dart';
import 'package:growup/models/media_source.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import 'list_tile_widget.dart';

class GalleryButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListTileWidget(
        text: 'From Gallery',
        icon: Iconsax.gallery,
        onClicked: () => pickGalleryMedia(context),
      );

  Future pickGalleryMedia(BuildContext context) async {
    var source = ModalRoute.of(context)!.settings.arguments;

    final getMedia = source == MediaSource.image
        ? ImagePicker().getImage
        : ImagePicker().getVideo;

    final media = await getMedia(source: ImageSource.gallery);
    final file = File(media!.path);

    Navigator.of(context).pop(file);
  }
}
