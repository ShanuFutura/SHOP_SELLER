import 'package:flutter/material.dart';
import 'package:shop_seller/models/product.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/product_grid.dart';

class ViewProducts extends StatefulWidget {
  String shopId;
  ViewProducts({Key? key, required this.shopId}) : super(key: key);

  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Products"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getProducts(),
          builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return ProductGrid(items: snapshot.data!);
            } else {
              return const Center(
                child: Text("loading..."),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Product>> getProducts() async {
    List json =
        await getData("view_products.php", params: {"shop_id": widget.shopId});
    return json.map((e) => Product.fromJson(e)).toList();
  }
}
