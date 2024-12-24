import 'dart:convert';

class AuthModel {
  final String id;
  final String name;
  final String email;
  final String? role; // Optional role

  AuthModel({
    required this.id,
    required this.name,
    required this.email,
    this.role, // Make it optional
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role ?? "receptionist", // Default to receptionist
    };
  }

  static AuthModel fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: map['role'], // Can be null
    );
  }
  String toJson() => json.encode(toMap());
  factory AuthModel.fromJson(String source) => AuthModel.fromMap(json.decode(source) as Map<String,dynamic>);
}
