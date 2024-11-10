import 'getusermodel.dart';

class Support {
  final String url;
  final String text;

  Support({required this.url, required this.text});

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      url: json['url'],
      text: json['text'],
    );
  }
}

class UserDetails {
  final User user;
  final Support support;

  UserDetails({required this.user, required this.support});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      user: User.fromJson(json['data']),
      support: Support.fromJson(json['support']),
    );
  }
}
