import 'dart:async';
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  String db = "db";
  String name = "waio";
  String index = "index";
  String dbVersion = "db_version";
  String isUpdated = "is_updated";
  String isFirstTime = "is_first_time";

  late SharedPreferences prefs;

  Future getInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future saveDB(bool sbStatus) async {
    await prefs.setBool(db, true);
  }

  Future saveDBIndex(int index) async {
    await prefs.setInt(this.index, index);
  }

  Future<int?> getIndex() async {
    prefs.getInt(index);
  }

  Future saveDBVersion(int dbVersion) async {
    await prefs.setInt(this.dbVersion, dbVersion);
  }

  Future<int?> getIDBVersion() async {
    prefs.getInt(dbVersion);
  }

  Future saveNotFirstTime(bool isFirst) async {
    prefs.setBool(isFirstTime, isFirst);
  }

  Future<bool?> getFirstTime() async {
    prefs.getInt(isFirstTime);
  }

  putString(String key, String value) {
    prefs.setString(key, value);
  }

  String getString(String key, String defValue) {
    return prefs.getString(key) ?? defValue;
  }

  putInt(String key, int value) {
    prefs.setInt(key, value);
  }

  int getInt(String key, int defValue) {
    return prefs.getInt(key) ?? defValue;
  }

  putFloat(String key, double value) {
    prefs.setDouble(key, value);
  }

  double getFloat(String key, double defValue) {
    return prefs.getDouble(key) ?? defValue;
  }

  putBoolean(String key, bool value) {
    prefs.setBool(key, value);
  }

  bool getBoolean(String key, bool defValue) {
    return prefs.getBool(key) ?? defValue;
  }

  clear() {
    prefs.clear();
  }
}
