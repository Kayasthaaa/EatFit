class GetPlansModels {
  int? id;
  List<Meals>? meals;
  List<MealTimes>? mealTimes;
  String? createdAt;
  String? modifiedAt;
  String? planName;
  int? numberOfDays;
  String? price;
  bool? isArchived;
  String? verified;
  int? user;

  GetPlansModels(
      {this.id,
      this.meals,
      this.mealTimes,
      this.createdAt,
      this.modifiedAt,
      this.planName,
      this.numberOfDays,
      this.price,
      this.isArchived,
      this.verified,
      this.user});

  GetPlansModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
    if (json['meal_times'] != null) {
      mealTimes = <MealTimes>[];
      json['meal_times'].forEach((v) {
        mealTimes!.add(MealTimes.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    planName = json['plan_name'];
    numberOfDays = json['number_of_days'];
    price = json['price'];
    isArchived = json['is_archived'];
    verified = json['verified'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (meals != null) {
      data['meals'] = meals!.map((v) => v.toJson()).toList();
    }
    if (mealTimes != null) {
      data['meal_times'] = mealTimes!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['modified_at'] = modifiedAt;
    data['plan_name'] = planName;
    data['number_of_days'] = numberOfDays;
    data['price'] = price;
    data['is_archived'] = isArchived;
    data['verified'] = verified;
    data['user'] = user;
    return data;
  }
}

class Meals {
  int? day;
  List<DayMeals>? dayMeals;

  Meals({this.day, this.dayMeals});

  Meals.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['day_meals'] != null) {
      dayMeals = <DayMeals>[];
      json['day_meals'].forEach((v) {
        dayMeals!.add(DayMeals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    if (dayMeals != null) {
      data['day_meals'] = dayMeals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DayMeals {
  String? time;
  String? description;
  int? id;

  DayMeals({this.time, this.description, this.id});

  DayMeals.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['description'] = description;
    data['id'] = id;
    return data;
  }
}

class MealTimes {
  String? time;

  MealTimes({this.time});

  MealTimes.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    return data;
  }
}
