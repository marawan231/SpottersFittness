class ForgotPassModel {
  String? status;
  List<String>? error;

  ForgotPassModel({this.status, this.error});

  ForgotPassModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    return data;
  }
}
