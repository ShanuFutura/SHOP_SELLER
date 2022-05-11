import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee/marquee.dart';
import 'package:shop_seller/models/product.dart';
import 'package:shop_seller/utils/constant.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/counter.dart';
import 'package:shop_seller/widget/custom_alert.dart';

class ProductGrid extends StatefulWidget {
  List<Product> items;
  ProductGrid({Key? key, required this.items}) : super(key: key);

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  TextEditingController counterController = TextEditingController();
  late String userId;
  @override
  void initState() {
    Constants.getUserId().then((value) => userId = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 3,
            crossAxisCount: 2,
          ),
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            Product product = widget.items.elementAt(index);
            return InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ViewProduct()),
                // );
              },
              child: Card(
                color: Colors.amber,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (deviceWidth / 2) - 70,
                            child: Text(
                              product.product!,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                getData("add_favourite.php", params: {
                                  "user_id": userId,
                                  "product_id": product.pId
                                }).then((value) => Fluttertoast.showToast(
                                    msg: value['message']));
                              },
                              icon: const Icon(Icons.favorite))
                        ],
                        mainAxisSize: MainAxisSize.max,
                      ),
                      Image.network(
                        Constants.BASE_URL + product.imageUrl!,
                        width: (deviceWidth / 2) - 40,
                        height: 100,
                        fit: BoxFit.fitWidth,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "price : " + product.price!,
                            // style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Container(
                            height: 30,
                            width: (deviceWidth / 4) - 10,
                            color: Colors.green,
                            padding: const EdgeInsets.all(5.0),
                            child: Marquee
                                // Text
                                (
                              velocity: 30,
                              text: "category : " + product.category!,
                              // style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  addToCart(context, product, deviceHeight);
                                },
                                child: const Text("Add to Cart")),
                          )
                        ],
                      )
                    ],
                  ),
                )),
              ),
            );
          }),
    );
  }

  Future<dynamic> addToCart(
      BuildContext context, Product product, double deviceHeight) {
    return showDialog(
        context: context,
        builder: (_) => CustomAlert(
              height: deviceHeight / 2,
              okClick: () async {
                await getData("add_to_cart.php", params: {
                  "user_id": userId,
                  "product_id": product.pId,
                  "quantity": counterController.text
                }).then((value) => Fluttertoast.showToast(msg: "add to cart"));
              },
              title: 'Add to Cart',
              widget: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.network(
                    Constants.BASE_URL + product.imageUrl!,
                    width: 120,
                    height: 80,
                  ),
                  Text(
                    "product name : " + product.product!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    "price : " + product.price!,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    "category : " + product.category!,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    "stock available : " + product.stock!,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  CounterTextField(
                    controller: counterController,
                    count: 1,
                  )
                ],
              ),
            ));
  }
}
