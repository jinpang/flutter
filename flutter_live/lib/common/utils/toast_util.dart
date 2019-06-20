import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live/common/utils/util.dart';

class ToastUtil {
  static OverlayEntry entry;
  static Future future;

  static void show(BuildContext context, String message, {int duration}) {
    if (future != null) {
      return;
    }
    entry = OverlayEntry(builder: (context) {
      return Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.7,
        ),
        padding: EdgeInsets.only(left: 30, right: 30),
        alignment: Alignment.center,
        child: Center(
          child: Container(
            //color: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  backgroundColor: Colors.transparent,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        ),
      );
    });

    Overlay.of(context).insert(entry);
    future = Future.delayed(Duration(seconds: duration ?? 2)).then((value) {
      future = null;
      cancel();
    });
  }

  static void showWarn(BuildContext context, String message,
      {int duration, String prefixIconName, Color iconColor, Color bgColor}) {
    if (future != null) {
      return;
    }
    entry = OverlayEntry(builder: (context) {
      return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                child: Image.asset(
                  Util.getImgPath(prefixIconName ?? "ic_exclamation_point"),
                  width: 20,
                  height: 20,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(message,
                      style: TextStyle(
                        color: iconColor ?? Colors.orange,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        backgroundColor: Colors.transparent,
                        decoration: TextDecoration.none,
                      )),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
              color: bgColor ?? Colors.white,
              border: Border.all(
                color: iconColor ?? Colors.orange,
                width: 1,
              ),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      );
    });

    Overlay.of(context).insert(entry);
    future = Future.delayed(Duration(seconds: duration ?? 2)).then((value) {
      future = null;
      cancel();
    });
  }

  static void showError(BuildContext context, String message, {int duration}) {
    showWarn(context, message,
        prefixIconName: "ic_toast_error",
        iconColor: Colors.red,
        bgColor: Colors.white);
  }

  static void showSuccess(BuildContext context, String message,
      {int duration}) {
    showWarn(context, message,
        prefixIconName: "ic_toast_success",
        iconColor: Colors.cyan,
        bgColor: Colors.black87);
  }

  static cancel() {
    // 移除层可以通过调用OverlayEntry的remove方法。
    if (entry != null) {
      entry.remove();
      entry = null;
    }
  }
}
