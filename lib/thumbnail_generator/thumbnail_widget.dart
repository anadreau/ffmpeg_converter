import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:verticrowlabs_media_converter/thumbnail_generator/thumbnail_barrel.dart';

//Thumbnail function goes here.
///[ConsumerWidget] to return the thumbnail of the media file that will be
///converted.
class MediaThumbnailWidget extends ConsumerWidget {
  ///Default constructor of [MediaThumbnailWidget]
  const MediaThumbnailWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = ref.read(thumbnailPathProvider);
    final loaded = ref.watch(thumbnailLoadedProvider);

    switch (loaded) {
      case true:
        return SizedBox(
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              File('${imagePath.value}/thumbnail.jpg'),
            ),
          ),
        );
      case false:
        return SizedBox(
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/ImageHolder.jpg',
            ),
          ),
        );
    }
  }
}
