import 'dart:convert';
//class ประกาศตัวแปร->หลอดไฟ->genclass
class UserModel {
  final String email;
  final String lat;
  final String long;
  final String name;
  final String token;
  UserModel({
    this.email,
    this.lat,
    this.long,
    this.name,
    this.token,
  });

  UserModel copyWith({
    String email,
    String lat,
    String long,
    String name,
    String token,
  }) {
    return UserModel(
      email: email ?? this.email,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      name: name ?? this.name,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'lat': lat,
      'long': long,
      'name': name,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserModel(
      email: map['email'],
      lat: map['lat'],
      long: map['long'],
      name: map['name'],
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(email: $email, lat: $lat, long: $long, name: $name, token: $token)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserModel &&
      o.email == email &&
      o.lat == lat &&
      o.long == long &&
      o.name == name &&
      o.token == token;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      lat.hashCode ^
      long.hashCode ^
      name.hashCode ^
      token.hashCode;
  }
}
