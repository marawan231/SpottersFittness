class UploadVideoModel {
  String? status;
  String? usrID;
  List<String>? error;

  UploadVideoModel({this.status, this.usrID, this.error});

  UploadVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usrID = json['usrID'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['usrID'] = this.usrID;
    data['error'] = this.error;
    return data;
  }
}
