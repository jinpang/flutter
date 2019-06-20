import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live/common/constants/live_colors.dart';
import 'package:flutter_live/common/utils/util.dart';
import 'package:flutter_live/components/app_bar.dart';
import 'package:flutter_live/entity/rank_item_model.dart';
import 'package:flutter_live/module/rank/rank_list_refresh.dart';

class RankPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RankPageState();
  }
}

class RankPageState extends State<RankPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '主播人气榜'),
    Tab(text: '主播财富榜'),
    Tab(text: '主播胜率榜'),
  ];
  List<RankItemModel> dayList;
  List<RankItemModel> monthList;
  List<RankItemModel> totalList;

  TabController _tabController;
  int currentValue = 0;
  String prefix = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    prefix = myTabs.elementAt(0).text;
    _tabController.addListener(() {
      if(_tabController.index.toDouble() == _tabController.animation.value){
        switch (_tabController.index) {
          case 0:
            print(1);
            break;
          case 1:
            print(2);
            break;
          case 2:
            print(3);
            break;
        }
        prefix = myTabs.elementAt(_tabController.index).text;
      }
      setState(() {
      });
    });
    dayList = createTestData("人气榜", "日榜");
    monthList = createTestData("财富榜", "月榜");
    totalList = createTestData("胜率榜", "总榜");
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      MyAppBar.getAppBar(
          context: context,
          title: "排行榜",
          rightText: "排行榜说明",
          rightFunction: () {
            Util.showSnackBar(context, "排行榜说明");
          }),
      new Expanded(
        child: Container(
            child: Scaffold(
          appBar: TabBar(
            controller: _tabController,
            tabs: myTabs,
            labelColor: Colors.red,
            unselectedLabelColor: LiveColors.getColor(LiveColors.text1),
            indicatorPadding: EdgeInsets.fromLTRB(50, 0, 50, 2),
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: myTabs.map((Tab tab) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
                            color: LiveColors.getColor(LiveColors.divider),
                            child: CupertinoSegmentedControl<int>(
                              children: {
                                0: Padding(
                                  child: Text("日榜"),
                                  padding:
                                      EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                                ),
                                1: Padding(
                                  child: Text("月榜"),
                                  padding:
                                      EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                                ),
                                2: Padding(
                                  child: Text("总榜"),
                                  padding:
                                      EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                                ),
                              },
                              onValueChanged: (newValue) {
                                print("newValue:${newValue}");
                                setState(() {
                                  currentValue = newValue;
                                });
                              },
                              groupValue: currentValue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: RankListRefresh(getRankContentItem, getList()),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        )),
      )
    ]);
  }

  // 下拉加载的事件，清空之前list内容，取前X个
// 其实就是列表重置
  Future<Null> _handleRefresh() async {
    if (this.mounted) {
      setState(() {
        return null;
      });
    }
  }

  Widget getRankContentItem(
      int rankNo, String headImage, String nickname, double rankValue) {
    return InkWell(
      onTap: () {
        Util.showSnackBar(context, "点击了${rankNo}");
      },
      child: Container(
        //height: 50,
        child: Row(
          children: <Widget>[
            getRankWidget(rankNo),
            getRankHeadWidget(rankNo, headImage),
            Container(
              child: Text(
                nickname,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              margin: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: <Widget>[
                    Text(
                      "人气值：",
                      style: TextStyle(
                        fontSize: 15,
                        color: LiveColors.getColor(LiveColors.text3),
                      ),
                    ),
                    Text(
                      "${rankValue}万",
                      style: TextStyle(
                        fontSize: 15,
                        color: LiveColors.getColor(LiveColors.text4),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(20.0, 5, 15, 5),
      ),
    );
  }

  getRankWidget(int rank) {
    if (rank > 3) {
      return Container(
        width: 25,
        height: 25,
        child: Center(
          child: Text(
            "${rank}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      );
    } else {
      String path = "";
      if (rank == 1) {
        path = "assets/images/ic_rank1.png";
      } else if (rank == 2) {
        path = "assets/images/ic_rank2.png";
      } else if (rank == 3) {
        path = "assets/images/ic_rank3.png";
      }
      return Container(
        child: Image.asset(
          path,
          width: 25,
          height: 25,
        ),
      );
    }
  }

  getRankHeadWidget(int rank, String path) {
    String tag = "";
    if (rank == 1) {
      tag = "assets/images/ic_rank_head1.png";
    } else if (rank == 2) {
      tag = "assets/images/ic_rank_head2.png";
    } else if (rank == 3) {
      tag = "assets/images/ic_rank_head3.png";
    }
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
      child: Container(
        width: 63,
        height: 63,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: ClipOval(
                child: Image.asset(
                  path,
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),
              bottom: 8,
              right: 9,
            ),
            Positioned(
              child: Image.asset(
                tag,
                width: 56,
                height: 56,
              ),
              bottom: 8,
              right: 7,
            ),
          ],
          alignment: Alignment.center,
        ),
      ),
    );
  }

  List<RankItemModel> createTestData(String prefix, String title) {
    List<RankItemModel> list = new List();
    for (int i = 0; i < 10; i++) {
      list.add(RankItemModel("${prefix}-人气主播${i}-${title}",
          "assets/images/ic_defualt_girl.png", 2.6 + i, i + 1));
    }
    return list;
  }

  getList() {
    return createTestData(_tabController.index == 0 ? "人气榜" : (_tabController.index == 1 ? "财富榜" : "胜率榜"), currentValue == 0 ? "日榜" : (currentValue == 1 ? "月榜" : "总榜"));
  }
}
