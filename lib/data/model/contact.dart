class ContactModel {
  String? status;
  String? usrid;
  String? type;
  List<String>? error;

  ContactModel({this.status, this.usrid, this.type, this.error});

  ContactModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usrid = json['usrid'];
    type = json['type'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['usrid'] = usrid;
    data['type'] = type;
    data['error'] = error;
    return data;
  }
}
