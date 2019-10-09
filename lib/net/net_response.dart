///restful网络请求的通用封装
class NetResponse {
  String msg;
  int code;
  dynamic data;
  bool success;

  NetResponse();

  NetResponse.fromJson(Map<String, dynamic> json) {
    this.msg = json['msg'];
    this.code = json['code'];
    this.data = json['data'];
    this.success = json['success'];
  }

  Map<String, dynamic> toJson() =>
      {'msg': msg, 'code': code, 'success': success, 'data': data};

  @override
  String toString() {
    return 'NetResponse{msg: $msg, code: $code, data: $data, success: $success}';
  }

}
