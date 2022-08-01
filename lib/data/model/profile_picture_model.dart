// ignore_for_file: unnecessary_this, prefer_void_to_null

class ProfilePicture {
  String? status;
  Null fileLoc;
  Null usrEmail;
  List<String>? error;

  ProfilePicture({this.status, this.fileLoc, this.usrEmail, this.error});

  ProfilePicture.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    fileLoc = json['fileLoc'];
    usrEmail = json['usrEmail'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['fileLoc'] = this.fileLoc;
    data['usrEmail'] = this.usrEmail;
    data['error'] = this.error;
    return data;
  }
}
