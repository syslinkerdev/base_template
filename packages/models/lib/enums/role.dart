import 'package:flutter/material.dart';
import 'package:models/models.dart';

enum Role {
  client,
  admin,
  appManagement,
}

class RoleConverter {
  static final _converter = EnumJsonConverter(Role.values);

  static Role fromJson(Object json) => _converter.fromJson(json);
  static String toJson(Role role) => _converter.toJson(role);
  static Role? fromJsonNullable(Object? json) =>
      _converter.fromJsonNullable(json);
  static String? toJsonNullable(Role? role) => _converter.toJsonNullable(role);
}

extension RoleHierarchy on Role {
  Role? get superRole {
    switch (this) {
      case Role.client:
        return Role.admin;
      case Role.admin:
        return Role.appManagement;
      case Role.appManagement:
        return null; // 🔝 highest role
    }
  }
}

Role? getSuperRoleFromString(String? roleString) {
  if (roleString == null) return null;
  try {
    final role = RoleConverter.fromJson(roleString);
    return role.superRole;
  } catch (e) {
    // Optional: log error or handle invalid role string
    return null;
  }
}

extension RoleApi on Role {
  String get label => switch (this) {
        Role.client => 'Client',
        Role.admin => 'Admin',
        Role.appManagement => 'App Management',
      };

  Color get color => switch (this) {
        Role.client => Colors.blue.shade600,
        Role.admin => Colors.red.shade600,
        Role.appManagement => Colors.teal.shade600,
      };

  IconData get icon => switch (this) {
        Role.client => Icons.person,
        Role.admin => Icons.workspace_premium,
        Role.appManagement => Icons.settings_suggest,
      };
}
