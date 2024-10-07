class GenerateCodeModels {
  int? status;
  String? inviteCode;

  GenerateCodeModels({this.status, this.inviteCode});

  GenerateCodeModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    inviteCode = json['Invite Code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['Invite Code'] = inviteCode;
    return data;
  }
}
