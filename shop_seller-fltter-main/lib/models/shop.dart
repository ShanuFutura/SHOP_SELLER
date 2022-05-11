class Shop {
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
  String? shopLocation;

  Shop(
      {this.sRegisterId,
      this.logid,
      this.name,
      this.address,
      this.phone,
      this.username,
      this.password,
      this.email,
      this.role,
      this.approvalStatus,
      this.shopLocation});

  Shop.fromJson(Map<String, dynamic> json) {
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
    shopLocation = json['coordinates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['coordinates'] = shopLocation;
    return data;
  }
}
