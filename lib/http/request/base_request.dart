enum HttpMethod { GET, POST, DELETE }

/// 基础请求

abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print(uri.toString());
    return uri.toString();
  }
  bool needLogin();
  Map<String, String> params = Map();
  ///添加参数
  BaseRequest add(String k, String v) {
    params[k] = v.toString();
    return this;
  }
  Map<String, dynamic> header = Map();
  ///添加header
  BaseRequest addHeader(String k, String v) {
    header[k] = v.toString();
    return this;
  }
}
