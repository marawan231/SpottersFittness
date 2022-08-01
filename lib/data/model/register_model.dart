class RegisterModel {
  String? status;
  int? usrid;
  String? phone;
  String? email;
  String? otp;
  List<String>? error;

  RegisterModel(
      {this.status, this.usrid, this.phone, this.email, this.otp, this.error});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usrid = json['usrid'];
    phone = json['phone'];
    email = json['email'];
    otp = json['otp'].toString();
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['usrid'] = usrid;
    data['phone'] = phone;
    data['email'] = email;
    data['otp'] = otp;
    data['error'] = error;
    return data;
  }
}
