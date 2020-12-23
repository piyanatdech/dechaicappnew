import 'dart:convert';

class UserModel {
  final String id;
  final String user;
  final String name;
  final String password;
  final String typeuser;
  final String address;
  final String lat;
  final String lng;
  UserModel({
    this.id,
    this.user,
    this.name,
    this.password,
    this.typeuser,
    this.address,
    this.lat,
    this.lng,
  });

  UserModel copyWith({
    String id,
    String user,
    String name,
    String password,
    String typeuser,
    String address,
    String lat,
    String lng,
  }) {
    return UserModel(
      id: id ?? this.id,
      user: user ?? this.user,
      name: name ?? this.name,
      password: password ?? this.password,
      typeuser: typeuser ?? this.typeuser,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'name': name,
      'password': password,
      'typeuser': typeuser,
      'address': address,
      'lat': lat,
      'lng': lng,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserModel(
      id: map['id'],
      user: map['user'],
      name: map['name'],
      password: map['password'],
      typeuser: map['typeuser'],
      address: map['address'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, user: $user, name: $name, password: $password, typeuser: $typeuser, address: $address, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserModel &&
      o.id == id &&
      o.user == user &&
      o.name == name &&
      o.password == password &&
      o.typeuser == typeuser &&
      o.address == address &&
      o.lat == lat &&
      o.lng == lng;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user.hashCode ^
      name.hashCode ^
      password.hashCode ^
      typeuser.hashCode ^
      address.hashCode ^
      lat.hashCode ^
      lng.hashCode;
  }
}
