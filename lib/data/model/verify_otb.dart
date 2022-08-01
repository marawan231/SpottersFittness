class VerifyOtb {
  String? status;
  String? usrid;
  List<String>? error;

  VerifyOtb({this.status, this.usrid, this.error});

  VerifyOtb.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    usrid = json['usrid'];
    error = json['error'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['usrid'] = usrid;
    data['error'] = error;
    return data;
  }
}
