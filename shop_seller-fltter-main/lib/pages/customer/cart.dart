import 'package:flutter/material.dart';
import 'package:shop_seller/models/cart_item.dart';
import 'package:shop_seller/utils/constant.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/counter.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late String user_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Cart"),
      // ),
      body: FutureBuilder(
          future: getCart(),
          builder: (context, AsyncSnapshot<List<CartItem>> snapshot) {
            if (snapshot.hasData) {
              List<CartItem>? products = snapshot.data;
              int total = 0;

              if (products!.isEmpty) {
                return const Center(
                  child: Text("Cart is Empty!"),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (BuildContext context, int index) {
                              CartItem product = products.elementAt(index);

                              return Card(
                                  child: ListTile(
                                leading: Image.network(
                                  Constants.BASE_URL + product.imageUrl!,
                                  width: 50,
                                ),
                                title: Text(product.product!),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.price!),
                                    Text(product.category!),
                                    Text("quantity : ${product.quantity}")
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    Text("created on "),
                                    Text(product.timestamp!),
                                  ],
                                ),
                              ));
                            }),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  getData("place_order.php",
                                          params: {"user_id": user_id})
                                      .then((value) {
                                    setState(() {});
                                  });
                                },
                                child: const Text("place order")),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }
            } else {
              return const Center(
                child: Text("loading..."),
              );
            }
          }),
    );
  }

  Future<List<CartItem>> getCart() async {
    user_id = await Constants.getUserId();
    List jsonList =
        await getData("view_cart.php", params: {"user_id": user_id});
    return jsonList.map((json) => CartItem.fromJson(json)).toList();
  }
}
