class FetchCertifcateModel {
  String? cid;
  String? trID;
  String? cpic;
  String? dt;

  FetchCertifcateModel({this.cid, this.trID, this.cpic, this.dt});

  FetchCertifcateModel.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    trID = json['trID'];
    cpic = json['cpic'];
    dt = json['dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['trID'] = this.trID;
    data['cpic'] = this.cpic;
    data['dt'] = this.dt;
    return data;
  }
}
