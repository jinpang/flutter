import 'package:flutter/material.dart';
import 'package:flutter_live/common/constants/live_colors.dart';
import 'package:flutter_live/components/app_bar.dart';

class GuessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GuessPageState();
  }
}

class GuessPageState extends State<GuessPage> {
  @override
  Widget build(BuildContext context) {
    return new Column(children: <Widget>[
      MyAppBar.getAppBar(context:context, title:"竞猜中心", rightText:"竞猜说明", rightFunction:() {
        showAlertDialog(context);
      }),
      new Expanded(
        child: new RefreshIndicator(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return createGuessTopRow(context);
              } else if (index == 1) {
                return createLucklyCar(context, "北京赛车");
              } else if (index == 2) {
                return createLucklyCar(context, "重庆时时彩");
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
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
                title: new Text("Dialog Title"),
                content: new Text("This is my content"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("CANCEL"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]));
  }

  Widget createGuessTopColumn(
      BuildContext context, Color color, String imagePath) {
    return Container(
      //color: color,
      decoration: new BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
      child: Column(
        children: <Widget>[
          Text(
            "幸运飞艇",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Text(
            "001期",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Text(
            "竞猜人数",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          Container(
            child: FlatButton(
                onPressed: () {
                  showAlertDialog(context);
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "立即加入",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  decoration: new BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  padding: EdgeInsets.all(5.0),
                )),
          ),

        ],
      ),
    );
  }

  Widget createGuessTopRow(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: createGuessTopColumn(context, Colors.orange,
                "assets/images/bg_guess_entrece_01.png"),
          ),
          Expanded(
            flex: 1,
            child: createGuessTopColumn(context, Colors.deepPurple,
                "assets/images/bg_guess_entrece_02.png"),
          ),
        ],
      ),
      color: Colors.white,
    );
  }

  Widget createLucklyCar(BuildContext context, String title) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                decorationStyle: TextDecorationStyle.solid,
              ),
              textAlign: TextAlign.left,
            ),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            padding: EdgeInsets.all(10.0),
          ),
          Container(
            color: LiveColors.getColor(LiveColors.divider),
            height: 1,
          ),
          Container(
            child: GridView.count(
              //水平子Widget之间间距
              crossAxisSpacing: 15.0,
              //垂直子Widget之间间距
              mainAxisSpacing: 15.0,
              //一行的Widget数量
              crossAxisCount: 2,
              //子Widget宽高比例
              childAspectRatio: 2.0,
              children: getItems(6),
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
            ),
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  List<Widget> getItems(int size) {
    List<Widget> list = new List();
    for (int i = 0; i < size; i++) {
      if(i >=0 && i<=1) {
        list.add(getItemContainer("民间超级大神${i}", "${i*10}%", Colors.orange));
      }else if(i >=2 && i<=3) {
        list.add(getItemContainer("民间超级大神${i}", "${i*10}%", Colors.deepPurple));
      } else if(i >=4 && i<=5) {
        list.add(getItemContainer("民间超级大神${i}", "${i*10}%", Colors.pink));
      }
    }
    return list;
  }

  Widget getItemContainer(String item, String percent, MaterialColor mc) {
    return Material(
      child: Ink(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          border: Border.all(color: LiveColors.getColor(LiveColors.divider), width: 1.0),
        ),
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    'assets/images/ic_defualt_girl.png',
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Align(
                          child: Text(
                            item,
                            style: TextStyle(color: Colors.black54, fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "盈利：",
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                              Text(
                                percent,
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    mc[50],
                                    mc[500],
                                    mc[900],
                                  ],
                                  begin: FractionalOffset(1, 0),
                                  end: FractionalOffset(0, 1))),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10.0),
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(5.0),
          ),
          onTap: () {
            showAlertDialog(context);
          },
        ),
      ),
    );
  }
}
