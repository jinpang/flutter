
import 'dart:async';


abstract class CollectionInterface {
  String get name;
  String get router;
}

class Collection implements CollectionInterface {
  String name;
  String router;

  Collection({this.name, this.router});

  factory Collection.fromJSON(Map json){
    return Collection(name: json['name'],router: json['router']);
  }

  Object toMap() {
    return {'name': name, 'router': router};
  }
}

class CollectionControlModel {
  final String table = 'collection';

  CollectionControlModel() {
  }

  // 获取所有的收藏

  // 插入新收藏
  Future insert(Collection collection) {
    return null;
  }

  // 获取全部的收藏
  Future<List<Collection>> getAllCollection() async {
    return null;
  }

  // 通过收藏名获取router
  Future getRouterByName(String name) async {
    return null;
  }

  // 删除
  Future deleteByName(String name) async{
  }
}
