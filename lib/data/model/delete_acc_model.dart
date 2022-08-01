// ignore_for_file: unnecessary_this

class DeleteAccount {
  String? status;
  String? usrEmail;
  String? usrID;
  String? msg;
  List<String>? error;

  DeleteAccount({this.status, this.usrEmail, this.usrID, this.msg, this.error});

  DeleteAccount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usrEmail = json['usrEmail'];
    usrID = json['usrID'];
    msg = json['msg'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['usrEmail'] = this.usrEmail;
    data['usrID'] = this.usrID;
    data['msg'] = this.msg;
    data['error'] = this.error;
    return data;
  }
}
