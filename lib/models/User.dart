// lib/models/User.dart
class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final String? dateOfBirth;
  final String? address;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.imageUrl,
    this.dateOfBirth,
    this.address,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] is int 
          ? json['id'] 
          : (json['id'] != null ? int.tryParse(json['id'].toString()) : null),
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      imageUrl: json['image_url']?.toString(),
      dateOfBirth: json['dateOfBirth']?.toString(),
      address: json['address']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image_url': imageUrl,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}