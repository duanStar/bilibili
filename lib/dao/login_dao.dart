import 'package:flutter_bili_app/http/request/base_request.dart';

class LoginDao {
  static login(String username, String password) {
    return _send(username, password);
  }

  static _send(String username, String password, {imoocId, orderId}) async{
    BaseRequest request;
    if (imoocId != null && orderId != null) {

    }
  }
}