import 'dart:async';

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
}
