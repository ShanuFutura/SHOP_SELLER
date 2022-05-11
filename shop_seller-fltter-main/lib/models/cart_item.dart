// ignore_for_file: unnecessary_new

class CartItem {
  String? pId;
  String? product;
  String? category;
  String? price;
  String? stock;
  String? imageUrl;
  String? shopId;
  String? cartId;
  String? uId;
  String? quantity;
  String? timestamp;

  CartItem(
      {this.pId,
      this.product,
      this.category,
      this.price,
      this.stock,
      this.imageUrl,
      this.shopId,
      this.cartId,
      this.uId,
      this.quantity,
      this.timestamp});

  CartItem.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    product = json['product'];
    category = json['category'];
    price = json['price'];
    stock = json['stock'];
    imageUrl = json['image_url'];
    shopId = json['shop_id'];
    cartId = json['cart_id'];
    uId = json['u_id'];
    quantity = json['quantity'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['p_id'] = pId;
    data['product'] = product;
    data['category'] = category;
    data['price'] = price;
    data['stock'] = stock;
    data['image_url'] = imageUrl;
    data['shop_id'] = shopId;
    data['cart_id'] = cartId;
    data['u_id'] = uId;
    data['quantity'] = quantity;
    data['timestamp'] = timestamp;
    return data;
  }
}
