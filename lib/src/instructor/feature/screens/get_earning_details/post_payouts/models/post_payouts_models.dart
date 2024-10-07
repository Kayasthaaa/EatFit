class PostPayoutModels {
  int? id;
  User? user;
  String? createdAt;
  String? modifiedAt;
  String? status;
  int? amount;
  String? reason;
  int? instructor;

  PostPayoutModels(
      {this.id,
      this.user,
      this.createdAt,
      this.modifiedAt,
      this.status,
      this.amount,
      this.reason,
      this.instructor});

  PostPayoutModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    status = json['status'];
    amount = json['amount'];
    reason = json['reason'];
    instructor = json['instructor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['status'] = status;
    data['amount'] = amount;
    data['reason'] = reason;
    data['instructor'] = instructor;
    return data;
  }
}

class User {
  String? fullName;
  String? email;
  String? phoneNumber;

  User({this.fullName, this.email, this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
