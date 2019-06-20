import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live/common/utils/util.dart';
//import 'package:flutter_lottie/flutter_lottie.dart';

import 'package:flutter_live/module/home/home.dart';

/**
 * 欢迎页
 * Created by jinpang
 * Date: 2019-05-30
 */

class WelcomePage extends StatefulWidget {

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;
  double size = 200;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hadInit) {
      return;
    }
    hadInit = true;
    ///防止多次进入
    new Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      gotoHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          new Center(
            child: new Image(
                image: new AssetImage(Util.getImgPath('bg_welcome')),
              fit: BoxFit.fill,
            ),
          ),
          /*new Align(
            alignment: Alignment.bottomCenter,
            child: new Container(
              width: size,
              height: size,
              color: Colors.white,
              child: LottieView.fromFile(
                filePath: Util.getFilePath("rejection2"),
                autoPlay: true,
                loop: true,
                reverse: false,
                onViewCreated: onViewCreatedFile,
              ),
            ),
          )*/
        ],
      ),
    );
  }

  /*void onViewCreatedFile(LottieController controller) {

  }*/

  gotoHomePage(){
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
            builder: (context) => HomePage()),
            (route) => route == null);
  }
}
