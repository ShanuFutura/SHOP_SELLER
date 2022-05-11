import 'package:flutter/material.dart';
import 'package:shop_seller/models/order.dart';
import 'package:shop_seller/utils/constant.dart';
import 'package:shop_seller/utils/network_service.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late String user_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getOrderHistory(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasData) {
            List<Order>? orders = snapshot.data;

            if (orders!.isEmpty) {
              return const Center(
                child: Text("order data is Empty!"),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (BuildContext context, int index) {
                            Order order = orders.elementAt(index);

                            return Card(
                                color: Colors.amber,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(
                                      Constants.BASE_URL + order.imageUrl!,
                                    ),
                                  ),
                                  title: Text(order.product!),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(order.price!),
                                      Text(order.category!),
                                      Text("quantity : ${order.quantity}")
                                    ],
                                  ),
                                  trailing: Column(
                                    children: [
                                      Text(
                                        "shop name : " + order.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Text("phone : " + order.phone!),
                                      Text("status : Order " + order.status!),
                                    ],
                                  ),
                                ));
                          }),
                    ),
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: Text("loading.."),
            );
          }
        },
      ),
    );
  }

  Future<List<Order>> getOrderHistory() async {
    user_id = await Constants.getUserId();
    List jsonList =
        await getData("view_orders.php", params: {"user_id": user_id});
    return jsonList.map((e) => Order.fromJson(e)).toList();
  }
}
