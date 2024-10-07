// ignore_for_file: unnecessary_this

class ProfileModels {
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

  ProfileModels(
      {this.id,
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
      this.emailVerified});

  ProfileModels.fromJson(Map<String, dynamic> json) {
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
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phone_number'] = this.phoneNumber;
    data['bio'] = this.bio;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    data['is_staff'] = this.isStaff;
    data['last_login'] = this.lastLogin;
    data['profile_picture'] = this.profilePicture;
    data['user_type'] = this.userType;
    data['role_type'] = this.roleType;
    data['email_verified'] = this.emailVerified;
    return data;
  }
}
