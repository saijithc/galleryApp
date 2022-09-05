import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery/largeScreen.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

// import 'body.dart';
// String image = '';
ValueNotifier<List> images = ValueNotifier([]);

// ignore: camel_case_types
class Gallery_Screen extends StatefulWidget {
  const Gallery_Screen({Key? key}) : super(key: key);

  @override
  State<Gallery_Screen> createState() => _Gallery_ScreenState();
}

// ignore: camel_case_types
class _Gallery_ScreenState extends State<Gallery_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () {
          camera();
        },
      ),
    );
  }

  camera() async {
    final capture = await ImagePicker().pickImage(source: ImageSource.camera);
    if (capture == null) {
      return;
    }
    Directory? directory = await getExternalStorageDirectory();
    // print(directory);
    File imagepath = File(capture.path);

    await imagepath.copy('${directory!.path}/${DateTime.now()}.jpg');
    
    jpgTesting(directory);

    // final bytes = File(capture.path).readAsBytesSync();
    // setState(() {
    //   image = base64Encode(bytes);
    //   img.add(image);
    //   getitems(directory);
    // });
    // return image;
  }
}

body() {
  return ValueListenableBuilder(
    valueListenable: images,
    builder: (context, dynamic data, anything) {
      return GridView.extent(
        crossAxisSpacing: 1,
        maxCrossAxisExtent: 150,
        children: List.generate(
          data.length,
          (index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) =>
                        Large_Screen(image: data[index], tagForHero: index),
                  ),
                );
              },
              child: Hero(
                tag: index,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                          File(
                            data[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

jpgTesting(Directory directory) async {
  final listDir = await directory.list().toList();
  images.value.clear();
  for (var i = 0; i < listDir.length; i++) {
    if (listDir[i].path.substring(
            (listDir[i].path.length - 4), (listDir[i].path.length)) ==
        '.jpg') {
      images.value.add(listDir[i].path);
      images.notifyListeners();
    }
  }
}

// List<String> img = <String>[];
