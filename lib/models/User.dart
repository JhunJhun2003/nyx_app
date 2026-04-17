class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;

  const User({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final dynamic rawId = json['id'];

    return User(
      id: rawId is int ? rawId : int.tryParse(rawId?.toString() ?? ''),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
