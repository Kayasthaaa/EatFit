class SubscriberDetailsModels {
  Subscription? subscription;
  List<Days>? days;

  SubscriberDetailsModels({this.subscription, this.days});

  SubscriberDetailsModels.fromJson(Map<String, dynamic> json) {
    subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subscription != null) {
      data['subscription'] = subscription!.toJson();
    }
    if (days != null) {
      data['days'] = days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subscription {
  int? subscriptionId;
  int? mealplanId;
  int? instructor;
  String? photo;
  int? numberOfDays;

  Subscription(
      {this.subscriptionId,
      this.mealplanId,
      this.instructor,
      this.photo,
      this.numberOfDays});

  Subscription.fromJson(Map<String, dynamic> json) {
    subscriptionId = json['subscription_id'];
    mealplanId = json['mealplan_id'];
    instructor = json['instructor'];
    photo = json['photo'];
    numberOfDays = json['number_of_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subscription_id'] = subscriptionId;
    data['mealplan_id'] = mealplanId;
    data['instructor'] = instructor;
    data['photo'] = photo;
    data['number_of_days'] = numberOfDays;
    return data;
  }
}

class Days {
  int? day;
  String? deliveredDate;
  List<MealsOfTheDay>? mealsOfTheDay;

  Days({this.day, this.deliveredDate, this.mealsOfTheDay});

  Days.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    deliveredDate = json['delivered_date'];
    if (json['meals_of_the_day'] != null) {
      mealsOfTheDay = <MealsOfTheDay>[];
      json['meals_of_the_day'].forEach((v) {
        mealsOfTheDay!.add(MealsOfTheDay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['delivered_date'] = deliveredDate;
    if (mealsOfTheDay != null) {
      data['meals_of_the_day'] = mealsOfTheDay!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MealsOfTheDay {
  int? id;
  String? mealTime;
  String? mealDetails;
  String? createdAt;
  String? modifiedAt;
  String? deliveredDate;
  String? orderProgress;
  int? subscription;
  int? meal;
  int? user;
  String? rider;

  MealsOfTheDay(
      {this.id,
      this.mealTime,
      this.mealDetails,
      this.createdAt,
      this.modifiedAt,
      this.deliveredDate,
      this.orderProgress,
      this.subscription,
      this.meal,
      this.user,
      this.rider});

  MealsOfTheDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealTime = json['meal_time'];
    mealDetails = json['meal_details'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    deliveredDate = json['delivered_date'];
    orderProgress = json['order_progress'];
    subscription = json['subscription'];
    meal = json['meal'];
    user = json['user'];
    rider = json['rider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['meal_time'] = mealTime;
    data['meal_details'] = mealDetails;
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['delivered_date'] = deliveredDate;
    data['order_progress'] = orderProgress;
    data['subscription'] = subscription;
    data['meal'] = meal;
    data['user'] = user;
    data['rider'] = rider;
    return data;
  }
}
