class LoginModel {
  String? status;
  String? trID;
  String? trEmail;
  String? trFname;
  String? trPhone;
  String? trPic;
  String? trVerify;
  String? trOTP;
  String? trProfile;
  List<String>? error;

  LoginModel(
      {this.status,
      this.trID,
      this.trEmail,
      this.trFname,
      this.trPhone,
      this.trPic,
      this.trVerify,
      this.trOTP,
      this.trProfile,
      this.error});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    trID = json['trID'];
    trEmail = json['trEmail'];
    trFname = json['trFname'];
    trPhone = json['trPhone'];
    trPic = json['trPic'];
    trVerify = json['trVerify'];
    trOTP = json['trOTP'];
    trProfile = json['trProfile'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['trID'] = trID;
    data['trEmail'] = trEmail;
    data['trFname'] = trFname;
    data['trPhone'] = trPhone;
    data['trPic'] = trPic;
    data['trVerify'] = trVerify;
    data['trOTP'] = trOTP;
    data['trProfile'] = trProfile;
    data['error'] = error;
    return data;
  }
}
