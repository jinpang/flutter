import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_live/common/constants/live_colors.dart';
import 'package:flutter_live/common/utils/util.dart';
import 'package:flutter_live/common/utils/toast_util.dart';
import 'package:flutter_live/module/guess/guess_page.dart';
import 'package:flutter_live/module/live/live_home_page.dart';
import 'package:flutter_live/module/live/live_page.dart';
import 'package:flutter_live/module/lottery/lottery_page.dart';
import 'package:flutter_live/module/mine/mine_page.dart';
import 'package:flutter_live/module/rank/rank_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;
  String appBarTitle = tabData[0]['text'];
  static List tabData = [
    {
      'text': '直播',
      'icon': new ImageIcon(AssetImage(
        Util.getImgPath("ic_live_unselect"),
      ))
    },
    {
      'text': '彩票',
      'icon': new ImageIcon(AssetImage(
        Util.getImgPath("ic_lottery_unselect"),
      ))
    },
    {
      'text': '竞猜',
      'icon': new ImageIcon(AssetImage(
        Util.getImgPath("ic_guess_unselect"),
      ))
    },
    {
      'text': '排行',
      'icon': new ImageIcon(AssetImage(
        Util.getImgPath("ic_rank_unselect"),
      ))
    },
    {
      'text': '我的',
      'icon': new ImageIcon(AssetImage(
        Util.getImgPath("ic_my_unselect"),
      ))
    }
  ];

  List<Widget> myTabs = [];

  @override
  void initState() {
    super.initState();

    initSearchHistory();
    controller = new TabController(
        initialIndex: 0,
        vsync: this,
        length: tabData.length); // 这里的length 决定有多少个底导 submenus
    for (int i = 0; i < tabData.length; i++) {
      myTabs.add(new Tab(text: tabData[i]['text'], icon: tabData[i]['icon']));
    }
    controller.addListener(() {
      if (controller.indexIsChanging) {
        _onTabChange();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  initSearchHistory() async {}

  @override
  Widget build(BuildContext context) {
    LivePageState.getIndexListData();
    return WillPopScope(
      onWillPop: () {
//        return _dialogExitApp(context);
        return doubleClickBack();
      },
      child: Scaffold(
        body: getBody(),
        bottomNavigationBar: Material(
          color: const Color(0xFFF0EEEF), //底部导航栏主题颜色
          child: SafeArea(
            child: Container(
              height: 65.0,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: LiveColors.getColor(LiveColors.divider),
                  width: 1,
                ),
                /*boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFFd0d0d0),
                    blurRadius: 3.0,
                    spreadRadius: 2.0,
                    offset: Offset(-1.0, -1.0),
                  ),
                ],*/
              ),
              child: TabBar(
                  controller: controller,
                  indicatorColor: Colors.transparent,
                  //tab标签的下划线颜色
                  // labelColor: const Color(0xFF000000),
                  //indicatorWeight: 3.0,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: const Color(0xFF8E8E8E),
                  tabs: myTabs),
            ),
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return new TabBarView(controller: controller, children: <Widget>[
      new LiveHomePage(),
      new LotteryPage(),
      new GuessPage(),
      new RankPage(),
      new MinePage()
    ]);
  }

  void _onTabChange() {
    if (this.mounted) {
      this.setState(() {
        appBarTitle = tabData[controller.index]['text'];
      });
    }
  }

  /// 不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(true);
  }

  DateTime _lastPressedAdt;

  Future<bool> doubleClickBack() async {
    //当_lastPressedAdt 为空说明是第一次点击
    // 当Date.now().different(_lastPressAdt) 是比较当前时间和上一次点击的时间，如果差距小于1秒钟
    //当满足这两种情况的时候，说明这个可能是意外点击到了返回按钮，在这里我们返回flase，表示不响应
    if (_lastPressedAdt == null ||
        DateTime.now().difference(_lastPressedAdt) > Duration(seconds: 2)) {
      //两次点击时间间隔超过1秒则重新计时
      ToastUtil.show(context, "再按一次退出应用");
      _lastPressedAdt = DateTime.now();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
