// ignore_for_file: unnecessary_this

class FetchProfile {
  String? trID;
  String? fname;
  String? email;
  String? phone;
  String? pic;
  String? token;

  FetchProfile(
      {this.trID, this.fname, this.email, this.phone, this.pic, this.token});

  FetchProfile.fromJson(Map<String, dynamic> json) {
    trID = json['trID'];
    fname = json['fname'];
    email = json['email'];
    phone = json['phone'];
    pic = json['pic'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trID'] = this.trID;
    data['fname'] = this.fname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['pic'] = this.pic;
    data['token'] = this.token;
    return data;
  }
}
