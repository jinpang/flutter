import 'package:flutter/material.dart';
import 'package:flutter_live/common/constants/live_colors.dart';
import 'package:flutter_live/components/app_bar.dart';
import 'package:flutter_live/common/utils/toast_util.dart';
import 'package:flutter_live/components/chewie_video.dart';
import 'package:flutter_live/entity/mine_item_model.dart';
import 'package:flutter_live/module/mine/voucher_center_page.dart';

import 'login_page.dart';
import 'login_register_page.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MinePageState();
  }
}

class MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  List<MineItemModel> dataList;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void setState(VoidCallback fn) {}

  @override
  void initState() {
    dataList = createTestData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      MyAppBar.getAppBar(backFunction:(){
        Navigator.pop(context);
      },context:context, title:"我的", rightIcon:"assets/images/ic_setting.png", rightFunction:() {
        showAlertDialog(context);
      }),
      Expanded(
        flex: 1,
        child: RefreshIndicator(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            itemCount: dataList.length,
            separatorBuilder: (BuildContext context, int index) {
              MineItemModel model = dataList[index];
              if (model.title == "head") {
                return Divider(
                  height: 0,
                  color: Colors.white,
                );
              } else {
                return Divider(
                  height: 1.0,
                  color: LiveColors.getColor(LiveColors.divider),
                );
              }
            },
            itemBuilder: (BuildContext context, int index) {
              MineItemModel model = dataList[index];
              if (model.title == "head") {
                return getMyTopWidget(
                    "超级民间专家", 'assets/images/ic_defualt_girl.png');
              } else {
                return getMyContentItem(model.title, model.image,
                    model.rightText, model.rightImage, index);
              }
            },
            controller: null,

          ),
          onRefresh: _handleRefresh,
        ),
      ),
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

  void showAlertDialog(BuildContext context) {
    ToastUtil.show(context, "打开设置");
  }

  Widget getMyTopWidget(String nickname, String avatar) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                avatar,
              ),
            ),
            margin: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: Align(
              child: Text(
                nickname,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decorationStyle: TextDecorationStyle.solid),
                textAlign: TextAlign.center,
              ),
              alignment: Alignment.center,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
            color: LiveColors.getColor(LiveColors.divider),
            height: 1.0,
          ),
          Container(
            child: Row(
              children: <Widget>[
                getMyFollowBtn("关注", "assets/images/ic_mine_follow.png"),
                getMyFollowBtn("粉丝", "assets/images/ic_mine_fans.png"),
                getMyFollowBtn(
                    "彩币", "assets/images/ic_mine_color_currency.png"),
                getMyFollowBtn("充值", "assets/images/ic_mine_recharge.png"),
                getMyFollowBtn("活动", "assets/images/ic_hot_activity.png"),
              ],
            ),
          ),
          Container(
            color: LiveColors.getColor(LiveColors.divider),
            height: 15,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Widget getMyFollowBtn(String title, String icon) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
                return new LoginRegisterPage();
              }));
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Image.asset(
                icon,
                height: 25,
                width: 25,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  Widget getMyContentItem(
      String title, String image, String rightText, String rightImage, int index) {
    return InkWell(
      onTap: () {
        /*if (index == 0){
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
                return new VoucherCenterPage();
              }));
        }else {
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
                return new ChewieDemo();
              }));
        }*/
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
              return new VoucherCenterPage();
            }));
      },
      child: Container(
        height: 50,
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(
                image,
                width: 25,
                height: 25,
              ),
            ),
            Container(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              margin: EdgeInsets.all(5.0),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: getItemRightWidget(rightText, rightImage),
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10.0),
      ),
    );
  }

  List<Widget> getItemRightWidget(String rightText, String rightIcon) {
    List<Widget> list = new List();
    if (rightText != null) {
      list.add(Container(
        child: Text(
          rightText,
          style: TextStyle(
            color: Colors.red,
            fontSize: 14,
          ),
        ),
        margin: EdgeInsets.all(5.0),
      ));
    }
    if (rightIcon != null) {
      list.add(Image.asset(
        rightIcon,
        width: 15,
        height: 15,
      ));
    }
    return list;
  }

  List<MineItemModel> createTestData() {
    List<MineItemModel> list = new List();
    list.add(MineItemModel("head", "", "", ""));
    list.add(MineItemModel("个人中心", "assets/images/ic_mine_my_center.png", null,
        "assets/images/ic_more3.png"));
    list.add(MineItemModel("商城道具", "assets/images/ic_mine_mall_props.png",
        "最炫道具热卖中", "assets/images/ic_hot.png"));
    list.add(MineItemModel("任务大厅", "assets/images/ic_mine_task_hall.png",
        "最炫道具热卖中", "assets/images/ic_task.png"));
    list.add(MineItemModel("Y币兑换", "assets/images/ic_mine_currency_swap.png",
        null, "assets/images/ic_more3.png"));
    list.add(MineItemModel("消息中心", "assets/images/ic_mine_message_center.png",
        null, "assets/images/ic_more3.png"));
    list.add(MineItemModel("交易流水", "assets/images/ic_mine_transaction_flow.png",
        null, "assets/images/ic_more3.png"));
    list.add(MineItemModel("竞猜订单", "assets/images/ic_mine_order.png", null,
        "assets/images/ic_more3.png"));
    list.add(MineItemModel("打赏记录", "assets/images/ic_mine_reward_record.png",
        null, "assets/images/ic_more3.png"));
    list.add(MineItemModel(
        "我要当主播",
        "assets/images/ic_mine_application_anchor.png",
        null,
        "assets/images/ic_more3.png"));
    list.add(MineItemModel("联系客服", "assets/images/ic_mine_customer_service.png",
        null, "assets/images/ic_more3.png"));
    return list;
  }
}
