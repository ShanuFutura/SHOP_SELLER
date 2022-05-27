import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_seller/models/shop.dart';
import 'package:shop_seller/pages/customer/view_products.dart';
import 'package:shop_seller/utils/constant.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/custom_alert.dart';

class ShopGrid extends StatefulWidget {
  List<Shop> items;
  ShopGrid({Key? key, required this.items}) : super(key: key);

  @override
  _ShopGridState createState() => _ShopGridState();
}

class _ShopGridState extends State<ShopGrid> {
  double currentRating = 3.5;

  late String userId;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Constants.getUserId().then((value) => userId = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            Shop shop = widget.items.elementAt(index);
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewProducts(
                            shopId: shop.sRegisterId!,shopName:shop.name!
                          )),
                );
              },
              child: Stack(
                children: [
                  Card(
                    // color: Colors.amber,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.network(
                              "https://www.freeiconspng.com/uploads/retail-store-icon-6.png",
                              height: 108,
                            ),
                            Text(
                              shop.name!,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              "phone : " + shop.phone!,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => CustomAlert(
                                  widget: Column(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: currentRating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          // color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          currentRating = rating;
                                        },
                                      ),
                                      TextFormField(
                                        controller: controller,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color: Colors.grey[800]),
                                          hintText: "Type your feedback here..",
                                        ),
                                        minLines:
                                            6, // any number you need (It works as the rows for the textarea)
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                      ),
                                    ],
                                  ),
                                  title: "Feedback",
                                  okClick: () {
                                    getData("add_feedback.php", params: {
                                      "user_id": userId,
                                      "shop_id": shop.sRegisterId,
                                      "feedback":
                                          "star rating: $currentRating \n" +
                                              controller.text
                                    }).then((value) => Fluttertoast.showToast(
                                        msg: "feedback submitted."));
                                  }));
                        },
                        icon: Icon(
                          Icons.message,
                          color: Colors.green,
                        ),
                      )),
                ],
              ),
            );
          }),
    );
  }
}
