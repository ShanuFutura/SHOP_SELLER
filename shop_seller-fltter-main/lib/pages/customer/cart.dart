import 'package:flutter/material.dart';
import 'package:shop_seller/models/cart_item.dart';
import 'package:shop_seller/models/shop.dart';
import 'package:shop_seller/utils/constant.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/counter.dart';
import 'package:url_launcher/url_launcher.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late String user_id;

  @override
  Widget build(BuildContext context) {
    Future<void> sendPayment(
        {required double amount, String upiId = ''}) async {
      print('called');
      String upiurl =
          'upi://pay?pa=$upiId&pn=shop_easy&tn=TestingGpay&am=$amount&cu=INR';
      // await launchUrl(Uri.parse(upiurl));
      return null;
    }

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
                double grandTotal = 0.0;
                bool isMakingPayment = false;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (BuildContext context, int index) {
                              CartItem product = products.elementAt(index);
                              grandTotal =
                                  double.parse(product.price!) + grandTotal;

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
                                  setState(() {
                                    isMakingPayment = true;
                                  });
                                  sendPayment(amount: grandTotal, ).then((_) {
                                    Future.delayed(Duration(seconds: 20))
                                        .then((_) {
                                      getData("place_order.php",
                                              params: {"user_id": user_id})
                                          .then((value) {
                                        setState(() {
                                          isMakingPayment = false;
                                        });
                                      });
                                    });
                                  });
                                },
                                child: Text(isMakingPayment
                                    ? 'proceeding..'
                                    : 'place order')),
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
