import 'package:dio/dio.dart';
import 'package:flutter_bili_app/http/core/hi_adapter.dart';
import 'package:flutter_bili_app/http/core/hi_errror.dart';
import 'package:flutter_bili_app/http/request/base_request.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), options: options, data: request.params);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), options: options, data: request.params);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    if (error != null) {
      throw HiNetError(response?.statusCode ?? -1, error.toString(),
          data: bulidRes(request, response));
    }
    return bulidRes(request, response);
  }

  HiNetResponse bulidRes(BaseRequest request, Response response) {
    return HiNetResponse(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
