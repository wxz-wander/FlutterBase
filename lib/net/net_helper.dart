import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base_app/net/net_response.dart';
import 'package:flutter_base_app/utils/log_util.dart';
import 'net_config.dart';

///网络请求类
class NetHelper {
  //单例公开访问点
  factory NetHelper() => _getInstance();

  //静态私有成员
  static NetHelper _instance;
  Dio _mDio;

  //私有构造方法
  NetHelper._() {
    var headers = new Map<String, dynamic>()
      ..['timestamp'] = new DateTime.now()
      ..['format'] = "JSON"
      ..['Accept'] = "application/json"
      ..['Charset'] = "utf-8"
      ..['os'] = "Android";
    var baseOptions = new BaseOptions(
        baseUrl: NetConfig.BASE_URL,
        connectTimeout: NetConfig.TIME_OUT,
        receiveTimeout: NetConfig.TIME_OUT,
        sendTimeout: NetConfig.TIME_OUT,
        headers: headers);
    _mDio = new Dio(baseOptions);
    if (NetConfig.USER_PROXY) {
      (_mDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY ${NetConfig.PROXY_SETTING}";
        };
      };
    }
    //设置拦截器
    _mDio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      return e; //continue
    }));
    //添加日志log
    _mDio.interceptors
        .add(new LogInterceptor(requestBody: true, responseBody: true));
  }

  static NetHelper _getInstance() {
    if (_instance == null) {
      _instance = NetHelper._();
    }
    return _instance;
  }

  ///post请求，path路径，data请求体，json格式
  post(String path,
      {data, Map<String, dynamic> queryParameters, Options options}) async {
    LogUtil.logD("url=$path,body=$data,options=$options");
    _mDio.options.headers['method'] = path;
    var netResponse;
    try {
      Response response = await _mDio.post(path,
          data: data, queryParameters: queryParameters, options: options);
      netResponse = NetResponse.fromJson(response.data);
//      response.data = netResponse;
    } on DioError catch (e) {
      netResponse = new NetResponse();
      netResponse.success = false;
      netResponse.data = null;
      if (e.response != null) {
        netResponse.code = e.response.statusCode;
        netResponse.msg = e.message;
      } else {
        netResponse.msg = e.message;
        netResponse.code = -1;
      }
//      response = new Response(data: netResponse);
    }
    return netResponse;
  }

  get(String path,
      {Map<String, dynamic> queryParameters, Options options}) async {
    LogUtil.logD("path=$path+query=$queryParameters");
    _mDio.options.headers['method'] = path;
    Response response;
    var netResponse;
    try {
      response = await _mDio.get(path,
          queryParameters: queryParameters, options: options);
      netResponse = NetResponse.fromJson(response.data);
      response.data = netResponse;
    } on DioError catch (e) {
      netResponse = new NetResponse();
      netResponse.success = false;
      netResponse.data = null;
      if (e.response != null) {
        netResponse.code = e.response.statusCode;
        netResponse.msg = e.message;
      } else {
        netResponse.msg = e.message;
        netResponse.code = -1;
      }
      response = new Response(data: netResponse);
    }
    return response;
  }

  download(String path, ProgressCallback onReceiveProgress, savePath) async {
    try {
      var dio = new Dio();
      dio.interceptors.add(LogInterceptor());
      // This is big file(about 200M)
//   var url = "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
      return await dio.download(path, savePath,
          onReceiveProgress: onReceiveProgress);
    } catch (e) {
      LogUtil.logD("down $path error $e");
    }
  }
}
