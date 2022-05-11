class Category {
  String? cId;
  String? category;
  String? timestamp;

  Category({this.cId, this.category, this.timestamp});

  Category.fromJson(Map<String, dynamic> json) {
    cId = json['c_id'];
    category = json['category'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['c_id'] = cId;
    data['category'] = category;
    data['timestamp'] = timestamp;
    return data;
  }
}
