import 'dart:core';

/// @Author: 一凨
/// @Date: 2019-01-14 17:53:54
/// @Last Modified by: 一凨
/// @Last Modified time: 2019-01-14 17:57:51

import 'package:flutter/material.dart';
import 'package:flutter_live/routers/application.dart';
import 'package:flutter_live/routers/routers.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class LotteryItem extends StatelessWidget {
  final String itemUrl;
  final String itemTitle;
  final String data;
  int countdownTime;

  LotteryItem(
      {Key key, this.itemUrl, this.itemTitle, this.data, this.countdownTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      //elevation: 4.0,
      //margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: new InkWell(
        child: new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    new Text("北京赛车PK10",
                        style: new TextStyle(
                          decorationColor: Colors.black26,
                          //线的颜色
                          decoration: TextDecoration.none,
                          //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
                          decorationStyle: TextDecorationStyle.solid,
                          //文字装饰的风格  dashed,dotted虚线(简短间隔大小区分)  double三条线  solid两条线
                          wordSpacing: 0.0,
                          //单词间隙(负值可以让单词更紧凑)
                          letterSpacing: 0.0,
                          //字母间隙(负值可以让字母更紧凑)
                          fontStyle: FontStyle.normal,
                          //文字样式，斜体和正常
                          fontSize: 15.0,
                          //字体大小
                          fontWeight: FontWeight.w900,
                          //字体粗细  粗体和正常
                          color: Colors.black87, //文字颜色
                        )),
                    new Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: new Text("第733893期开奖",
                          style: new TextStyle(
                            decorationColor: Colors.black26,
                            //线的颜色
                            decoration: TextDecoration.none,
                            //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
                            decorationStyle: TextDecorationStyle.solid,
                            //文字装饰的风格  dashed,dotted虚线(简短间隔大小区分)  double三条线  solid两条线
                            wordSpacing: 0.0,
                            //单词间隙(负值可以让单词更紧凑)
                            letterSpacing: 0.0,
                            //字母间隙(负值可以让字母更紧凑)
                            fontStyle: FontStyle.normal,
                            //文字样式，斜体和正常
                            fontSize: 10.0,
                            //字体大小
                            fontWeight: FontWeight.w900,
                            //字体粗细  粗体和正常
                            color: Colors.black38, //文字颜色
                          )),
                    ),
                    new Expanded(
                        child: new Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                      child: new Text(
                        "下期倒计时：19分35秒${countdownTime}",
                        style: new TextStyle(
                          decorationColor: Colors.black26,
                          //线的颜色
                          decoration: TextDecoration.none,
                          //none无文字装饰   lineThrough删除线   overline文字上面显示线    underline文字下面显示线
                          decorationStyle: TextDecorationStyle.solid,
                          //文字装饰的风格  dashed,dotted虚线(简短间隔大小区分)  double三条线  solid两条线
                          wordSpacing: 0.0,
                          //单词间隙(负值可以让单词更紧凑)
                          letterSpacing: 0.0,
                          //字母间隙(负值可以让字母更紧凑)
                          fontStyle: FontStyle.normal,
                          //文字样式，斜体和正常
                          fontSize: 10.0,
                          //字体大小
                          fontWeight: FontWeight.w300,
                          //字体粗细  粗体和正常
                          color: Colors.orange[400], //文字颜色
                        ),
                        textAlign: TextAlign.right,
                      ),
                    )),
                  ],
                ),
              ),
              new Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: createBall(data)),
              new Padding(
                padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                child: new Row(
                  children: <Widget>[
                    new InkWell(
                      onTap: () {},
                      child: new Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                        child: new Container(
                          child: new Text(
                            "免费参考",
                            style: new TextStyle(color: Colors.black45),
                          ),
                          padding: EdgeInsets.all(3.0),
                          decoration: new BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                          ),
                        ),
                      ),
                    ),
                    new InkWell(
                      onTap: () {},
                      child: new Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                        child: new Container(
                          child: new Text(
                            "历史开奖",
                            style: new TextStyle(color: Colors.black45),
                          ),
                          padding: EdgeInsets.all(3.0),
                          decoration: new BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                          ),
                        ),
                      ),
                    ),
                    new InkWell(
                      onTap: () {},
                      child: new Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                        child: new Container(
                          child: new Text(
                            "开奖视频",
                            style: new TextStyle(color: Colors.black45),
                          ),
                          padding: EdgeInsets.all(3.0),
                          decoration: new BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                          ),
                        ),
                      ),
                    ),
                    new InkWell(
                      onTap: () {
                        //处理点击事件
                      },
                      child: new Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5.0, 0),
                        child: new Container(
                          child: new Text(
                            "竞猜中心",
                            style: new TextStyle(color: Colors.black45),
                          ),
                          padding: EdgeInsets.all(3.0),
                          decoration: new BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius:
                                BorderRadius.all(Radius.circular(3.0)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          //onClick(context);
        },
      ),
    );
  }

  Widget createBall(String ball) {
    List<String> balls = ball.split(",");
    List<Widget> list = new List();
    int size = balls.length;
    for (int i = 0; i < size; i++) {
      list.add(createSingleBall(balls.elementAt(i), i));
    }
    return new Row(children: list);
  }

  Widget createSingleBall(String num, int index) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
      child: new Container(
        child: new Center(
          child: new Text(
            num,
            style: new TextStyle(color: Colors.white),
          ),
        ),
        width: 25,
        height: 25,
        decoration: new BoxDecoration(
            color: getColor(index),
            borderRadius: BorderRadius.all(Radius.circular(2.0))),
      ),
    );
  }

  Color getColor(int index) {
    switch (index) {
      case 0:
        {
          return Colors.pink;
        }
      case 1:
        {
          return Colors.green;
        }
      case 2:
        {
          return Colors.black87;
        }
      case 3:
        {
          return Colors.red;
        }
      case 4:
        {
          return Colors.blue;
        }
      case 5:
        {
          return Colors.grey;
        }
      case 6:
        {
          return Colors.orange;
        }
      case 7:
        {
          return Colors.deepPurple;
        }
      case 8:
        {
          return Colors.yellowAccent;
        }
      case 9:
        {
          return Colors.cyanAccent;
        }
      default:
        {
          return Colors.cyanAccent;
        }
    }
  }

  onClick(BuildContext context) {
    /*Fluttertoast.showToast(
        msg: "点击了${itemTitle}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black87,
        fontSize: 16.0
    );*/
    Application.router.navigateTo(context,
        '${Routes.webViewPage}?title=${Uri.encodeComponent(itemTitle)}&url=${Uri.encodeComponent(itemUrl)}');
  }
}
