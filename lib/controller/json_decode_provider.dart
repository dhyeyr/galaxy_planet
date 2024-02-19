import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../model/json_decode.dart';

class puzz_provider extends ChangeNotifier {
  int? intVat;
  List<JsonDecodeModel> galaxyDetails = [];
  List<JsonDecodeModel> favoriteList = [];
  String favoriteListJson = "";

  void refresh() {
    notifyListeners();
  }
  bool isFavorite(JsonDecodeModel obj) {
    return favoriteList.any((element) => element.name == obj.name);
  }

  void addFavorite(JsonDecodeModel planet) {
    if (isFavorite(planet)) {
      print("ALREADY");
    } else {
      favoriteList.add(planet);
      notifyListeners();
      print("LEGNTH ==>  ${favoriteList.length}");
    }
  }
  void removeFavorite(int index) {
    favoriteList.removeAt(index);
    notifyListeners();
  }

  void saveData() {
    favoriteListJson =
        jsonEncode(favoriteList.map((product) => product.toJson()).toList());
    prefs.setString("cart", favoriteListJson);
    print("SAVED LOCALLY");
    notifyListeners();
  }

  void getData() async {
    print("GET DATA FROM LOCAL");
    prefs = await SharedPreferences
        .getInstance(); // Obtain SharedPreferences instance
    String? cartListJson = prefs.getString('cart');
    if (cartListJson != null) {
      List<dynamic> decodedList = jsonDecode(cartListJson);
      favoriteList = decodedList.map((json) => JsonDecodeModel.fromJson(json)).toList();
      print(favoriteList.length);
    }
    notifyListeners();
  }

  Future<void> loadJson() async {
    var fileData = await rootBundle.loadString("assets/planet_details.json");
    jsonDecode(fileData);
    galaxyDetails = jsonDecodeModelFromJson(fileData);
    notifyListeners();
  }
}
