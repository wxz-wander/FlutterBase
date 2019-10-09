import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../components/home/home_component.dart';
import '../components/network/network_compoment.dart';

///home的路由
var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomeComponent(
    title: "home",
  );
});

///网络请求的路由
var networkHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new NetworkComponent();
});
