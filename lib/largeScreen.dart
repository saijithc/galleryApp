// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery/gallery.dart';

// ignore: camel_case_types
class Large_Screen extends StatelessWidget {
  const Large_Screen({Key? key, this.image, required this.tagForHero})
      : super(key: key);
  final dynamic image;
  final int tagForHero;
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: images,
            builder: (context, List data, _) {
              return Center(
                child: Hero(
                    tag: tagForHero, child: Image.file(File(image.toString()))),
              );
            }),
      ),
    );
  }
}
