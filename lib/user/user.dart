class User {
  String name;
  String email;
  String phone;
  String aboutMeDescription;

  // Constructor
  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.aboutMeDescription,
  });

  User copy({
    String? name,
    String? phone,
    String? email,
    String? about,
  }) =>
      User(

        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        aboutMeDescription: about ?? this.aboutMeDescription,
      );

  static User fromJson(Map<String, dynamic> json) => User(

        name: json['name'],
        email: json['email'],
        aboutMeDescription: json['about'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'about': aboutMeDescription,
        'phone': phone,
      };
}