import 'dart:convert';

import 'constants2.dart' as Constant;
import 'package:http/http.dart' as http;

class FavoriteService {
  static Future<int> set(
      String reltid, String idv1, String idv2, String aktiv) async {
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    // var key = _storageKey;
    // key = _storageKey + "user";
    // user = pref.getString(key);
    final user = 'AU000018';
    final sessionid = 'SESS28362837461282';

    final String params = "user=" +
        (user ?? "") +
        "&" +
        "sessionid=" +
        (sessionid ?? "") +
        "&" +
        "reltid=" +
        (reltid ?? "") +
        "&" +
        "idv1=" +
        (idv1 ?? "") +
        "&" +
        "idv2=" +
        (idv2 ?? "") +
        "&" +
        "aktiv=" +
        (aktiv ?? "0");
    String url = Constant.HTTP_URL_PROD_ROOT +
        "?" +
        Constant.HTTP_BASE_URL_ROUTE_APP_FAVORITESET +
        '&' +
        params;
    url = Uri.encodeFull(url);

    print("url: $url");
    final response = await http.get(url);
    //print("response.body: ${response.body}");
    //print("response.statusCode: ${response.statusCode}");
    //print("json ${json.decode(response.body)['result']}");
    if (response.statusCode == 200) {
      return json.decode(response.body)['result'];
    } else {
      throw Exception('Failed to load FavoriteService.set');
    }
  }

  static Future<int> get(String reltid, String idv1, String idv2) async {
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    // var key = _storageKey;
    // key = _storageKey + "user";
    // user = pref.getString(key);
    final user = 'AU000018';
    final sessionid = 'SESS28362837461282';

    final String params = "user=" +
        (user ?? "") +
        "&" +
        "sessionid=" +
        (sessionid ?? "") +
        "&" +
        "reltid=" +
        (reltid ?? "") +
        "&" +
        "idv1=" +
        (idv1 ?? "") +
        "&" +
        "idv2=" +
        (idv2 ?? "");
    String url = Constant.HTTP_URL_PROD_ROOT +
        "?" +
        Constant.HTTP_BASE_URL_ROUTE_APP_FAVORITEGET +
        '&' +
        params;
    url = Uri.encodeFull(url);

    final response = await http.get(url);
    print("url: $url");
    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      return json.decode(response.body)['result'];
    } else {
//      return 0;
      throw Exception('Failed to load FavoriteService.get');
    }
  }
}

class NoteService {
  static Future<int> set(String reltid, String idv1, String idv2, String text1,
      String aktiv) async {
    final user = 'AU000018';
    final sessionid = 'SESS28362837461282';

    final String params = "user=" +
        (user ?? "") +
        "&" +
        "sessionid=" +
        (sessionid ?? "") +
        "&" +
        "reltid=" +
        (reltid ?? "") +
        "&" +
        "idv1=" +
        (idv1 ?? "") +
        "&" +
        "idv2=" +
        (idv2 ?? "") +
        "&" +
        "text1=" +
        (text1 ?? "0") +
        "&" +
        "aktiv=" +
        (aktiv ?? "0");
    String url = Constant.HTTP_URL_PROD_ROOT +
        "?" +
        Constant.HTTP_BASE_URL_ROUTE_APP_NOTESET +
        '&' +
        params;
    url = Uri.encodeFull(url);
    final response = await http.get(url);
    print("url: $url");
    if (response.statusCode == 200) {
      return json.decode(response.body)['result'];
    } else {
      throw Exception('Failed to load NoteService.set');
    }
  }

  static Future<String> get(String reltid, String idv1, String idv2) async {
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    // var key = _storageKey;
    // key = _storageKey + "user";
    // user = pref.getString(key);
    final user = 'AU000018';
    final sessionid = 'SESS28362837461282';

    final String params = "user=" +
        (user ?? "") +
        "&" +
        "sessionid=" +
        (sessionid ?? "") +
        "&" +
        "reltid=" +
        (reltid ?? "") +
        "&" +
        "idv1=" +
        (idv1 ?? "") +
        "&" +
        "idv2=" +
        (idv2 ?? "");

    String url = Constant.HTTP_URL_PROD_ROOT +
        "?" +
        Constant.HTTP_BASE_URL_ROUTE_APP_NOTEGET +
        '&' +
        params;
    url = Uri.encodeFull(url);

    final response = await http.get(url);
    print("url: $url");
    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      return json.decode(response.body)['result'];
    } else {
      throw Exception('Failed to load NoteService.get');
    }
  }
}
