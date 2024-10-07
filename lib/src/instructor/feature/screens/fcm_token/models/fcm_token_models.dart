class FcmModels {
  int? id;
  String? modifiedAt;
  String? registrationId;

  FcmModels({this.id, this.modifiedAt, this.registrationId});

  FcmModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modifiedAt = json['modified_at'];
    registrationId = json['registration_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['modified_at'] = modifiedAt;
    data['registration_id'] = registrationId;
    return data;
  }
}
