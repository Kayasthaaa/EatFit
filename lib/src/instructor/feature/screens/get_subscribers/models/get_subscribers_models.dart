class GetSubscribersModels {
  int? id;
  int? activeSubscribers;
  int? inactiveSubscribers;
  bool? activeStatus;
  String? subscriberName;
  String? subscriberNumber;
  String? instructorName;
  String? instructorPicture;
  String? createdAt;
  String? modifiedAt;
  String? validTill;
  bool? isArchived;
  String? latitude;
  String? longitude;
  String? location;
  int? user;
  MealPlan? mealPlan;
  int? payment;
  int? mealTimes;

  GetSubscribersModels(
      {this.id,
      this.activeSubscribers,
      this.inactiveSubscribers,
      this.activeStatus,
      this.subscriberName,
      this.subscriberNumber,
      this.instructorName,
      this.instructorPicture,
      this.createdAt,
      this.modifiedAt,
      this.validTill,
      this.isArchived,
      this.latitude,
      this.longitude,
      this.location,
      this.user,
      this.mealPlan,
      this.payment,
      this.mealTimes});

  GetSubscribersModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activeSubscribers = json['active_subscribers'];
    inactiveSubscribers = json['inactive_subscribers'];
    activeStatus = json['active_status'];
    subscriberName = json['subscriber_name'];
    subscriberNumber = json['subscriber_number'];
    instructorName = json['instructor_name'];
    instructorPicture = json['instructor_picture'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    validTill = json['valid_till'];
    isArchived = json['is_archived'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    location = json['location'];
    user = json['user'];
    mealPlan =
        json['meal_plan'] != null ? MealPlan.fromJson(json['meal_plan']) : null;
    payment = json['payment'];
    mealTimes = json['meal_times'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active_subscribers'] = activeSubscribers;
    data['inactive_subscribers'] = inactiveSubscribers;
    data['active_status'] = activeStatus;
    data['subscriber_name'] = subscriberName;
    data['subscriber_number'] = subscriberNumber;
    data['instructor_name'] = instructorName;
    data['instructor_picture'] = instructorPicture;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['valid_till'] = validTill;
    data['is_archived'] = isArchived;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location'] = location;
    data['user'] = user;
    if (mealPlan != null) {
      data['meal_plan'] = mealPlan!.toJson();
    }
    data['payment'] = payment;
    data['meal_times'] = mealTimes;
    return data;
  }
}

class MealPlan {
  int? id;
  String? planName;
  int? numberOfDays;

  MealPlan({this.id, this.planName, this.numberOfDays});

  MealPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['plan_name'];
    numberOfDays = json['number_of_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plan_name'] = planName;
    data['number_of_days'] = numberOfDays;
    return data;
  }
}
