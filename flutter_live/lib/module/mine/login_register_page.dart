import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live/common/constants/live_colors.dart';
import 'package:flutter_live/common/utils/theme_utils.dart';
import 'package:flutter_live/common/utils/toast_util.dart';
import 'package:flutter_live/common/utils/util.dart';
import 'package:flutter_live/components/app_bar.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => new _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  Color _eyeColor;
  bool _isClickEye = true;
  String _userName;
  String _pwd;
  String _nickname;
  String _code;

  static const double contentPaddingVertical = 13.0;
  static const double contentPaddingHorizontal = 10.0;

  static const String loginTitle = "登录";
  static const String registerTitle = "注册";
  static const String loginCodeTip = "手机快捷登录";
  static const String loginPwdTip = "账号密码登录";

  String title = loginTitle;
  String loginTip = loginPwdTip;
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: "登录"),
    Tab(text: "注册"),
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        title = loginTitle;
      } else {
        title = registerTitle;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar.getAppBar(
            context: context, showBackIcon: true, title: title),
        body: Container(
          padding: EdgeInsets.only(top: 30),
          color: LiveColors.getColor(LiveColors.divider),
          child: Scaffold(
            backgroundColor: LiveColors.getColor(LiveColors.divider),
            body: Column(
              children: <Widget>[
                Padding(
                  child: TabBar(
                    controller: _tabController,
                    tabs: myTabs,
                    labelColor: Colors.red,
                    unselectedLabelColor: LiveColors.getColor(LiveColors.text1),
                    indicatorPadding: EdgeInsets.fromLTRB(50, 0, 50, 10),
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.only(left: 70, right: 70),
                ),
                Expanded(
                  child: Form(
                      key: _formKey,
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          createLoginUI(loginTip), //登录页面
                          createRegisterUI(), //注册页面
                        ],
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  createLoginUI(String loginTip) {
    if (loginTip == loginPwdTip) {
      //手机快捷登录
      return ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                initLoginPhone(),
                SizedBox(height: 30.0),
                initLoginCode(),
                initAccountPwdLogin(loginPwdTip),
                SizedBox(height: 30.0),
              ],
            ),
          ),
          Container(
            child: initButton(title),
            color: LiveColors.getColor(LiveColors.divider),
          ),
        ],
      );
    } else if (loginTip == loginCodeTip) {
      return ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                initLoginPhone(),
                SizedBox(height: 30.0),
                initLoginPwd(),
                initAccountPwdLogin(loginCodeTip),
                SizedBox(height: 30.0),
              ],
            ),
          ),
          Container(
            child: initButton(title),
            color: LiveColors.getColor(LiveColors.divider),
          ),
        ],
      );
    }
  }

  createRegisterUI() {
    return ListView(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              initLoginPhone(),
              SizedBox(height: 30.0),
              initRegisterPwd(),
              SizedBox(height: 30.0),
              initRegisterNickname(),
              SizedBox(height: 30.0),
              initLoginCode(),
              SizedBox(height: 30.0),
            ],
          ),
          color: Colors.white,
        ),
        Container(
          child: initButton(title),
          color: LiveColors.getColor(LiveColors.divider),
        ),
      ],
      shrinkWrap: true,
    );
  }

  Padding initHorizontalLine() {
    return Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.deepOrange,
            width: 100,
            height: 2,
          ),
        ));
  }

  initLoginPhone() {
    return Container(
      child: Row(
        children: <Widget>[
          Center(
            child: ImageIcon(
              AssetImage(Util.getImgPath("ic_phone")),
              color: LiveColors.getColor(LiveColors.lightGrey),
            ),
          ),
          Expanded(
              child: Padding(
            child: ThemeUtils.getTextFieldTheme(TextFormField(
              onSaved: (String value) => _userName = value,
              //maxLength: 11,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: contentPaddingVertical,
                    horizontal: contentPaddingHorizontal),
                hintText: '请输入手机号码',
                hintStyle: TextStyle(
                  color: LiveColors.getColor(LiveColors.lightGrey),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: LiveColors.getColor(LiveColors.lightGrey),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (String value) {
                /*var isPhone = RegExp("^1[3456789][0-9]{9}");
                if (!isPhone.hasMatch(value)) {
                  return '手机号码不正确';
                }*/
                _userName = value;
              },
            )),
            padding: EdgeInsets.only(left: 10, right: 10),
          )),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.only(left: 30, right: 30),
    );
  }

  initRegisterNickname() {
    return Container(
      child: Row(
        children: <Widget>[
          Center(
            child: ImageIcon(AssetImage(Util.getImgPath("ic_nick_name")),
                color: LiveColors.getColor(LiveColors.lightGrey)),
          ),
          Expanded(
              child: Padding(
            child: Column(
              children: <Widget>[
                ThemeUtils.getTextFieldTheme(TextFormField(
                  onSaved: (String value) => _nickname = value,
                  //maxLength: 11,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: contentPaddingVertical,
                        horizontal: contentPaddingHorizontal),
                    hintText: '请输入你的昵称',
                    hintStyle: TextStyle(
                      color: LiveColors.getColor(LiveColors.lightGrey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: LiveColors.getColor(LiveColors.lightGrey),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    /*helperText: "限输入6-12个字符的中文/数字/字母等",
                    helperStyle: TextStyle(
                        color: Colors.deepOrangeAccent[400], fontSize: 12),*/
                  ),
                  validator: (String value) {
                    /*var isPhone = RegExp("a-zA-Z\u4e00-\u9fa5");
                    if (!isPhone.hasMatch(value)) {
                      return '昵称不正确';
                    }*/
                    _nickname = value;
                  },
                )),
                initHelpText("限输入6-12个字符的中文/数字/字母等"),
              ],
            ),
            padding: EdgeInsets.only(left: 10, right: 10),
          )),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.only(left: 30, right: 30),
    );
  }

  initHelpText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(color: Colors.deepOrangeAccent[400], fontSize: 12),
      ),
    );
  }

  initLoginCode() {
    return Container(
      child: Row(
        children: <Widget>[
          Center(
            child: ImageIcon(AssetImage(Util.getImgPath("ic_auth_code")),
                color: LiveColors.getColor(LiveColors.lightGrey)),
          ),
          Expanded(
              child: Padding(
            child: ThemeUtils.getTextFieldTheme(TextFormField(
              onSaved: (String value) => _code = value,
              //maxLength: 11,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: contentPaddingVertical,
                    horizontal: contentPaddingHorizontal),
                hintText: '请输入验证码',
                hintStyle: TextStyle(
                  color: LiveColors.getColor(LiveColors.lightGrey),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: LiveColors.getColor(LiveColors.lightGrey),
                  ),
                ),
              ),
              validator: (String value) {
                /*if (value.isEmpty) {
                  return '验证码不能为空';
                }*/
                _code = value;
              },
            )),
            padding: EdgeInsets.only(left: 10, right: 10),
          )),
          Padding(
            child: Align(
              child: SizedBox(
                child: RaisedButton(
                  child: Text(
                    _codeCountdownStr,
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.deepOrangeAccent[100],
                  onPressed: () {
                    /*if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      ToastUtil.show(context, _userName + "----" + _pwd);
                    }*/
                    reGetCountdown();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(left: 10, right: 10),
                ),
              ),
            ),
            padding: EdgeInsets.only(right: 10),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.only(left: 30, right: 30),
    );
  }

  initLoginPwd() {
    return Container(
      child: Row(
        children: <Widget>[
          Center(
            child: ImageIcon(AssetImage(Util.getImgPath("ic_lock")),
                color: LiveColors.getColor(LiveColors.lightGrey)),
          ),
          Expanded(
              child: Padding(
            child: ThemeUtils.getTextFieldTheme(TextFormField(
              onSaved: (String value) => _pwd = value,
              //maxLength: 11,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: contentPaddingHorizontal),
                hintText: '请输入密码',
                hintStyle: TextStyle(
                  color: LiveColors.getColor(LiveColors.lightGrey),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: LiveColors.getColor(LiveColors.lightGrey),
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                    icon: ImageIcon(AssetImage(Util.getImgPath("ic_lock")),
                        color: _eyeColor),
                    onPressed: () {
                      setState(() {
                        _isClickEye = !_isClickEye;
                        _eyeColor =
                            _isClickEye ? Colors.grey : Colors.deepOrangeAccent;
                      });
                    }),
              ),
              obscureText: _isClickEye,
              validator: (String value) {
                /*if (value.isEmpty) {
                  return '密码不能为空';
                }*/
                _pwd = value;
              },
            )),
            padding: EdgeInsets.only(left: 10, right: 10),
          )),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.only(left: 30, right: 30),
    );
  }

  initRegisterPwd() {
    return Container(
      child: Row(
        children: <Widget>[
          Center(
            child: ImageIcon(AssetImage(Util.getImgPath("ic_lock")),
                color: LiveColors.getColor(LiveColors.lightGrey)),
          ),
          Expanded(
              child: Padding(
            child: Column(
              children: <Widget>[
                ThemeUtils.getTextFieldTheme(TextFormField(
                  onSaved: (String value) => _pwd = value,
                  //maxLength: 11,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: contentPaddingHorizontal),
                    hintText: '请输入密码',
                    hintStyle: TextStyle(
                      color: LiveColors.getColor(LiveColors.lightGrey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: LiveColors.getColor(LiveColors.lightGrey),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                        icon: ImageIcon(AssetImage(Util.getImgPath("ic_lock")),
                            color: _eyeColor),
                        onPressed: () {
                          setState(() {
                            _isClickEye = !_isClickEye;
                            _eyeColor = _isClickEye
                                ? Colors.grey
                                : Colors.deepOrangeAccent;
                          });
                        }),
                    /*helperText: "限输入6-12个字符的中文/数字/字母等",
                    helperStyle: TextStyle(
                        color: Colors.deepOrangeAccent[400], fontSize: 12),*/
                  ),
                  obscureText: _isClickEye,
                  validator: (String value) {
                    /*if (value.isEmpty) {
                      return '密码不能为空';
                    }*/
                    _pwd = value;
                  },
                )),
                initHelpText("限输入6-12个字符的中文/数字/字母等"),
              ],
            ),
            padding: EdgeInsets.only(left: 10, right: 10),
          )),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
      padding: EdgeInsets.only(left: 30, right: 30),
    );
  }

  Padding initForgetPwd() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            child: Text('忘记密码？'),
            onTap: () {
              ToastUtil.show(context, '忘记密码');
            },
          )),
    );
  }

  Padding initAccountPwdLogin(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, right: 10),
      child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            child: Text(
              title,
              style: TextStyle(color: LiveColors.getColor(LiveColors.text1)),
            ),
            onTap: () {
              setState(() {
                if (title == loginCodeTip) {
                  loginTip = loginPwdTip;
                } else {
                  loginTip = loginCodeTip;
                }
              });
            },
          )),
    );
  }

  initButton(String titleBtn) {
    return Padding(
      child: Align(
        child: SizedBox(
          width: 300.0,
          height: 50.0,
          child: RaisedButton(
              child: Text(
                titleBtn,
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.deepOrangeAccent,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                }
                if (title == loginTitle) {
                  if (loginTip == loginCodeTip) {
                    if (_userName == null || _userName.length == 0) {
                      ToastUtil.showWarn(context, "手机号不能为空");
                      return;
                    }
                    if (_pwd == null || _pwd.length == 0) {
                      ToastUtil.showWarn(context, "密码不能为空");
                      return;
                    }
                  } else {
                    if (_userName == null || _userName.length == 0) {
                      ToastUtil.showWarn(context, "手机号不能为空");
                      return;
                    }
                    if (_pwd == null || _pwd.length == 0) {
                      ToastUtil.showWarn(context, "密码不能为空");
                      return;
                    }
                    ToastUtil.showWarn(context, "登录成功");
                  }
                } else {
                  if (_userName == null || _userName.length == 0) {
                    ToastUtil.showWarn(context, "手机号不能为空");
                    return;
                  }
                  if (_pwd == null || _pwd.length == 0) {
                    ToastUtil.showError(context, "密码不能为空");
                    return;
                  }
                  if (_nickname == null || _nickname.length == 0) {
                    ToastUtil.showError(context, "昵称不能为空");
                    return;
                  }
                  ToastUtil.showSuccess(context, "注册成功");
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        ),
        alignment: Alignment.topCenter,
      ),
      padding: EdgeInsets.only(top: 30),
    );
  }

  Padding initRegister() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        child: Align(
          alignment: Alignment.center,
          child: Text('没有账号？点击注册'),
        ),
        onTap: () {
          ToastUtil.show(context, '点击注册');
        },
      ),
    );
  }

  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;

  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}重新获取';
      _countdownTimer = new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}重新获取';
          } else {
            _codeCountdownStr = '获取验证码';
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  // 不要忘记在这里释放掉Timer
  @override
  void dispose() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
}
