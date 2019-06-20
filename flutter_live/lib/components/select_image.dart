import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'app_bar.dart';

class SelectImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MySelectImage();
  }
}

class MySelectImage extends State {
  List imgList = new List<File>();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgList.add(image);
    });
  }

  dynamic getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
    }
  }

  bool showLoadingDialog() {
    if (imgList.length == 0) {
      return true;
    }

    return false;
  }

  Center getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  ListView getListView() => new ListView.builder(
      itemCount: imgList.length,
      itemBuilder: (BuildContext context, int position) {
        return Image.file(imgList[position], height: 300);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(context: context, showBackIcon: true, title: "选择图片"),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
