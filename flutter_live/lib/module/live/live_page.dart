import 'package:flutter/material.dart';
import 'package:flutter_live/module/live/pagination.dart';
import 'package:flutter_live/common/utils/net_utils.dart';

import 'disclaimer_msg.dart';
import 'first_page_item.dart';
import 'list_refresh.dart' as listComp;
import 'list_view_item.dart';

class LivePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LivePageState();
  }
}

class LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      new Expanded(
          child: listComp.ListRefresh(getIndexListData, makeCard, headerView))
    ]);
  }

  headerView() {
    return Column(
      children: <Widget>[
        Stack(
            //alignment: const FractionalOffset(0.9, 0.1),//方法一
            children: <Widget>[
              Pagination(226),
              Positioned(
                  //方法二
                  top: 10.0,
                  left: 0.0,
                  child: DisclaimerMsg(key: new Key("test"), pWidget: this)),
            ]),
        SizedBox(
            height: 1, child: Container(color: Theme.of(context).primaryColor)),
        SizedBox(height: 10),
      ],
    );
  }

  Widget makeCard(index, item) {
    var myTitle = '${item.title}';
    var myUsername = '${'👲'}: ${item.username} ';
    var codeUrl = '${item.detailUrl}';
    return new ListViewItem(
      itemUrl: codeUrl,
      itemTitle: myTitle,
      data: myUsername,
    );
  }

  static Future<Map> getIndexListData([Map<String, dynamic> params]) async {
    const juejin_flutter =
        'https://timeline-merger-ms.juejin.im/v1/get_tag_entry?src=web&tagId=5a96291f6fb9a0535b535438';
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    final _param = {'page': pageIndex, 'pageSize': 20, 'sort': 'rankIndex'};
    var responseList = [];
    var pageTotal = 0;

    try {
      var response = await NetUtils.get(juejin_flutter, params: _param);
      responseList = response['d']['entrylist'];
      pageTotal = response['d']['total'];
      if (!(pageTotal is int) || pageTotal <= 0) {
        pageTotal = 0;
      }
    } catch (e) {}
    pageIndex += 1;
    List resultList = new List();
    for (int i = 0; i < responseList.length; i++) {
      try {
        FirstPageItem cellData = new FirstPageItem.fromJson(responseList[i]);
        resultList.add(cellData);
      } catch (e) {
        // No specified type, handles all
      }
    }
    Map<String, dynamic> result = {
      "list": resultList,
      'total': pageTotal,
      'pageIndex': pageIndex
    };
    return result;
  }
}
