class EarningDetailsModel {
  int? id;
  String? createdAt;
  String? modifiedAt;
  double? amount;
  String? earningPercentage;
  String? type;
  int? user;
  int? commisionFrom;
  int? mealPlan;
  String? status;

  EarningDetailsModel(
      {this.id,
      this.createdAt,
      this.modifiedAt,
      this.amount,
      this.earningPercentage,
      this.type,
      this.user,
      this.commisionFrom,
      this.mealPlan,
      this.status});

  EarningDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    amount = json['amount'];
    earningPercentage = json['earning_percentage'];
    type = json['type'];
    user = json['user'];
    commisionFrom = json['commision_from'];
    mealPlan = json['meal_plan'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['amount'] = amount;
    data['earning_percentage'] = earningPercentage;
    data['type'] = type;
    data['user'] = user;
    data['commision_from'] = commisionFrom;
    data['meal_plan'] = mealPlan;
    data['status'] = status;
    return data;
  }
}
