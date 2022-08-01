// ignore_for_file: unnecessary_this

class ResendOtbModel {
  String? status;
  String? usrid;
  String? email;
  String? otp;
  List<String>? error;

  ResendOtbModel({this.status, this.usrid, this.email, this.otp, this.error});

  ResendOtbModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usrid = json['usrid'];
    email = json['email'];
    otp = json['otp'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['usrid'] = this.usrid;
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['error'] = this.error;
    return data;
  }
}
