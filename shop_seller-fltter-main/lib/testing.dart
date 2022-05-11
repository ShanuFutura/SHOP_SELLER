import 'package:flutter/material.dart';
import 'package:shop_seller/utils/network_service.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  String data = "hello";
  var ddt = ["aswin", "arun"];
  @override
  void initState() {
    final res = getData("test.php", params: {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(data),
      ),
    );
  }
}
