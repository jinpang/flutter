import 'package:flutter/material.dart';
import 'package:flutter_live/common/constants/live_colors.dart';
import 'package:flutter_live/common/utils/util.dart';
import 'package:flutter_live/components/app_bar.dart';

import 'message_dialog.dart';

class VoucherCenterPage extends StatefulWidget {
  @override
  _VoucherCenterPageState createState() => _VoucherCenterPageState();
}

class _VoucherCenterPageState extends State<VoucherCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.getAppBar(
          context: context,
          showBackIcon: true,
          title: "充值中心",
          rightText: "联系客服",
          rightFunction: () {
            Util.showSnackBar(context, "联系客服");
          }),
      body: Container(
        color: LiveColors.getColor(LiveColors.divider),
        child: Stack(
          children: <Widget>[
            ListView.separated(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return getTopHeader();
                } else if (index == 1) {
                  return getListPay();
                } else if (index == 2) {
                  return getVoucherMoney();
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return getDivider(10);
              },
              itemCount: 3,
            ),
            getToPayBtn(),
          ],
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }

  getToPayBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            "应支付金额：200元",
            style: TextStyle(
              color: LiveColors.getColor(LiveColors.text3),
            ),
          ),
          RaisedButton(
            onPressed: () {
              showDialog<Null>(
                  context: context, //BuildContext对象
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return new MessageDialog(
                      title: "充值提示",
                      message: "请您在新打开的页面上完成充值",
                      negativeText: "充值完成",
                      positiveText: "继续充值",
                      onCloseEvent: () {
                        Navigator.pop(context); //关闭对话框
                      },
                      onPositivePressEvent: () {
                        Navigator.pop(context); //关闭对话框
                      },
                    );
                  });
            },
            child: Text("去支付"),
            color: Colors.orange[900],
            textColor: Colors.white,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  getTopHeader() {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 50, top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                Padding(
                  child: Image.asset(
                    Util.getImgPath("ic_defualt_girl"),
                    width: 50,
                    height: 50,
                  ),
                  padding: EdgeInsets.only(
                    left: 0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "超级玩家",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  children: <Widget>[
                    Text(
                      "账户余额：",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "0彩币",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 15,
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )),
        ],
      ),
    );
  }

  getDivider(double h) {
    return Container(
      height: h,
      color: LiveColors.getColor(LiveColors.divider),
    );
  }

  getDivider2(double h) {
    return Container(
      height: h,
      child: Row(
        children: <Widget>[
          Container(
            height: h,
            width: 15,
            color: LiveColors.getColor(LiveColors.white),
          ),
          Expanded(
              child: Container(
            height: h,
            color: LiveColors.getColor(LiveColors.divider),
          )),
        ],
      ),
    );
  }

  getPayWayTitleItem() {
    return ListTile(
      title: Text("选择支付方式"),
    );
  }

  int curIndex = 0;

  getPayWayWXItem() {
    return ListTile(
      title: Text("微信支付"),
      leading: Image.asset(
        Util.getImgPath("ic_wx"),
        width: 30,
        height: 30,
      ),
      trailing: Checkbox(
        value: curIndex == 0,
        onChanged: (changed) {
          if (changed == true) {
            curIndex = 0;
          }
          setState(() {});
        },
        activeColor: Colors.orange,
        checkColor: Colors.white,
      ),
    );
  }

  getPayWayZFBItem() {
    return ListTile(
      title: Text("支付宝支付"),
      leading: Image.asset(
        Util.getImgPath("ic_zfb"),
        width: 30,
        height: 30,
      ),
      trailing: Checkbox(
        value: curIndex == 1,
        onChanged: (changed) {
          if (changed == true) {
            curIndex = 1;
          }
          setState(() {});
        },
        activeColor: Colors.orange,
        checkColor: Colors.white,
      ),
    );
  }

  getPayWayYHItem() {
    return ListTile(
      title: Text("银联支付"),
      leading: Image.asset(
        Util.getImgPath("ic_yh"),
        width: 30,
        height: 30,
      ),
      trailing: Checkbox(
        value: curIndex == 2,
        onChanged: (changed) {
          if (changed == true) {
            curIndex = 2;
          }
          setState(() {});
        },
        activeColor: Colors.orange,
        checkColor: Colors.white,
      ),
    );
  }

  getListPay() {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return getPayWayTitleItem();
          } else if (index == 1) {
            //return getPayWayWXItem();
            return createPayItem("微信支付", "ic_wx");
          } else if (index == 2) {
            //return getPayWayZFBItem();
            return createPayItem("支付宝支付", "ic_zfb");
          } else if (index == 3) {
            //return getPayWayYHItem();
            return createPayItem("银联支付", "ic_yh");
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return getDivider2(1);
        },
        itemCount: 4,
        shrinkWrap: true,
        physics: null,
      ),
    );
  }

  String curPayTitle;

  createPayItem(String title, String icon) {
    return CheckboxListTile(
      secondary: Image.asset(
        Util.getImgPath(icon),
        width: 30,
        height: 30,
      ),
      title: Text(title),
      value: this.curPayTitle == title,
      onChanged: (bool value) {
        setState(() {
          this.curPayTitle = title;
        });
      },
      activeColor: Colors.orange,
    );
  }

  Color colorSelectedBg = Colors.orange;
  Color colorUnSelectedBg = Colors.white;
  Color colorSelectedText = Colors.white;
  Color colorUnSelectedText = Colors.orange;
  int selectedCur = 0;

  getColorText(bool selected) {
    return selected ? colorSelectedText : colorUnSelectedText;
  }

  getColorBg(bool selected) {
    return selected ? colorSelectedBg : colorUnSelectedBg;
  }

  getVoucherMoney() {
    return Container(
      color: Colors.white,
      child: Padding(padding: EdgeInsets.only(bottom: 30), child: Column(
        children: <Widget>[
          Align(
            child: ListTile(title: Text("选择充值金额")),
            alignment: Alignment.centerLeft,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(0),
                  child: RaisedButton(
                    onPressed: () {
                      selectedCur = 0;
                      setState(() {});
                    },
                    child: Text("200彩币"),
                    color: getColorBg(selectedCur == 0),
                    textColor: getColorText(selectedCur == 0),
                    padding: EdgeInsets.all(2),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: RaisedButton(
                      onPressed: () {
                        selectedCur = 1;
                        setState(() {});
                      },
                      child: Text("300彩币"),
                      color: getColorBg(selectedCur == 1),
                      textColor: getColorText(selectedCur == 1),
                      padding: EdgeInsets.all(2),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: RaisedButton(
                      onPressed: () {
                        selectedCur = 2;
                        setState(() {});
                      },
                      child: Text("500彩币"),
                      color: getColorBg(selectedCur == 2),
                      textColor: getColorText(selectedCur == 2),
                      padding: EdgeInsets.all(2),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: RaisedButton(
                    onPressed: () {
                      selectedCur = 3;
                      setState(() {});
                    },
                    child: Text("1000彩币"),
                    color: getColorBg(selectedCur == 3),
                    textColor: getColorText(selectedCur == 3),
                    padding: EdgeInsets.all(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),),
    );
  }
}
