import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar {
  static const String defaultBackIcon = "assets/images/ic_back.png";

  static Widget getAppBar(
      {BuildContext context,
      String backIcon,
      Function backFunction,
      bool showBackIcon = false,
      String title,
      bool centerTitle = true,
      String rightText,
      String rightIcon,
      Function rightFunction}) {
    return AppBar(
      leading: getBackWidget(
          context: context,
          backIcon: backIcon,
          backFunction: backFunction,
          show: showBackIcon),
      actions: getActionsWidget(rightText, rightIcon, rightFunction),
      title: getTitleWidget(title),
      centerTitle: centerTitle,
    );
  }

  static getTitleWidget(String title) {
    return title != null
        ? Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        : null;
  }

  static getBackWidget(
      {BuildContext context,
      String backIcon,
      Function backFunction,
      bool show = false}) {
    if (show) {
      if (backIcon == null && backFunction == null) {
        if (context != null) {
          return IconButton(
            icon: ImageIcon(AssetImage(defaultBackIcon)),
            onPressed: context != null
                ? () {
                    Navigator.pop(context);
                  }
                : null,
          );
        } else {
          return ImageIcon(AssetImage(defaultBackIcon));
        }
      } else if (backIcon == null && backFunction != null) {
        return IconButton(
          icon: ImageIcon(AssetImage(defaultBackIcon)),
          onPressed: backFunction,
        );
      } else if (backIcon != null && backFunction == null) {
        if (context != null) {
          return IconButton(
            icon: ImageIcon(AssetImage(backIcon)),
            onPressed: context != null
                ? () {
                    Navigator.pop(context);
                  }
                : null,
          );
        } else {
          return ImageIcon(AssetImage(backIcon));
        }
      } else if (backIcon != null && backFunction != null) {
        return IconButton(
          icon: ImageIcon(AssetImage(backIcon)),
          onPressed: backFunction,
        );
      }
    } else {
      return null;
    }
  }

  static List<Widget> getActionsWidget(
      String rightText, String icon, Function rightFunction) {
    List<Widget> list = new List();
    if (rightText != null) {
      list.add(InkWell(
        child: Center(
            child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Text(
            rightText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
        onTap: rightFunction,
      ));
    } else if (icon != null) {
      if (rightFunction != null) {
        list.add(IconButton(
          icon: ImageIcon(AssetImage(icon)),
          onPressed: rightFunction,
        ));
      } else {
        list.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: ImageIcon(AssetImage(icon)),
        ));
      }
    }
    return list;
  }
}
