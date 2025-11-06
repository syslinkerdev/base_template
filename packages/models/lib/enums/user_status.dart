import 'package:models/models.dart';
import 'package:flutter/material.dart';

enum UserStatus {
  // pending,   // Registered but incomplete setup
  active, // All set and working
  suspended, // Temporarily restricted
  // blocked,   // Permanently blocked
  // deleted,   // Marked for deletion (soft delete)
}

extension UserStatusApi on UserStatus {
  String get label => switch (this) {
        UserStatus.active => 'Active',
        UserStatus.suspended => 'Suspended',
      };

  Color get color => switch (this) {
        UserStatus.active => Colors.green,
        UserStatus.suspended => Colors.orange,
      };

  IconData get icon => switch (this) {
        UserStatus.active => Icons.check_circle,
        UserStatus.suspended => Icons.pause_circle_filled,
      };
  UserStatus? get reverse {
    switch (this) {
      case UserStatus.active:
        return UserStatus.suspended;
      case UserStatus.suspended:
        return UserStatus.active;
    }
  }
}

class UserStatusConverter {
  static final _converter = EnumJsonConverter(UserStatus.values);

  static UserStatus fromJson(Object json) => _converter.fromJson(json);
  static String toJson(UserStatus userStatus) => _converter.toJson(userStatus);
  static UserStatus? fromJsonNullable(Object? json) =>
      _converter.fromJsonNullable(json);
  static String? toJsonNullable(UserStatus? userStatus) =>
      _converter.toJsonNullable(userStatus);
}
