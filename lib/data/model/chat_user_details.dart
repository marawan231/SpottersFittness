class ChatUserDetails {
  String? userID;
  String? fname;
  String? city;
  String? country;
  String? age;
  String? job;
  String? gender;
  String? abt;
  String? interests;
  String? pic;
  String? token;

  ChatUserDetails(
      {this.userID,
      this.fname,
      this.city,
      this.country,
      this.age,
      this.job,
      this.gender,
      this.abt,
      this.interests,
      this.pic,
      this.token});

  ChatUserDetails.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    fname = json['fname'];
    city = json['city'];
    country = json['country'];
    age = json['age'];
    job = json['job'];
    gender = json['gender'];
    abt = json['abt'];
    interests = json['interests'];
    pic = json['pic'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['fname'] = fname;
    data['city'] = city;
    data['country'] = country;
    data['age'] = age;
    data['job'] = job;
    data['gender'] = gender;
    data['abt'] = abt;
    data['interests'] = interests;
    data['pic'] = pic;
    data['token'] = token;
    return data;
  }
}
