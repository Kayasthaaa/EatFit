class RegisterModels {
  int? id;
  String? userName;
  String? fullName;
  String? email;
  String? gender;
  String? phoneNumber;
  String? bio;
  String? dob;
  String? createdAt;
  bool? isStaff;
  String? lastLogin;
  String? profilePicture;
  String? userType;
  String? roleType;
  bool? emailVerified;

  RegisterModels({
    this.id,
    this.userName,
    this.fullName,
    this.email,
    this.gender,
    this.phoneNumber,
    this.bio,
    this.dob,
    this.createdAt,
    this.isStaff,
    this.lastLogin,
    this.profilePicture,
    this.userType,
    this.roleType,
    this.emailVerified,
  });

  RegisterModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    fullName = json['full_name'];
    email = json['email'];
    gender = json['gender'];
    phoneNumber = json['phone_number'];
    bio = json['bio'];
    dob = json['dob'];
    createdAt = json['created_at'];
    isStaff = json['is_staff'];
    lastLogin = json['last_login'];
    profilePicture = json['profile_picture'];
    userType = json['user_type'];
    roleType = json['role_type'];
    emailVerified = json['email_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['full_name'] = fullName;
    data['email'] = email;
    data['gender'] = gender;
    data['phone_number'] = phoneNumber;
    data['bio'] = bio;
    data['dob'] = dob;
    data['created_at'] = createdAt;
    data['is_staff'] = isStaff;
    data['last_login'] = lastLogin;
    data['profile_picture'] = profilePicture;
    data['user_type'] = userType;
    data['role_type'] = roleType;
    data['email_verified'] = emailVerified;
    return data;
  }
}
