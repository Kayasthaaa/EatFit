class RedeemCodeModels {
  String? number;
  bool? valid;
  bool? userexist;
  String? msg;

  RedeemCodeModels({this.number, this.valid, this.msg, this.userexist});

  RedeemCodeModels.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    valid = json['Valid'];
    msg = json['msg'];
    userexist = json['user_exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Number'] = number;
    data['Valid'] = valid;
    data['msg'] = msg;
    data['user_exist'] = userexist;
    return data;
  }
}
