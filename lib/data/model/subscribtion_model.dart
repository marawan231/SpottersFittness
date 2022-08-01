class SubscribtionModel {
  String? id;
  String? pack;
  String? detail;
  String? price;
  String? month;

  SubscribtionModel({this.id, this.pack, this.detail, this.price});

  SubscribtionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pack = json['pack'];
    detail = json['detail'];
    price = json['price'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pack'] = pack;
    data['detail'] = detail;
    data['price'] = price;
    data['month'] = month;
    return data;
  }
}
