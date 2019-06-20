import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_live/components/app_bar.dart';
import 'package:flutter_live/entity/collection.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);

  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _hasCollected = false;
  String _router = '';
  var _collectionIcons;
  CollectionControlModel _collectionControl = new CollectionControlModel();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _collectionControl
        .getRouterByName(Uri.encodeComponent(widget.title.trim()))
        .then((list) {
      list.forEach((item) {
        if (widget.title.trim() == item['name']) {
          _router = item['router'];
        }
      });
      if (mounted) {
        setState(() {
          _hasCollected = list.length > 0;
        });
      }
    });
  }

  // 点击收藏按钮
  _getCollection() {
    if (_hasCollected) {
      // 删除操作
      _collectionControl
          .deleteByName(Uri.encodeComponent(widget.title.trim()))
          .then((result) {
        if (result > 0 && this.mounted) {
          setState(() {
            _hasCollected = false;
          });
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('已取消收藏')));
          return;
        }
        print('删除错误');
      });
    } else {
      // 插入操作
      _collectionControl
          .insert(Collection(
              name: Uri.encodeComponent(widget.title.trim()),
              router: widget.url))
          .then((result) {
        if (this.mounted) {
          setState(() {
            _hasCollected = true;
          });

          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text('收藏成功')));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasCollected) {
      _collectionIcons = Icons.favorite;
    } else {
      _collectionIcons = Icons.favorite_border;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar.getAppBar(context: context, title: widget.title.trim(), showBackIcon: true),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
      ),
    );
  }
}
