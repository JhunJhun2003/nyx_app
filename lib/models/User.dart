class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? dateOfBirth; // Added field
  final String? imageUrl;

  const User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.dateOfBirth, // Added parameter
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final dynamic rawId = json['id'];

    return User(
      id: rawId is int ? rawId : int.tryParse(rawId?.toString() ?? ''),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      dateOfBirth: json['dateOfBirth']?.toString() ?? json['date_of_birth']?.toString(), // Handle both
      imageUrl: json['image_url']?.toString() ?? json['imageUrl']?.toString(), // Handle both
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth, // Include in JSON
      'image_url': imageUrl,
    };
  }
}