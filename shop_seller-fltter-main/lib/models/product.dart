class Product {
  String? pId;
  String? product;
  String? category;
  String? price;
  String? stock;
  String? imageUrl;
  String? shopId;

  Product(
      {this.pId,
      this.product,
      this.category,
      this.price,
      this.stock,
      this.imageUrl,
      this.shopId});

  Product.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    product = json['product'];
    category = json['category'];
    price = json['price'];
    stock = json['stock'];
    imageUrl = json['image_url'];
    shopId = json['shop_id'];
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
    return data;
  }
}
