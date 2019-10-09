import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/net/net_config.dart';
import 'package:flutter_base_app/net/net_response.dart';
import '../../net/net_helper.dart';
import '../../net/service_api.dart';
import 'dart:convert';

class NetworkComponent extends StatefulWidget {
  @override
  NetworkComponentState createState() => new NetworkComponentState();
}

class NetworkComponentState extends State<NetworkComponent> {
  String _responseText = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('network'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              onPressed: () => _requestNetwork(),
              textTheme: ButtonTextTheme.accent,
              child: Text("请求网络"),
            ),
            Text(_responseText),
          ],
        ),
      ),
    );
  }

  _requestNetwork() async {
    var data = {
      'device_id': 'xxxxx',
      'account': 'xxx',
      'password': 'xxx',
    };
   NetResponse response = await new NetHelper().post(ServiceApi.LOGIN,data: json.encode(data));
   setState(() {
     _responseText = response.toString();
   });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(NetworkComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
