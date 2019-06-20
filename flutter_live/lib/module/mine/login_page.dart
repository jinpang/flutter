import 'package:flutter/material.dart';
import 'package:flutter_live/common/utils/toast_util.dart';
import 'package:flutter_live/components/app_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  Color _eyeColor;
  bool _isClickEye = false;
  String _userName;
  String _pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar.getAppBar(
            context: context, showBackIcon: true, title: "登录"),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              //initTitle(),
              //initHorizontalLine(),
              SizedBox(height: 80.0),
              initLoginName(),
              SizedBox(height: 30.0),
              initLoginPWD(),
              initForgetPwd(),
              SizedBox(height: 50.0),
              initButton(),
              initRegister(),
              SizedBox(height: 100.0),
              initBottomIcon()
            ],
          ),
        ));
  }

  Padding initTitle() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        'Login View',
        style: TextStyle(
            fontSize: 30.0,
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
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

  TextFormField initLoginName() {
    return TextFormField(
      onSaved: (String value) => _pwd = value,
      maxLength: 11,
      decoration: InputDecoration(labelText: '用户名'),
      validator: (String value) {
        var isPhone = RegExp("^1[3456789][0-9]{9}");
        if (!isPhone.hasMatch(value)) {
          return '用户名格式不正确';
        }
      },
    );
  }

  TextFormField initLoginPWD() {
    return TextFormField(
      obscureText: _isClickEye,
      onSaved: (String value) => _userName = value,
      validator: (String value) {
        if (value.isEmpty) {
          return '密码不能为空';
        }
      },
      decoration: InputDecoration(
        labelText: '密码',
        suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye, color: _eyeColor),
            onPressed: () {
              setState(() {
                _isClickEye = !_isClickEye;
                _eyeColor = _isClickEye ? Colors.grey : Colors.blue;
              });
            }),
      ),
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

  Align initButton() {
    return Align(
      child: SizedBox(
        width: 300.0,
        height: 50.0,
        child: RaisedButton(
          child: Text(
            '登录',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.deepOrangeAccent,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              ToastUtil.show(context, _userName + "----" + _pwd);
            }
          },
          shape:
              StadiumBorder(side: BorderSide(color: Colors.deepOrangeAccent)),
        ),
      ),
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

  Align initBottomIcon() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(Icons.android,
                        size: 50, color: Colors.deepOrangeAccent),
                    onPressed: () {}),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(
                      Icons.desktop_windows,
                      size: 50,
                      color: Colors.deepOrangeAccent,
                    ),
                    onPressed: () {}),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(Icons.directions_bike,
                        size: 50, color: Colors.deepOrangeAccent),
                    onPressed: () {}),
              ),
            ],
          ),
          alignment: Alignment.center,
        ));
  }
}
