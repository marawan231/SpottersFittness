class ChatUsers {
  String? userID;
  String? fname;
  String? city;
  String? usrPic;
  String? usrToken;
  bool isSelected = false;

  ChatUsers({this.userID, this.fname, this.city, this.usrPic, this.usrToken});

  ChatUsers.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    fname = json['fname'];
    city = json['city'];
    usrPic = json['usrPic'];
    usrToken = json['usrToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['fname'] = fname;
    data['city'] = city;
    data['usrPic'] = usrPic;
    data['usrToken'] = usrToken;
    return data;
  }
}
