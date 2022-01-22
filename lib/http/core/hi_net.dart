import 'package:flutter_bili_app/http/core/dio_adapter.dart';
import 'package:flutter_bili_app/http/core/hi_adapter.dart';
import 'package:flutter_bili_app/http/core/hi_errror.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

class HiNet {
  static final HiNet _instance = HiNet();

  static HiNet getInstance() {
    return _instance;
  }

  Future fire(BaseRequest request) async {
     HiNetResponse? response;
     var error;
     try {
        response = await send(request);
     } on HiNetError catch(err) {
       error = err;
       response = err.data;
       printLog(err.message);
     } catch(err) {
       error = err;
       printLog(err);
     }
     if (response == null) {
       printLog(error);
     }
     var result = response?.data;
     printLog(result.toString());
     var status = response?.statusCode;
     switch(status) {
       case 200:
         return result;
       case 401:
         return NeedLogin();
       case 403:
         return NeedAuth(result.toString(), data: result);
       default:
         throw HiNetError(status!, result.toString(), data: result);
     }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog(request.url());
    DioAdapter adapter = DioAdapter();
    return adapter.send(request);
  }
  void printLog(log) {
    print("hi_net:${log.toString()}");
  }
}

