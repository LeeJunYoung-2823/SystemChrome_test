import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// 메인화면 Drawer model
class MenuResponse {
  List<MenuList> menuList = [];
  List<GoodsInfo> goodsList = [];

  MenuResponse({required this.menuList, required this.goodsList});

  MenuResponse.fromJson(Map<String, dynamic> json) {
    if (json['menulist'] != null) {
      menuList = [];
      json['menulist'].forEach((v) {
        menuList.add(new MenuList.fromJson(v));
      });
    }
    if (json['goods-list'] != null) {
      goodsList = [];
      json['goods-list'].forEach((v) {
        goodsList.add(new GoodsInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.menuList != null) {
      data['menulist'] = this.menuList.map((v) => v.toJson()).toList();
    }
    if (this.goodsList != null) {
      data['goods-list'] = this.goodsList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuState with ChangeNotifier {
  List<MenuList> _menuList = [];
  List<MenuList> get menuList => _menuList;
  late MenuList selectMenu;

  List<GoodsInfo> _goodsList = [];
  List<GoodsInfo> get goodsList => _goodsList;

  bool isFetching = false;

  MenuState();

  menuFetchData(menuList) {
    String url = 'https://www.sweetbook.com/m/$menuList';
    if (menuList == null || menuList == '')
      url = 'https://www.sweetbook.com/m/menulist-new.json';
    isFetching = true;
    _menuFetchData(url).then((result) {
      if (result != null) {
        _menuList = result.menuList;
        _goodsList = result.goodsList;
      }
      isFetching = false;
      notifyListeners();
    }).catchError((error) {
      print('menu fetch error');

      isFetching = false;
      notifyListeners();
    });
  }

  Future<MenuResponse?> _menuFetchData(String path) async {
    var url = Uri.parse(path);
    var response = await http.get(url);

    if (200 <= response.statusCode && response.statusCode < 300) {
      // 한글 깨지는 현상 처리 및 Json 파싱 리턴
      var menuResponse =
          MenuResponse.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return menuResponse;
    }
    return null;
  }

  // 메뉴 탭 이벤트 Value 값 저장
  menuValue(MenuList selectValue) {
    selectMenu = selectValue;
    notifyListeners();
  }
}

class MenuList {
  String? title;
  String? type;
  String? action;
  String? subtitle;

  MenuList({this.title, this.type, this.action, this.subtitle});

  MenuList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    action = json['action'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['type'] = this.type;
    data['action'] = this.action;
    data['subtitle'] = this.subtitle;
    return data;
  }
}

class GoodsInfo {
  String? productId;
  String? productName;
  String? productSubName;
  String? category1;
  String? price1;
  String? imageUrl;
  String? action;
  String? category2;
  String? price2;
  String? category3;
  String? price3;
  String? type;
  String? productDc;

  GoodsInfo(
      {this.productId,
      this.productName,
      this.productSubName,
      this.category1,
      this.price1,
      this.imageUrl,
      this.action,
      this.category2,
      this.price2,
      this.category3,
      this.price3,
      this.type,
      this.productDc});

  GoodsInfo.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productSubName = json['productSubName'];
    category1 = json['category1'];
    price1 = json['price1'];
    imageUrl = json['imageUrl'];
    action = json['action'];
    category2 = json['category2'];
    price2 = json['price2'];
    category3 = json['category3'];
    price3 = json['price3'];
    type = json['type'];
    productDc = json['product_dc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productSubName'] = this.productSubName;
    data['category1'] = this.category1;
    data['price1'] = this.price1;
    data['imageUrl'] = this.imageUrl;
    data['action'] = this.action;
    data['category2'] = this.category2;
    data['price2'] = this.price2;
    data['category3'] = this.category3;
    data['price3'] = this.price3;
    data['type'] = this.type;
    data['product_dc'] = this.productDc;
    return data;
  }
}
