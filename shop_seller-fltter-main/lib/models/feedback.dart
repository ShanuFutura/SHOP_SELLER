class Feedbacks {
  String? fId;
  String? feedback;
  String? senderId;
  String? recieverId;
  String? timestamp;
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

  Feedbacks(
      {this.fId,
      this.feedback,
      this.senderId,
      this.recieverId,
      this.timestamp,
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

  Feedbacks.fromJson(Map<String, dynamic> json) {
    fId = json['f_id'];
    feedback = json['feedback'];
    senderId = json['sender_id'];
    recieverId = json['reciever_id'];
    timestamp = json['timestamp'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_id'] = this.fId;
    data['feedback'] = this.feedback;
    data['sender_id'] = this.senderId;
    data['reciever_id'] = this.recieverId;
    data['timestamp'] = this.timestamp;
    data['s_register_id'] = this.sRegisterId;
    data['logid'] = this.logid;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['role'] = this.role;
    data['approval_status'] = this.approvalStatus;
    return data;
  }
}
