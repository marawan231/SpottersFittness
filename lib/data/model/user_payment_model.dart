class UserPaymentInfo {
  String? pid;
  String? orderid;
  String? trID;
  String? userID;
  String? amountPaid;
  String? paid;
  String? txnid;
  String? dt;

  UserPaymentInfo(
      {this.pid,
      this.orderid,
      this.trID,
      this.userID,
      this.amountPaid,
      this.paid,
      this.txnid,
      this.dt});

  UserPaymentInfo.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    orderid = json['orderid'];
    trID = json['trID'];
    userID = json['userID'];
    amountPaid = json['amountPaid'];
    paid = json['paid'];
    txnid = json['txnid'];
    dt = json['dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pid'] = pid;
    data['orderid'] = orderid;
    data['trID'] = trID;
    data['userID'] = userID;
    data['amountPaid'] = amountPaid;
    data['paid'] = paid;
    data['txnid'] = txnid;
    data['dt'] = dt;
    return data;
  }
}
