// ignore_for_file: unnecessary_this

class UpdatedProfile {
  String? status;
  String? usrID;
  List<String>? error;

  UpdatedProfile({this.status, this.usrID, this.error});

  UpdatedProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usrID = json['usrID'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['usrID'] = this.usrID;
    data['error'] = this.error;
    return data;
  }
}
