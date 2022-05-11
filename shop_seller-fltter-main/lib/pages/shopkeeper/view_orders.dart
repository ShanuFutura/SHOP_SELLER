import 'package:flutter/material.dart';
import 'package:shop_seller/models/order.dart';
import 'package:shop_seller/utils/constant.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/custom_alert.dart';

class ViewOrders extends StatefulWidget {
  ViewOrders({Key? key}) : super(key: key);

  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  late String user_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
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

                            return InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) => CustomAlert(
                                          okClick: () {
                                            getData("deliver_order.php",
                                                params: {
                                                  "order_id": order.orderId
                                                }).then((value) {
                                              setState(() {});
                                            });
                                          },
                                          widget: Text(
                                            "do you want to make this order as deliverd..?",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          title: '',
                                        ));
                              },
                              child: Card(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                          " : " + order.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Text("phone : " + order.phone!),
                                        Text("status : Order " + order.status!),
                                      ],
                                    ),
                                  )),
                            );
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
        await getData("shop_view_orders.php", params: {"shop_id": user_id});
    return jsonList.map((e) => Order.fromJson(e)).toList();
  }
}
