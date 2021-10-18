import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

///Based on [https://pub.dev/packages/cached_network_image_builder]
///Was necessary changed the lib to could receive Gravatar Image
class CachedNetworkImageBuilder extends StatelessWidget {
  final String url;
  final List<String>? imageExtensions;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final Widget Function(File image) builder;

  const CachedNetworkImageBuilder({
    Key? key,
    required this.url,
    this.imageExtensions,
    this.placeHolder,
    this.errorWidget,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Future<String>.microtask(() async {
        final imageName = url.split('/').last;
        final directory = await getApplicationDocumentsDirectory();

        final folderDirectory = Directory(directory.path + '/cached_images/');

        if (!folderDirectory.existsSync()) {
          await folderDirectory.create(recursive: true);
        }

        final imageDirectory = Directory(folderDirectory.path + imageName);

        if (folderDirectory
            .listSync()
            .toString()
            .contains(imageDirectory.path)) {
          return imageDirectory.path;
        } else if (url.startsWith(RegExp("http(s)?://"))) {
          final response = await get(Uri.parse(url));
          if (response.statusCode == 200) {
            if ((response.headers['content-type'] ?? "").startsWith('image')) {
              final file = File(imageDirectory.path);
              file.writeAsBytesSync(response.bodyBytes);
              return imageDirectory.path;
            } else {
              return ":error: url does not contain image";
            }
          } else {
            return ":error: Failed to load image : statusCode: ${response.statusCode}";
          }
        } else {
          return ":error: unknown error occured";
        }
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          if (snapshot.data!.startsWith(":error:")) {
            return errorWidget ?? Center(child: Text(snapshot.data!));
          } else {
            return builder(File(snapshot.data!));
          }
        } else {
          return placeHolder ??
              const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
