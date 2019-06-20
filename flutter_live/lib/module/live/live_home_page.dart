import 'package:flutter/material.dart';
import 'package:flutter_live/common/constants/live_colors.dart';
import 'package:flutter_live/common/utils/util.dart';
import 'package:flutter_live/components/marquee.dart';
import 'package:flutter_live/components/select_image.dart';
import 'package:flutter_live/module/live/pagination.dart';
import 'package:flutter_live/module/webview/web_view_page.dart';

import 'disclaimer_msg.dart';
import 'live_room_page.dart';

class LiveHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LiveHomePageState();
  }
}

class LiveHomePageState extends State<LiveHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Expanded(
        child: RefreshIndicator(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return headerView();
              } else if (index == 1) {
                return getNotice("北京赛车精英火热进行中");
              } else if (index == 2) {
                return createHotLottery(context, "热门彩种");
              } else if (index == 3) {
                return createAnchors(context, "推荐主播");
              } else if (index == 4) {
                return getMiddleBannerView();
              } else if (index == 5) {
                return createExperts(context, "推荐专家");
              }
            },
          ),
          onRefresh: _handleRefresh,
        ),
      )
    ]);
  }

  Widget getNotice(String title) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 40.0,
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.notifications,
                  color: LiveColors.getColor(LiveColors.notice),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: MarqueeContinuous(
                      child: Text(
                        "${title}",
                        style: TextStyle(
                          fontSize: 14,
                          color: LiveColors.getColor(LiveColors.notice),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          Container(
            height: 10,
            color: LiveColors.getColor(LiveColors.divider),
          ),
        ],
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    if (this.mounted) {
      setState(() {
        return null;
      });
    }
  }

  headerView() {
    return Column(
      children: <Widget>[
        Stack(
            //alignment: const FractionalOffset(0.9, 0.1),//方法一
            children: <Widget>[
              Pagination(226.0),
              Positioned(
                  //方法二
                  top: 10.0,
                  left: 0.0,
                  child: DisclaimerMsg(key: new Key("test"), pWidget: this)),
            ]),
        SizedBox(
            height: 1, child: Container(color: Theme.of(context).primaryColor)),
        SizedBox(height: 10),
      ],
    );
  }

  Widget getMiddleBannerView() {
    return Column(
      children: <Widget>[
        Stack(children: <Widget>[
          Pagination(80.0),
        ]),
      ],
    );
  }

  Widget createHotLottery(BuildContext context, String title) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Image.asset(
                  Util.getImgPath("ic_hot"),
                  height: 20,
                  width: 20,
                ),
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                ),
              ],
            ),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: EdgeInsets.all(10.0),
          ),
          Container(
            color: LiveColors.getColor(LiveColors.divider),
            height: 1,
          ),
          Container(
            child: GridView.count(
              //水平子Widget之间间距
              crossAxisSpacing: 15.0,
              //垂直子Widget之间间距
              mainAxisSpacing: 15.0,
              //一行的Widget数量
              crossAxisCount: 3,
              //子Widget宽高比例
              childAspectRatio: 0.75,
              children: getItemsHotLottery(6),
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
            ),
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget createAnchors(BuildContext context, String title) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Image.asset(
                  Util.getImgPath("ic_hot"),
                  height: 20,
                  width: 20,
                ),
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      "更多>>",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: EdgeInsets.all(10.0),
          ),
          Container(
            color: LiveColors.getColor(LiveColors.divider),
            height: 1,
          ),
          Container(
            child: GridView.count(
              //水平子Widget之间间距
              crossAxisSpacing: 15.0,
              //垂直子Widget之间间距
              mainAxisSpacing: 15.0,
              //一行的Widget数量
              crossAxisCount: 2,
              //子Widget宽高比例
              childAspectRatio: 1.42,
              children: getItemsAnchor(6),
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
            ),
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget createExperts(BuildContext context, String title) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Image.asset(
                  Util.getImgPath("ic_hot"),
                  height: 20,
                  width: 20,
                ),
                Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      "更多>>",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: EdgeInsets.all(10.0),
          ),
          Container(
            color: LiveColors.getColor(LiveColors.divider),
            height: 1,
          ),
          Container(
            child: GridView.count(
              //水平子Widget之间间距
              crossAxisSpacing: 15.0,
              //垂直子Widget之间间距
              mainAxisSpacing: 15.0,
              //一行的Widget数量
              crossAxisCount: 2,
              //子Widget宽高比例
              childAspectRatio: 2.0,
              children: getItemsExpert(6),
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
            ),
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  List<Widget> getItemsHotLottery(int size) {
    List<Widget> list = new List();
    for (int i = 0; i < size; i++) {
      if (i >= 0 && i <= 1) {
        list.add(getHotLotteryItemContainer(
            "民间超级大神${i}", "${i * 10}%", Colors.orange));
      } else if (i >= 2 && i <= 3) {
        list.add(getHotLotteryItemContainer(
            "民间超级大神${i}", "${i * 10}%", Colors.deepPurple));
      } else if (i >= 4 && i <= 5) {
        list.add(getHotLotteryItemContainer(
            "民间超级大神${i}", "${i * 10}%", Colors.pink));
      }
    }
    return list;
  }

  List<Widget> getItemsAnchor(int size) {
    List<Widget> list = new List();
    for (int i = 0; i < size; i++) {
      if (i >= 0 && i <= 1) {
        list.add(
            getAnchorItemContainer("民间超级大神${i}", "${i * 10}%", Colors.orange));
      } else if (i >= 2 && i <= 3) {
        list.add(getAnchorItemContainer(
            "民间超级大神${i}", "${i * 10}%", Colors.deepPurple));
      } else if (i >= 4 && i <= 5) {
        list.add(
            getAnchorItemContainer("民间超级大神${i}", "${i * 10}%", Colors.pink));
      }
    }
    return list;
  }

  List<Widget> getItemsExpert(int size) {
    List<Widget> list = new List();
    for (int i = 0; i < size; i++) {
      if (i >= 0 && i <= 1) {
        list.add(
            getExpertItemContainer("民间超级大神${i}", "${i * 10}%", Colors.orange));
      } else if (i >= 2 && i <= 3) {
        list.add(getExpertItemContainer(
            "民间超级大神${i}", "${i * 10}%", Colors.deepPurple));
      } else if (i >= 4 && i <= 5) {
        list.add(
            getExpertItemContainer("民间超级大神${i}", "${i * 10}%", Colors.pink));
      }
    }
    return list;
  }

  Widget getHotLotteryItemContainer(
      String title, String percent, MaterialColor mc) {
    return Material(
      child: Ink(
        child: InkWell(
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new LiveRoomPage();
              }));
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          Util.getImgPath("bg_guess_entrece_01"),
                        ),
                        Container(
                          width: 60,
                          child: Center(
                              child: Text(
                            "直播中",
                            style: TextStyle(color: Colors.white),
                          )),
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                        ),
                      ],
                      alignment: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(title),
                    ),
                  )
                ],
              ),
            )),
        decoration: BoxDecoration(
          border: Border.all(
              color: LiveColors.getColor(LiveColors.divider), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  Widget getAnchorItemContainer(
      String title, String percent, MaterialColor mc) {
    return Material(
      child: Ink(
        child: InkWell(
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new WebViewPage(
                    "https://zhuanlan.zhihu.com/p/52409897", "第一现场");
              }));
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    child: Stack(
                      children: <Widget>[
                        AspectRatio(
                          child: Image.asset(
                            Util.getImgPath("bg_guess_entrece_02"),
                            fit: BoxFit.fill,
                          ),
                          aspectRatio: 1.43, //横纵比 长宽比  3:2
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: Container(
                            width: 80,
                            child: Center(
                                child: Text(
                              "重庆时时彩",
                              style: TextStyle(color: Colors.white),
                            )),
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                  colors: [
                                    mc[50],
                                    mc[500],
                                    mc[900],
                                  ],
                                  begin: FractionalOffset(1, 0),
                                  end: FractionalOffset(0, 1)),
                            ),
                            padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            width: 60,
                            child: Center(
                                child: Text(
                              "直播中",
                              style: TextStyle(color: Colors.white),
                            )),
                            alignment: Alignment.topRight,
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            width: 100,
                            child: Center(
                                child: Text(
                              "卡路卡路卡路",
                              style: TextStyle(color: Colors.white),
                            )),
                            alignment: Alignment.bottomRight,
                            padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                          ),
                        ),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ],
              ),
            )),
        decoration: BoxDecoration(
          border: Border.all(
              color: LiveColors.getColor(LiveColors.divider), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  Widget getExpertItemContainer(String item, String percent, MaterialColor mc) {
    return Material(
      child: Ink(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          border: Border.all(
              color: LiveColors.getColor(LiveColors.divider), width: 1.0),
        ),
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    'assets/images/ic_defualt_girl.png',
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Align(
                          child: Text(
                            item,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "盈利：",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              Text(
                                percent,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                mc[50],
                                mc[500],
                                mc[900],
                              ],
                                  begin: FractionalOffset(1, 0),
                                  end: FractionalOffset(0, 1))),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10.0),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(5.0),
          ),
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (BuildContext context) {
                  return new SelectImage();
                }));
          },
        ),
      ),
    );
  }
}
