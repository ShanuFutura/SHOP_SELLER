class Order {
  String? orderId;
  String? pId;
  String? uId;
  String? quantity;
  String? timestamp;
  String? status;
  String? amount;
  String? product;
  String? category;
  String? price;
  String? stock;
  String? imageUrl;
  String? shopId;
  String? sRegisterId;
  String? logid;
  String? name;
  String? address;
  String? phone;
  String? username;
  String? password;
  String? email;
  String? role;
  String? approvalStatus;

  Order(
      {this.orderId,
      this.pId,
      this.uId,
      this.quantity,
      this.timestamp,
      this.status,
      this.amount,
      this.product,
      this.category,
      this.price,
      this.stock,
      this.imageUrl,
      this.shopId,
      this.sRegisterId,
      this.logid,
      this.name,
      this.address,
      this.phone,
      this.username,
      this.password,
      this.email,
      this.role,
      this.approvalStatus});

  Order.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    pId = json['p_id'];
    uId = json['u_id'];
    quantity = json['quantity'];
    timestamp = json['timestamp'];
    status = json['status'];
    amount = json['amount'];
    product = json['product'];
    category = json['category'];
    price = json['price'];
    stock = json['stock'];
    imageUrl = json['image_url'];
    shopId = json['shop_id'];
    sRegisterId = json['s_register_id'];
    logid = json['logid'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    role = json['role'];
    approvalStatus = json['approval_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['p_id'] = pId;
    data['u_id'] = uId;
    data['quantity'] = quantity;
    data['timestamp'] = timestamp;
    data['status'] = status;
    data['amount'] = amount;
    data['product'] = product;
    data['category'] = category;
    data['price'] = price;
    data['stock'] = stock;
    data['image_url'] = imageUrl;
    data['shop_id'] = shopId;
    data['s_register_id'] = sRegisterId;
    data['logid'] = logid;
    data['name'] = name;
    data['address'] = address;
    data['phone'] = phone;
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['role'] = role;
    data['approval_status'] = approvalStatus;
    return data;
  }
}
