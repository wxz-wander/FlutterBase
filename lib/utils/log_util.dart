///日志输出类
class LogUtil {
  static const bool LOG_ENABLE = true;

  static void logD(obj) {
    if (LOG_ENABLE) {
      print(obj);
    }
  }
}
