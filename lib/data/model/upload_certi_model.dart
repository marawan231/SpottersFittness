// ignore_for_file: unnecessary_this

class UploadVCertiModel {
  String? status;
  String? trID;
  String? cpicUploaded;
  List<String>? error;

  UploadVCertiModel({this.status, this.trID, this.cpicUploaded, this.error});

  UploadVCertiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    trID = json['trID'];
    cpicUploaded = json['cpicUploaded'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['trID'] = this.trID;
    data['cpicUploaded'] = this.cpicUploaded;
    data['error'] = this.error;
    return data;
  }
}
