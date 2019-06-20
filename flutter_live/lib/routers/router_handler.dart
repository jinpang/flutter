import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_live/module/home/home.dart';
import 'package:flutter_live/module/rank/rank_page.dart';
import 'package:flutter_live/module/webview/web_view_page.dart';

// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new HomePage();
  },
);

var webViewPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params['title']?.first;
  String url = params['url']?.first;
  return new WebViewPage(url, title);
});

var rankHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new RankPage();
  },
);