class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.photo,
    required this.title,
    required this.contact,
    required this.contactType,
    required this.description,
    required this.token,
    required this.expiresOn,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    role = json['role'] ?? '';
    photo = json['photo'] ?? '';
    title = json['title'] ?? '';
    contact = json['contact'] ?? '';
    contactType = json['contactType'] ?? '';
    description = json['description'] ?? '';
    token = json['token'] ?? '';
    expiresOn = json['expiresOn'] ?? '';
  }

  late String id;
  late String name;
  late String email;
  late String phoneNumber;
  late String role;
  late String photo;
  late String title;
  late String contact;
  late String contactType;
  late String description;
  late String token;
  late String expiresOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['role'] = role;
    map['photo'] = photo;
    map['title'] = title;
    map['contact'] = contact;
    map['contactType'] = contactType;
    map['description'] = description;
    map['token'] = token;
    map['expiresOn'] = expiresOn;
    return map;
  }
}
