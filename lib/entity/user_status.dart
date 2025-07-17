import 'user.dart';

class UserStatus {
  User? user;
  String? baseUrl;
  String? token;
  int? status;

  UserStatus({this.user, this.baseUrl, this.token, this.status});

  UserStatus.fromMap(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromMap(json['user']) : null;
    baseUrl = json['base_url'];
    token = json['token'];
    status = json['status'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toMap();
    }
    data['base_url'] = this.baseUrl;
    data['token'] = this.token;
    data['status'] = this.status;
    return data;
  }

  @override
  String toString() {
    return '''UserStatus{
      user: $user, 
      baseUrl: $baseUrl, 
      token: $token, 
      status: $status
    }''';
  }
}
