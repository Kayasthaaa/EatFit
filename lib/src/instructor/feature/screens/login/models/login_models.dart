class LoginModels {
  String? validNumber;
  String? msg;

  LoginModels({this.validNumber, this.msg});

  LoginModels.fromJson(Map<String, dynamic> json) {
    validNumber = json['valid number'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valid number'] = validNumber;
    data['msg'] = msg;
    return data;
  }
}
