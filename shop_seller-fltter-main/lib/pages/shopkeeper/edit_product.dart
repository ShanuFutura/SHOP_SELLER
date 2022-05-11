import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_seller/models/product.dart';
import 'package:shop_seller/utils/constant.dart';
import 'package:shop_seller/utils/network_service.dart';
import 'package:shop_seller/widget/counter.dart';
import 'package:shop_seller/widget/edit_textfield.dart';
import 'package:shop_seller/widget/form_button.dart';

class EditProduct extends StatefulWidget {
  Product product;
  EditProduct({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  int stock = 0;
  @override
  void initState() {
    productController.text = widget.product.product!;
    priceController.text = widget.product.price!;
    stock = int.parse(widget.product.stock!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(18.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              Constants.BASE_URL + widget.product.imageUrl!,
              width: 150,
            ),
            Text(
              widget.product.category!,
              style: Theme.of(context).textTheme.headline6,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text("Product name : "),
              ),
              Expanded(
                child: EditTextField(
                  controller: productController,
                ),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text("Product price : "),
              ),
              Expanded(
                child: EditTextField(
                  controller: priceController,
                ),
              )
            ]),
            Row(children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text("Current stock : "),
              ),
              Expanded(
                child: CounterTextField(
                  controller: stockController,
                  count: stock,
                ),
              )
            ]),
            Row(
              children: [
                Expanded(
                  child: FormButton(
                    onPressed: editProduct,
                    text: "Edit",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> editProduct() async {
    widget.product.product = productController.text;
    widget.product.price = priceController.text;
    widget.product.stock = stockController.text;

    print(widget.product);
    final result = await getData("edit_product.php", params: {
      "product": widget.product.product,
      "category": widget.product.category,
      "price": widget.product.price,
      "stock": widget.product.stock,
      "user_id": widget.product.shopId,
      "product_id": widget.product.pId,
    });
    Fluttertoast.showToast(msg: result['message']);
  }
}
