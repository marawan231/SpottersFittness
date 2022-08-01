class Sumbit {
  String? status;
  String? usrEmail;
  String? usrID;
  List<String>? error;

  Sumbit({this.status, this.usrEmail, this.usrID, this.error});

  Sumbit.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usrEmail = json['usrEmail'];
    usrID = json['usrID'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['usrEmail'] = usrEmail;
    data['usrID'] = usrID;
    data['error'] = error;
    return data;
  }
}
