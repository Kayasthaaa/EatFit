class UserInvitationsModels {
  int? id;
  String? instructorName;
  String? instructorPicture;
  String? createdAt;
  String? modifiedAt;
  String? phoneNumber;
  String? expiresAt;
  bool? isArchived;
  MealPlan? mealPlan;
  int? mealTimes;

  UserInvitationsModels(
      {this.id,
      this.instructorName,
      this.instructorPicture,
      this.createdAt,
      this.modifiedAt,
      this.phoneNumber,
      this.expiresAt,
      this.isArchived,
      this.mealPlan,
      this.mealTimes});

  UserInvitationsModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instructorName = json['instructor_name'];
    instructorPicture = json['instructor_picture'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    phoneNumber = json['phone_number'];
    expiresAt = json['expires_at'];
    isArchived = json['is_archived'];
    mealPlan =
        json['meal_plan'] != null ? MealPlan.fromJson(json['meal_plan']) : null;
    mealTimes = json['meal_times'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['instructor_name'] = instructorName;
    data['instructor_picture'] = instructorPicture;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['phone_number'] = phoneNumber;
    data['expires_at'] = expiresAt;
    data['is_archived'] = isArchived;
    if (mealPlan != null) {
      data['meal_plan'] = mealPlan!.toJson();
    }
    data['meal_times'] = mealTimes;
    return data;
  }
}

class MealPlan {
  int? id;
  String? planName;
  int? numberOfDays;
  String? price;

  MealPlan({this.id, this.planName, this.numberOfDays, this.price});

  MealPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['plan_name'];
    numberOfDays = json['number_of_days'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plan_name'] = planName;
    data['number_of_days'] = numberOfDays;
    data['price'] = price;
    return data;
  }
}
