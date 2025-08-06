class UserModel {
  final int? userId;
  final String? token;
  final String? userName;
  final String? fullName;
  final String? companyName;
  final String? role;
  final String? profilePicture;
  final List<dynamic>? reportUsers;

  UserModel({
    this.userId,
    this.token,
    this.userName,
    this.fullName,
    this.companyName,
    this.role,
    this.profilePicture,
    this.reportUsers,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['UserID'],
      token: json['Token'],
      userName: json['UserName'],
      fullName: json['FullName'],
      companyName: json['CompanyName'],
      role: json['Role'],
      profilePicture: json['ProfilePicture'],
      reportUsers: json['ReportUsers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userId,
      'Token': token,
      'UserName': userName,
      'FullName': fullName,
      'CompanyName': companyName,
      'Role': role,
      'ProfilePicture': profilePicture,
      'ReportUsers': reportUsers,
    };
  }
}
