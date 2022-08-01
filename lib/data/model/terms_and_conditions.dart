// ignore_for_file: unnecessary_this

class TermsAndConditions {
  String? id;
  String? pgTitle;
  String? pgTxt;

  TermsAndConditions({this.id, this.pgTitle, this.pgTxt});

  TermsAndConditions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pgTitle = json['pgTitle'];
    pgTxt = json['pgTxt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['pgTitle'] = this.pgTitle;
    data['pgTxt'] = this.pgTxt;
    return data;
  }
}
