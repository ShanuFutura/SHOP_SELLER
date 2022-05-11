import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_seller/models/category.dart';
import 'package:shop_seller/models/product.dart';
import 'package:shop_seller/pages/login.dart';
import 'package:shop_seller/pages/shopkeeper/edit_product.dart';
import 'package:shop_seller/utils/constant.dart';

import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/custom_alert.dart';
import 'package:shop_seller/widget/drop_down.dart';
import 'package:shop_seller/widget/image_selector.dart';

class AddProduct extends StatefulWidget {
  AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> categories = [''];

  late String user_id;

  @override
  initState() {
    getCategory().then((value) => {categories.addAll(value)});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("products"),
        actions: [
          IconButton(
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => SimpleLoginScreen());
                Navigator.pushReplacement(context, route);
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder(
          future: getProducts(),
          builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              List<Product>? products = snapshot.data;
              return ListView.builder(
                  itemCount: products!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product product = products.elementAt(index);
                    return Card(
                        child: ListTile(
                      leading: Image.network(
                        Constants.BASE_URL + product.imageUrl!,
                        width: 50,
                      ),
                      title: Text(product.product!),
                      subtitle: Text(product.price!),
                      trailing: Wrap(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await getData("delete_product.php",
                                    params: {"product_id": product.pId!});
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete)),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProduct(
                                            product: product,
                                          )),
                                );
                              },
                              icon: const Icon(Icons.edit))
                        ],
                      ),
                    ));
                  });
            } else {
              return const Center(
                child: Text("loading..."),
              );
            }
          }),
      floatingActionButton: ElevatedButton.icon(
          onPressed: () {
            addProduct(context);
          },
          icon: const Icon(Icons.add),
          label: const Text("add product")),
    );
  }

  addProduct(BuildContext context) {
    final productNameController = TextEditingController();
    final priceController = TextEditingController();
    final categoryController = TextEditingController();
    final stockController = TextEditingController();
    late File imageFile;
    late String selectedCategory;
    return showDialog(
      context: context,
      builder: (_) => CustomAlert(
        height: 400,
        title: "Add Product",
        widget: SingleChildScrollView(
          child: Column(
            children: [
              ImageSelector(
                imageData: (file) {
                  imageFile = file;
                },
              ),
              TextField(
                controller: productNameController,
                decoration: InputDecoration(hintText: 'product name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(hintText: 'price'),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Text("Category : "),
                  Expanded(
                    child: MyDropDown(
                      datas: categories,
                      onSelected: (value) {
                        selectedCategory = value;
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'stock'),
              ),
            ],
          ),
        ),
        okClick: () async {
          final product = productNameController.text;
          final category = selectedCategory;
          final stock = stockController.text;
          final price = priceController.text;

          if (validate(product, price, category, stock, imageFile)) {
            await Upload(imageFile, "add_product.php", {
              "product": product,
              "price": price,
              "category": category,
              "stock": stock,
              "user_id": user_id,
            });
            setState(() {});
          }
        },
      ),
    );
  }

  bool validate(
      String product, String price, String category, String stock, File image) {
    if (product.isEmpty) {
      Fluttertoast.showToast(msg: "product name required");
    }
    return true;
  }

  Future<List<Product>> getProducts() async {
    user_id = await Constants.getUserId();
    List json =
        await getData("view_products.php", params: {"shop_id": user_id});
    return json.map((e) => Product.fromJson(e)).toList();
  }

  Future<List<String>> getCategory() async {
    List json = await getData("view_category.php");
    List<Category> categories = json.map((e) => Category.fromJson(e)).toList();
    return categories.map((e) => e.category!).toList();
  }
}
