import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live/components/app_bar.dart';

import 'lottery_item.dart';

class LotteryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LotteryPageState();
  }
}

class LotteryPageState extends State<LotteryPage> {
  ScrollController _scrollController = new ScrollController();
  bool _hasMore = true;
  bool isLoading = false;
  int _pageIndex = 0; // 页面的索引
  int _pageTotal = 0; // 页面的索引

  @override
  void initState() {
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startCountdownTimer();
    return getItemWidget(20);
  }

  int items = 20;

  getItemWidget(int size) {
    return new Column(
      children: <Widget>[
        //MyAppBar.getAppBar(context, "彩票大厅", null, null),
        MyAppBar.getAppBar(title:"彩票大厅"),
        new Expanded(
            child: new RefreshIndicator(
          child: ListView.separated(
            padding: EdgeInsets.all(0),
            itemCount: items,
            separatorBuilder: (BuildContext context, int index) {
              return new Divider(
                height: 1.0,
                color: Colors.grey,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              if (index == items) {
                //return _buildLoadText();
                return _buildProgressIndicator();
              }
              return new LotteryItem(
                itemUrl: "https://flutterchina.club/flutter-for-android/",
                itemTitle: "彩票中心$index",
                data: "1,6,9,8,7,5,2,1,3,4",
                countdownTime: _countdownTime,
              );
            },
            controller: _scrollController,
          ),
          onRefresh: _handleRefresh,
        ))
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

// 下拉加载的事件，清空之前list内容，取前X个
// 其实就是列表重置
  Future<Null> _handleRefresh() async {
    if (this.mounted) {
      setState(() {
        isLoading = false;
        _hasMore = true;
        return null;
      });
    }
  }

// 上提加载loading的widget,如果数据到达极限，显示没有更多
  Widget _buildProgressIndicator() {
    if (_hasMore) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
            child: Column(
          children: <Widget>[
            new Opacity(
              opacity: isLoading ? 1.0 : 0.0,
              child: new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue)),
            ),
            SizedBox(height: 20.0),
            Text(
              '稍等片刻更精彩...',
              style: TextStyle(fontSize: 14.0),
            )
          ],
        )
            //child:
            ),
      );
    } else {
      return _buildLoadText();
    }
  }

// 加载中的提示
  Widget _buildLoadText() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Center(
        child: Text("数据没有更多了！！！"),
      ),
    ));
  }

// list探底，执行的具体事件
  Future _getMoreData() async {
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() => isLoading = true);
      }
      //if(_hasMore){ // 还有数据可以拉新
      //List newEntries = await mokeHttpRequest();
      //if (newEntries.isEmpty) {
      _hasMore = true;
      if (this.mounted) {
        setState(() {
          //items.addAll(newEntries);
          isLoading = false;
        });
      }
      //backElasticEffect();
    } else if (!isLoading && !_hasMore) {
      // 这样判断,减少以后的绘制
      _pageIndex = 0;
      //backElasticEffect();
    }
  }

  Timer _timer;
  int _countdownTime = 1000;

  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);
    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              _timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          })
        };
    _timer = Timer.periodic(oneSec, callback);
  }
}
