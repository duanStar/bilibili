import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  SharedPreferences? perfs;

  HiCache._() {
    init();
  }

  static HiCache? _instance;

  HiCache._pre(SharedPreferences prefs) {
    perfs = prefs;
  }

  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefs);
    }
    return _instance!;
  }

  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
    }
    return _instance!;
  }

  void init() async {
    if (perfs == null) {
      perfs = await SharedPreferences.getInstance();
    }
  }

  setString(String key, String value) {
    perfs?.setString(key, value);
  }

  setDouble(String key, double value) {
    perfs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    perfs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    perfs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    perfs?.setStringList(key, value);
  }

  T get<T>(String key) {
    return perfs?.get(key);
  }
}
