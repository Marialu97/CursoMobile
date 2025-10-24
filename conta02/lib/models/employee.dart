import 'package:cloud_firestore/cloud_firestore.dart';

enum Role { admin, employee }

class Employee {
  final String id;
  final String name;
  final String email;
  final Role role;
  final String? position;
  final bool isActive;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.position,
    this.isActive = true,
  });

  // Convert to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role.name, // Store as string
      'position': position,
      'isActive': isActive,
    };
  }

  // Create from Firestore document
  factory Employee.fromMap(String id, Map<String, dynamic> map) {
    return Employee(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: Role.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => Role.employee,
      ),
      position: map['position'],
      isActive: map['isActive'] ?? true,
    );
  }

  // Copy with method for updates
  Employee copyWith({
    String? id,
    String? name,
    String? email,
    Role? role,
    String? position,
    bool? isActive,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      position: position ?? this.position,
      isActive: isActive ?? this.isActive,
    );
  }
}
