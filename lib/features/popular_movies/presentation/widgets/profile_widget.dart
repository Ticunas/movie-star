import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:movie_star/core/constants/dio_constants.dart';
import 'package:movie_star/core/presentation/widgets/cached_network_image_builder.dart';
import 'package:movie_star/features/login/domain/entities/credential.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key, required this.credential}) : super(key: key);
  final Credential credential;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 50,
        height: 50,
        child: CachedNetworkImageBuilder(
            url: baseGravatarUrl + '/' + md5Converter(credential.email),
            builder: (image) {
              return Center(child: Image.file(image));
            },
            placeHolder: const LinearProgressIndicator(),
            errorWidget: const Icon(Icons.error)),
      ),
      title: Text(credential.name),
      subtitle: Text(credential.email),
    );
  }
}

String md5Converter(String value) {
  return md5.convert(utf8.encode(value)).toString();
}
