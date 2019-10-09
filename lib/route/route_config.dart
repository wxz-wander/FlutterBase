import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../route/route_handler.dart';

class RouteConfig {
  static const String root = "/";

//  static const String demoSimple = "/demo";
//  static const String demoSimpleFixedTrans = "/demo/fixedTrans";
//  static const String demoFunc = "/demo/func";
//  static const String demoLink = "/demo/message";
  static const String network = "/network";

  static void configuringRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> parameters) {
      print("route is not found");
      return null;
    });
    router.define(root, handler: rootHandler);
    router.define(network, handler: networkHandler);
  }
}
