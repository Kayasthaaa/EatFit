class ProfileUpdate {
  final int? id;
  final String? userName;
  final String? fullName;
  final String? email;
  final String? gender;
  final String? phoneNumber;
  final String? bio;
  final String? dob;
  final String? createdAt;
  final bool? isStaff;
  final String? lastLogin;
  final String?
      profilePicturePath; // Store the file path instead of File object
  final String? userType;
  final String? roleType;
  final bool? emailVerified;

  ProfileUpdate({
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
    this.profilePicturePath, // Use string instead of File object
    this.userType,
    this.roleType,
    this.emailVerified,
  });

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) {
    return ProfileUpdate(
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      bio: json['bio'] as String?,
      dob: json['dob'] as String?,
      createdAt: json['createdAt'] as String?,
      isStaff: json['isStaff'] as bool?,
      lastLogin: json['lastLogin'] as String?,
      profilePicturePath: json['profilePicture'] as String?, // Store file path
      userType: json['userType'] as String?,
      roleType: json['roleType'] as String?,
      emailVerified: json['emailVerified'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'fullName': fullName,
      'email': email,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'bio': bio,
      'dob': dob,
      'createdAt': createdAt,
      'isStaff': isStaff,
      'lastLogin': lastLogin,
      'profilePicture': profilePicturePath, // Serialize file path
      'userType': userType,
      'roleType': roleType,
      'emailVerified': emailVerified,
    };
  }
}
