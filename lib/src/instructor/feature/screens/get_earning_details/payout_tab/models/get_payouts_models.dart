class GetPaymentModels {
  int? id;
  Instructor? instructor;
  String? createdAt;
  String? modifiedAt;
  String? status;
  double? amount;
  String? reason;
  int? user;

  GetPaymentModels(
      {this.id,
      this.instructor,
      this.createdAt,
      this.modifiedAt,
      this.status,
      this.amount,
      this.reason,
      this.user});

  GetPaymentModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instructor = json['instructor'] != null
        ? Instructor.fromJson(json['instructor'])
        : null;
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    status = json['status'];
    amount = json['amount'];
    reason = json['reason'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (instructor != null) {
      data['instructor'] = instructor!.toJson();
    }
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['status'] = status;
    data['amount'] = amount;
    data['reason'] = reason;
    data['user'] = user;
    return data;
  }
}

class Instructor {
  String? fullName;
  String? email;
  String? phoneNumber;

  Instructor({this.fullName, this.email, this.phoneNumber});

  Instructor.fromJson(Map<String, dynamic> json) {
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
