class Countries {
  String? id;
  String? country;

  Countries({this.id, this.country});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country'] = country;
    return data;
  }
}
