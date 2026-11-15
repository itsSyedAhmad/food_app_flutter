class User {
  const User({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.dateOfBirth,
  });

  final String fullName;
  final String email;
  final String mobileNumber;
  final String dateOfBirth;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      mobileNumber: json['mobileNumber'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'fullName': fullName, 
        'email': email,
        'mobileNumber': mobileNumber,
        'dateOfBirth': dateOfBirth,
      };
}
