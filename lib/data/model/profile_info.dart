// ignore_for_file: unnecessary_this

class ProfileInfo {
  String? trID;
  String? country;
  String? city;
  String? gender;
  String? dob;
  String? exp;
  String? spe;
  String? certi;
  String? abt;
  String? pic;

  ProfileInfo(
      {this.trID,
      this.country,
      this.city,
      this.gender,
      this.dob,
      this.exp,
      this.spe,
      this.certi,
      this.abt,
      this.pic});

  ProfileInfo.fromJson(Map<String, dynamic> json) {
    trID = json['trID'];
    country = json['country'];
    city = json['city'];
    gender = json['gender'];
    dob = json['dob'];
    exp = json['exp'];
    spe = json['spe'];
    certi = json['certi'];
    abt = json['abt'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trID'] = this.trID;
    data['country'] = this.country;
    data['city'] = this.city;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['exp'] = this.exp;
    data['spe'] = this.spe;
    data['certi'] = this.certi;
    data['abt'] = this.abt;
    data['pic'] = this.pic;
    return data;
  }
}
